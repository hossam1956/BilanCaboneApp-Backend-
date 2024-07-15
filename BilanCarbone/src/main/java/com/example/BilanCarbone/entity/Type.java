package com.example.BilanCarbone.entity;

import com.example.BilanCarbone.common.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.List;

/**
 * @author Oussama
 **/
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Type extends BaseEntity {
    private String name;
    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Type parent;
    private Boolean active ;
    @OneToMany(mappedBy = "type", cascade = CascadeType.ALL)
    private List<Facteur> facteurs;
}
