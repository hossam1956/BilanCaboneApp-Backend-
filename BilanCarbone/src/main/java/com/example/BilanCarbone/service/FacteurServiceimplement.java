package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.config.Userget;
import com.example.BilanCarbone.dto.FacteurRequest;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.entity.*;
import com.example.BilanCarbone.exception.OperationNotPermittedException;
import com.example.BilanCarbone.jpa.FacteurRepository;
import com.example.BilanCarbone.jpa.TypeRepository;
import com.example.BilanCarbone.jpa.UtilisateurRepository;
import com.example.BilanCarbone.mapper.FacteurMapper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.security.access.AccessDeniedException;

import java.security.PrivateKey;
import java.time.LocalDateTime;
import java.util.*;

/**
 * @author Oussama
 * Service implementation for managing {@link Facteur} entities.
 * Provides methods for CRUD operations, including handling soft delete and recovery.
 * Implements {@link FacteurService} interface.
 * <p>
 * This service also interacts with {@link Type} entities to manage relationships between factors and types.
 * </p>
 */
@Service
@RequiredArgsConstructor
public class FacteurServiceimplement implements FacteurService {
    private final FacteurRepository facteurRepository;
    private final TypeRepository typeRepository;
    private final FacteurMapper facteurMapper;
    private final Userget userclaim;
    private final UtilisateurRepository userRepository;
    @Override
    public PageResponse<FacteurResponse> getAllFacteurs(int page,boolean my, int size, String search, String... sortBy) {
        List<Sort.Order> orders = new ArrayList<>();
        for (int i = 0; i < sortBy.length; i++) {
            if (sortBy[i].equals("asc") || sortBy[i].equals("desc")) {
                continue;
            } else {
                Sort.Direction direction = (i + 1 < sortBy.length && sortBy[i + 1].equals("desc")) ? Sort.Direction.DESC : Sort.Direction.ASC;
                orders.add(new Sort.Order(direction, sortBy[i]));
            }
        }

        orders.add(new Sort.Order(Sort.Direction.ASC, "id"));
        Pageable pageable = PageRequest.of(page, size, Sort.by(orders));
        Page<Facteur> facteurPage=null;
        Map<String, Object> table = userclaim.getUserInfo();
        if (my && table.containsKey("roles")) {
            Collection<GrantedAuthority> roles = (Collection<GrantedAuthority>) table.get("roles");
            boolean isNotAdmin = roles.stream().noneMatch(role -> role.getAuthority().equals("ADMIN"));
            if (isNotAdmin) {
                String subject = table.get("sub").toString();
                Utilisateur utilisateur = userRepository.findById(subject)
                        .orElseThrow(() -> new AccessDeniedException("Utilisateur non trouvé, accès refusé."));
                Entreprise entreprise = utilisateur.getEntreprise();
                if (entreprise == null) {
                    throw new EntityNotFoundException("L'utilisateur n'appartient pas à une entreprise.");
                }
                facteurPage = search.isEmpty() ?
                        facteurRepository.findAllByEntrepriseAndIsDeletedIsNull(entreprise, pageable) :
                        facteurRepository.findAllByNomContainingIgnoreCaseAndEntrepriseAndIsDeletedIsNull(search.toLowerCase().trim(), entreprise, pageable);
            }else {
                facteurPage = search.isEmpty() ?
                        facteurRepository.findAllByEntrepriseIsNullAndIsDeletedIsNull(pageable) :
                        facteurRepository.findAllByNomContainingIgnoreCaseAndEntrepriseIsNullAndIsDeletedIsNullAndEntrepriseIsNull(search.toLowerCase().trim(), pageable);
            }
        } else {
            facteurPage = search.isEmpty() ?
                    facteurRepository.findAllByEntrepriseIsNullAndIsDeletedIsNull(pageable) :
                    facteurRepository.findAllByNomContainingIgnoreCaseAndEntrepriseIsNullAndIsDeletedIsNullAndEntrepriseIsNull(search.toLowerCase().trim(), pageable);
        }

        List<FacteurResponse> responseList = facteurPage.stream()
                .map(facteurMapper::toFacteurResponse)
                .toList();

        return PageResponse.<FacteurResponse>builder()
                .content(responseList)
                .number(facteurPage.getNumber())
                .size(facteurPage.getSize())
                .totalElements(facteurPage.getTotalElements())
                .totalPages(facteurPage.getTotalPages())
                .first(facteurPage.isFirst())
                .last(facteurPage.isLast())
                .build();
    }



