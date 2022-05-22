package com.example.isupervisionbackend.controller;

import com.example.isupervisionbackend.model.LoginRequest;
import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionException;
import org.springframework.http.MediaType;
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

    @GetMapping("/login/{email}/{password}")
    public User login(@PathVariable String email, @PathVariable String password) {
        return userService.login(new LoginRequest(email,password));
    }

    @GetMapping("/getUserById/{id}")
    public User getUserById(@PathVariable long id) {
        return userService.findUserById(id);
    }

    @GetMapping("/searchUser/{filter}")
    public Iterable<User> searchUser(@PathVariable String filter){

        return userService.searchUser(filter);

    }

    @PutMapping(value = "/updateUser")
    public void updateUser(@RequestBody User user){
        userService.updateUser(user);
    }

    //TODO doesnt work
    @PutMapping("/addProjectToUser/{user_id}/{project_id}")
    public void addProjectToUser(@PathVariable long user_id, @PathVariable long project_id) {
        userService.addProjectToUser(user_id, project_id);
    }

    @DeleteMapping("/deleteUser/{id}")
    public void deleteUser(@PathVariable long id){
        userService.deleteUser(id);
    }
}
