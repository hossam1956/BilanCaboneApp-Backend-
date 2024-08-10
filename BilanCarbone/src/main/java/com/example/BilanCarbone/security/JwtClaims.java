package com.example.BilanCarbone.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class JwtClaims {

    @Value("${spring.security.oauth2.resourceserver.jwt.jwk-set-uri}")
    private String keycloakURL;

    public JwtClaims() {
    }

    public Map<String, Object> extractClaims(String token) {
        try {
            // Decode the token
            JwtDecoder jwtDecoder = NimbusJwtDecoder.withJwkSetUri(keycloakURL).build();
            Jwt jwt = jwtDecoder.decode(token);

            // Extract claims
            Map<String, Object> claims = jwt.getClaims();
            return claims;
        } catch (JwtException e) {
            throw new RuntimeException("Invalid token", e);
        }
    }

}