    @Override
    public FacteurResponse getFacteurById(Long id) {
        return facteurMapper.toFacteurResponse(findbyid(id,false));
    }

    @Override
    public FacteurResponse update(Long id, FacteurRequest request,Type type,boolean all) {
        Facteur facteur = null;
        if(all){
            facteur=facteurRepository.findById(id).orElseThrow(
                    ()->{
                        throw new EntityNotFoundException("facteur not exist");
                    }
            );
            if(facteur.getIsDeleted()!=null){
                this.recovery_facteur(id);
            }
        }else{
            facteur = findbyid(id,true);
        }
        boolean check=check_owner(facteur,true);
        if (!check) {
            throw new AccessDeniedException("Vous n'êtes pas autorisé à accéder à cette ressource.");
        }
        if (request.nom_facteur() != null && !request.nom_facteur().isEmpty() && !request.nom_facteur().equals(facteur.getNom())) {
            facteur.setNom(request.nom_facteur());
        }
        if (request.unit() != null && !request.unit().isEmpty()) {
            if (Unite.fromString(request.unit()) != Unite.UNKNOWN) {
                facteur.setUnit(Unite.fromString(request.unit()));
            }
        }
        if (request.emissionFactor() != null && !request.emissionFactor().equals(facteur.getEmissionFactor())) {
            facteur.setEmissionFactor(request.emissionFactor());
        }
        if (request.active() != null && !request.active().equals(facteur.getActive())) {
            facteur.setActive(request.active());
        }
        if(type!=null&& !type.getId().equals(facteur.getType().getId())){
            facteur.setType(type);
        }
        Facteur updatedFacteur = facteurRepository.save(facteur);
        return facteurMapper.toFacteurResponse(updatedFacteur);
    }


    @Transactional
    @Override
    public FacteurResponse addFacteur(FacteurRequest request, Type type) {
        Map<String, Object> table = userclaim.getUserInfo();
        Entreprise entr = null;
        if (table.containsKey("roles")) {
            Collection<GrantedAuthority> roles = (Collection<GrantedAuthority>) table.get("roles");
            boolean hasPermission = roles.stream()
                    .anyMatch(role -> role.getAuthority().equals("ADMIN")
                            || role.getAuthority().equals("MANAGER")
                            || role.getAuthority().equals("RESPONSABLE"));
            if (!hasPermission) {
                throw new AccessDeniedException("Accès refusé pour le rôle actuel.");
            }
            boolean isNotAdmin = roles.stream().noneMatch(role -> role.getAuthority().equals("ADMIN"));
            if (isNotAdmin) {
                String subject = table.get("sub").toString();
                Utilisateur utilisateur = userRepository.findById(subject)
                        .orElseThrow(() -> new AccessDeniedException("Utilisateur non trouvé, accès refusé."));
                entr = utilisateur.getEntreprise();
                if (entr == null) {
                    throw new EntityNotFoundException("L'utilisateur n'appartient pas à une entreprise.");
                }
            }
        }
        Facteur existingFacteur = facteurRepository.findByNomAndIsDeletedIsNullAndEntrepriseIsNullOrEntreprise(request.nom_facteur(),entr);
        if (existingFacteur != null) {
            throw new OperationNotPermittedException("Facteur avec nom " + request.nom_facteur() + " déjà existe.");
        }
        Facteur facteur = Facteur.builder()
                .nom(request.nom_facteur())
                .unit(Unite.fromString(request.unit()))
                .emissionFactor(request.emissionFactor())
                .type(type)
                .active((request.active() != null) ? request.active() : true)
                .entreprise(entr)
                .build();

        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }


