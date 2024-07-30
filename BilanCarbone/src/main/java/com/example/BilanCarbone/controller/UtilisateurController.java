package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.service.UtilisateurService;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpHeaders;

/**
 * Contrôleur pour gérer les requêtes liées aux utilisateurs.
 * Ce contrôleur fournit des points d'accès pour récupérer les utilisateurs.
 *
 * @author CHALABI Hossam
 *
 */
@RestController
@RequestMapping("api/utilisateur")
public class UtilisateurController {

    @Autowired
    private UtilisateurService utilisateurService;

    /**
     * Récupère une liste paginée d'utilisateurs.
     *
     * @param page le numéro de la page à récupérer, la valeur par défaut est 0
     * @param size le nombre d'utilisateurs par page, la valeur par défaut est 8
     * @param search le terme de recherche pour filtrer les utilisateurs par prénom ou nom, la valeur par défaut est vide
     * @param authorizationHeader l'en-tête d'autorisation contenant le jeton Bearer
     * @return un objet PageResponse contenant la liste paginée des objets UserRepresentation
     */
    @GetMapping
    public PageResponse<UserRepresentation> getAllUtilisateur(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "") String search,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader) {
        String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;
        return utilisateurService.getAllUtilisateur(page, size, search, token);
    }
}
