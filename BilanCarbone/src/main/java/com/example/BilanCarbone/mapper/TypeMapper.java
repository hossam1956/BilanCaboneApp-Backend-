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


    public TypeResponse typeParentResponse(Type type) {
        return TypeResponse.builder()
                .id(type.getId())
                .nbr_facteur(type.getFacteurs() != null ? type.getFacteurs().size(): 0)
                .nom_type(type.getName())
                .active(type.getActive())
                .type_parent(type.getParent()!=null ? type.getParent().getName():"- - -")
                .create(type.getCreatedDate().format(formatter))
                .deleted(type.getIsDeleted() != null ? type.getIsDeleted().format(formatter) : null)
                .update(type.getUpdateDate() != null ? type.getUpdateDate().format(formatter) : null)
                .files(new ArrayList<>())
                .parent(null)
                .entreprise(type.getEntreprise()!=null?type.getEntreprise().getId():null)
                .build();
    }
    public TypeResponse typeParentResponse_with_facteur(Type type) {
       TypeResponse typeResponse = typeParentResponse(type);
                typeResponse.setFacteurs(type.getFacteurs() != null ? type.getFacteurs().stream().map(facteurMapper::toFacteurResponse).collect(Collectors.toList()) : null);
                return typeResponse;
    }


    public TypeResponse typeParentResponse_with_date_and_parent(Type type) {
        TypeResponse typeResponse = this.typeParentResponse_simple(type);
        typeResponse.setActive(type.getActive());
        typeResponse.setDeleted(type.getIsDeleted() != null ? type.getIsDeleted().format(formatter) : null);
        typeResponse.setUpdate(type.getUpdateDate() != null ? type.getUpdateDate().format(formatter) : null);
        typeResponse.setCreate(type.getCreatedDate() != null ? type.getCreatedDate().format(formatter) : null);
        typeResponse.setParent(type.getParent() != null ? type.getParent().getId() : null);
        typeResponse.setEntreprise(type.getEntreprise()!=null?type.getEntreprise().getId():null);

        return typeResponse;
    }


    public TypeResponse typeParentResponse_simple(Type type) {
        return TypeResponse.builder()
                .id(type.getId())
                .nom_type(type.getName())
                .type_parent(type.getParent()!=null ? type.getParent().getName():"- - -")
                .files(new ArrayList<>())
                .nbr_facteur(type.getFacteurs() != null ? type.getFacteurs().size(): 0)
                .build();
    }


    public TypeResponse typeParentResponse(Type type, List<Type> types,boolean with_facteur) {
        List<TypeResponse> responses = new ArrayList<>();
        if (!types.isEmpty()) {
            for (Type t : types) {
                if (with_facteur) {
                    responses.add(typeParentResponse_with_facteur(t));
                }else {
                    responses.add(typeParentResponse(t));
                }
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
                .entreprise(type.getEntreprise()!=null?type.getEntreprise().getId():null)
                .build();
    }


    public List<TypeResponse> hierarchiqueResponse(List<Type> list, List<Type> child,boolean mode) {
        List<TypeResponse> res = null;
        if (list != null) {
            res = new ArrayList<>();
            for (Type i : list) {
                if (i.getParent() == null) {
                    if(mode){
                        res.add(typeParentResponse_simple(i));
                    }else {
                        res.add(typeParentResponse(i));

                    }
                }
            }
            for (TypeResponse i : res) {
                for (Type j : child) {
                    if (i.existfils(j.getId())) {
                        continue;
                    }
                    if (j.getParent()!=null && i.getId().equals(j.getParent().getId())) {
                        if(mode){
                            i.getFiles().add(typeParentResponse_simple(j));
                        }else {
                            i.getFiles().add(typeParentResponse_with_date_and_parent(j));
                        }
                    }
                }
            }
            return res;
        }
        return res;
    }
}