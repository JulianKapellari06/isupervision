package com.example.isupervisionbackend.controller;

import com.example.isupervisionbackend.model.BachelorProject;
import com.example.isupervisionbackend.model.MasterProject;
import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.service.WorkService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/api/project")
public class WorkController {

    private final WorkService workService;

    @GetMapping("/getAllProjects")
    public Iterable<Project> getAllProjects(){
        return workService.getAllProjects();
    }

    @PostMapping("/addProject")
    public void addProject(@RequestBody Project project){

        workService.addProject(project);

    }
    @GetMapping("/getAllBachelorProjects")
    public Iterable<BachelorProject> getAllBachelorProjects(){
        return workService.getAllBachelorProjects();
    }

    @PostMapping("/addBachelorProject")
    public void addBachelorProject(@RequestBody BachelorProject project){

        workService.addBachelorProject(project);

    }
    @GetMapping("/getAllMasterProjects")
    public Iterable<MasterProject> getAllMasterProjects(){
        return workService.getAllMasterProjects();
    }

    @PostMapping("/addMasterProject")
    public void addMasterProject(@RequestBody MasterProject project){

        workService.addMasterProject(project);

    }

}
