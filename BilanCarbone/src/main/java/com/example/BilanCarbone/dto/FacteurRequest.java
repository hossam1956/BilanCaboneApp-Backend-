package com.example.BilanCarbone.dto;

import com.example.BilanCarbone.validation.OnCreate;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

/**
 * @author Oussama
 **/
public record FacteurRequest(
        @NotBlank(groups = OnCreate.class, message = "Nom must not be blank")
        String nom_facteur,
        @NotBlank(groups = OnCreate.class, message = "Unit must not be blank")
        String unit,
        @NotNull(groups = OnCreate.class, message = "Emission Factor must not be null")
        BigDecimal emissionFactor,
        Boolean active
) {
}
