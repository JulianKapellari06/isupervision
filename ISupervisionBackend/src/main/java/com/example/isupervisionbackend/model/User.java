package com.example.isupervisionbackend.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.LinkedList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "User")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String name;
    private String email;
    private String password;

    @Enumerated(EnumType.STRING)
    private UserRole userRole;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "user_project",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "work_id", referencedColumnName = "id"))
    private List<Project> projects = new LinkedList<>();

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "user_bachelor",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "work_id", referencedColumnName = "id"))
    private List<BachelorProject> bachelorProjects;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "user_master",
            joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "work_id", referencedColumnName = "id"))
    private List<MasterProject> masterProjects;



}
