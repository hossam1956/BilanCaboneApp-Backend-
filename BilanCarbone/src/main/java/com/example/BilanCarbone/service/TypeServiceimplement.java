package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurRequest;
import com.example.BilanCarbone.dto.TypeRequest;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.entity.Type;
import com.example.BilanCarbone.entity.Unite;
import com.example.BilanCarbone.exception.OperationNotPermittedException;
import com.example.BilanCarbone.jpa.FacteurRepository;
import com.example.BilanCarbone.jpa.TypeRepository;
import com.example.BilanCarbone.mapper.TypeMapper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author Oussama
 **/

/**
 * Implémentation des services liés aux entités Type.
 *
 * @author Oussama
 */
@Service
public class TypeServiceimplement implements TypeService {

    private final TypeRepository typeRepository;
    private final TypeMapper typeMapper;
    private final FacteurRepository facteurRepository;
    private final FacteurService facteurService;

    public TypeServiceimplement(TypeRepository typeRepository, TypeMapper typeMapper, FacteurRepository facteurRepository, FacteurService facteurService) {
        this.typeRepository = typeRepository;
        this.typeMapper = typeMapper;
        this.facteurRepository = facteurRepository;
        this.facteurService = facteurService;
    }

    /**
     * Liste des types parent avec pagination, tri et recherche.
     *
     * @param page   Numéro de la page à récupérer (commence à 0).
     * @param size   Nombre d'éléments par page.
     * @param search Critère de recherche dans le nom des types.
     * @param order  Ordre de tri des résultats.
     * @return PageResponse<TypeResponse> Liste paginée des types parent.
     */
    @Override
    public PageResponse<TypeResponse> list_parent(int page, int size, String search, String... order) {
        Page<Type> respage = pagesorted(page, size, search, order);
        return getTypeResponsePageResponse(respage);
    }

    /**
     * Liste de tous les types avec pagination, tri et recherche.
     *
     * @param page   Numéro de la page à récupérer (commence à 0).
     * @param size   Nombre d'éléments par page.
     * @param search Critère de recherche dans le nom des types.
     * @param order  Ordre de tri des résultats.
     * @return PageResponse<TypeResponse> Liste paginée de tous les types.
     */
    @Override
    public PageResponse<TypeResponse> list_all(int page, int size, String search, String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(page, size, sort);
        Page<Type> respage = null;
        if (search != null && !search.isEmpty()) {
            respage = typeRepository.findAllByNameContainingIgnoreCaseAndIsDeletedIsNull(search, pe);
        } else {
            respage = typeRepository.findAllByIsDeletedIsNull(pe);
        }
        return getTypeResponsePageResponse(respage);
    }

    /**
     * Liste détaillée de tous les types avec pagination, tri et recherche.
     *
     * @param page   Numéro de la page à récupérer (commence à 0).
     * @param size   Nombre d'éléments par page.
     * @param search Critère de recherche dans le nom des types.
     * @param order  Ordre de tri des résultats.
     * @return PageResponse<TypeResponse> Liste paginée des types avec détails.
     */
    @Override
    public PageResponse<TypeResponse> list_all_detail(int page, int size, String search, String... order) {
        Page<Type> respage = pagesorted(page, size, search, order);
        List<Type> child = typeRepository.findAllByParentIsNotNullAndIsDeletedIsNull();
        List<TypeResponse> list = typeMapper.hierarchiqueResponse(respage.stream().toList(), child);
        return PageResponse.<TypeResponse>builder()
                .content(list)
                .number(respage.getNumber())
                .size(respage.getSize())
                .totalElements(respage.getTotalElements())
                .totalPages(respage.getTotalPages())
                .first(respage.isFirst())
                .last(respage.isLast())
                .build();
    }

