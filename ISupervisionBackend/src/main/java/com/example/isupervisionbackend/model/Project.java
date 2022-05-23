package com.example.isupervisionbackend.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "Work")
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String title;
    private String deadline;
    private String examDate;
    private String description;

    @Enumerated(EnumType.STRING)
    private ProjectRole projectRole;

    @ManyToMany(targetEntity = User.class, mappedBy = "projects", cascade = {CascadeType.PERSIST, CascadeType.DETACH, CascadeType.MERGE, CascadeType.REFRESH})
    private List<User> user;

    public Project(String title, String deadline, ProjectRole projectRole, List<User> user) {
        this.title = title;
        this.deadline = deadline;
        this.projectRole = projectRole;
        this.user = user;
    }

    public Project(String title, String deadline, String description, ProjectRole projectRole, List<User> user) {
        this.title = title;
        this.deadline = deadline;
        this.description = description;
        this.projectRole = projectRole;
        this.user = user;
    }

    public Project(String title, String deadline, String examDate, String description, ProjectRole projectRole, List<User> user) {

        this.title = title;
        this.deadline = deadline;
        this.examDate = examDate;
        this.description = description;
        this.projectRole = projectRole;
        this.user = user;
    }
}
