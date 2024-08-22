package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurRequest;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.service.FacteurService;
import com.example.BilanCarbone.validation.OnCreate;
import com.example.BilanCarbone.validation.OnUpdate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Contrôleur REST pour gérer les opérations liées aux facteurs.
 * <p>
 * Cette classe expose les endpoints nécessaires pour effectuer des opérations CRUD (Créer, Lire, Mettre à jour, Supprimer)
 * sur les objets de type {@link-Facteur}. Elle fournit également des fonctionnalités pour activer, désactiver et récupérer les facteurs.
 * </p>
 *
 * @author Oussama
 */
@RestController
@RequestMapping("/api/facteur")
public class FacteurController {

    private final FacteurService facteurService;

    public FacteurController(FacteurService facteurService) {
        this.facteurService = facteurService;
    }

    /**
     * Obtient une liste paginée de facteurs, avec options de recherche et de tri.
     *
     * @param page   Le numéro de la page à récupérer (0 par défaut).
     * @param size   La taille de la page (8 par défaut).
     * @param search Termes de recherche pour filtrer les résultats.
     * @param sortBy Critères de tri des résultats.
     * @param my Indicateur pour obtenir les facteur personnalisé (false par défaut).
     * @return Une réponse contenant la page de facteurs correspondant aux critères spécifiés.
     */
    @GetMapping()
    public ResponseEntity<PageResponse<FacteurResponse>> list_all(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "false") Boolean my,
            @RequestParam(defaultValue = "")    String[] sortBy
    ) {
        return ResponseEntity.ok(facteurService.getAllFacteurs(page,my,size, search,sortBy));
    }

    /**
     * Obtient les détails d'un facteur spécifique par son identifiant.
     *
     * @param id L'identifiant du facteur à récupérer.
     * @return Une réponse contenant les détails du facteur demandé.
     */
    @GetMapping("/{id}")
    public ResponseEntity<FacteurResponse> get_item(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.getFacteurById(id));
    }

    /**
     * Active un facteur spécifique par son identifiant.
     *
     * @param id L'identifiant du facteur à activer.
     * @return Une réponse contenant les détails du facteur après activation.
     */
    @PutMapping("/{id}/activate")
    public ResponseEntity<FacteurResponse> activate_facteur(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.tooglefactecurtoggleActivation(id, true));
    }

    /**
     * Désactive un facteur spécifique par son identifiant.
     *
     * @param id L'identifiant du facteur à désactiver.
     * @return Une réponse contenant les détails du facteur après désactivation.
     */
    @PutMapping("/{id}/desactivate")
    public ResponseEntity<FacteurResponse> desactivate_facteur(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.tooglefactecurtoggleActivation(id, false));
    }

    /**
     * Met à jour un facteur spécifique avec les nouvelles informations fournies.
     *
     * @param id             L'identifiant du facteur à mettre à jour.
     * @param facteurRequest Les nouvelles données du facteur à mettre à jour.
     * @return Une réponse contenant les détails du facteur après mise à jour.
     */
    @PutMapping("/{id}")
    public ResponseEntity<FacteurResponse> update_facteur(@PathVariable Long id, @Validated(OnUpdate.class) @RequestBody FacteurRequest facteurRequest) {
        return ResponseEntity.ok(facteurService.update(id, facteurRequest,null,false));
    }

    /**
     * Obtient la liste des unités disponibles pour les facteurs.
     *
     * @return Une réponse contenant la liste des unités.
     */
    @GetMapping("/type")
    public ResponseEntity<List<String>> get_facteurs_unite() {
        return ResponseEntity.ok(facteurService.getType());
    }

    /**
     * Ajoute un nouveau facteur avec les données fournies.
     *
     * @param facteurRequest Les données du facteur à ajouter.
     * @return Une réponse contenant les détails du facteur après ajout.
     */
    @PostMapping()
    public ResponseEntity<FacteurResponse> Add_facteur(@Validated(OnCreate.class) @RequestBody FacteurRequest facteurRequest) {
        return ResponseEntity.ok(facteurService.addFacteur(facteurRequest, null));
    }

    /**
     * Obtient une liste de tous les facteurs, éventuellement filtrée par un identifiant parent.
     *
     * @param parent L'identifiant du parent pour filtrer les facteurs, ou -1 pour obtenir tous les facteurs.
     * @return Une réponse contenant la liste des facteurs correspondant aux critères spécifiés.
     */
    @GetMapping("/all")
    public ResponseEntity<List<FacteurResponse>> list_all_facteur(
            @RequestParam(defaultValue = "-1") Long parent) {
        return ResponseEntity.ok(facteurService.list_facteur(parent));
    }

    /**
     * Supprime un facteur spécifique par son identifiant en le marquant comme supprimé (soft delete).
     *
     * @param id L'identifiant du facteur à supprimer.
     * @return Une réponse contenant les détails du facteur après suppression.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<FacteurResponse> delete_facteur(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.delete_facteur(id));
    }

    /**
     * Supprime définitivement un facteur spécifique par son identifiant.
     *
     * @param id L'identifiant du facteur à supprimer définitivement.
     * @return Une réponse contenant les détails du facteur après suppression définitive.
     */
    @DeleteMapping("/trash/{id}")
    public ResponseEntity<FacteurResponse> delete_force_facteur(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.delete_force_facteur(id));
    }

    /**
     * Récupère un facteur spécifique de la corbeille (soft delete) par son identifiant.
     *
     * @param id L'identifiant du facteur à récupérer.
     * @return Une réponse contenant les détails du facteur après récupération.
     */
    @PostMapping("/trash/{id}")
    public ResponseEntity<FacteurResponse> recovery_facteur(@PathVariable Long id) {
        return ResponseEntity.ok(facteurService.recovery_facteur(id));
    }

    /**
     * Obtient une liste paginée de facteurs supprimés (soft delete), avec options de recherche et de tri.
     *
     * @param page   Le numéro de la page à récupérer (0 par défaut).
     * @param size   La taille de la page (8 par défaut).
     * @param search Termes de recherche pour filtrer les résultats.
     * @param sortBy Critères de tri des résultats.
     * @return Une réponse contenant la page de facteurs supprimés correspondant aux critères spécifiés.
     */
    @GetMapping("/trash")
    public ResponseEntity<PageResponse<FacteurResponse>> list_all_facteur(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "") String[] sortBy) {
        return ResponseEntity.ok(facteurService.get_All_deleted_Facteurs(page, size, search, sortBy));
    }
    /**
     * Vérifie l'existence d'un facteur avec le nom spécifié, en ignorant la casse, et s'assure que le champ
     * `isDeleted` est `null`.
     *
     * @param search le nom du facteur à rechercher
     * @return `true` si un type facteur le nom spécifié existe et n'est pas supprimé, sinon `false`
     */
    @GetMapping("/search")
    public ResponseEntity<Boolean> search(
            @RequestParam(defaultValue = "") String search,
    @RequestParam(defaultValue = "0" ) int id) {
        Boolean res=facteurService.search_facteur(search,id);

        return ResponseEntity.ok(res);
    }
}