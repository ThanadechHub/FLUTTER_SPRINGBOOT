package dev.danvega.h2demo.controller;

import dev.danvega.h2demo.model.Users;
import dev.danvega.h2demo.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;

@RestController
@RequestMapping("/api")
public class UserController {

    private final UserRepository repository;

    public UserController(UserRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/allUser")
    public Iterable<Users> findAll() {
        return repository.findAll();
    }

    @GetMapping("/user")
    public Iterable<Users> getUser(@RequestParam String username) {
        return Collections.singleton(repository.findByUsername(username));
    }

    @PostMapping("/createUser") 
    public ResponseEntity<Users> createUser(@RequestBody Users user) {
        Users savedUser = repository.save(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedUser);
    }
}