    @Override
    public List<String> getType() {
        return Unite.getAllUnits();
    }

    @Override
    public List<FacteurResponse> list_facteur(Long idtype) {
        Entreprise entr = null;
        Map<String, Object> table = userclaim.getUserInfo();

        if (table.containsKey("roles")) {
            Collection<GrantedAuthority> roles = (Collection<GrantedAuthority>) table.get("roles");
            boolean isNotAdmin = roles.stream().noneMatch(role -> role.getAuthority().equals("ADMIN"));
            if (isNotAdmin) {
                String subject = table.get("sub").toString();
                Utilisateur utilisateur = userRepository.findById(subject)
                        .orElseThrow(() -> new AccessDeniedException("Utilisateur non trouvé, accès refusé."));
                entr = utilisateur.getEntreprise();
                if (entr == null) {
                    throw new EntityNotFoundException("L'utilisateur n'appartient pas à une entreprise.");
                }
            }
        }

        List<Facteur> list;
        if (idtype > 0) {
            Type type = typeRepository.findByIdAndEntrepriseIsNullOrEntreprise(idtype,entr);
            if(type==null) {
                throw new EntityNotFoundException("type not found with id: " + idtype);
            }
            list = facteurRepository.findAllByActiveIsTrueAndTypeAndIsDeletedIsNullAndEntrepriseIsNullOrEntreprise(type,entr);
        } else {
            list = facteurRepository.findAllByActiveIsTrueAndIsDeletedIsNullAndEntrepriseIsNullOrEntreprise(entr);
        }
        return list.stream().map(facteurMapper::toFacteurResponse).toList();
    }


    @Override
    public FacteurResponse delete_facteur(Long facteurId) {
        Facteur facteur = findbyid(facteurId,true);
        if (facteur.getIsDeleted() != null) {
            throw new OperationNotPermittedException("le facteur " + facteurId + " déjà supprimé");
        }
        facteur.setIsDeleted(LocalDateTime.now());
        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }


    @Override
    public FacteurResponse delete_force_facteur(Long facteurId) {
        Facteur facteur = findbyid_deleted(facteurId);
        if (facteur.getIsDeleted() == null) {
            throw new OperationNotPermittedException("le facteur " + facteurId + " n'est pas supprimé");
        }
        facteurRepository.delete(facteur);
        return facteurMapper.toFacteurResponse(facteur);
    }


    @Override
    public FacteurResponse recovery_facteur(Long facteurId) {
        Facteur facteur = findbyid_deleted(facteurId);
        if (facteur.getIsDeleted() == null) {
            throw new OperationNotPermittedException("le facteur " + facteur.getNom() + " n'est pas supprimé");
        }
        if (facteur.getType() != null && facteur.getType().getIsDeleted() != null) {
            throw new OperationNotPermittedException("vous devez d'abord récupérer le type son nom :" + facteur.getNom() + ", et son id :" + facteur.getId());
        }
        Boolean exit=search_facteur(facteur.getNom(),0);
        if(exit){
            throw new OperationNotPermittedException("Il y en a déjà un similaire de cette facteur");
        }
        facteur.setIsDeleted(null);
        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }

