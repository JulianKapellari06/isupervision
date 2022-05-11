package com.example.isupervisionbackend.service;

import com.example.isupervisionbackend.model.BachelorProject;
import com.example.isupervisionbackend.model.MasterProject;
import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.repository.BachelorProjectRepository;
import com.example.isupervisionbackend.repository.MasterProjectRepository;
import com.example.isupervisionbackend.repository.ProjectRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class WorkService {

    private ProjectRepository projectRepository;
    private BachelorProjectRepository bachelorProjectRepository;
    private MasterProjectRepository masterProjectRepository;

    public Iterable<Project> getAllProjects() {

        return projectRepository.findAll();

    }

    public void addProject(Project project){

        projectRepository.save(project);

    }
    public Iterable<BachelorProject> getAllBachelorProjects() {

        return bachelorProjectRepository.findAll();

    }

    public void addBachelorProject(BachelorProject project){

        bachelorProjectRepository.save(project);

    }
    public Iterable<MasterProject> getAllMasterProjects() {

        return masterProjectRepository.findAll();

    }

    public void addMasterProject(MasterProject project){

        masterProjectRepository.save(project);

    }
}
