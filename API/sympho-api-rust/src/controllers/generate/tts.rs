use crate::services::generation::tts::make_tts;
use crate::structs::request::tts::TTSBody;
use crate::structs::response::tts::TTSResponse;
use actix_web::web::Json;
use actix_web::{HttpResponse, Responder, post};

#[post("/v1/generation/tts")]
async fn generate_tts(body: Json<TTSBody>) -> impl Responder {
    let mut response: TTSResponse = TTSResponse {
        error: Some("unknow-error".to_string()),
        audio: None,
    };

    // TODO Later check if free user to detect the model you should use ...
    let request_tts = make_tts(body.into_inner(), false).await;

    match request_tts {
        Ok(audio) => {
            response.error = None;
            response.audio = Some(audio);
        }
        Err(err) => {
            println!("Error Generate: {:?}", err);
            response.error = Some("internal-error".to_string());
            response.audio = None;
        }
    }

    HttpResponse::Ok().json(response)
}