    /**
     * Récupère les détails d'un type par son ID.
     *
     * @param id Identifiant du type à récupérer.
     * @return TypeResponse Détails du type.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    public TypeResponse get_type(Long id) {
        Type res = findbyid(id);
        return typeMapper.typeParentResponse_with_date_and_parent(res);
    }

    /**
     * Récupère les détails d'un type avec ses enfants.
     *
     * @param id Identifiant du type à récupérer.
     * @return TypeResponse Détails du type avec ses enfants.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    public TypeResponse get_type_detail(Long id) {
        Type res = findbyid(id);
        List<Type> list = typeRepository.findAllByParentAndIsDeletedIsNull(res);
        if (!list.isEmpty()) {
            return typeMapper.typeParentResponse(res, list);
        }
        return typeMapper.typeParentResponse(res);
    }

    /**
     * Récupère les détails d'un type suprimee avec ses enfants.
     *
     * @param id Identifiant du type à récupérer.
     * @return TypeResponse Détails du type avec ses enfants.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    private TypeResponse get_type_detail_deleted(Long id) {
        Type res = find_deleted_byid(id);
        List<Type> list = typeRepository.findAllByParentAndIsDeletedNotNull(res);
        if (!list.isEmpty()) {
            return typeMapper.typeParentResponse(res, list);
        }
        return typeMapper.typeParentResponse(res);
    }

    /**
     * Récupère tous les types en remontant jusqu'au type racine si nécessaire.
     *
     * @param id Identifiant du type à récupérer.
     * @return TypeResponse Détails du type ou de son parent racine.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    public TypeResponse get_type_all(Long id) {
        Type res = findbyid(id);
        if (res.getParent() != null) {
            res = res.getParent();
        }
        List<Type> list = typeRepository.findAllByParentAndIsDeletedIsNull(res);
        if (!list.isEmpty()) {
            return typeMapper.typeParentResponse(res, list);
        }
        return typeMapper.typeParentResponse(res);
    }

    /**
     * Active un type en le rétablissant s'il était désactivé.
     *
     * @param id Identifiant du type à activer.
     * @return TypeResponse Détails du type activé.
     * @throws OperationNotPermittedException Si le type est déjà activé.
     * @throws EntityNotFoundException        Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    public TypeResponse activate_type(Long id) {
        Type type = findbyid(id);
        if (type.getActive()) {
            throw new OperationNotPermittedException("Le type " + id + " a déjà été activé");
        }

        type.setActive(true);
        return typeMapper.typeParentResponse_with_date_and_parent(typeRepository.save(type));
    }

    /**
     * Active ou désactive un type et ses enfants.
     *
     * @param id       Identifiant du type à modifier.
     * @param activate Boolean indiquant si le type doit être activé (true) ou désactivé (false).
     * @return TypeResponse Détails du type après activation/désactivation.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    public TypeResponse toggle_type_detail(Long id, boolean activate) {
        Type type = findbyid(id);
        Type re = toggleTypeAndChildren(type, activate);
        return this.get_type_all(re.getId());
    }

    /**
     * Ajoute un type détaillé en utilisant les informations fournies.
     *
     * @param request Requête contenant les détails du type à ajouter.
     * @return TypeResponse Détails du type ajouté.
     */
    @Override
    @Transactional
    public TypeResponse add_type_detail(TypeRequest request) {
        Type type = add_type(request, null);
        return this.get_type_detail(type.getId());
    }

    /**
     * Liste de tous les types actifs.
     *
     * @return List<TypeResponse> Liste des types actifs.
     */
    @Override
    public List<TypeResponse> list_type() {
        List<Type> list = typeRepository.findAllByActiveIsTrueAndIsDeletedIsNull();
        List<Type> child = typeRepository.findAllByParentIsNotNullAndIsDeletedIsNull();
        return typeMapper.hierarchiqueResponse(list.stream().toList(), child);
    }

