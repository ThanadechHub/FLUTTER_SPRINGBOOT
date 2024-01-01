package dev.danvega.h2demo.model;

import org.springframework.data.annotation.Id;

public record Users(@Id Integer id, String name, String username, String password) {
}
