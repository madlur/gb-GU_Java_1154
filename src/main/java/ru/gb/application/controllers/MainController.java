package ru.gb.application.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class MainController {

    @GetMapping("/")
    public String homePage() {

        return "index";
    }

    @GetMapping("/auth")
    public String authPage() {

        return "home";
    }

    @GetMapping("/admin")
    public String adminPage() {

        return "admin";
    }

}
