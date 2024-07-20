package com.example.BilanCarbone.service;

import com.example.BilanCarbone.common.PageResponse;
import com.example.BilanCarbone.dto.FacteurRequest;
import com.example.BilanCarbone.dto.FacteurResponse;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.entity.Type;
import com.example.BilanCarbone.entity.Unite;
import com.example.BilanCarbone.exception.OperationNotPermittedException;
import com.example.BilanCarbone.jpa.FacteurRepository;
import com.example.BilanCarbone.jpa.TypeRepository;
import com.example.BilanCarbone.mappeer.FacteurMapper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Sort;

import java.time.LocalDateTime;
import java.util.List;

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

    /**
     * Retrieves a paginated list of all active factors with optional search and sorting.
     *
     * @param ge     Page number to retrieve.
     * @param size   Number of factors per page.
     * @param search Optional search term to filter factors by name.
     * @param order  Optional sorting parameters.
     * @return A {@link PageResponse} containing the paginated list of {@link FacteurResponse}.
     */
    @Override
    public PageResponse<FacteurResponse> getAllFacteurs(int ge, int size, String search, String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(ge, size, sort);
        Page<Facteur> page = search.isEmpty() ?
                facteurRepository.findAllByIsDeletedIsNull(pe) :
                facteurRepository.findAllByNomContainingIgnoreCaseAndIsDeletedIsNull(search.toLowerCase().trim(), pe);

        List<FacteurResponse> res = page.stream().map(facteurMapper::toFacteurResponse).toList();
        return PageResponse.<FacteurResponse>builder()
                .content(res)
                .number(page.getNumber())
                .size(page.getSize())
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .first(page.isFirst())
                .last(page.isLast())
                .build();
    }

    /**
     * Retrieves a factor by its ID.
     *
     * @param id ID of the factor to retrieve.
     * @return {@link FacteurResponse} containing the factor details.
     * @throws EntityNotFoundException If the factor with the specified ID does not exist.
     */
    @Override
    public FacteurResponse getFacteurById(Long id) {
        return facteurMapper.toFacteurResponse(findbyid(id));
    }

    /**
     * Updates the details of an existing factor.
     *
     * @param id      ID of the factor to update.
     * @param request {@link FacteurRequest} containing the new details.
     * @return {@link FacteurResponse} containing the updated factor details.
     * @throws EntityNotFoundException If the factor with the specified ID does not exist.
     */
    @Override
    public FacteurResponse update(Long id, FacteurRequest request) {
        Facteur facteur = findbyid(id);
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
        Facteur updatedFacteur = facteurRepository.save(facteur);
        return facteurMapper.toFacteurResponse(updatedFacteur);
    }

    /**
     * Adds a new factor to the specified type.
     *
     * @param request {@link FacteurRequest} containing the details of the factor to add.
     * @param type    {@link Type} to which the factor belongs.
     * @return {@link FacteurResponse} containing the added factor details.
     * @throws OperationNotPermittedException If a factor with the same name already exists.
     */
    @Transactional
    @Override
    public FacteurResponse addFacteur(FacteurRequest request, Type type) {
        Facteur existingFacteur = facteurRepository.findByNomAndIsDeletedIsNull(request.nom_facteur());
        if (existingFacteur != null) {
            throw new OperationNotPermittedException("Facteur avec nom " + request.nom_facteur() + " deja exists.");
        }
        Facteur facteur = Facteur.builder()
                .nom(request.nom_facteur())
                .unit(Unite.fromString(request.unit()))
                .emissionFactor(request.emissionFactor())
                .type(type)
                .active((request.active() != null) ? request.active() : true)
                .build();

        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }

    /**
     * Retrieves a list of all available units.
     *
     * @return List of unit names as strings.
     */
    @Override
    public List<String> getType() {
        return Unite.getAllUnits();
    }

    /**
     * Retrieves a list of active factors, optionally filtered by type ID.
     *
     * @param facteurId Optional ID of the type to filter factors by. If not provided, retrieves all active factors.
     * @return List of {@link FacteurResponse} containing the active factors.
     * @throws EntityNotFoundException If the type with the specified ID does not exist.
     */
    @Override
    public List<FacteurResponse> list_facteur(Long facteurId) {
        List<Facteur> list;
        if (facteurId > 0) {
            Type type = typeRepository.findById(facteurId).orElseThrow(
                    () -> new EntityNotFoundException("type not found with id: " + facteurId)
            );
            list = facteurRepository.findAllByActiveIsTrueAndTypeAndIsDeletedIsNull(type);
        } else {
            list = facteurRepository.findAllByActiveIsTrueAndIsDeletedIsNull();
        }
        return list.stream().map(facteurMapper::toFacteurResponse).toList();
    }

    /**
     * Soft deletes a factor by marking it as deleted.
     *
     * @param facteurId ID of the factor to delete.
     * @return {@link FacteurResponse} containing the details of the deleted factor.
     * @throws OperationNotPermittedException If the factor is already deleted.
     * @throws EntityNotFoundException       If the factor with the specified ID does not exist.
     */
    @Override
    public FacteurResponse delete_facteur(Long facteurId) {
        Facteur facteur = findbyid(facteurId);
        if (facteur.getIsDeleted() != null) {
            throw new OperationNotPermittedException("le facteur " + facteurId + " déjà supprimé");
        }
        facteur.setIsDeleted(LocalDateTime.now());
        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }

    /**
     * Forcefully deletes a factor by removing it from the repository.
     *
     * @param facteurId ID of the factor to delete.
     * @return {@link FacteurResponse} containing the details of the deleted factor.
     * @throws OperationNotPermittedException If the factor is not deleted.
     * @throws EntityNotFoundException       If the factor with the specified ID does not exist.
     */
    @Override
    public FacteurResponse delete_force_facteur(Long facteurId) {
        Facteur facteur = findbyid_deleted(facteurId);
        if (facteur.getIsDeleted() == null) {
            throw new OperationNotPermittedException("le facteur " + facteurId + " n'est pas supprimé");
        }
        facteurRepository.delete(facteur);
        return facteurMapper.toFacteurResponse(facteur);
    }

    /**
     * Recovers a previously deleted factor by restoring it.
     *
     * @param facteurId ID of the factor to recover.
     * @return {@link FacteurResponse} containing the details of the recovered factor.
     * @throws OperationNotPermittedException If the factor is not deleted or its type is deleted.
     * @throws EntityNotFoundException       If the factor with the specified ID does not exist.
     */
    @Override
    public FacteurResponse recovery_facteur(Long facteurId) {
        Facteur facteur = findbyid_deleted(facteurId);
        if (facteur.getIsDeleted() == null) {
            throw new OperationNotPermittedException("le facteur " + facteur.getNom() + " n'est pas supprimé");
        }
        if (facteur.getType() != null && facteur.getType().getIsDeleted() != null) {
            throw new OperationNotPermittedException("vous devez d'abord récupérer le type son nom :" + facteur.getNom() + ", et son id :" + facteur.getId());
        }
        facteur.setIsDeleted(null);
        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }

    /**
     * Retrieves a paginated list of all deleted factors with optional search and sorting.
     *
     * @param ge     Page number to retrieve.
     * @param size   Number of factors per page.
     * @param search Optional search term to filter factors by name.
     * @param order  Optional sorting parameters.
     * @return A {@link PageResponse} containing the paginated list of {@link FacteurResponse}.
     */
    @Override
    public PageResponse<FacteurResponse> get_All_deleted_Facteurs(int ge, int size, String search, String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(ge, size, sort);
        Page<Facteur> page = search.isEmpty() ?
                facteurRepository.findAllByIsDeletedNotNull(pe) :
                facteurRepository.findAllByNomContainingIgnoreCaseAndIsDeletedNotNull(search.toLowerCase().trim(), pe);

        List<FacteurResponse> res = page.stream().map(facteurMapper::toFacteurResponse).toList();
        return PageResponse.<FacteurResponse>builder()
                .content(res)
                .number(page.getNumber())
                .size(page.getSize())
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .first(page.isFirst())
                .last(page.isLast())
                .build();
    }

    /**
     * Toggles the activation status of a factor.
     *
     * @param id       ID of the factor to update.
     * @param activate New activation status.
     * @return {@link FacteurResponse} containing the updated factor details.
     * @throws OperationNotPermittedException If the factor is already in the desired state or if the type is inactive.
     * @throws EntityNotFoundException       If the factor with the specified ID does not exist.
     */
    @Override
    public FacteurResponse tooglefactecurtoggleActivation(Long id, boolean activate) {
        Facteur facteur = findbyid(id);
        if (facteur.getActive() == activate) {
            String action = activate ? "activé" : "désactivé";
            throw new OperationNotPermittedException("Le facteur " + id + " a déjà été " + action);
        }
        if (!activate) {
            Type type = facteur.getType();
            if (!type.getActive()) {
                throw new OperationNotPermittedException("Le type " + id + " est désactivé (active ce type)");
            }
        }
        facteur.setActive(activate);
        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }

    /**
     * Finds a factor by its ID, ignoring deleted factors.
     *
     * @param id ID of the factor to find.
     * @return The found {@link Facteur}.
     * @throws EntityNotFoundException If the factor with the specified ID is not found.
     */
    private Facteur findbyid(Long id) {
        Facteur facteur = facteurRepository.findByIdAndIsDeletedIsNull(id);
        if (facteur == null) {
            throw new EntityNotFoundException("facteur not found with id: " + id);
        }
        return facteur;
    }

    /**
     * Finds a factor by its ID, including deleted factors.
     *
     * @param id ID of the factor to find.
     * @return The found {@link Facteur}.
     * @throws EntityNotFoundException If the factor with the specified ID is not found.
     */
    private Facteur findbyid_deleted(Long id) {
        Facteur facteur = facteurRepository.findByIdAndIsDeletedNotNull(id);
        if (facteur == null) {
            throw new EntityNotFoundException("facteur not found with id: " + id);
        }
        return facteur;
    }
}