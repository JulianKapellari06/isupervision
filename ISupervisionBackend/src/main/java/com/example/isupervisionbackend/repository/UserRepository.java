package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends CrudRepository<User,Integer> {

    Optional<User> findUserByEmailAndPassword(String email, String password);

    Optional<User> findUserByEmail(String email);

    Optional<User> findUserById(long id);

    @Query("SELECT user FROM User user WHERE user.name LIKE %?1% OR user.email LIKE %?1%")
    Optional<Iterable<User>> searchUser(String filter);


}
