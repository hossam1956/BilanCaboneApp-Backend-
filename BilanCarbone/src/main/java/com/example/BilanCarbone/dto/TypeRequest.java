package com.example.BilanCarbone.dto;

import com.example.BilanCarbone.validation.OnCreate;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

/**
 * @author Oussama
 **/
public record TypeRequest(
        @NotBlank(groups = OnCreate.class, message = "Nom must not be blank")
        String nom_type,
        List<TypeRequest> types,
        List<FacteurRequest> facteurs,
        Boolean active,
        Long id
) {

}
