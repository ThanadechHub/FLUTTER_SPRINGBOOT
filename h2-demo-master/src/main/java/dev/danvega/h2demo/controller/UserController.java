package dev.danvega.h2demo.controller;

import dev.danvega.h2demo.model.Users;
import dev.danvega.h2demo.repository.UserRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/user")
public class UserController {

    private final UserRepository repository;

    public UserController(UserRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public Iterable<Users> findAll() {
        return repository.findAll();
    }
}
