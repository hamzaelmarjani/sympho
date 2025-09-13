package cc.hamzaelmarjani.sympho_api_java.controllers;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cc.hamzaelmarjani.sympho_api_java.configs.decorators.SkipAuth;

// All endpoints inside this controller should skip the auth-token validation
@SkipAuth
@RestController
@RequestMapping("/v1/check-health")
public class HealthController {

    @GetMapping("/public")
    public ResponseEntity<Map<String, String>> publicCheckHealth() {
        return ResponseEntity.ok(Map.of("public-health", "check passed"));
    }
}
