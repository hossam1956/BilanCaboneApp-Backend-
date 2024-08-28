package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.DemandeUtilisateurDTO;
import com.example.BilanCarbone.entity.DemandeUtilisateur;
import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Utilisateur;
import com.example.BilanCarbone.jpa.DemandeUtilisateurRepository;
import com.example.BilanCarbone.jpa.EntrepriseRepository;
import com.example.BilanCarbone.jpa.UtilisateurRepository;
import com.example.BilanCarbone.security.PasswordEncryptionService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.keycloak.representations.idm.UserRepresentation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Service pour gérer les demandes d'utilisateurs.
 * Ce service permet de récupérer, ajouter, accepter ou refuser des demandes d'utilisateurs,
 * ainsi que de gérer les utilisateurs dans Keycloak.
 *
 * @author CHALABI Hossam
 */
@Service
public class DemandeUtilisateurService {
    private static final Logger log = LoggerFactory.getLogger(DemandeUtilisateurService.class);

    @Autowired
    private DemandeUtilisateurRepository demandeUtilisateurRepository;

    @Autowired
    private EntrepriseRepository entrepriseRepository;

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${keycloak.auth-server-url}")
    private String keycloakURL;

    @Value("${keycloak.realm}")
    private String realm;

    @Autowired
    private PasswordEncryptionService passwordEncryptionService;
    /**
     * Convertit un objet DemandeUtilisateurDTO en une entité DemandeUtilisateur.
     *
     * @param demandeUtilisateurDTO l'objet Data Transfer Object à convertir.
     * @return l'entité DemandeUtilisateur correspondante.
     */
    public DemandeUtilisateur toEntity(DemandeUtilisateurDTO demandeUtilisateurDTO) {
        Optional<Entreprise> optionalEntreprise = entrepriseRepository.findById(demandeUtilisateurDTO.getEntreprise_id());
        Entreprise entrepriseFound = optionalEntreprise.orElseThrow(() -> new RuntimeException("Cette entreprise n'existe pas"));


        return DemandeUtilisateur.builder()
                .id(demandeUtilisateurDTO.getId())
                .nomUtilisateur(demandeUtilisateurDTO.getNomUtilisateur())
                .email(demandeUtilisateurDTO.getEmail())
                .prenom(demandeUtilisateurDTO.getPrenom())
                .nom(demandeUtilisateurDTO.getNom())
                .sendDate(demandeUtilisateurDTO.getSendDate())
                .role(demandeUtilisateurDTO.getRole())
                .entreprise(entrepriseFound)
                .password(passwordEncryptionService.encryptPassword(demandeUtilisateurDTO.getPassword()))
                .build();
    }
    /**
     * Récupère l'entreprise associée à un utilisateur.
     *
     * @param user l'utilisateur dont on souhaite récupérer l'entreprise
     * @return l'entreprise associée à l'utilisateur
     * @throws RuntimeException si l'utilisateur n'est pas trouvé dans la base de données
     */
    public Entreprise fetchEntrepriseOfUtilisateur(UserRepresentation user) {
        String ID = user.getId();
        if (utilisateurRepository.findById(ID).isPresent()) {
            return utilisateurRepository.findById(ID).get().getEntreprise();
        } else {
            throw new RuntimeException("L'utilisateur n'est pas trouvé ");
        }
    }
    /**
     * Récupère toutes les demandes d'utilisateur avec pagination et recherche.
     *
     * @param current_page le numéro de la page actuelle.
     * @param size la taille de la page.
     * @param search le terme de recherche pour filtrer les demandes.
     * @return une réponse paginée contenant les demandes d'utilisateur.
     */
    @Transactional
    public PageResponse<DemandeUtilisateur> getAllDemandeUtilisateur(int current_page, int size, String search,String token,Object roles,Object idUser) {
        Pageable page = PageRequest.of(current_page, size);
        if(roles.toString().contains("ADMIN")){
            Page<DemandeUtilisateur> pages = search.isEmpty() ?
                    demandeUtilisateurRepository.findAll(page) :
                    demandeUtilisateurRepository.findAllByNomContainingIgnoreCase(search.toLowerCase().trim(), page);
                    List<DemandeUtilisateur> res = pages.stream().toList();

                    return PageResponse.<DemandeUtilisateur>builder()
                            .content(res)
                            .number(pages.getNumber())
                            .size(pages.getSize())
                            .totalElements(pages.getTotalElements())
                            .totalPages(pages.getTotalPages())
                            .first(pages.isFirst())
                            .last(pages.isLast())
                            .build();
        }
        else if(roles.toString().contains("MANAGER")){
            String URL_GET_CONNECTED_USER = keycloakURL + "/admin/realms/" + realm + "/users/"+String.valueOf(idUser);
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(token);
            HttpEntity<String> httpEntity = new HttpEntity<>(headers);
            ResponseEntity<UserRepresentation> response_GET_CONNECTED_USER = restTemplate.exchange(URL_GET_CONNECTED_USER,HttpMethod.GET,httpEntity,UserRepresentation.class);
            if (response_GET_CONNECTED_USER.getStatusCode().is2xxSuccessful()) {
                UserRepresentation user = response_GET_CONNECTED_USER.getBody();
                Entreprise entreprise = fetchEntrepriseOfUtilisateur(user);
                Page<DemandeUtilisateur> pages = search.isEmpty() ?
                        demandeUtilisateurRepository.findAllByEntreprise(entreprise,page) :
                        demandeUtilisateurRepository.findAllByNomContainingIgnoreCaseFilterByEntreprise(search.toLowerCase().trim(),entreprise, page);
                List<DemandeUtilisateur> res = pages.stream().toList();
                return PageResponse.<DemandeUtilisateur>builder()
                        .content(res)
                        .number(pages.getNumber())
                        .size(pages.getSize())
                        .totalElements(pages.getTotalElements())
                        .totalPages(pages.getTotalPages())
                        .first(pages.isFirst())
                        .last(pages.isLast())
                        .build();
            }
            else{
                throw new RuntimeException("getAllDemandeUtilisateur:Failed to fetch Connected User ");
            }

        }

        throw new RuntimeException("getAllDemandeUtilisateur:The connected user is not a MANAGER or ADMIN ");

    }

