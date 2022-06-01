package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.ProjectRole;
import com.example.isupervisionbackend.model.User;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface ProjectRepository extends CrudRepository<Project, Integer> {

    Optional<Iterable<Project>> findProjectByUserId(long id);

    Optional<Project> findProjectById(long id);

    @Query("SELECT project FROM Project project WHERE project.title LIKE %?1% ORDER BY project.projectRole")
    Optional<List<Project>> searchProject(String filter);

    Optional<Iterable<Project>> findProjectByProjectRole(ProjectRole projectRole);

    //TODO update User from Projects
    @Transactional
    @Modifying
    @Query("UPDATE Project p SET p.title = ?2, p.deadline = ?3, p.examDate = ?4, p.description = ?5, p.projectRole = ?6 WHERE p.id = ?1")
    void updateProject(long id, String title, Date deadline, Date examDate, String description, ProjectRole projectRole, List<User> user);

    @Transactional
    @Modifying
    void deleteProjectById(long id);
}
