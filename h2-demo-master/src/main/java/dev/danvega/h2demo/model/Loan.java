package dev.danvega.h2demo.model;

import org.springframework.data.annotation.Id;

public record Loan(@Id Integer id, String name) {

}
