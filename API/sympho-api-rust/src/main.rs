mod controllers;
mod middleware;
mod services;
mod structs;

use crate::controllers::generate::tts::generate_tts;
use crate::middleware::guard::guard;
use actix_web::{App, HttpServer, middleware::from_fn};
use dotenv::dotenv;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Load env-vars
    dotenv().ok();

    HttpServer::new(|| {
        App::new()
            // Guard: check if the user is authenticated
            .wrap(from_fn(guard))
            // Generate TTS: end point
            .service(generate_tts)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await

    // App running on:
    // http://127.0.0.1:8080 | http://0.0.0.0:8080 | http://localhost:8080
}
