package com.example.BilanCarbone.config;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author Oussama
 **/
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CustomUserRepresentationWithRole {
    private CustomUserRepresentation customUserRepresentation;
    private String role;
}
