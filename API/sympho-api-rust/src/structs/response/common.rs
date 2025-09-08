use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
pub struct UnauthorizedResponse {
    pub message: String,
}