package ru.gb.application.repositories;

import org.springframework.data.repository.CrudRepository;
import ru.gb.application.entity.Role;

public interface RoleRepository extends CrudRepository<Role, Long> {

}
