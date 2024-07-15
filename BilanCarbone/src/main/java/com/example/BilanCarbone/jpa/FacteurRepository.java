package com.example.BilanCarbone.jpa;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.BilanCarbone.entity.Facteur;
@Repository
public interface FacteurRepository extends JpaRepository<Facteur, Long> {
    Page<Facteur> findAllByNomContainingIgnoreCase(String name, Pageable pageable);
}
