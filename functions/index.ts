export interface Env {
  APP_NAME: string;
  APP_ENV: string;
}

export default {
  async fetch(
    request: Request,
    env: Env
  ): Promise<Response> {
    return new Response(
      JSON.stringify({
        name: env.APP_NAME,
        environment: env.APP_ENV,
        status: "ok",
        message: "Levity Ethics Systems API is running."
      }),
      {
        status: 200,
        headers: {
          "content-type": "application/json"
        }
      }
    );
  }
};
