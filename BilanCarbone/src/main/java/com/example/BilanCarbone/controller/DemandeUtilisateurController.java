package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.entity.DemandeUtilisateur;
import com.example.BilanCarbone.service.DemandeUtilisateurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*")
@RequestMapping("api/demande")
@RestController
public class DemandeUtilisateurController {

    @Autowired
    private DemandeUtilisateurService demandeUtilisateurService;

    /**
     * Récupère toutes les demandes d'utilisateur avec pagination et recherche.
     *
     * @param page le numéro de la page actuelle.
     * @param size la taille de la page.
     * @param search le terme de recherche.
     * @return une réponse contenant les demandes d'utilisateur paginées.
     */
    @GetMapping
    public ResponseEntity<PageResponse<DemandeUtilisateur>> getDemandesUtilisateur(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "") String search) {
        return ResponseEntity.ok(demandeUtilisateurService.getAllDemandeUtilisateur(page, size, search));
    }

    /**
     * Crée une nouvelle demande d'utilisateur.
     *
     * @param demandeUtilisateur la demande d'utilisateur à créer.
     * @return la demande d'utilisateur créée.
     */
    @PostMapping
    public DemandeUtilisateur createDemandesUtilisateur(@RequestBody DemandeUtilisateur demandeUtilisateur) {
        return demandeUtilisateurService.addDemandeUtilisateur(demandeUtilisateur);
    }

    /**
     * Accepte une demande d'utilisateur.
     *
     * @param id l'identifiant de la demande d'utilisateur.
     * @param authorizationHeader l'en-tête d'autorisation contenant le jeton Bearer.
     * @return true si la demande est acceptée, false sinon.
     */
    @DeleteMapping("accept")
    public Boolean accepterDemandesUtilisateur(@RequestParam(defaultValue = "0") Long id, @RequestHeader(HttpHeaders.AUTHORIZATION) String authorizationHeader) {
        String token = authorizationHeader.startsWith("Bearer ") ? authorizationHeader.substring(7) : authorizationHeader;
        return demandeUtilisateurService.AccepterDemandeUtilisateur(id, token);
    }

    /**
     * Refuse une demande d'utilisateur.
     *
     * @param id l'identifiant de la demande d'utilisateur.
     * @return true si la demande est refusée, false sinon.
     */
    @DeleteMapping("reject")
    public Boolean refuserDemandesUtilisateur(@RequestParam(defaultValue = "0") Long id) {
        return demandeUtilisateurService.RefuserDemandeUtilisateur(id);
    }
}
