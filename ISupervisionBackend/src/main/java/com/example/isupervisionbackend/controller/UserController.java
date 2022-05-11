package com.example.isupervisionbackend.controller;

import com.example.isupervisionbackend.model.LoginRequest;
import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;

    @GetMapping("/getAll")
    public Iterable<User> getAll(){
        return userService.getAll();
    }

    @PostMapping("/register")
    public User register(@RequestBody User user){
        return userService.register(user);
    }

    @GetMapping("/login")
    public User login(@RequestBody LoginRequest request) {
        return userService.login(request);
    }
}
