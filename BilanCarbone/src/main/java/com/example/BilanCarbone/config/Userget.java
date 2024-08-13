package com.example.BilanCarbone.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Oussama
 **/

@Service
public class Userget {

    /**
     * Retrieve the current authenticated user's information from the JWT token.
     *
     * @return a map containing user information such as username and roles.
     */
    public Map<String, Object> getUserInfo() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Jwt jwt = (Jwt) authentication.getPrincipal();

        // Use a HashMap to allow null values
        Map<String, Object> userInfo = new HashMap<>();

        String username = jwt.getClaimAsString("preferred_username");
        String email = jwt.getClaimAsString("email");
        String sub = jwt.getClaimAsString("sub");
        Collection<GrantedAuthority> roles = (Collection<GrantedAuthority>) authentication.getAuthorities();

        if (username != null) {
            userInfo.put("username", username);
        }

        if (email != null) {
            userInfo.put("email", email);
        }

        if (roles != null) {
            userInfo.put("roles", roles);
        }
        if(sub!=null){
            userInfo.put("sub", sub);
        }

        return userInfo;
    }

    /**
     * Get the user's roles directly from the JWT token.
     *
     * @return a collection of roles.
     */
    public Collection<GrantedAuthority> getUserRoles() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return (Collection<GrantedAuthority>) authentication.getAuthorities();
    }

    /**
     * Retrieve a specific claim from the JWT token.
     *
     * @param claim the claim name.
     * @return the claim value as an Object.
     */
    public Object getClaim(String claim) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Jwt jwt = (Jwt) authentication.getPrincipal();
        return jwt.getClaim(claim);
    }
}