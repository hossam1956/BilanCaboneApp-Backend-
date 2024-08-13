package com.example.BilanCarbone.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.List;

/**
 * @author Oussama
 **/
@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
public class TypeResponse {
    private Long id;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Long entreprise;
    private String nom_type;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Boolean active;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String create;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<TypeResponse> files;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Long parent;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String type_parent;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<FacteurResponse> facteurs;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String deleted;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String update;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private int nbr_facteur;
    public boolean existfils(Long id) {
        for (TypeResponse fil : files) {
            if (fil.getId().equals(id)) {
                return true;
            }
        }
        return false;
    }
}