package com.example.BilanCarbone.config;

import lombok.*;
import org.keycloak.representations.idm.RoleRepresentation;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CustomUserRepresentationWithRole {
    private CustomUserRepresentation customUserRepresentation;
    private String role;
}
