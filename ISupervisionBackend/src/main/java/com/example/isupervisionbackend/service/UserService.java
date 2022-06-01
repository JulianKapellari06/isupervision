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

import java.util.Arrays;
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

        User user = findUserById(user_id);
        Project project = projectService.getProjectById(project_id);

        user.addProject(project);

        userRepository.save(user);


    }

    public Iterable<User> searchUser(String filter) {

        return userRepository.searchUser(filter).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "No user found"));
    }

    public void updateUser(User user) {

        User existingUser = findUserById(user.getId());
        existingUser.setProjects(user.getProjects());
        existingUser.setUserRole(user.getUserRole());
        existingUser.setPassword(user.getPassword());
        existingUser.setEmail(user.getEmail());
        existingUser.setName(user.getName());
        existingUser.setBachelorLimit(user.getBachelorLimit());
        existingUser.setMasterLimit(user.getMasterLimit());
        existingUser.setProjectLimit(user.getProjectLimit());
        userRepository.save(existingUser);
    }

    public void deleteUser(long id) {
        userRepository.deleteUserById(id);
    }

    public void addProjectAssistant(Project project, long user_id) {

        User user = findUserById(user_id);
        user.getProjects().add(project);

        projectRepository.save(project);
        userRepository.save(user);

    }

    public void deleteProjectFromUser(long user_id, String[] project_ids) {

        User user = findUserById(user_id);

        List<String> list = Arrays.asList(project_ids);

        user.getProjects().removeIf(item -> list.contains(item.getId()+""));
        userRepository.save(user);
    }
}
