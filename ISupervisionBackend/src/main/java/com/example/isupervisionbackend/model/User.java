package com.example.isupervisionbackend.model;

import com.example.isupervisionbackend.config.CustomListSerializer;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "User")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String name;
    private String email;
    private String password;

    @Enumerated(EnumType.STRING)
    private UserRole userRole;
    private int projectLimit;
    private int bachelorLimit;
    private int masterLimit;

    //@JsonIdentityReference(alwaysAsId=true)
    @JsonIgnoreProperties({"user"})
    @ManyToMany(targetEntity = Project.class, fetch = FetchType.LAZY, cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.PERSIST })
    @JoinTable(
            name = "user_project",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "work_id", referencedColumnName = "id"))

    private List<Project> projects = new ArrayList<>();

    public User(String name, String email, String password, UserRole userRole, int projectLimit, int bachelorLimit, int masterLimit, List<Project> projects) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.userRole = userRole;
        this.projectLimit = projectLimit;
        this.bachelorLimit = bachelorLimit;
        this.masterLimit = masterLimit;
        this.projects = projects;
    }

    public User(String name, String email, String password, UserRole userRole, List<Project> projects) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.userRole = userRole;
        this.projects = projects;
    }

    public void addProject(Project project) {
        projects.add(project);
    }
}
