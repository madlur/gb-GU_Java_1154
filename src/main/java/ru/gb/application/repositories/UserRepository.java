package ru.gb.application.repositories;

import org.springframework.data.repository.CrudRepository;
import ru.gb.application.entity.User;

import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Long> {

    Optional<User> findByEmail(String email);

}
