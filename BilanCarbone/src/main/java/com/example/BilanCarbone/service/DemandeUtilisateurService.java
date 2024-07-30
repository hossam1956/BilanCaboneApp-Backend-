package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.entity.DemandeUtilisateur;
import com.example.BilanCarbone.jpa.DemandeUtilisateurRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service pour gérer les demandes d'utilisateurs.
 *
 * @author CHALABI Hossam
 */
@Service
public class DemandeUtilisateurService {
    @Autowired
    private DemandeUtilisateurRepository demandeUtilisateurRepository;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${keycloak.auth-server-url}")
    private String keycloakURL;

    @Value("${keycloak.realm}")
    private String realm;


    /**
     * Récupère toutes les demandes d'utilisateur avec pagination et recherche.
     *
     * @param current_page le numéro de la page actuelle.
     * @param size la taille de la page.
     * @param search le terme de recherche.
     * @return une réponse paginée contenant les demandes d'utilisateur.
     */
    @Transactional
    public PageResponse<DemandeUtilisateur> getAllDemandeUtilisateur(int current_page, int size, String search) {
        Pageable page = PageRequest.of(current_page, size);
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

    /**
     * Ajoute une demande d'utilisateur.
     *
     * @param demandeUtilisateur la demande d'utilisateur à ajouter.
     * @return la demande d'utilisateur ajoutée.
     */
    @Transactional
    public DemandeUtilisateur addDemandeUtilisateur(DemandeUtilisateur demandeUtilisateur) {
        if (demandeUtilisateur != null) {
            return demandeUtilisateurRepository.save(demandeUtilisateur);
        }
        return null;
    }

    /**
     * Accepte une demande d'utilisateur en créant un utilisateur dans Keycloak.
     *
     * @param demandeUtilisateurId l'identifiant de la demande d'utilisateur.
     * @param token le jeton d'accès.
     * @return true si la demande est acceptée, false sinon.
     */
    @Transactional
    public boolean AccepterDemandeUtilisateur(Long demandeUtilisateurId, String token) {
        if (demandeUtilisateurId != null) {
            RestTemplate restTemplate = new RestTemplate();
            DemandeUtilisateur demandeUtilisateur = demandeUtilisateurRepository.findById(demandeUtilisateurId)
                    .orElseThrow(() -> new EntityNotFoundException("La demande avec id: " + demandeUtilisateurId + " n'est pas trouvée"));
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
            userRepresentation.put("credentials", List.of(
                    Map.of("type", "password", "value", demandeUtilisateur.getPassword(), "temporary", false)
            ));
            HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(userRepresentation, headers);
            ResponseEntity<String> response = restTemplate.exchange(URL, HttpMethod.POST, httpEntity, String.class);
            if (response.getStatusCode().is2xxSuccessful()) {
                demandeUtilisateurRepository.delete(demandeUtilisateur);
                return true;
            } else {
                throw new RuntimeException("Erreur pendant la création de l'utilisateur dans Keycloak: " + response.getStatusCode());
            }
        }
        return false;
    }

    /**
     * Refuse une demande d'utilisateur en la supprimant.
     *
     * @param demandeUtilisateurId l'identifiant de la demande d'utilisateur.
     * @return true si la demande est refusée, false sinon.
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
