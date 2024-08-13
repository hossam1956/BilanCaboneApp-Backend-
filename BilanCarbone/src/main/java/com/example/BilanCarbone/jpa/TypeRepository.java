package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Entreprise;
import com.example.BilanCarbone.entity.Type;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author Oussama
 **/
public interface TypeRepository extends JpaRepository<Type, Long> {
    Page<Type> findAllByParentIsNullAndIsDeletedIsNull(Pageable pageable);
    Page<Type> findAllByNameContainingIgnoreCaseAndParentIsNullAndIsDeletedIsNull(String Name,Pageable pageable);
    Page<Type> findAllByNameContainingIgnoreCaseAndIsDeletedIsNull(String Name,Pageable pageable);

    List<Type> findAllByParentIsNotNullAndIsDeletedIsNull();
    List<Type> findAllByParentAndIsDeletedIsNull(Type parent);
    Type findByNameAndIsDeletedIsNull(String name);
    List<Type> findAllByActiveIsTrueAndIsDeletedIsNull();
    Type findByIdAndIsDeletedIsNull(Long id);
    Page<Type> findAllByIsDeletedIsNull(Pageable pageable);
    List<Type> findAllByParentAndIdNotIn(Type parent, List<Long> ids);
    Type findByIdAndIsDeletedIsNotNull(Long id);
    List<Type> findAllByParent(Type parent);
    Page<Type> findAllByIsDeletedNotNull(Pageable pageable);
    Page<Type> findAllByNameContainingIgnoreCaseAndIsDeletedIsNotNull(String nom,Pageable pageable);
    List<Type> findAllByParentAndIsDeletedNotNull(Type parent);
    Boolean existsByNameIgnoreCaseAndIsDeletedIsNull(String name);
    Boolean existsByNameIgnoreCaseAndIdNotAndIsDeletedNotNull(String name,Long id);

   //perso
    Page<Type> findAllByNameContainingIgnoreCaseAndEntrepriseAndIsDeletedIsNull(String nom, Entreprise entreprise, Pageable pageable);
    Page<Type> findAllByEntrepriseAndIsDeletedIsNull(Entreprise entreprise, Pageable pageable);
    Page<Type> findAllByParentIsNullAndEntrepriseAndIsDeletedIsNull(Entreprise entreprise,Pageable pageable);
    Page<Type> findAllByNameContainingIgnoreCaseAndParentIsNullAndEntrepriseAndIsDeletedIsNull(String nom, Entreprise entreprise, Pageable pageable);




}