    @Override
    public Boolean search_facteur(String search,int id) {
        Entreprise entreprise=check_owner_entreprise();
        Facteur facteur=facteurRepository.findByIdAndIsDeletedIsNull((long) id);
        if(facteur!=null &&!Objects.equals(facteur.getEntreprise().getId(), entreprise.getId())) {
            throw new AccessDeniedException("Accès refusé pour le rôle actuel.");
        }
        if(facteur==null){
            return facteurRepository.existsByNomIgnoreCaseAndIsDeletedIsNullAndEntrepriseIsNull(search) ||
                    facteurRepository.existsByNomIgnoreCaseAndIsDeletedIsNullAndEntreprise(search, entreprise);
        }
        return facteurRepository.existsAllByNomIgnoreCaseAndIdNotAndIsDeletedNotNullAndEntrepriseIsNull(search, (long) id) ||
                facteurRepository.existsAllByNomIgnoreCaseAndIdNotAndIsDeletedNotNullAndEntreprise(search, (long) id, entreprise);
    }


    @Override
    public PageResponse<FacteurResponse> get_All_deleted_Facteurs(int ge, int size, String search, String... sortBy) {
        List<Sort.Order> orders = new ArrayList<>();
        for (int i = 0; i < sortBy.length; i++) {
            if (sortBy[i].equals("asc") || sortBy[i].equals("desc")) {
                continue;
            } else {
                Sort.Direction direction = (i + 1 < sortBy.length && sortBy[i + 1].equals("desc")) ? Sort.Direction.DESC : Sort.Direction.ASC;
                orders.add(new Sort.Order(direction, sortBy[i]));
            }
        }
        orders.add(new Sort.Order(Sort.Direction.ASC, "id"));
        Pageable pageable = PageRequest.of(ge, size, Sort.by(orders));
        Page<Facteur> facteurPage=null;
        Map<String, Object> table = userclaim.getUserInfo();
        if ( table.containsKey("roles")) {
            Collection<GrantedAuthority> roles = (Collection<GrantedAuthority>) table.get("roles");
            boolean hasPermission = roles.stream()
                    .anyMatch(role -> role.getAuthority().equals("ADMIN")
                            || role.getAuthority().equals("MANAGER")
                            || role.getAuthority().equals("RESPONSABLE"));
            if (!hasPermission) {
                throw new AccessDeniedException("Accès refusé pour le rôle actuel.");
            }
            boolean isNotAdmin = roles.stream().noneMatch(role -> role.getAuthority().equals("ADMIN"));
            if (isNotAdmin) {
                String subject = table.get("sub").toString();
                Utilisateur utilisateur = userRepository.findById(subject)
                        .orElseThrow(() -> new AccessDeniedException("Utilisateur non trouvé, accès refusé."));
                Entreprise entreprise = utilisateur.getEntreprise();
                if (entreprise == null) {
                    throw new EntityNotFoundException("L'utilisateur n'appartient pas à une entreprise.");
                }
                facteurPage = search.isEmpty() ?
                        facteurRepository.findAllByIsDeletedNotNullAndEntreprise(entreprise, pageable) :
                        facteurRepository.findAllByNomContainingIgnoreCaseAndIsDeletedNotNullAndEntreprise(search.toLowerCase().trim(), entreprise, pageable);
            }else {
                facteurPage = search.isEmpty() ?
                        facteurRepository.findAllByIsDeletedNotNullAndEntrepriseIsNull(pageable) :
                        facteurRepository.findAllByNomContainingIgnoreCaseAndIsDeletedNotNullAndEntrepriseIsNull(search.toLowerCase().trim(), pageable);
            }
        } else {
            throw new AccessDeniedException("Vous n'êtes pas autorisé à accéder à cette ressource.");
        }
        List<FacteurResponse> res = facteurPage.stream().map(facteurMapper::toFacteurResponse).toList();
        return PageResponse.<FacteurResponse>builder()
                .content(res)
                .number(facteurPage.getNumber())
                .size(facteurPage.getSize())
                .totalElements(facteurPage.getTotalElements())
                .totalPages(facteurPage.getTotalPages())
                .first(facteurPage.isFirst())
                .last(facteurPage.isLast())
                .build();
    }


