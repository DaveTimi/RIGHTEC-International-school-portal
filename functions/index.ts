export interface Env {
  DB: D1Database;
  APP_NAME: string;
  APP_ENV: string;
}

function json(data: unknown, status = 200): Response {
  return Response.json(data, { status });
}

function createSlug(name: string): string {
  return name
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

function createId(prefix: string): string {
  return `${prefix}_${crypto.randomUUID()}`;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);

    try {
      // ---------------------------------------
      // HEALTH / DATABASE TEST
      // ---------------------------------------
      if (request.method === "GET" && url.pathname === "/") {
        const result = await env.DB
          .prepare(
            "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name"
          )
          .all();

        return json({
          success: true,
          app: env.APP_NAME,
          environment: env.APP_ENV,
          database: "connected",
          tables: result.results
        });
      }

      // ---------------------------------------
      // SCHOOL OWNER ONBOARDING
      // ---------------------------------------
      if (
        request.method === "POST" &&
        url.pathname === "/api/onboarding/school"
      ) {
        const body = await request.json<{
          school_name?: string;
          email?: string;
          first_name?: string;
          last_name?: string;
          phone?: string;
          city?: string;
          state?: string;
          country?: string;
        }>();

        const schoolName = body.school_name?.trim();
        const email = body.email?.trim().toLowerCase();
        const firstName = body.first_name?.trim();
        const lastName = body.last_name?.trim();

        if (!schoolName || !email || !firstName || !lastName) {
          return json(
            {
              success: false,
              error:
                "school_name, email, first_name and last_name are required"
            },
            400
          );
        }

        const slug = createSlug(schoolName);

        if (!slug) {
          return json(
            {
              success: false,
              error: "A valid school name is required"
            },
            400
          );
        }

        // Check whether the email already exists.
        const existingUser = await env.DB
          .prepare("SELECT id FROM users WHERE email = ? LIMIT 1")
          .bind(email)
          .first();

        if (existingUser) {
          return json(
            {
              success: false,
              error: "A user with this email already exists"
            },
            409
          );
        }

        // Check whether the school slug already exists.
        const existingSchool = await env.DB
          .prepare("SELECT id FROM schools WHERE slug = ? LIMIT 1")
          .bind(slug)
          .first();

        if (existingSchool) {
          return json(
            {
              success: false,
              error: "A school with this name already exists"
            },
            409
          );
        }

        const schoolId = createId("school");
        const userId = createId("user");
        const membershipId = createId("member");

        const country = body.country?.trim() || "Nigeria";

        // Create the school, owner account and school membership together.
        await env.DB.batch([
          env.DB
            .prepare(
              `INSERT INTO schools (
                id,
                name,
                slug,
                status,
                email,
                phone,
                address,
                city,
                state,
                country,
                timezone
              )
              VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`
            )
            .bind(
              schoolId,
              schoolName,
              slug,
              "active",
              email,
              body.phone?.trim() || null,
              null,
              body.city?.trim() || null,
              body.state?.trim() || null,
              country,
              "Africa/Lagos"
            ),

          env.DB
            .prepare(
              `INSERT INTO users (
                id,
                email,
                first_name,
                last_name,
                phone,
                status
              )
              VALUES (?, ?, ?, ?, ?, ?)`
            )
            .bind(
              userId,
              email,
              firstName,
              lastName,
              body.phone?.trim() || null,
              "active"
            ),

          env.DB
            .prepare(
              `INSERT INTO school_members (
                id,
                school_id,
                user_id,
                role
              )
              VALUES (?, ?, ?, ?)`
            )
            .bind(
              membershipId,
              schoolId,
              userId,
              "school_owner"
            )
        ]);

        return json(
          {
            success: true,
            message: "School created successfully",
            school: {
              id: schoolId,
              name: schoolName,
              slug,
              status: "active"
            },
            owner: {
              id: userId,
              email,
              first_name: firstName,
              last_name: lastName,
              role: "school_owner"
            },
            membership: {
              id: membershipId,
              role: "school_owner"
            }
          },
          201
        );
      }

      // ---------------------------------------
      // 404
      // ---------------------------------------
      return json(
        {
          success: false,
          error: "Route not found"
        },
        404
      );
    } catch (error) {
      return json(
        {
          success: false,
          error: error instanceof Error ? error.message : String(error)
        },
        500
      );
    }
  }
};
