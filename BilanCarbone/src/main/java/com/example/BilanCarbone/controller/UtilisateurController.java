package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.service.UtilisateurService;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpHeaders;

/**
 * Contrôleur pour gérer les requêtes liées aux utilisateurs.
 * Ce contrôleur fournit des points d'accès pour récupérer, bloquer et supprimer des utilisateurs.
 *
 * @author CHALABI Hossam
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

    /**
     * Bloque un utilisateur en fonction de son identifiant.
     *
     * @param ID l'identifiant de l'utilisateur à bloquer
     * @param authorizationHeader l'en-tête d'autorisation contenant le jeton Bearer
     * @return true si l'utilisateur a été bloqué avec succès, sinon false
     */
    @PutMapping("block")
    public boolean blockUtilisateur(
            @RequestParam(defaultValue = "") String ID,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader
    ) {
        String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;
        return utilisateurService.blockUtilisateur(ID, token);
    }

    /**
     * Supprime un utilisateur en fonction de son identifiant.
     *
     * @param ID l'identifiant de l'utilisateur à supprimer
     * @param authorizationHeader l'en-tête d'autorisation contenant le jeton Bearer
     * @return true si l'utilisateur a été supprimé avec succès, sinon false
     */
    @DeleteMapping
    public boolean deleteUtilisateur(
            @RequestParam(defaultValue = "") String ID,
            @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader
    ) {
        String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;
        return utilisateurService.DeleteUtilisateur(ID, token);
    }
}