    /**
     * Met à jour les détails d'un type.
     *
     * @param id      Identifiant du type à mettre à jour.
     * @param request Requête contenant les nouvelles informations du type.
     * @return TypeResponse Détails du type mis à jour.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    @Transactional
    public TypeResponse update_type_detail(Long id, TypeRequest request) {
        Type type = updateType(id, request, null);
        return this.get_type_detail(type.getId());
    }

    /**
     * Supprime un type en le marquant comme supprimé, et supprime également ses enfants.
     *
     * @param id Identifiant du type à supprimer.
     * @return TypeResponse Détails du type supprimé.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    @Transactional
    public TypeResponse delete_type_detail(Long id) {
        Type type = toggle_delete(id, true);

        return this.get_type_detail_deleted(type.getId());
    }

    /**
     * Supprime de force un type et ses enfants, même si le type est déjà marqué comme supprimé.
     *
     * @param id Identifiant du type à supprimer de force.
     * @return TypeResponse Détails du type supprimé de force.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    @Transactional
    public TypeResponse force_delete_type(Long id) {
        Type type = find_deleted_byid(id);
        TypeResponse resp = this.get_type_detail_deleted(type.getId());
        deleteTypeAndChildren(type);
        return resp;
    }

    /**
     * Récupère un type supprimé ainsi que ses enfants.
     *
     * @param id Identifiant du type à récupérer.
     * @return TypeResponse Détails du type récupéré.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    @Override
    @Transactional
    public TypeResponse recovery_delete_all(Long id) {
        Type type = toggle_delete(id, false);
        return this.get_type_detail(type.getId());
    }

    /**
     * Liste des types supprimés avec pagination, tri et recherche.
     *
     * @param page   Numéro de la page à récupérer (commence à 0).
     * @param size   Nombre d'éléments par page.
     * @param search Critère de recherche dans le nom des types supprimés.
     * @param order  Ordre de tri des résultats.
     * @return PageResponse<TypeResponse> Liste paginée des types supprimés.
     */
    @Override
    public PageResponse<TypeResponse> list_all_detail_trash(int page, int size, String search, String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(page, size, sort);
        Page<Type> respage = null;
        if (search != null && !search.isEmpty()) {
            respage = typeRepository.findAllByNameContainingIgnoreCaseAndIsDeletedIsNotNull(search, pe);
        } else {
            respage = typeRepository.findAllByIsDeletedNotNull(pe);
        }
        return getTypeResponsePageResponse(respage);
    }

    /**
     * Basculer l'état de suppression d'un type et de ses enfants.
     *
     * @param id      Identifiant du type à modifier.
     * @param deleted Boolean indiquant si le type doit être supprimé (true) ou récupéré (false).
     * @return Type Le type modifié.
     * @throws OperationNotPermittedException Si l'opération n'est pas autorisée.
     * @throws EntityNotFoundException        Si le type avec l'ID spécifié n'est pas trouvé.
     */
    private Type toggle_delete(Long id, Boolean deleted) {
        Type type;
        if (deleted) {
            type = findbyid(id);
            if (type.getIsDeleted() != null) {
                throw new OperationNotPermittedException("Le type " + type.getId() + " est supprimé");
            }
            type.setIsDeleted(LocalDateTime.now());
        } else {
            type = find_deleted_byid(id);
            if (type.getIsDeleted() == null) {
                throw new OperationNotPermittedException("Le type " + type.getId() + " n'est pas supprimé");
            }
            if (type.getParent() != null && type.getParent().getIsDeleted() != null) {
                throw new OperationNotPermittedException("Vous devez d'abord récupérer le type parent: " +
                        type.getParent().getName() + ", id: " + type.getParent().getId());
            }
            type.setIsDeleted(null);
        }
        typeRepository.save(type);
        if (type.getFacteurs() != null && !type.getFacteurs().isEmpty()) {
            for (Facteur facteur : type.getFacteurs()) {
                if (facteur.getIsDeleted() == null && deleted) {
                    facteurService.delete_facteur(facteur.getId());
                } else if (facteur.getIsDeleted() != null && !deleted) {
                    facteurService.recovery_facteur(facteur.getId());
                }
            }
        }
        List<Type> childTypes = typeRepository.findAllByParent(type);
        if (!childTypes.isEmpty()) {
            for (Type childType : childTypes) {
                toggle_delete(childType.getId(), deleted);
            }
        }

        return type;
    }

    /**
     * Ajoute un type et ses facteurs, ainsi que ses enfants si spécifié.
     *
     * @param request Requête contenant les détails du type à ajouter.
     * @param parent  Type parent du nouveau type.
     * @return Type Le type ajouté.
     * @throws OperationNotPermittedException Si un type avec le même nom existe déjà ou si la profondeur dépasse deux niveaux.
     */
    private Type add_type(TypeRequest request, Type parent) {
        Type type = typeRepository.findByNameAndIsDeletedIsNull(request.nom_type());
        if (type != null) {
            throw new OperationNotPermittedException("type avec nom " + type.getName() + " deja exists.");
        }
        int depth = getDepth(parent);
        if (depth > 1) {
            throw new OperationNotPermittedException("La profondeur du type ne peut pas dépasser deux niveaux.");
        }
        type = Type.builder()
                .name(request.nom_type())
                .parent(parent)
                .active(true)
                .build();
        type = typeRepository.save(type);

        if (request.facteurs() != null && !request.facteurs().isEmpty()) {
            for (FacteurRequest i : request.facteurs()) {
                Facteur facteur = Facteur.builder()
                        .nom(i.nom_facteur())
                        .unit(Unite.fromString(i.unit()))
                        .emissionFactor(i.emissionFactor())
                        .type(type)
                        .active((i.active() != null) ? i.active() : true)
                        .build();
                facteurRepository.save(facteur);
            }
        }
        if (request.types() != null && !request.types().isEmpty()) {
            for (TypeRequest childRequest : request.types()) {
                add_type(childRequest, type);
            }
        }
        return type;
    }

