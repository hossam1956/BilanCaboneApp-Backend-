package com.example.BilanCarbone.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.core.convert.converter.Converter;

import java.util.Collection;
import java.util.stream.Collectors;

/**
 * Convertisseur personnalisé pour extraire les rôles d'un JWT et les convertir en autorités accordées de Spring Security.
 * Cette classe garantit que les rôles présents dans le JWT sont préfixés avec "ROLE_" comme requis par Spring Security.
 * Elle combine les autorités accordées par défaut avec les rôles personnalisés du domaine.
 * @author CHALABI Hossam
 */
public class CustomJwtAuthenticationConverter implements Converter<Jwt, Collection<GrantedAuthority>> {

    /**
     * Convertit un JWT en une collection d'objets GrantedAuthority.
     * Elle extrait les rôles de la revendication "realm_access.roles" du JWT et les préfixe avec "ROLE_".
     *
     * @param jwt le JWT à convertir
     * @return une collection d'objets GrantedAuthority
     */
    @Override
    public Collection<GrantedAuthority> convert(Jwt jwt) {
        // Utiliser le convertisseur par défaut pour obtenir les autorités standard
        JwtGrantedAuthoritiesConverter defaultGrantedAuthoritiesConverter = new JwtGrantedAuthoritiesConverter();
        Collection<GrantedAuthority> authorities = defaultGrantedAuthoritiesConverter.convert(jwt);

        // Extraire les rôles de la revendication "realm_access.roles" et les mapper aux autorités de Spring Security
        Collection<GrantedAuthority> realmRoles = ((Collection<String>) jwt.getClaimAsMap("realm_access").get("roles"))
                .stream()
                .map(role -> new SimpleGrantedAuthority(role))
                .collect(Collectors.toList());

        // Ajouter les rôles personnalisés à la collection d'autorités
        authorities.addAll(realmRoles);
        return authorities;
    }
}
