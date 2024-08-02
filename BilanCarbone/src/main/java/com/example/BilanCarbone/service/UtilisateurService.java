package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import jakarta.transaction.Transactional;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import org.springframework.data.domain.Pageable;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service pour gérer les utilisateurs.
 * Ce service fournit des méthodes pour récupérer des utilisateurs depuis Keycloak.
 * <p>
 * @author CHALABI Hossam
 * </p>
 */
@Service
public class UtilisateurService {

    @Autowired
    private RestTemplate restTemplate;

    @Value("${keycloak.auth-server-url}")
    private String keycloakURL;

    @Value("${keycloak.realm}")
    private String realm;

    /**
     * Récupère une liste paginée d'utilisateurs depuis Keycloak.
     *
     * @param currentpage le numéro de la page actuelle
     * @param size le nombre d'utilisateurs par page
     * @param search le terme de recherche pour filtrer les utilisateurs par prénom, nom ou nom d'utilisateur
     * @param token le jeton d'authentification Bearer
     * @return un objet PageResponse contenant la liste paginée des objets UserRepresentation
     */
    @Transactional
    public PageResponse<UserRepresentation> getAllUtilisateur(int currentpage, int size, String search, String token) {
        Pageable pageable = PageRequest.of(currentpage, size);
        RestTemplate restTemplate = new RestTemplate();
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

        int totalElements = filtredUtilisateur.size();
        int totalPages = (int) Math.ceil((double) totalElements / size);
        int start = Math.min((int) pageable.getOffset(), totalElements);
        int end = Math.min((start + pageable.getPageSize()), totalElements);
        boolean isLast = (end == totalElements - 1);
        boolean isFirst = (start == 0);
        List<UserRepresentation> pageContent = filtredUtilisateur.subList(start, end);

        return PageResponse.<UserRepresentation>builder()
                .content(pageContent)
                .number(pageable.getPageNumber())
                .size(pageable.getPageSize())
                .totalElements(totalElements)
                .totalPages(totalPages)
                .first(isFirst)
                .last(isLast)
                .build();
    }

    public boolean blockUtilisateur(String ID,String token){
        RestTemplate restTemplate = new RestTemplate();
        String URL = keycloakURL + "/admin/realms/" + realm + "/users/"+ID;
        System.out.println(URL);
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(token);
        HttpEntity<String> httpEntity = new HttpEntity<>(headers);
        ResponseEntity<UserRepresentation> response = restTemplate.exchange(
                URL, HttpMethod.GET, httpEntity,UserRepresentation.class);
        if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
            UserRepresentation user=response.getBody();
            boolean enabled=user.isEnabled();
            user.setEnabled(!enabled);
            HttpEntity<UserRepresentation> updateEntity = new HttpEntity<>(user,headers);
            ResponseEntity<Void> responseUpdate = restTemplate.exchange(
                    URL, HttpMethod.PUT, updateEntity,Void.class);
            return true;
        }


        return false;
    }
}
