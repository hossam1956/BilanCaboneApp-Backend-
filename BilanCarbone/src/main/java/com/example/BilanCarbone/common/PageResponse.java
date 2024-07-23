package com.example.BilanCarbone.common;

import lombok.*;

import java.util.List;


/**
 * Représente une réponse paginée pour les requêtes de données.
 * <p>
 * Cette classe est utilisée pour encapsuler les informations relatives à une page de résultats,
 * y compris le contenu de la page, le numéro de la page, la taille de la page, le nombre total
 * d'éléments, le nombre total de pages, et les indicateurs de première et dernière page.
 * </p>
 *
 * @param <T> le type des éléments contenus dans la réponse paginée
 * @author Oussama
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PageResponse<T> {

    /**
     * Le contenu de la page, une liste d'objets de type {@code T}.
     */
    private List<T> content;

    /**
     * Le numéro de la page actuelle.
     */
    private int number;

    /**
     * La taille de la page, c'est-à-dire le nombre d'éléments par page.
     */
    private int size;

    /**
     * Le nombre total d'éléments disponibles.
     */
    private long totalElements;

    /**
     * Le nombre total de pages disponibles.
     */
    private int totalPages;

    /**
     * Indique si la page actuelle est la première page.
     */
    private boolean first;

    /**
     * Indique si la page actuelle est la dernière page.
     */
    private boolean last;
}