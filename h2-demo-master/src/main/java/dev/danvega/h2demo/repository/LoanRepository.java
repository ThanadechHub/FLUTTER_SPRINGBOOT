package dev.danvega.h2demo.repository;

import dev.danvega.h2demo.model.Loan;
import dev.danvega.h2demo.model.Users;
import org.springframework.data.repository.CrudRepository;

public interface LoanRepository extends CrudRepository<Loan,Integer> {
}
