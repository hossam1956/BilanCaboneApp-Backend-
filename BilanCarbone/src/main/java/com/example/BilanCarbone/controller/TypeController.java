package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.TypeRequest;
import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.service.TypeService;
import com.example.BilanCarbone.validation.OnCreate;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;


/**
 * Contrôleur REST pour gérer les opérations liées aux types.
 * <p>
 * Cette classe expose les endpoints nécessaires pour effectuer des opérations CRUD (Créer, Lire, Mettre à jour, Supprimer)
 * sur les objets de type {@link  -Type}. Elle fournit également des fonctionnalités pour activer, désactiver, et gérer les types
 * dans la corbeille.
 * </p>
 *
 * @author Oussama
 */
@RestController
@RequestMapping("/api/type")
public class TypeController {

    private final TypeService typeService;

    public TypeController(TypeService typeService) {
        this.typeService = typeService;
    }

    /**
     * Obtient une liste paginée de types, avec options de recherche, de tri, et de filtrage par type parent ou détaillé.
     *
     * @param page   Le numéro de la page à récupérer (0 par défaut).
     * @param size   La taille de la page (8 par défaut).
     * @param search Termes de recherche pour filtrer les résultats.
     * @param sortBy Critères de tri des résultats.
     * @param parent Indicateur pour filtrer uniquement les types parents (false par défaut).
     * @param detail Indicateur pour obtenir des détails supplémentaires sur les types (false par défaut).
     * @return Une réponse contenant la page de types correspondant aux critères spécifiés.
     */
    @GetMapping()
    public ResponseEntity<PageResponse<TypeResponse>> list_all_type(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "") String[] sortBy,
            @RequestParam(defaultValue = "false") Boolean parent,
            @RequestParam(defaultValue = "false") Boolean detail) {
        if (parent) {
            return ResponseEntity.ok(typeService.list_parent(page, size, search, sortBy));
        } else if (detail) {
            return ResponseEntity.ok(typeService.list_all_detail(page, size, search, sortBy));
        }
        return ResponseEntity.ok(typeService.list_all(page, size, search, sortBy));
    }

    /**
     * Obtient les détails d'un type spécifique par son identifiant, avec options pour des détails supplémentaires ou complets.
     *
     * @param id     L'identifiant du type à récupérer.
     * @param detail Indicateur pour obtenir des détails supplémentaires sur le type (false par défaut).
     * @param all    Indicateur pour obtenir toutes les informations disponibles sur le type (false par défaut).
     * @return Une réponse contenant les détails du type demandé.
     */
    @GetMapping("/{id}")
    public ResponseEntity<TypeResponse> get_type(
            @PathVariable Long id,
            @RequestParam(defaultValue = "false") Boolean detail,
            @RequestParam(defaultValue = "false") Boolean all) {
        TypeResponse res;
        if (all) {
            res = typeService.get_type_all(id);
        } else if (detail) {
            res = typeService.get_type_detail(id);
        } else {
            res = typeService.get_type(id);
        }
        return ResponseEntity.ok(res);
    }

    /**
     * Active un type spécifique par son identifiant, avec option pour obtenir des détails complets.
     *
     * @param id  L'identifiant du type à activer.
     * @param all Indicateur pour obtenir des détails complets après activation (false par défaut).
     * @return Une réponse contenant les détails du type après activation.
     */
    @PutMapping("/{id}/activate")
    public ResponseEntity<TypeResponse> activate_type(@PathVariable Long id, @RequestParam(defaultValue = "false") Boolean all) {
        if (!all) {
            return ResponseEntity.ok(typeService.activate_type(id));
        }
        return ResponseEntity.ok(typeService.toggle_type_detail(id, true));
    }

    /**
     * Désactive un type spécifique par son identifiant.
     *
     * @param id L'identifiant du type à désactiver.
     * @return Une réponse contenant les détails du type après désactivation.
     */
    @PutMapping("/{id}/desactivate")
    public ResponseEntity<TypeResponse> deactivate_type(@PathVariable Long id) {
        return ResponseEntity.ok(typeService.toggle_type_detail(id, false));
    }

    /**
     * Ajoute un nouveau type avec les données fournies.
     *
     * @param typeRequest Les données du type à ajouter.
     * @return Une réponse contenant les détails du type après ajout.
     */
    @PostMapping()
    public ResponseEntity<TypeResponse> add_type(@Validated(OnCreate.class) @RequestBody TypeRequest typeRequest) {
        return ResponseEntity.ok(typeService.add_type_detail(typeRequest));
    }

    /**
     * Obtient une liste de tous les types disponibles.
     *
     * @return Une réponse contenant la liste des types.
     */
    @GetMapping("/all")
    public ResponseEntity<List<TypeResponse>> list_type() {
        return ResponseEntity.ok(typeService.list_type());
    }

    /**
     * Supprime un type spécifique par son identifiant en le marquant comme supprimé (soft delete).
     *
     * @param id L'identifiant du type à supprimer.
     * @return Une réponse contenant les détails du type après suppression.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<TypeResponse> delete_type(@PathVariable Long id) {
        return ResponseEntity.ok(typeService.delete_type_detail(id));
    }

    /**
     * Supprime définitivement un type spécifique par son identifiant.
     *
     * @param id L'identifiant du type à supprimer définitivement.
     * @return Une réponse contenant les détails du type après suppression définitive.
     */
    @DeleteMapping("/trash/{id}")
    public ResponseEntity<TypeResponse> delete_force_type(@PathVariable Long id) {
        return ResponseEntity.ok(typeService.force_delete_type(id));
    }

    /**
     * Récupère un type spécifique de la corbeille (soft delete) par son identifiant.
     *
     * @param id L'identifiant du type à récupérer.
     * @return Une réponse contenant les détails du type après récupération.
     */
    @PostMapping("/trash/{id}")
    public ResponseEntity<TypeResponse> recovery_type(@PathVariable Long id) {
        return ResponseEntity.ok(typeService.recovery_delete_all(id));
    }

    /**
     * Obtient une liste paginée de types supprimés (soft delete), avec options de recherche et de tri.
     *
     * @param page   Le numéro de la page à récupérer (0 par défaut).
     * @param size   La taille de la page (8 par défaut).
     * @param search Termes de recherche pour filtrer les résultats.
     * @param sortBy Critères de tri des résultats.
     * @return Une réponse contenant la page de types supprimés correspondant aux critères spécifiés.
     */
    @GetMapping("/trash")
    public ResponseEntity<PageResponse<TypeResponse>> list_all_type_trash(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "8") int size,
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "") String[] sortBy) {
        return ResponseEntity.ok(typeService.list_all_detail_trash(page, size, search, sortBy));
    }

    /**
     * Met à jour un type spécifique avec les nouvelles informations fournies.
     *
     * @param id          L'identifiant du type à mettre à jour.
     * @param typeRequest Les nouvelles données du type à mettre à jour.
     * @return Une réponse contenant les détails du type après mise à jour.
     */
    @PutMapping("/{id}")
    public ResponseEntity<TypeResponse> update_type(@PathVariable Long id, @RequestBody TypeRequest typeRequest) {
        return ResponseEntity.ok(typeService.update_type_detail(id, typeRequest));
    }
    /**
     *  chercher d'un type spécifique par son nom
     *
     * @param search le nom de type
     * @return Une réponse contenant True si existe ou false si n'esxit pas
     * */
    @GetMapping("/search")
    public ResponseEntity<Boolean> search(
            @RequestParam(defaultValue = "") String search,
            @RequestParam(defaultValue = "0") int id) {
        Boolean res=typeService.search_type(search,id);

        return ResponseEntity.ok(res);
    }
}