    /**
     * Active ou désactive un type et ses enfants.
     *
     * @param type     Type à modifier.
     * @param activate Boolean indiquant si le type doit être activé (true) ou désactivé (false).
     * @return Type Le type modifié.
     */
    private Type toggleTypeAndChildren(Type type, boolean activate) {
        if (type.getActive() != activate) {
            type.setActive(activate);
            typeRepository.save(type);
        }
        if (type.getFacteurs() != null && !type.getFacteurs().isEmpty()) {
            for (Facteur i : type.getFacteurs()) {
                if (i.getActive() != activate) {
                    i.setActive(activate);
                    facteurRepository.save(i);
                }
            }
        }
        List<Type> childTypes = typeRepository.findAllByParentAndIsDeletedIsNull(type);
        if (childTypes != null && !childTypes.isEmpty()) {
            for (Type childType : childTypes) {
                if (childType.getActive() != activate) {
                    toggleTypeAndChildren(childType, activate);
                }
            }
        }
        return type;
    }

    /**
     * Obtient une page de types triés en fonction de la recherche et du tri.
     *
     * @param page   Numéro de la page à récupérer (commence à 0).
     * @param size   Nombre d'éléments par page.
     * @param search Critère de recherche dans le nom des types.
     * @param order  Ordre de tri des résultats.
     * @return Page<Type> Page des types triés.
     */
    private Page<Type> pagesorted(int page, int size, String search, String[] order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(page, size, sort);
        if (!search.isEmpty()) {
            return typeRepository.findAllByNameContainingIgnoreCaseAndParentIsNullAndIsDeletedIsNull(search, pe);
        }
        return typeRepository.findAllByParentIsNullAndIsDeletedIsNull(pe);
    }

    /**
     * Convertit une page de types en une réponse paginée de TypeResponse.
     *
     * @param respage Page de types à convertir.
     * @return PageResponse<TypeResponse> Réponse paginée des types.
     */
    private PageResponse<TypeResponse> getTypeResponsePageResponse(Page<Type> respage) {
        List<TypeResponse> res = respage.stream().map(typeMapper::typeParentResponse_with_date_and_parent).toList();
        return PageResponse.<TypeResponse>builder()
                .content(res)
                .number(respage.getNumber())
                .size(respage.getSize())
                .totalElements(respage.getTotalElements())
                .totalPages(respage.getTotalPages())
                .first(respage.isFirst())
                .last(respage.isLast())
                .build();
    }

    /**
     * Trouve un type par son identifiant, en ignorant les types supprimés.
     *
     * @param id Identifiant du type à rechercher.
     * @return Type Type trouvé.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    private Type findbyid(Long id) {
        Type t = typeRepository.findByIdAndIsDeletedIsNull(id);
        if (t == null) {
            throw new EntityNotFoundException("Type not found with id: " + id);
        }
        return t;
    }

    /**
     * Trouve un type par son identifiant, y compris les types supprimés.
     *
     * @param id Identifiant du type à rechercher.
     * @return Type Type trouvé.
     * @throws EntityNotFoundException Si le type avec l'ID spécifié n'est pas trouvé.
     */
    private Type find_deleted_byid(Long id) {
        Type t = typeRepository.findByIdAndIsDeletedIsNotNull(id);
        if (t == null) {
            throw new EntityNotFoundException("Type not found with id: " + id);
        }
        return t;
    }

    /**
     * Calcule la profondeur d'un type en remontant à ses parents.
     *
     * @param type Type pour lequel calculer la profondeur.
     * @return int Profondeur du type.
     */
    private int getDepth(Type type) {
        int depth = 0;
        while (type != null) {
            type = type.getParent();
            depth++;
        }
        return depth;
    }

