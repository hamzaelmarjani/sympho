use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
pub struct TTSResponse {
    pub error: Option<String>,
    pub audio: Option<Vec<u8>>,
}