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

    List<Facteur> findAllByActiveIsTrueAndIsDeletedIsNullAndEntrepriseIsNullOrEntreprise(Entreprise entreprise);
    List<Facteur> findAllByActiveIsTrueAndTypeAndIsDeletedIsNullAndEntrepriseIsNullOrEntreprise(Type type,Entreprise entreprise);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndEntrepriseIsNullAndIsDeletedIsNullAndEntrepriseIsNull(String name, Pageable pageable);

    //global
    Facteur findByNomAndIsDeletedIsNull(String nom);
    Facteur findByIdAndIsDeletedIsNull(Long id);
    Page<Facteur> findAllByEntrepriseIsNullAndIsDeletedIsNull(Pageable pageable);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndIsDeletedNotNull(String name, Pageable pageable);
    Page<Facteur> findAllByIsDeletedNotNull(Pageable pageable);
    Facteur findByIdAndIsDeletedNotNull(Long id);
    List<Facteur> findAllByTypeAndIdNotInAndIsDeletedNull(Type type,List<Long> ids);
    List<Facteur> findAllByTypeAndIsDeletedIsNull(Type type);
    Boolean existsByNomIgnoreCaseAndIsDeletedIsNull(String nom);
    Boolean existsAllByNomIgnoreCaseAndIdNotAndIsDeletedNotNull(String nom,Long id);
//personalise
    Page<Facteur> findAllByEntrepriseAndIsDeletedIsNull(Entreprise entreprise, Pageable pageable);
    Page<Facteur> findAllByNomContainingIgnoreCaseAndEntrepriseAndIsDeletedIsNull(String name, Entreprise entreprise, Pageable pageable);
}