    /**
     * Ajoute une nouvelle demande d'utilisateur en la sauvegardant dans la base de données.
     *
     * @param demandeUtilisateurDTO les détails de la demande d'utilisateur à ajouter.
     * @return l'objet DemandeUtilisateur sauvegardé.
     */
    @Transactional
    public DemandeUtilisateur addDemandeUtilisateur(DemandeUtilisateurDTO demandeUtilisateurDTO) {
        DemandeUtilisateur demandeUtilisateur = this.toEntity(demandeUtilisateurDTO);
        return demandeUtilisateurRepository.save(demandeUtilisateur);
    }

    /**
     * Récupère l'identifiant d'un rôle dans Keycloak en fonction du nom du rôle.
     *
     * @param roleName le nom du rôle dont on souhaite obtenir l'identifiant.
     * @param token le jeton d'authentification Bearer.
     * @return l'identifiant du rôle.
     * @throws RuntimeException si le rôle n'est pas trouvé.
     */
    public String getRoleId(String roleName, String token) {
        if(roleName.equals("ADMIN")){throw new RuntimeException("Rôle non trouvé");}
        String url = keycloakURL + "/admin/realms/" + realm + "/roles/" + roleName;
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);

        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            return (String) response.getBody().get("id");
        }

        throw new RuntimeException("Rôle non trouvé");
    }

    /**
     * Récupère l'identifiant d'un utilisateur dans Keycloak en fonction du nom d'utilisateur.
     *
     * @param userName le nom d'utilisateur dont on souhaite obtenir l'identifiant.
     * @param token le jeton d'authentification Bearer.
     * @return l'identifiant de l'utilisateur.
     * @throws RuntimeException si l'utilisateur n'est pas trouvé.
     */
    public String getUserId(String userName, String token) {
        String url = keycloakURL + "/admin/realms/" + realm + "/users?username=" + userName;
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<List<Map<String, Object>>> response = restTemplate.exchange(url, HttpMethod.GET, entity, new ParameterizedTypeReference<>() {});

        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            return (String) response.getBody().get(0).get("id");
        }

        throw new RuntimeException("Utilisateur non trouvé");
    }

    /**
     * Assigne un rôle à un utilisateur dans Keycloak.
     *
     * @param userId l'identifiant de l'utilisateur.
     * @param roleId l'identifiant du rôle.
     * @param roleName le nom du rôle.
     * @param token le jeton d'authentification Bearer.
     * @throws RuntimeException si l'attribution du rôle échoue ou si le rôle n'est pas trouvé.
     */
    public void assignRoleToUser(String userId, String roleId, String roleName, String token) {
        String url = keycloakURL + "/admin/realms/" + realm + "/users/" + userId + "/role-mappings/realm";
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        if (!roleName.equals("ADMIN")) {
            Map<String, Object> roleRepresentation = new HashMap<>();
            roleRepresentation.put("id", roleId);
            roleRepresentation.put("name", roleName);
            HttpEntity<List<Map<String, Object>>> entity = new HttpEntity<>(List.of(roleRepresentation), headers);
            ResponseEntity<Void> response = restTemplate.exchange(url, HttpMethod.POST, entity, Void.class);

            if (!response.getStatusCode().is2xxSuccessful()) {
                throw new RuntimeException("Échec de l'attribution du rôle à l'utilisateur");

            }
        } else {
            throw new RuntimeException("Rôle non trouvé");
        }
    }

    /**
     * Accepte une demande d'utilisateur en créant un utilisateur dans Keycloak et en l'ajoutant à la base de données.
     *
     * @param demandeUtilisateurId l'identifiant de la demande d'utilisateur.
     * @param token le jeton d'accès Bearer.
     * @return true si la demande est acceptée et l'utilisateur est créé, sinon false.
     */
    @Transactional
    public boolean AccepterDemandeUtilisateur(Long demandeUtilisateurId, String token) {


        if (demandeUtilisateurId != null) {

            DemandeUtilisateur demandeUtilisateur = demandeUtilisateurRepository.findById(demandeUtilisateurId)
                    .orElseThrow(() -> new EntityNotFoundException("La demande avec id: " + demandeUtilisateurId + " n'est pas trouvée"));
            //--------------
            if(demandeUtilisateur.getRole().equals("MANAGER")){
                List<Utilisateur> utilisateurs=utilisateurRepository.findAll();

                List<Utilisateur> utilisateursByEntreprise=utilisateurs.stream()
                        .filter(utilisateur -> utilisateur.getEntreprise()==demandeUtilisateur.getEntreprise())
                        .collect(Collectors.toList());
                for(Utilisateur utilisateur:utilisateursByEntreprise){
                    String URL_FETCH_ROLE = keycloakURL + "admin/realms/" + realm + "/users/"+utilisateur.getId()+"/role-mappings/realm";
                    //System.out.println(URL_FETCH_ROLE);
                    HttpHeaders headers = new HttpHeaders();
                    headers.setBearerAuth(token);
                    HttpEntity<String> entity = new HttpEntity<>(headers);
                    ResponseEntity<List<Map<String, Object>>> roleResponse = restTemplate.exchange(URL_FETCH_ROLE, HttpMethod.GET, entity,new ParameterizedTypeReference<>() {});
                    Map<String, Object> roles=roleResponse.getBody().get(0);
                    String role=roles.get("name").toString();
                    if(role.equals("MANAGER")){
                        throw new RuntimeException("Un manager déja existant");
                    }
                    else{
                        continue;
                    }

                }



            }


            String URL = keycloakURL + "/admin/realms/" + realm + "/users";
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(token);
            String searchUrl = URL + "?email=" + demandeUtilisateur.getEmail();
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<List> searchResponse = restTemplate.exchange(searchUrl, HttpMethod.GET, entity, List.class);

            if (searchResponse.getStatusCode().is2xxSuccessful() && !searchResponse.getBody().isEmpty()) {
                return false;
            }
            Map<String, Object> userRepresentation = new HashMap<>();
            userRepresentation.put("username", demandeUtilisateur.getNomUtilisateur());
            userRepresentation.put("enabled", true);
            userRepresentation.put("firstName", demandeUtilisateur.getPrenom());
            userRepresentation.put("lastName", demandeUtilisateur.getNom());
            userRepresentation.put("email", demandeUtilisateur.getEmail());
            String rawPassword = passwordEncryptionService.decryptPassword(demandeUtilisateur.getPassword());//;

            if (rawPassword == null) {
                throw new IllegalArgumentException("Le mot de passe ne peut pas être nul");
            }
            userRepresentation.put("credentials", List.of(
                    Map.of("type", "password", "value", rawPassword, "temporary", false)
            ));
            HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(userRepresentation, headers);
            ResponseEntity<String> response = restTemplate.exchange(URL, HttpMethod.POST, httpEntity, String.class);
            if (response.getStatusCode().is2xxSuccessful()) {
                String idRole = getRoleId(demandeUtilisateur.getRole(), token);
                String idUser = getUserId(demandeUtilisateur.getNomUtilisateur(), token);
                if (idRole != null && idUser != null) {
                    utilisateurRepository.save(
                            Utilisateur.builder()
                                    .id(idUser)
                                    .entreprise(demandeUtilisateur.getEntreprise())
                                    .build()
                    );
                    try {
                        assignRoleToUser(idUser, idRole, demandeUtilisateur.getRole(), token);
                    }
                    catch (RuntimeException e){throw new RuntimeException("AccepterDemandeUtilisateur: Assign Role Failed ------> "+e);}

                    demandeUtilisateurRepository.delete(demandeUtilisateur);
                    return true;
                } else {
                   throw new RuntimeException("idRole or idUser is null");
                }
            } else {
                throw new RuntimeException("Erreur pendant la création de l'utilisateur dans Keycloak: " + response.getStatusCode());
            }
        }
        throw new RuntimeException("Error In operation of acceptation");

    }

    /**
     * Refuse une demande d'utilisateur en la supprimant de la base de données.
     *
     * @param demandeUtilisateurId l'identifiant de la demande d'utilisateur.
     * @return true si la demande est refusée et supprimée, sinon false.
     */
    @Transactional
    public boolean RefuserDemandeUtilisateur(Long demandeUtilisateurId) {
        if (demandeUtilisateurId != null) {
            DemandeUtilisateur demandeUtilisateur = demandeUtilisateurRepository.findById(demandeUtilisateurId)
                    .orElseThrow(() -> new EntityNotFoundException("La demande avec id: " + demandeUtilisateurId + " n'est pas trouvée"));

            demandeUtilisateurRepository.delete(demandeUtilisateur);
            return true;
        }
        return false;
    }
}
