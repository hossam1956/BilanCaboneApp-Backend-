package com.example.BilanCarbone.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class FacteurController{

    @GetMapping("/hos")
    public String sayHello() {
        return "Hello, World!";
    }
}

