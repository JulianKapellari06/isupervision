package com.example.isupervisionbackend.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
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

    @ManyToMany(targetEntity = Project.class, fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "user_project",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "work_id", referencedColumnName = "id"))
    private List<Project> projects = new ArrayList<>();


    public User(String name, String email, String password, UserRole userRole, List<Project> projects) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.userRole = userRole;
        this.projects = projects;
    }
    public void addProject(Project project){
        projects.add(project);
    }
}
