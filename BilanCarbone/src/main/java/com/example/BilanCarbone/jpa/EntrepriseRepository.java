package com.example.BilanCarbone.jpa;

import com.example.BilanCarbone.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EntrepriseRepository extends JpaRepository<Entreprise,Long> {

}
