package com.example.isupervisionbackend.controller;

import com.example.isupervisionbackend.model.BachelorProject;
import com.example.isupervisionbackend.model.MasterProject;
import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.service.WorkService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(maxAge = 3600)
@RestController
@AllArgsConstructor
@RequestMapping("/api/project")
public class WorkController {

    private final WorkService workService;

    @GetMapping("/getAllProjects")
    public Iterable<Project> getAllProjects() {
        return workService.getAllProjects();
    }

    @PostMapping("/addProject")
    public void addProject(@RequestBody Project project) {

        workService.addProject(project);

    }

    @GetMapping("/getAllBachelorProjects")
    public Iterable<BachelorProject> getAllBachelorProjects() {
        return workService.getAllBachelorProjects();
    }

    @PostMapping("/addBachelorProject")
    public void addBachelorProject(@RequestBody BachelorProject project) {

        workService.addBachelorProject(project);

    }

    @GetMapping("/getAllMasterProjects")
    public Iterable<MasterProject> getAllMasterProjects() {
        return workService.getAllMasterProjects();
    }

    @PostMapping("/addMasterProject")
    public void addMasterProject(@RequestBody MasterProject project) {

        workService.addMasterProject(project);

    }

    @GetMapping("/getAllProjectsByUserId/{user_id}")
    public Iterable<Project> getAllProjectsByUser(@PathVariable long user_id) {
        return workService.getAllProjectsByUser(user_id);
    }

    @GetMapping("/getAllBachelorProjectsByUserId/{user_id}")
    public Iterable<BachelorProject> getAllBachelorProjectsByUser(@PathVariable long user_id) {
        return workService.getAllBachelorProjectsByUser(user_id);
    }

    @GetMapping("/getAllMasterProjectsByUserId/{user_id}")
    public Iterable<MasterProject> getAllMasterProjectsByUser(@PathVariable long user_id) {
        return workService.getAllMasterProjectsByUser(user_id);
    }
    @GetMapping("/searchProject/{filter}")
    public Iterable<Project> searchProject(@PathVariable String filter){

        return workService.searchProject(filter);

    }
    @GetMapping("/searchBachelorProject/{filter}")
    public Iterable<BachelorProject> searchBachelorProject(@PathVariable String filter){

        return workService.searchBachelorProject(filter);

    }
    @GetMapping("/searchMasterProject/{filter}")
    public Iterable<MasterProject> searchMasterProject(@PathVariable String filter){

        return workService.searchMasterProject(filter);

    }

}
