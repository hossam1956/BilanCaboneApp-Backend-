package com.example.BilanCarbone.mappeer;

import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.entity.Facteur;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;

/**
 * @author Oussama
 **/
@Service
public class FacteurMapper {
    private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    public FacteurResponse toFacteurResponse(Facteur facteur) {
        return FacteurResponse.builder()
                .id(facteur.getId())
                .nom(facteur.getNom())
                .unit(facteur.getUnit())
                .active(facteur.getActive())
                .emissionFactor(facteur.getEmissionFactor())
                .type(facteur.getType().getId())
                .creat_at(facteur.getCreatedDate().format(formatter))
                .update_at(facteur.getLastModifiedDate()!=null?facteur.getLastModifiedDate().format(formatter):null)
                .build();
    }

}
