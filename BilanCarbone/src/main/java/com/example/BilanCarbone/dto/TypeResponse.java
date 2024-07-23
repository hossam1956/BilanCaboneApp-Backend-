package com.example.BilanCarbone.dto;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author Oussama
 **/
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TypeResponse {
    private Long id;
    private String nom_type;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Boolean active;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String date;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<TypeResponse> fils;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Long parent;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<FacteurResponse> facteurs;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private String deleted;

    public boolean existfils(Long id){
        for (TypeResponse fils : fils) {
            if (fils.getId().equals(id)) {
                return true;
            }
        }
        return false;
    }

	

}
