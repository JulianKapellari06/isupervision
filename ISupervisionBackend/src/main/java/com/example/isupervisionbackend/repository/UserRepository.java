package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import javax.transaction.Transactional;
import java.util.Collection;
import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Integer> {

    Optional<User> findUserByEmailAndPassword(String email, String password);

    Optional<User> findUserByEmail(String email);

    Optional<User> findUserById(long id);

    @Query("SELECT user FROM User user WHERE user.name LIKE %?1% OR user.email LIKE %?1% ORDER BY user.userRole")
    Optional<Iterable<User>> searchUser(String filter);

    @Transactional
    @Modifying
    @Query("UPDATE User u SET u.projects = ?2 WHERE u.id = ?1")
    void addProjectToUser(long id, Collection projectList);

    @Transactional
    @Modifying
    void deleteUserById(long id);

}
