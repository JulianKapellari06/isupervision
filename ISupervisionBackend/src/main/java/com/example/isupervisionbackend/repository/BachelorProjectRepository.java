package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.BachelorProject;
import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface BachelorProjectRepository extends CrudRepository<BachelorProject, Integer> {

    Optional<Iterable<BachelorProject>> findBachelorProjectByUserId(long id);

    @Query("SELECT bachelorproject FROM BachelorProject bachelorproject WHERE bachelorproject.title LIKE %?1%")
    Optional<List<BachelorProject>> searchBachelorProject(String filter);
}
