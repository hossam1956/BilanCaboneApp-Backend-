package com.example.BilanCarbone.dto;
import com.fasterxml.jackson.annotation.JsonIgnore;
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
    private String name;
    private Boolean active;
    private String date;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<TypeResponse> fils;
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<FacteurResponse> facteurs;
    public boolean existfils(Long id){
        for (TypeResponse fil : fils) {
            if (fil.getId().equals(id)) {
                return true;
            }
        }
        return false;
    }

}
