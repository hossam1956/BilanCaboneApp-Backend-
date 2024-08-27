package com.example.BilanCarbone.dto;

import jakarta.validation.constraints.NotNull;

/**
 * @author CHALABI Hossam
 **/
public record DataInfoRequest (
        @NotNull(message = "ID Utilisateur must not be blank")
        String idUtilisateur,
        @NotNull(message = "ID Facteur must not be blank")
        Long idFacteur,
        @NotNull(message = "date must not be blank")
        String date,
        @NotNull(message = "Quantity must not be blank")
        Double quantity

){}
