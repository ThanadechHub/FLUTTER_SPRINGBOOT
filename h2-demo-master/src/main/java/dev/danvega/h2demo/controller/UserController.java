package dev.danvega.h2demo.controller;

import dev.danvega.h2demo.model.Loan;
import dev.danvega.h2demo.model.Users;
import dev.danvega.h2demo.repository.LoanRepository;
import dev.danvega.h2demo.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;

@RestController
@RequestMapping("/api")
public class UserController {

    private final UserRepository userRepository;

    private final LoanRepository loanRepository;


    public UserController(UserRepository repository, LoanRepository loanRepository) {
        this.userRepository = repository;
        this.loanRepository = loanRepository;
    }

    @GetMapping("/allUser")
    public Iterable<Users> findAll() {
        return userRepository.findAll();
    }

    @GetMapping("/Loan")
    public Iterable<Loan> findLoan() {
        return loanRepository.findAll();
    }

    @GetMapping("/user")
    public Iterable<Users> getUser(@RequestParam String username) {
        return Collections.singleton(userRepository.findByUsername(username));
    }

    @PostMapping("/createUser") 
    public ResponseEntity<Users> createUser(@RequestBody Users user) {
        Users savedUser = userRepository.save(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedUser);
    }
}
