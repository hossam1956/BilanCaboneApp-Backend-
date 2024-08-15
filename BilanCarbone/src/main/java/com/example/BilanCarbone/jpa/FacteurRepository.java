package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Type;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.BilanCarbone.entity.Facteur;

import java.util.List;

@Repository
public interface FacteurRepository extends JpaRepository<Facteur, Long> {
    //global
    List<Facteur> findAllByActiveIsTrueAndIsDeletedIsNullAndEntrepriseIsNullOrEntreprise(Entreprise entreprise);
    List<Facteur> findAllByActiveIsTrueAndTypeAndIsDeletedIsNullAndEntrepriseIsNullOrEntreprise(Type type,Entreprise entreprise);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndEntrepriseIsNullAndIsDeletedIsNullAndEntrepriseIsNull(String name, Pageable pageable);
    Page<Facteur> findAllByIsDeletedNotNullAndEntrepriseIsNull(Pageable pageable);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndIsDeletedNotNullAndEntrepriseIsNull(String name, Pageable pageable);
    Facteur findByNomAndIsDeletedIsNullAndEntrepriseIsNullOrEntreprise(String nom,Entreprise entreprise)    ;
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
