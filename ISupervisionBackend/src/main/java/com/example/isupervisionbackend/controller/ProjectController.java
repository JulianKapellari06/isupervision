package com.example.isupervisionbackend.controller;

import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.ProjectRole;
import com.example.isupervisionbackend.service.ProjectService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(maxAge = 3600)
@RestController
@AllArgsConstructor
@RequestMapping("/api/project")
public class ProjectController {

    private final ProjectService projectService;

    @GetMapping("/getAllProjects")
    public Iterable<Project> getAllProjects() {
        return projectService.getAllProjects();
    }

    @GetMapping("/getAllProjectsByRole/{projectRole}")
    public Iterable<Project> getAllProjectsByRole(@PathVariable ProjectRole projectRole) {
        return projectService.getAllProjectsByRole(projectRole);
    }


    @PostMapping("/addProject")
    public void addProject(@RequestBody Project project) {

        projectService.addProject(project);

    }

    @GetMapping("/getAllProjectsByUserId/{user_id}")
    public Iterable<Project> getAllProjectsByUser(@PathVariable long user_id) {
        return projectService.getAllProjectsByUser(user_id);
    }

    @GetMapping("/searchProject/{filter}")
    public Iterable<Project> searchProject(@PathVariable String filter) {

        return projectService.searchProject(filter);

    }

    @PutMapping("/updateProject")
    public void updateProject(@RequestBody Project project) {
        projectService.updateProject(project);
    }

    @DeleteMapping("/deleteProject/{id}")
    public void deleteUser(@PathVariable long id) {
        projectService.deleteProject(id);
    }

    @PutMapping("/deleteUserFromProject/{project_id}/{user_ids}")
    public void deleteUserFromProject(@PathVariable long project_id, @PathVariable String[] user_ids) {
        projectService.deleteUserFromProject(project_id, user_ids);
    }

}
