package com.example.BilanCarbone.mapper;

import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.entity.Facteur;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;


/**
 * Fournit des méthodes pour mapper les entités {@link Facteur} en objets {@link FacteurResponse}.
 * <p>
 * Cette classe est annotée avec {@code @Service} et fournit une méthode pour convertir une
 * entité {@code Facteur} en une réponse de type {@code FacteurResponse}. Le format de date utilisé
 * est {@code "dd/MM/yyyy"}.
 * </p>
 *
 * @author Oussama
 */
@Service
public class FacteurMapper {
    private final     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm:ss");

    /**
     * Convertit une entité {@code Facteur} en un objet {@code FacteurResponse}.
     * <p>
     * Cette méthode utilise le format de date {@code "dd/MM/yyyy"} pour formater les dates
     * {@code createdDate} et {@code lastModifiedDate}. Elle extrait les informations pertinentes
     * de l'entité {@code Facteur} et les assigne aux champs de {@code FacteurResponse}.
     * </p>
     *
     * @param facteur l'entité {@code Facteur} à convertir
     * @return un objet {@code FacteurResponse} contenant les informations de l'entité {@code Facteur}
     */
    public FacteurResponse toFacteurResponse(Facteur facteur) {
        return FacteurResponse.builder()
                .id(facteur.getId())
                .nom_facteur(facteur.getNom())
                .unit(facteur.getUnit().getUnit())
                .active(facteur.getActive())
                .emissionFactor(facteur.getEmissionFactor())
                .type(facteur.getType() != null ? facteur.getType().getId() : null)
                .creat_at(facteur.getCreatedDate().format(formatter))
                .update_at(facteur.getUpdateDate() != null ? facteur.getUpdateDate().format(formatter) : null)
                .deleted(facteur.getIsDeleted() != null ? facteur.getIsDeleted().format(formatter) : null)
                .parent_type(facteur.getType()!=null?facteur.getType().getName():"---")
                .build();
    }
}
