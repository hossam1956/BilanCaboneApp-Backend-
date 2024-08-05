package com.example.BilanCarbone.mapper;

import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.entity.Type;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Fournit des méthodes pour mapper les entités {@link Type} en objets {@link TypeResponse}.
 * <p>
 * Cette classe est annotée avec {@code @Service} et utilise {@code @RequiredArgsConstructor} pour
 * l'injection automatique des dépendances. Elle utilise un format de date {@code "dd/MM/yyyy"}.
 * </p>
 *
 * @author Oussama
 */
@Service
public class TypeMapper {

    private final FacteurMapper facteurMapper;
    private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm:ss");

    public TypeMapper(FacteurMapper facteurMapper) {
        this.facteurMapper = facteurMapper;
    }

    /**
     * Convertit une entité {@code Type} en un objet {@code TypeResponse} en incluant les facteurs associés.
     * <p>
     * Cette méthode extrait les informations pertinentes de l'entité {@code Type} et les assigne
     * aux champs de {@code TypeResponse}. Les facteurs associés sont également convertis en objets
     * {@code FacteurResponse}.
     * </p>
     *
     * @param type l'entité {@code Type} à convertir
     * @return un objet {@code TypeResponse} contenant les informations de l'entité {@code Type}
     */
    public TypeResponse typeParentResponse(Type type) {
        return TypeResponse.builder()
                .id(type.getId())
                .facteurs(type.getFacteurs() != null ? type.getFacteurs().stream().map(facteurMapper::toFacteurResponse).collect(Collectors.toList()) : null)
                .nbr_facteur(type.getFacteurs() != null ? type.getFacteurs().size(): 0)
                .nom_type(type.getName())
                .active(type.getActive())
                .type_parent(type.getParent()!=null ? type.getParent().getName():"- - -")
                .create(type.getCreatedDate().format(formatter))
                .deleted(type.getIsDeleted() != null ? type.getIsDeleted().format(formatter) : null)
                .update(type.getUpdateDate() != null ? type.getUpdateDate().format(formatter) : null)
                .files(new ArrayList<>())
                .parent(null)
                .build();
    }

    /**
     * Convertit une entité {@code Type} en un objet {@code TypeResponse} en n'incluant pas les facteurs associés.
     * <p>
     * Cette méthode extrait les informations pertinentes de l'entité {@code Type} et les assigne
     * aux champs de {@code TypeResponse}. Le champ {@code facteurs} est défini sur {@code null}.
     * </p>
     *
     * @param type l'entité {@code Type} à convertir
     * @return un objet {@code TypeResponse} contenant les informations de l'entité {@code Type}
     */
    public TypeResponse typeParentResponse_with_date_and_parent(Type type) {
        TypeResponse typeResponse = this.typeParentResponse_simple(type);
        typeResponse.setActive(type.getActive());
        typeResponse.setDeleted(type.getIsDeleted() != null ? type.getIsDeleted().format(formatter) : null);
        typeResponse.setUpdate(type.getUpdateDate() != null ? type.getUpdateDate().format(formatter) : null);
        typeResponse.setCreate(type.getCreatedDate() != null ? type.getCreatedDate().format(formatter) : null);
        typeResponse.setParent(type.getParent() != null ? type.getParent().getId() : null);

        return typeResponse;
    }

    /**
     * Convertit une entité {@code Type} en un objet {@code TypeResponse} en n'incluant aucune des informations supplémentaires.
     * <p>
     * Cette méthode extrait les informations de base de l'entité {@code Type} et les assigne aux champs
     * de {@code TypeResponse}. Les champs tels que {@code actifs}, {@code date}, et {@code facteurs} sont définis sur {@code null}.
     * </p>
     *
     * @param type l'entité {@code Type} à convertir
     * @return un objet {@code TypeResponse} contenant les informations de l'entité {@code Type}
     */
    public TypeResponse typeParentResponse_simple(Type type) {
        return TypeResponse.builder()
                .id(type.getId())
                .nom_type(type.getName())
                .type_parent(type.getParent()!=null ? type.getParent().getName():"- - -")
                .files(new ArrayList<>())
                .nbr_facteur(type.getFacteurs() != null ? type.getFacteurs().size(): 0)
                .build();
    }

    /**
     * Convertit une entité {@code Type} en un objet {@code TypeResponse} en incluant ses enfants.
     * <p>
     * Cette méthode extrait les informations pertinentes de l'entité {@code Type} et de la liste des enfants fournie.
     * Les enfants sont convertis en objets {@code TypeResponse} et ajoutés au champ {@code fils} de la réponse.
     * </p>
     *
     * @param type  l'entité {@code Type} à convertir
     * @param types la liste des enfants à inclure dans la réponse
     * @return un objet {@code TypeResponse} contenant les informations de l'entité {@code Type} et ses enfants
     */
    public TypeResponse typeParentResponse(Type type, List<Type> types) {
        List<TypeResponse> responses = new ArrayList<>();
        if (!types.isEmpty()) {
            for (Type t : types) {
                responses.add(typeParentResponse(t));
            }
        }
        return TypeResponse.builder()
                .id(type.getId())
                .facteurs(null)
                .nom_type(type.getName())
                .active(type.getActive())
                .create(type.getCreatedDate().format(formatter))
                .deleted(type.getIsDeleted() != null ? type.getIsDeleted().format(formatter) : null)
                .update(type.getUpdateDate() != null ? type.getUpdateDate().format(formatter) : null)
                .files(responses)
                .build();
    }

    /**
     * Crée une hiérarchie d'objets {@code TypeResponse} à partir des listes fournies.
     * <p>
     * Cette méthode construit une hiérarchie d'objets {@code TypeResponse} à partir d'une liste de types et de leurs enfants.
     * Les types sans parent sont ajoutés à la liste des réponses, et les enfants sont associés aux parents correspondants.
     * </p>
     *
     * @param list  la liste des types principaux
     * @param child la liste des types enfants
     * @return une liste d'objets {@code TypeResponse} représentant la hiérarchie des types
     */
    public List<TypeResponse> hierarchiqueResponse(List<Type> list, List<Type> child) {
        List<TypeResponse> res = null;
        if (list != null) {
            res = new ArrayList<>();
            for (Type i : list) {
                if (i.getParent() == null) {
                    res.add(typeParentResponse(i));
                }
            }
            for (TypeResponse i : res) {
                for (Type j : child) {
                    if (i.existfils(j.getId())) {
                        continue;
                    }
                    if (i.getId().equals(j.getParent().getId())) {
                        i.getFiles().add(typeParentResponse_with_date_and_parent(j));
                    }
                }
            }
            return res;
        }
        return res;
    }
}