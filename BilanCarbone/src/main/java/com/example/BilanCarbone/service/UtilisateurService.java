package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.config.CustomUserRepresentation;
import com.example.BilanCarbone.dto.UtilisateurCreationRequest;
import com.example.BilanCarbone.dto.UtilisateurModificationRequest;
import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Utilisateur;
import com.example.BilanCarbone.jpa.EntrepriseRepository;
import com.example.BilanCarbone.jpa.UtilisateurRepository;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.representations.idm.UserRepresentation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Pageable;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Service pour gérer les utilisateurs.
 * Ce service fournit des méthodes pour récupérer, bloquer et supprimer des utilisateurs depuis Keycloak.
 *
 * @author CHALABI Hossam
 */

@Slf4j
@Service
public class UtilisateurService {

    @Autowired
    private RestTemplate restTemplate;

    @Value("${keycloak.auth-server-url}")
    private String keycloakURL;

    @Value("${keycloak.realm}")
    private String realm;

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    @Autowired
    private EntrepriseRepository entrepriseRepository;

    Logger logger =  LoggerFactory.getLogger(UtilisateurService.class);
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
            throw new RuntimeException("L'utilisateur n'est pas trouvé pour l'ajouter dans le CustomUserRepresentation");
        }
    }

    /**
     * Récupère une liste paginée d'utilisateurs depuis Keycloak.
     *
     * @param currentpage le numéro de la page actuelle
     * @param size le nombre d'utilisateurs par page
     * @param search le terme de recherche pour filtrer les utilisateurs par prénom, nom ou nom d'utilisateur
     * @param token le jeton d'authentification Bearer
     * @return un objet PageResponse contenant la liste paginée des objets CustomUserRepresentation
     */
    @Transactional
    public PageResponse<CustomUserRepresentation> getAllUtilisateur(int currentpage, int size, String search, String token) {
        Pageable pageable = PageRequest.of(currentpage, size);
        String URL = keycloakURL + "/admin/realms/" + realm + "/users";
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<String> httpEntity = new HttpEntity<>(headers);

        ResponseEntity<List<UserRepresentation>> response = restTemplate.exchange(
                URL, HttpMethod.GET, httpEntity, new ParameterizedTypeReference<List<UserRepresentation>>() {});

        List<UserRepresentation> utilisateurs = response.getBody();
        utilisateurs = utilisateurs.stream()
                .filter(utilisateur -> !"admin".equals(utilisateur.getUsername()))
                .collect(Collectors.toList());

        List<UserRepresentation> filtredUtilisateur = search.isEmpty() ? utilisateurs : utilisateurs.stream()
                .filter(utilisateur -> utilisateur.getFirstName().contains(search) ||
                        utilisateur.getLastName().contains(search) ||
                        utilisateur.getUsername().contains(search))
                .collect(Collectors.toList());

        List<CustomUserRepresentation> customUsers = filtredUtilisateur.stream()
                .map(user -> new CustomUserRepresentation(user, fetchEntrepriseOfUtilisateur(user)))
                .collect(Collectors.toList());
        int totalElements = customUsers.size();
        int totalPages = (int) Math.ceil((double) totalElements / size);
        int start = Math.min((int) pageable.getOffset(), totalElements);
        int end = Math.min((start + pageable.getPageSize()), totalElements);
        boolean isLast = (end == totalElements - 1);
        boolean isFirst = (start == 0);
        List<CustomUserRepresentation> pageContent = customUsers.subList(start, end);

        return PageResponse.<CustomUserRepresentation>builder()
                .content(pageContent)
                .number(pageable.getPageNumber())
                .size(pageable.getPageSize())
                .totalElements(totalElements)
                .totalPages(totalPages)
                .first(isFirst)
                .last(isLast)
                .build();
    }
    public CustomUserRepresentation getUtilisateurById(String ID,String token){

        String URL = keycloakURL + "/admin/realms/" + realm + "/users/"+ID;
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<String> httpEntity = new HttpEntity<>(headers);
        try{
            ResponseEntity<UserRepresentation> response = restTemplate.exchange(URL,HttpMethod.GET,httpEntity,UserRepresentation.class);
            UserRepresentation user=response.getBody();
            return new CustomUserRepresentation(user,fetchEntrepriseOfUtilisateur(user));

        }
        catch (Exception e){throw new RuntimeException("getUtilisateurById : User not found",e);}

    }
    // ----------------------


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


    public CustomUserRepresentation createUtilisateur(UtilisateurCreationRequest utilisateurCreationRequest,String token) {
        String URL = keycloakURL + "/admin/realms/" + realm + "/users";
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        Map<String, Object> userRepresentation = new HashMap<>();
        userRepresentation.put("username", utilisateurCreationRequest.username());
        userRepresentation.put("enabled", true);
        userRepresentation.put("firstName", utilisateurCreationRequest.firstName());
        userRepresentation.put("lastName",utilisateurCreationRequest.lastName());
        userRepresentation.put("email", utilisateurCreationRequest.email());
        userRepresentation.put("credentials", List.of(
                Map.of("type", "password", "value", utilisateurCreationRequest.password(), "temporary", false)
        ));
        HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(userRepresentation, headers);
        ResponseEntity<UserRepresentation> response = restTemplate.exchange(URL, HttpMethod.POST, httpEntity, UserRepresentation.class);

        if(response.getStatusCode().is2xxSuccessful()){
            String IdUtilisateur=getUserId(utilisateurCreationRequest.username(),token);
            UserRepresentation userRepresentationResponse=getUtilisateurById(IdUtilisateur,token).getUserRepresentation();
            Entreprise entreprise=entrepriseRepository.findById(utilisateurCreationRequest.entreprise_id()).isPresent()?entrepriseRepository.findById(utilisateurCreationRequest.entreprise_id()).get():null;
            try{
                Utilisateur utilisateur=Utilisateur.builder()
                        .id(IdUtilisateur)
                        .entreprise(entreprise)
                        .build();
                utilisateurRepository.save(utilisateur);
            }
            catch (RuntimeException e) {
                throw new RuntimeException("Utilisateur is unsaved : "+e);
            }

            try {
                String idRole = getRoleId(utilisateurCreationRequest.role(), token);
                assignRoleToUser(IdUtilisateur,idRole,utilisateurCreationRequest.role(),token);
                return  CustomUserRepresentation.builder()
                        .userRepresentation(userRepresentationResponse)
                        .entreprise(entreprise)
                        .build();
            }
            catch (RuntimeException e){
                throw new RuntimeException("Role not assign to utilisateur"+e);
            }
        }


        return null ;

    }


    // ----------------------
    public CustomUserRepresentation updateUtilisateur(String ID, String token, UtilisateurModificationRequest new_Utilisateur) {
        String URL = keycloakURL + "/admin/realms/" + realm + "/users/" + ID;
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<String> httpEntity1 = new HttpEntity<>(headers);
        ResponseEntity<UserRepresentation> response1 = restTemplate.exchange(URL, HttpMethod.GET, httpEntity1, UserRepresentation.class);
       if (response1.getStatusCode().is2xxSuccessful()) {
                UserRepresentation ex_userRepresentation = response1.getBody();
                if(ex_userRepresentation != null){
                    ex_userRepresentation.setEmail(new_Utilisateur.email());
                    ex_userRepresentation.setFirstName(new_Utilisateur.firstName());
                    ex_userRepresentation.setLastName(new_Utilisateur.lastName());
                    HttpEntity<UserRepresentation> httpEntity2 = new HttpEntity<>(ex_userRepresentation, headers);
                    ResponseEntity<UserRepresentation> response2 = restTemplate.exchange(URL, HttpMethod.PUT, httpEntity2, UserRepresentation.class);
                    if(response2.getStatusCode().is2xxSuccessful()){
                        ResponseEntity<UserRepresentation> response3 = restTemplate.exchange(URL, HttpMethod.GET, httpEntity1, UserRepresentation.class);
                        UserRepresentation userInfo=response3.getBody();
                        String idRole=getRoleId(new_Utilisateur.role(),token);
                        String UtilisateurId=response3.getBody()!=null?response3.getBody().getId():null;
                        assignRoleToUser(UtilisateurId,idRole,new_Utilisateur.role(),token);
                        if(userInfo!=null && UtilisateurId!=null){
                            Utilisateur user=utilisateurRepository.findById(UtilisateurId).get();
                            user.setId(UtilisateurId);
                            Entreprise entreprise=entrepriseRepository.findById(new_Utilisateur.entreprise_id()).get();
                            user.setEntreprise(entreprise);
                            utilisateurRepository.save(user);

                            return new CustomUserRepresentation(userInfo, fetchEntrepriseOfUtilisateur(userInfo));

                        }
                        else{
                            throw new RuntimeException("userInfo or UtilisateurId is null or both");
                        }
                    }
                    else {
                        throw new RuntimeException("Failed to fetch user for update");
                    }
                }
                else{
                    throw new RuntimeException("ex_userRepresentation is null");
                }
       }
       else {
           throw new RuntimeException("Utilisateur not found to update");
       }

    }



    /**
     * Bloque ou débloque un utilisateur en fonction de son identifiant.
     *
     * @param ID l'identifiant de l'utilisateur à bloquer ou débloquer
     * @param token le jeton d'authentification Bearer
     * @return true si l'utilisateur a été bloqué ou débloqué avec succès, sinon false
     */
    public boolean blockUtilisateur(String ID, String token) {
        String URL = keycloakURL + "/admin/realms/" + realm + "/users/" + ID;
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<String> httpEntity = new HttpEntity<>(headers);
        ResponseEntity<UserRepresentation> response = restTemplate.exchange(
                URL, HttpMethod.GET, httpEntity, UserRepresentation.class);
        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            UserRepresentation user = response.getBody();
            boolean enabled = user.isEnabled();
            user.setEnabled(!enabled);
            HttpEntity<UserRepresentation> updateEntity = new HttpEntity<>(user, headers);
            ResponseEntity<Void> responseUpdate = restTemplate.exchange(
                    URL, HttpMethod.PUT, updateEntity, Void.class);
            return true;
        }
        return false;
    }

    /**
     * Supprime un utilisateur en fonction de son identifiant.
     *
     * @param ID l'identifiant de l'utilisateur à supprimer
     * @param token le jeton d'authentification Bearer
     * @return true si l'utilisateur a été supprimé avec succès, sinon false
     */
    public boolean DeleteUtilisateur(String ID, String token) {
        String URL = keycloakURL + "/admin/realms/" + realm + "/users/" + ID;
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<Void> httpEntity = new HttpEntity<>(headers);
        ResponseEntity<Void> response = restTemplate.exchange(
                URL, HttpMethod.DELETE, httpEntity, Void.class);
        return response.getStatusCode().is2xxSuccessful();
    }
}
/*

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


public CustomUserRepresentation createUtilisateur(UtilisateurCreationRequest utilisateurCreationRequest,String token) {
    String URL = keycloakURL + "/admin/realms/" + realm + "/users";
    HttpHeaders headers = new HttpHeaders();
    headers.setBearerAuth(token);
    Map<String, Object> userRepresentation = new HashMap<>();
    userRepresentation.put("username", utilisateurCreationRequest.username());
    userRepresentation.put("enabled", true);
    userRepresentation.put("firstName", utilisateurCreationRequest.firstName());
    userRepresentation.put("lastName",utilisateurCreationRequest.lastName());
    userRepresentation.put("email", utilisateurCreationRequest.email());
    userRepresentation.put("credentials", List.of(
            Map.of("type", "password", "value", utilisateurCreationRequest.password(), "temporary", false)
    ));
    HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(userRepresentation, headers);
    ResponseEntity<UserRepresentation> response = restTemplate.exchange(URL, HttpMethod.POST, httpEntity, UserRepresentation.class);
    if(response.getStatusCode().is2xxSuccessful()){
        String IdUtilisateur=getUserId(utilisateurCreationRequest.username(),token);
        UserRepresentation userRepresentationResponse=getUtilisateurById(IdUtilisateur,token).getUserRepresentation();
        Entreprise entreprise=entrepriseRepository.findById(utilisateurCreationRequest.entreprise_id()).isPresent()?entrepriseRepository.findById(utilisateurCreationRequest.entreprise_id()).get():null;
        try{
            Utilisateur utilisateur=Utilisateur.builder()
                    .id(IdUtilisateur)
                    .entreprise(entreprise)
                    .build();

            utilisateurRepository.save(utilisateur);
        }
        catch (RuntimeException e) {
            throw new RuntimeException("Utilisateur is unsaved : "+e);
        }

        try {
            String idRole = getRoleId(utilisateurCreationRequest.role(), token);
            assignRoleToUser(IdUtilisateur,idRole,utilisateurCreationRequest.role(),token);
            return  CustomUserRepresentation.builder()
                    .userRepresentation(userRepresentationResponse)
                    .entreprise(entreprise)
                    .build();
        }
        catch (RuntimeException e){
            throw new RuntimeException("Role not assign to utilisateur"+e);
        }
    }


    return null ;

}
* */