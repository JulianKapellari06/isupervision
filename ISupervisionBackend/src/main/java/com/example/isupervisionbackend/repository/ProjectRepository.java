package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProjectRepository extends CrudRepository<Project, Integer> {

    Optional<Iterable<Project>> findProjectByUserId(long id);

    Optional<Project> findProjectById(long id);

    @Query("SELECT project FROM Project project WHERE project.title LIKE %?1%")
    Optional<List<Project>> searchProject(String filter);
}
