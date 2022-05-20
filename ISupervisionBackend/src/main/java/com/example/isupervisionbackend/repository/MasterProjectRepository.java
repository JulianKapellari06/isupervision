package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.MasterProject;
import com.example.isupervisionbackend.model.Project;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface MasterProjectRepository extends CrudRepository<MasterProject, Integer> {

    Optional<Iterable<MasterProject>> findMasterProjectByUserId(long id);

    @Query("SELECT masterproject FROM MasterProject masterproject WHERE masterproject.title LIKE %?1%")
    Optional<List<MasterProject>> searchMasterProject(String filter);

}
