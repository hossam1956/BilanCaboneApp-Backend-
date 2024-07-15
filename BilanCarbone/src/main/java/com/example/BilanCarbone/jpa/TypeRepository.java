package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Type;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author Oussama
 **/
public interface TypeRepository extends JpaRepository<Type, Long> {
    Page<Type> findAllByParentIsNull(Pageable pageable);
    Page<Type> findAllByNameContainingIgnoreCaseAndParentIsNull(String Name,Pageable pageable);

    List<Type> findAllByParent(Type parent);
}
