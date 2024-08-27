package com.example.BilanCarbone.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
/**
 * Configuration de la sécurité pour l'API.
 * Utilise OAuth2 Resource Server avec JWT pour l'authentification.
 * @author CHALABI Hossam
 */
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    /**
     * Configure la chaîne de filtres de sécurité.
     *
     * @param 'http' L'objet HttpSecurity utilisé pour configurer la sécurité web.
     * @return SecurityFilterChain configuré.
     * @throws Exception si une erreur de configuration survient.
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authorizeRequests ->
                        authorizeRequests
                               // .requestMatchers("/api/utilisateur/**").hasRole("ADMIN")
                               // .requestMatchers("/api/demande/**").hasRole("ADMIN")
                                .requestMatchers(HttpMethod.PUT,"api/utilisateur").permitAll()
                                .requestMatchers("api/utilisateur").permitAll()
                                .requestMatchers("/api/entreprises").permitAll()
                                .requestMatchers(HttpMethod.POST,"/api/demande").permitAll()
                                .anyRequest().permitAll()
                )
                .oauth2ResourceServer(oauth2 -> oauth2
                        .jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter()))
                );

        return http.build();
    }

    /**
     * Configure le convertisseur d'authentification JWT.
     *
     * @return JwtAuthenticationConverter configuré.
     */


    @Bean
    public JwtAuthenticationConverter jwtAuthenticationConverter() {
        JwtAuthenticationConverter jwtAuthenticationConverter = new JwtAuthenticationConverter();
        jwtAuthenticationConverter.setJwtGrantedAuthoritiesConverter(new CustomJwtAuthenticationConverter());
        return jwtAuthenticationConverter;
    }
}