    /**
     * Met à jour un type avec les informations fournies dans la requête.
     *
     * @param typeId  Identifiant du type à mettre à jour.
     * @param request Requête contenant les nouvelles informations du type.
     * @param parent  Type parent du type mis à jour.
     * @return Type Le type mis à jour.
     * @throws EntityNotFoundException        Si le type avec l'ID spécifié n'est pas trouvé.
     * @throws OperationNotPermittedException Si la profondeur du type dépasse deux niveaux.
     */
    private Type updateType(Long typeId, TypeRequest request, Type parent) {
        // Fetch the type by ID, ensuring it is not deleted
        Type type = typeRepository.findByIdAndIsDeletedIsNull(typeId);
        if (type == null) {
            throw new EntityNotFoundException("Type not found with id: " + typeId);
        }

        // Update type fields if provided
        if (request.nom_type() != null && !request.nom_type().equals(type.getName())) {
            type.setName(request.nom_type());
        }
        if (request.active() != null && !request.active().equals(type.getActive())) {
            type.setActive(request.active());
        }
        if (parent != null) {
            int depth = getDepth(parent);
            if (depth > 1) {
                throw new OperationNotPermittedException("La profondeur du type ne peut pas dépasser deux niveaux.");
            }
            type.setParent(parent);
        }
        type = typeRepository.save(type);
        if (request.facteurs() != null) {
            List<Long> newFacteurIds = request.facteurs().stream()
                    .map(FacteurRequest::id)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
            List<Facteur> oldFacteurs = newFacteurIds.isEmpty()
                    ? facteurRepository.findAllByTypeAndIsDeletedIsNull(type)
                    : facteurRepository.findAllByTypeAndIdNotInAndIsDeletedNull(type, newFacteurIds);
            for (Facteur facteur : oldFacteurs) {
                facteur.setIsDeleted(LocalDateTime.now());
                facteurRepository.save(facteur);
            }
            for (FacteurRequest i : request.facteurs()) {
                if (i.id() != null) {
                    facteurService.update(i.id(), i);
                } else {
                    facteurService.addFacteur(i, type);
                }
            }
        } else {
            List<Facteur> oldFacteurs = facteurRepository.findAllByTypeAndIsDeletedIsNull(type);
            for (Facteur facteur : oldFacteurs) {
                facteur.setIsDeleted(LocalDateTime.now());
                facteurRepository.save(facteur);
            }
        }
        if (request.types() != null) {
            List<Long> newTypeIds = request.types().stream()
                    .map(TypeRequest::id)
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());

            List<Type> oldTypes = typeRepository.findAllByParentAndIdNotIn(type, newTypeIds);
            for (Type oldType : oldTypes) {
                this.delete_type_detail(oldType.getId());
            }

            for (TypeRequest childRequest : request.types()) {
                if (childRequest.id() != null) {
                    updateType(childRequest.id(), childRequest, type);
                } else {
                    add_type(childRequest, type);
                }
            }
        }
        boolean shouldDeactivate = request.active() != null && !request.active();
        if (shouldDeactivate) {
            deactivateChildrenAndFacteurs(type);
        }

        return type;
    }


    /**
     * Désactive les enfants et facteurs d'un type si nécessaire.
     *
     * @param type Type dont les enfants et facteurs doivent être désactivés.
     */
    private void deactivateChildrenAndFacteurs(Type type) {
        if (type.getFacteurs() != null) {
            for (Facteur facteur : type.getFacteurs()) {
                if (facteur.getActive()) {
                    facteur.setActive(false);
                    facteurRepository.save(facteur);
                }
            }
        }

        List<Type> childTypes = typeRepository.findAllByParent(type);
        if (childTypes != null) {
            for (Type childType : childTypes) {
                if (childType.getActive()) {
                    childType.setActive(false);
                    deactivateChildrenAndFacteurs(childType);
                    typeRepository.save(childType);
                }
            }
        }
    }

    /**
     * Supprime un type ainsi que tous ses enfants et facteurs associés.
     *
     * @param type Type à supprimer.
     */
    private void deleteTypeAndChildren(Type type) {
        if (type.getFacteurs() != null) {
            for (Facteur facteur : type.getFacteurs()) {
                facteurService.delete_force_facteur(facteur.getId());
            }
        }
        List<Type> childTypes = typeRepository.findAllByParentAndIsDeletedNotNull(type);
        if (childTypes != null) {
            for (Type childType : childTypes) {
                deleteTypeAndChildren(childType);
            }
        }
        typeRepository.delete(type);
    }
}