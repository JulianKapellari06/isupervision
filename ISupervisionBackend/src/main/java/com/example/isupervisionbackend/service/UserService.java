package com.example.isupervisionbackend.service;

import com.example.isupervisionbackend.model.LoginRequest;
import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.repository.ProjectRepository;
import com.example.isupervisionbackend.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service
@AllArgsConstructor
public class UserService {

    private UserRepository userRepository;

    private ProjectRepository projectRepository;
    private ProjectService projectService;

    public Iterable<User> getAll() {
        return userRepository.findAll();
    }

    public User register(User user) {

        if (!userRepository.findUserByEmail(user.getEmail()).isPresent()) {
            return userRepository.save(user);
        } else {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Email already used");
        }

    }

    public User login(LoginRequest request) {

        return userRepository.findUserByEmailAndPassword(request.getEmail(), request.getPassword()).orElseThrow(()
                -> new ResponseStatusException(HttpStatus.FORBIDDEN, "Email or password wrong"));
    }

    public User findUserById(long id) {
        return userRepository.findUserById(id).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "No user with that id"));
    }

    public void addProjectToUser(long user_id, long project_id) {

        //TODO Doesnt work
        User user = findUserById(user_id);
        Project project = projectService.getProjectById(project_id);

        List<Project> projectList = user.getProjects();
        projectList.add(project);

        user.setProjects(projectList);
        List<User> userList = project.getUser();
        userList.add(user);

        userRepository.save(user);
        projectRepository.save(project);


    }

    public Iterable<User> searchUser(String filter) {

        return userRepository.searchUser(filter).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "No user found"));
    }

    public void updateUser(User user) {

        userRepository.updateUser(user.getId(), user.getName(), user.getEmail(), user.getPassword(), user.getUserRole(), user.getProjects());

    }

    public void deleteUser(long id) {
        userRepository.deleteUserById(id);
    }
}
