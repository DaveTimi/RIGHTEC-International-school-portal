export interface Env {
  DB: D1Database;
  APP_NAME: string;
  APP_ENV: string;
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    try {
      const result = await env.DB
        .prepare("SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name")
        .all();

      return Response.json({
        success: true,
        app: env.APP_NAME,
        environment: env.APP_ENV,
        database: "connected",
        tables: result.results
      });
    } catch (error) {
      return Response.json(
        {
          success: false,
          database: "connection failed",
          error: error instanceof Error ? error.message : String(error)
        },
        { status: 500 }
      );
    }
  }
};
