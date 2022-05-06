package com.example.isupervisionbackend.service;

import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUser() {
        return userRepository.findAll();
    }

    public User addUser(User user) {

       return userRepository.save(user);

    }
}
