package com.example.BilanCarbone.controller;

import com.example.BilanCarbone.entity.Entreprise;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.BilanCarbone.jpa.EntrepriseRepository;

import java.util.List;

@RequestMapping("api/entreprise")
@RestController
public class EntrepriseController {
    @Autowired
   private EntrepriseRepository entrepriseRepository;

    @GetMapping
    public List<Entreprise> getAllEntreprise(){
        return entrepriseRepository.findAll();

    }

    @PostMapping
    public Entreprise saveEntreprise(Entreprise entreprise){
        return entrepriseRepository.save(entreprise);

    }
}
