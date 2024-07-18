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

import java.util.List;

/**
 * @author Oussama
 **/
@Service
@RequiredArgsConstructor
public class FacteurServiceimplement implements FacteurService{

    private final FacteurRepository facteurRepository;
    private final TypeRepository typeRepository;
    private final FacteurMapper facteurMapper;
    @Override
    public PageResponse<FacteurResponse> getAllFacteurs(int ge,int size,String search,String... order) {
        Sort sort = Sort.by(Sort.Direction.ASC, order.length > 0 ? order : new String[]{"createdDate"});
        Pageable pe = PageRequest.of(ge, size,sort);
        Page<Facteur> page=null;
        if(!search.isEmpty()) {
            page=facteurRepository.findAllByNomContainingIgnoreCase(search.toLowerCase().trim(),pe);
        }else {
            page=facteurRepository.findAll(pe);
        }
        List<FacteurResponse> res=page.stream().map(facteurMapper::toFacteurResponse).toList();
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

    @Override
    public FacteurResponse getFacteurById(Long id) {
        return facteurMapper.toFacteurResponse(findbyid(id));
    }
    @Override
    public FacteurResponse update(Long id, FacteurRequest request) {
        Facteur facteur = findbyid(id);
        if (request.nom_facteur() != null && !request.nom_facteur().isEmpty() && !request.nom_facteur().equals(facteur.getNom())) {
            facteur.setNom(request.nom_facteur());
        }
        if (request.unit() != null && !request.unit().isEmpty()) {
            if(Unite.fromString(request.unit()) != Unite.UNKNOWN){
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
    @Transactional
    @Override
    public FacteurResponse addFacteur(FacteurRequest request,Type type) {
        Facteur existingFacteur = facteurRepository.findByNom(request.nom_facteur());
        if (existingFacteur !=null) {
            throw new IllegalArgumentException("Facteur avec nom " + request.nom_facteur() + " deja exists.");
        }
        Facteur facteur = Facteur.builder()
                .nom(request.nom_facteur())
                .unit(Unite.fromString(request.unit()))
                .emissionFactor(request.emissionFactor())
                .type(type)
                .active((request.active()!=null)?request.active():true)
                .build();

        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }

    @Override
    public List<String> getType() {
        return Unite.getAllUnits();
    }

    @Override
    public List<FacteurResponse> list_facteur(Long facteurId) {
        List<Facteur> list=null;
        if (facteurId>0){
            Type type = typeRepository.findById(facteurId).orElseThrow(
                    () -> new EntityNotFoundException("type not found with id: " +facteurId)
            );
             list = facteurRepository.findAllByActiveIsTrueAndType(type);
        }else{
            list = facteurRepository.findAllByActiveIsTrue();
        }
        return list.stream().map(facteurMapper::toFacteurResponse).toList();
    }

    private Facteur findbyid(Long id) {
        return facteurRepository.findById(id).orElseThrow(
                () -> new EntityNotFoundException("Facteur not found with id: " + id)
        );
    }
    @Override
    public FacteurResponse tooglefactecurtoggleActivation(Long id,boolean activate){
        Facteur facteur=findbyid(id);
        if(facteur.getActive()==activate) {
            String action =activate ? "activé" : "désactivé";
            throw new OperationNotPermittedException("Le facteur "+id+" a déjà été "+action);
        }
        if (!activate){
            Type t=facteur.getType();
            if(!t.getActive()){
                throw new OperationNotPermittedException("Le type "+id+" est désactivé (active ce type)");
            }
        }
        facteur.setActive(activate);
        return facteurMapper.toFacteurResponse(facteurRepository.save(facteur));
    }


}
