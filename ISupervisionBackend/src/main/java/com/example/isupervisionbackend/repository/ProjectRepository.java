package com.example.isupervisionbackend.repository;

import com.example.isupervisionbackend.model.Project;
import org.springframework.data.repository.CrudRepository;

public interface ProjectRepository extends CrudRepository<Project, Long> {
}
