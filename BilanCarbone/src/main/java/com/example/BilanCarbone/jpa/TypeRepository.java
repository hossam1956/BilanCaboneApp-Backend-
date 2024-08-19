package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Facteur;
import com.example.BilanCarbone.entity.Type;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.Query;



import java.util.List;
import java.util.Optional;

/**
 * @author Oussama
 **/
public interface TypeRepository extends JpaRepository<Type, Long> {
    @Query("SELECT t FROM Type t WHERE t.id = :idtype AND t.isDeleted IS NULL AND t.active = True  AND (t.entreprise = :entreprise OR t.entreprise IS NULL)")
    Optional<Type> findByIdAndIsDeletedIsNullAndEntreprise(@Param("idtype") Long idtype, @Param("entreprise") Entreprise entreprise);
    Page<Type> findAllByNameContainingIgnoreCaseAndIsDeletedIsNullAndEntrepriseIsNull(String Name,Pageable pageable);
    Page<Type> findAllByIsDeletedIsNullAndEntrepriseIsNull(Pageable pageable);
    Page<Type> findAllByNameContainingIgnoreCaseAndParentIsNullAndIsDeletedIsNullAndEntrepriseIsNull(String Name,Pageable pageable);
    Page<Type> findAllByParentIsNullAndIsDeletedIsNullAndEntrepriseIsNull(Pageable pageable);
    Boolean existsByNameIgnoreCaseAndIsDeletedIsNullAndEntreprise(String name,Entreprise entreprise);
    Boolean existsByNameIgnoreCaseAndIdNotAndIsDeletedIsNullAndEntreprise(String name,Long id,Entreprise entreprise);
    Boolean existsByNameIgnoreCaseAndIdNotAndIsDeletedIsNullAndEntrepriseIsNull(String name,Long id);
    Boolean existsByNameIgnoreCaseAndIsDeletedIsNullAndEntrepriseIsNull(String name);
    List<Type> findAllByActiveIsTrueAndIsDeletedIsNullAndEntrepriseOrEntrepriseIsNull( Entreprise entreprise);
    List<Type> findAllByParentIsNotNullAndIsDeletedIsNullAndEntrepriseOrEntrepriseIsNull(Entreprise entreprise);
    Page<Type> findAllByIsDeletedNotNullAndEntrepriseIsNull(Pageable pageable);
    Page<Type> findAllByIsDeletedNotNullAndEntreprise(Pageable pageable,Entreprise entreprise);
    Page<Type> findAllByNameContainingIgnoreCaseAndIsDeletedIsNotNullAndEntreprise(String nom,Pageable pageable,Entreprise entreprise);
    Page<Type> findAllByNameContainingIgnoreCaseAndIsDeletedIsNotNullAndEntrepriseIsNull(String nom,Pageable pageable);
    Boolean existsByNameIgnoreCaseAndIsDeletedIsNull(String name);
    //simple
    Type findByNameAndIsDeletedIsNull(String name);
    List<Type> findAllByParentAndIdNotIn(Type parent, List<Long> ids);
    List<Type> findAllByParent(Type parent);
    List<Type> findAllByParentAndIsDeletedNotNull(Type parent);
    Type findByIdAndIsDeletedIsNotNull(Long id);
    List<Type> findAllByParentIsNotNullAndIsDeletedIsNull( );
    Type findByIdAndIsDeletedIsNull(Long id);
    List<Type> findAllByParentAndIsDeletedIsNull(Type parent);
    List<Type> findAllByFacteurs(Facteur facteur);
    //perso
    Page<Type> findAllByNameContainingIgnoreCaseAndEntrepriseAndIsDeletedIsNull(String nom, Entreprise entreprise, Pageable pageable);
    Page<Type> findAllByEntrepriseAndIsDeletedIsNull(Entreprise entreprise, Pageable pageable);
    Page<Type> findAllByParentIsNullAndEntrepriseAndIsDeletedIsNull(Entreprise entreprise,Pageable pageable);
    Page<Type> findAllByNameContainingIgnoreCaseAndParentIsNullAndEntrepriseAndIsDeletedIsNull(String nom, Entreprise entreprise, Pageable pageable);
}
