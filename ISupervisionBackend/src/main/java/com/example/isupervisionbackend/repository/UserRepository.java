package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends CrudRepository<User,Long> {

    Optional<User> findUserByEmailAndPassword(String email, String password);

}
