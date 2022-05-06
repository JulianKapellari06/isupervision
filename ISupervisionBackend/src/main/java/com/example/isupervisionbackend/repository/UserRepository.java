package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserRepository extends CrudRepository<User,Long> {

    List<User> findAll();

}
