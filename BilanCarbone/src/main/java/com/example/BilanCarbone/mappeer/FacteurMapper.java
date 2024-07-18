package com.example.BilanCarbone.mappeer;

import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.entity.Unite;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;

/**
 * @author Oussama
 **/
@Service
public class FacteurMapper {
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    public FacteurResponse toFacteurResponse(Facteur facteur) {
        return FacteurResponse.builder()
                .id(facteur.getId())
                .nom_facteur(facteur.getNom())
                .unit(facteur.getUnit().getUnit())
                .active(facteur.getActive())
                .emissionFactor(facteur.getEmissionFactor())
                .type(facteur.getType()!=null?facteur.getType().getId():null)
                .creat_at(facteur.getCreatedDate().format(formatter))
                .update_at(facteur.getLastModifiedDate()!=null?facteur.getLastModifiedDate().format(formatter):null)
                .build();
    }

}
