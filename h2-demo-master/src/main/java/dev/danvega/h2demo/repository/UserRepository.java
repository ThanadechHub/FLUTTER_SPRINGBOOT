package dev.danvega.h2demo.repository;

import dev.danvega.h2demo.model.Users;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<Users,Integer> {
}
