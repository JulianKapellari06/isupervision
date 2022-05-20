package com.example.isupervisionbackend.controller;

import com.example.isupervisionbackend.model.LoginRequest;
import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.net.http.HttpHeaders;
import java.util.List;

@CrossOrigin(maxAge = 3600)
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
    public User login(@RequestBody LoginRequest request, HttpServletResponse response) {
        System.out.println(request.getEmail());
        return userService.login(request);
    }
    @GetMapping("/getUserById/{id}")
    public User getUserById(@PathVariable long id) {
        return userService.findUserById(id);
    }
    @PostMapping("/addProjectToUser/{user_id}/{project_id}")
    public void addProjectToUser(@PathVariable long user_id, @PathVariable long project_id) {
        userService.addProjectToUser(user_id, project_id);
    }
    @GetMapping("/searchUser/{filter}")
    public Iterable<User> searchUser(@PathVariable String filter){

        return userService.searchUser(filter);

    }
}
