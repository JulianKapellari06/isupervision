package com.example.isupervisionbackend.service;

import com.example.isupervisionbackend.model.LoginRequest;
import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.expression.ExpressionException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.InputMismatchException;

@Service
@AllArgsConstructor
public class UserService {

    private UserRepository userRepository;

    public Iterable<User> getAll() {
        return userRepository.findAll();
    }

    public User register(User user) {

        return userRepository.save(user);

    }

    public User login(LoginRequest request) throws UsernameNotFoundException {

        return userRepository.findUserByEmailAndPassword(request.getEmail(), request.getPassword()).orElseThrow(() -> new UsernameNotFoundException(""));
    }
}
