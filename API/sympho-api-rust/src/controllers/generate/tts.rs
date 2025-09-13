use crate::services::generation::tts::make_tts;
use crate::structs::request::tts::TTSBody;
use crate::structs::response::tts::TTSResponse;
use actix_web::web::Json;
use actix_web::{post, HttpResponse, Responder};

#[post("/v1/generation/tts")]
async fn generate_tts(body: Json<TTSBody>) -> impl Responder {
    let mut response: TTSResponse = TTSResponse {
        error: Some("unknow-error".to_string()),
        audio: None,
    };
    let request_tts = make_tts(
        body.into_inner(),
        // TODO You may want to check if the user has access to this model
        // TODO then set false or true to low_mode.
        // TODO true = ELEVEN_TURBO_V2_5, false = ELEVEN_MULTILINGUAL_V1
        false, // default to false for now.
    )
    .await;

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

    if response.audio.is_some() {
        HttpResponse::Ok().json(response)
    } else {
        HttpResponse::InternalServerError().json(response)
    }
}
