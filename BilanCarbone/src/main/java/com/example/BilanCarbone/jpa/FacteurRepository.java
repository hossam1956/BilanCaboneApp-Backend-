package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Type;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.BilanCarbone.entity.Facteur;

import java.util.List;

@Repository
public interface FacteurRepository extends JpaRepository<Facteur, Long> {
    //global
    @Query("SELECT f FROM Facteur f WHERE f.active = true AND f.isDeleted IS NULL AND (f.entreprise IS NULL OR f.entreprise = :entreprise) ORDER BY f.createdDate DESC")
    List<Facteur> findAllActiveAndNotDeletedWithOptionalEntreprise(@Param("entreprise") Entreprise entreprise);
    @Query("SELECT f FROM Facteur f WHERE f.active = true AND f.type = :type AND f.isDeleted IS NULL AND (f.entreprise IS NULL OR f.entreprise = :entreprise) ORDER BY f.createdDate DESC")
    List<Facteur> findAllActiveByTypeAndEntreprise(@Param("type") Type type, @Param("entreprise") Entreprise entreprise);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndEntrepriseIsNullAndIsDeletedIsNull(String name, Pageable pageable);
    Page<Facteur> findAllByIsDeletedNotNullAndEntrepriseIsNull(Pageable pageable);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndIsDeletedNotNullAndEntrepriseIsNull(String name, Pageable pageable);

    @Query("SELECT f FROM Facteur f WHERE f.nom = :nom AND f.isDeleted IS NULL AND (f.entreprise = :entreprise OR f.entreprise IS NULL)")
    List<Facteur> findExactMatchByNomAndEntreprise(@Param("nom") String nom, @Param("entreprise") Entreprise entreprise);
    Page<Facteur> findAllByEntrepriseIsNullAndIsDeletedIsNull(Pageable pageable);

    Boolean existsByNomIgnoreCaseAndIsDeletedIsNullAndEntrepriseIsNull(String nom);
    Boolean existsByNomIgnoreCaseAndIsDeletedIsNullAndEntreprise(String nom,Entreprise entreprise);
    Boolean existsAllByNomIgnoreCaseAndIdNotAndIsDeletedNotNullAndEntrepriseIsNull(String nom,Long id);
    Boolean existsAllByNomIgnoreCaseAndIdNotAndIsDeletedNotNullAndEntreprise(String nom,Long id,Entreprise entreprise);

    //personalise
    Page<Facteur> findAllByEntrepriseAndIsDeletedIsNull(Entreprise entreprise, Pageable pageable);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndEntrepriseAndIsDeletedIsNull(String name, Entreprise entreprise, Pageable pageable);
    Page<Facteur> findAllByIsDeletedNotNullAndEntreprise(Entreprise entreprise,Pageable pageable);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndIsDeletedNotNullAndEntreprise(String name,Entreprise entreprise, Pageable pageable);

    // normal
    Facteur findByIdAndIsDeletedIsNull(Long id);
    //
    Facteur findByIdAndIsDeletedNotNull(Long id);
    List<Facteur> findAllByTypeAndIdNotInAndIsDeletedNull(Type type,List<Long> ids);
    List<Facteur> findAllByTypeAndIsDeletedIsNull(Type type);


}
