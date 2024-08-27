package com.example.BilanCarbone.dto;

import com.example.BilanCarbone.entity.Entreprise;
import jakarta.validation.constraints.NotNull;

public record UtilisateurModificationRequest(
        @NotNull(message = "email must not be blank")
        String email,
        @NotNull(message = "firstName must not be blank")
        String firstName,
        @NotNull(message = "lastName must not be blank")
        String lastName,
        @NotNull(message = "role must not be blank")
        String role,
        @NotNull(message = "entreprise_id must not be blank")
        Long entreprise_id,
        @NotNull(message = "password must not be blank")
        String password

)
{}
