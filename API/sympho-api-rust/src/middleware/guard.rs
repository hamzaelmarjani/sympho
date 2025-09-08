use crate::structs::response::common::UnauthorizedResponse;
use actix_web::{
    Error as ActixWebError, HttpResponse,
    body::{EitherBody, MessageBody},
    dev::{ServiceRequest, ServiceResponse},
    middleware::Next,
};

pub async fn guard(
    req: ServiceRequest,
    next: Next<impl MessageBody>,
) -> Result<ServiceResponse<EitherBody<impl MessageBody, impl MessageBody>>, ActixWebError> {
    if let Some(token) = get_token_from_header(&req) {
        // TODO: later should check the token first
        // TODO: with JWT service
        if token == "f77cc4dd-b796-42e7-9c93-c7a69a83ec34" {
            let res = next.call(req).await?;
            return Ok(res.map_into_left_body());
        }
    }

    Ok(req.into_response(
        HttpResponse::Unauthorized()
            .json(UnauthorizedResponse {
                message: "unauthorized-request".into(),
            })
            .map_into_right_body(),
    ))
}

fn get_token_from_header(req: &ServiceRequest) -> Option<&str> {
    if let Some(auth_header) = req.headers().get("Authorization") {
        if let Ok(auth_str) = auth_header.to_str() {
            if let Some(token) = auth_str.strip_prefix("Bearer ") {
                return Some(token);
            }
        }
    }
    None
}
