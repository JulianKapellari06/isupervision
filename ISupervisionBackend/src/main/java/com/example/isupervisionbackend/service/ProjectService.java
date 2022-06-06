package com.example.isupervisionbackend.service;

import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.ProjectRole;
import com.example.isupervisionbackend.repository.ProjectRepository;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Arrays;
import java.util.List;

@Service
@AllArgsConstructor
public class ProjectService {

    private ProjectRepository projectRepository;


    public Iterable<Project> getAllProjects() {

        return projectRepository.findAll();

    }

    public Iterable<Project> getAllProjectsByRole(ProjectRole projectRole) {

        return projectRepository.findProjectByProjectRole(projectRole).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "Unknown role"));

    }

    public void addProject(Project project) {

        projectRepository.save(project);

    }

    public Iterable<Project> getAllProjectsByUser(long id) {

        return projectRepository.findProjectByUserId(id).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "Unknown user"));

    }

    public Project getProjectById(long project_id) {
        return projectRepository.findProjectById(project_id).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "Unknown id"));
    }

    public Iterable<Project> searchProject(String filter) {

        return projectRepository.searchProject(filter).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "No project found"));
    }

    public void updateProject(Project project) {
        projectRepository.updateProject(project.getId(), project.getTitle(), project.getDeadline(), project.getExamDate(), project.getDescription(), project.getProjectRole(), project.getUser());
    }

    public void deleteProject(long id) {
        projectRepository.deleteProjectById(id);
    }

    public void deleteUserFromProject(long project_id, String[] user_ids) {

        Project project = getProjectById(project_id);

        List<String> list = Arrays.asList(user_ids);

        project.getUser().removeIf(item -> list.contains(item.getId()+""));

        projectRepository.save(project);

    }
}