    @Override
    public FacteurResponse tooglefactecurtoggleActivation(Long id, boolean activate) {
        Facteur facteur = findbyid(id,true);
        if (facteur.getActive() == activate) {
            String action = activate ? "activé" : "désactivé";
            throw new OperationNotPermittedException("Le facteur " + id + " a déjà été " + action);
        }
        if (!activate) {
            Type type = facteur.getType();
            if ( type != null && !type.getActive()) {
                throw new OperationNotPermittedException("Le type " + id + " est désactivé (active ce type)");
            }
        }
        facteur.setActive(activate);
        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }

    private Facteur findbyid(Long id,boolean permision) {
        Facteur facteur = facteurRepository.findByIdAndIsDeletedIsNull(id);
        if (facteur == null) {
            throw new EntityNotFoundException("facteur not found with id: " + id);
        }
        boolean check =check_owner(facteur,permision);
        if (!check){
            throw new AccessDeniedException("Vous n'êtes pas autorisé à accéder à cette ressource.");
        }
        return facteur;
    }

    private Facteur findbyid_deleted(Long id) {
        Facteur facteur = facteurRepository.findByIdAndIsDeletedNotNull(id);
        if (facteur == null) {
            throw  new EntityNotFoundException("facteur not found with id: " + id);
        }
        boolean check =check_owner(facteur,true);
        if (!check){
            throw new AccessDeniedException("Vous n'êtes pas autorisé à accéder à cette ressource.");
        }
        return facteur;
    }

    private boolean check_owner(Facteur res, boolean permission) {
        Map<String, Object> table = userclaim.getUserInfo();
        if (table.containsKey("roles")) {
            Collection<GrantedAuthority> roles = (Collection<GrantedAuthority>) table.get("roles");
            if(permission){
                boolean hasPermission = roles.stream()
                        .anyMatch(role -> role.getAuthority().equals("ADMIN")
                                || role.getAuthority().equals("MANAGER")
                                || role.getAuthority().equals("RESPONSABLE"));
                if (!hasPermission) {
                    throw new AccessDeniedException("Accès refusé pour le rôle actuel.");
                }
            }
            boolean isNotAdmin = roles.stream().noneMatch(role -> role.getAuthority().equals("ADMIN"));

            if (isNotAdmin) {
                String subject = table.get("sub").toString();
                Utilisateur utilisateur = userRepository.findById(subject)
                        .orElseThrow(() -> new AccessDeniedException("Utilisateur non trouvé, accès refusé."));
                Entreprise entreprise = utilisateur.getEntreprise();

                if (entreprise == null) {
                    throw new EntityNotFoundException("L'utilisateur n'appartient pas à une entreprise.");
                }

                return res.getEntreprise() == null || Objects.equals(res.getEntreprise().getId(), entreprise.getId());
            }else {
                return true;
            }
        }

        return true;
    }
    private Entreprise check_owner_entreprise() {
        Entreprise entr = null;
        Map<String, Object> table = userclaim.getUserInfo();
        if (table.containsKey("roles")) {
            Collection<GrantedAuthority> roles = (Collection<GrantedAuthority>) table.get("roles");
            boolean hasPermission = roles.stream()
                    .anyMatch(role -> role.getAuthority().equals("ADMIN")
                            || role.getAuthority().equals("MANAGER")
                            || role.getAuthority().equals("RESPONSABLE"));
            if (!hasPermission) {
                throw new AccessDeniedException("Accès refusé pour le rôle actuel.");
            }
            boolean isNotAdmin = roles.stream().noneMatch(role -> role.getAuthority().equals("ADMIN"));
            if (isNotAdmin) {
                String subject = table.get("sub").toString();
                Utilisateur utilisateur = userRepository.findById(subject)
                        .orElseThrow(() -> new AccessDeniedException("Utilisateur non trouvé, accès refusé."));
                entr = utilisateur.getEntreprise();
                if (entr == null) {
                    throw new EntityNotFoundException("L'utilisateur n'appartient pas à une entreprise.");
                }
            }
        }
        return entr;
    }

}