package com.example.BilanCarbone.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * @author Oussama
 **/
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FacteurResponse {
    private Long id;
    private String nom_facteur;
    private String unit;
    private BigDecimal emissionFactor;
    private Boolean active ;
    private Long type;
    private String creat_at;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String update_at;


}
