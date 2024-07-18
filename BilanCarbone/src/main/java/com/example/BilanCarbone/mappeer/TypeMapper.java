package com.example.BilanCarbone.mappeer;

import com.example.BilanCarbone.dto.TypeResponse;
import com.example.BilanCarbone.entity.Type;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author Oussama
 **/
@Service
@RequiredArgsConstructor
public class TypeMapper {
    private final FacteurMapper facteurMapper;
   private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    public TypeResponse typeParentResponse(Type type){
        return  TypeResponse
                .builder()
                .id(type.getId())
                .facteurs(type.getFacteurs() != null ? type.getFacteurs().stream().map(facteurMapper::toFacteurResponse).collect(Collectors.toList()) : null)
                .nom_type(type.getName())
                .active(type.getActive())
                .date(type.getCreatedDate().format(formatter))
                .fils(new ArrayList<>())
                .parent(null)
                .build();
    }
    public TypeResponse typeParentResponse2(Type type){
        return  TypeResponse
                .builder()
                .id(type.getId())
                .facteurs(null)
                .nom_type(type.getName())
                .parent(type.getParent()!=null?type.getParent().getId():null)
                .active(type.getActive())
                .date(type.getCreatedDate().format(formatter))
                .fils(new ArrayList<>())
                .build();
    }
    public TypeResponse typeParentResponse3(Type type){
        return  TypeResponse
                .builder()
                .id(type.getId())
                .facteurs(null)
                .nom_type(type.getName())
                .parent(null)
                .active(null)
                .date(null)
                .fils(new ArrayList<>())
                .build();
    }
    public TypeResponse typeParentResponse(Type type,List<Type> types){
        List<TypeResponse> responses = new ArrayList<>();
        if(!types.isEmpty()){
            for(Type t : types){
                responses.add(typeParentResponse(t));
            }
        }
        return  TypeResponse
                .builder()
                .id(type.getId())
                .facteurs(null)
                .nom_type(type.getName())
                .active(type.getActive())
                .date(type.getCreatedDate().format(formatter))
                .fils(responses)
                .build();
    }
    public List<TypeResponse> hierarchiqueResponse (List<Type> list,List<Type> child){
        List<TypeResponse> res = null;
        if(list != null){
            res = new ArrayList<>();
            for(Type i: list){
                if(i.getParent()==null){
                    res.add(typeParentResponse3(i));
                }
            }
            for (TypeResponse i: res){
                for(Type j: child){
                    if(i.existfils(j.getId())){
                        continue;
                    }
                    if(i.getId().equals(j.getParent().getId())){
                        i.getFils().add(typeParentResponse3(j));
                    }
                }
            }
            return res;
        }
        return res;
    }
}
