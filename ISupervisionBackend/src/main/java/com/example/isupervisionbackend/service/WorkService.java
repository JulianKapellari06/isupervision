package com.example.isupervisionbackend.service;

import com.example.isupervisionbackend.model.BachelorProject;
import com.example.isupervisionbackend.model.MasterProject;
import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.repository.BachelorProjectRepository;
import com.example.isupervisionbackend.repository.MasterProjectRepository;
import com.example.isupervisionbackend.repository.ProjectRepository;
import com.example.isupervisionbackend.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.server.ResponseStatusException;

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

    public Iterable<Project> getAllProjectsByUser(long id) {

        return projectRepository.findProjectByUserId(id).orElseThrow(()-> new ResponseStatusException(HttpStatus.FORBIDDEN, "Unknown user") );

    }

    public Iterable<BachelorProject> getAllBachelorProjectsByUser(long id) {

        return bachelorProjectRepository.findBachelorProjectByUserId(id).orElseThrow(()-> new ResponseStatusException(HttpStatus.FORBIDDEN, "Unknown user") );


    }

    public Iterable<MasterProject> getAllMasterProjectsByUser(long id) {
        return masterProjectRepository.findMasterProjectByUserId(id).orElseThrow(()-> new ResponseStatusException(HttpStatus.FORBIDDEN, "Unknown user") );
    }

    public Project getProjectById(long project_id) {
        return projectRepository.findProjectById(project_id).orElseThrow(()->new ResponseStatusException(HttpStatus.FORBIDDEN,"Unknown id"));
    }
    public Iterable<Project> searchProject(String filter) {

        return projectRepository.searchProject(filter).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "No project found"));
    }
    public Iterable<BachelorProject> searchBachelorProject(String filter) {

        return bachelorProjectRepository.searchBachelorProject(filter).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "No bachelor project found"));
    }
    public Iterable<MasterProject> searchMasterProject(String filter) {

        return masterProjectRepository.searchMasterProject(filter).orElseThrow(() -> new ResponseStatusException(HttpStatus.FORBIDDEN, "No master project found"));
    }
}
