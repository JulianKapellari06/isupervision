package com.example.isupervisionbackend.model;

import com.example.isupervisionbackend.config.CustomListSerializer;
import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
import java.util.ArrayList;
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
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss.SSS")
    private Date deadline;
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss.SSS")
    private Date examDate;
    private String description;

    @Enumerated(EnumType.STRING)
    private ProjectRole projectRole;

    @JsonIgnoreProperties({"projects"})
    @ManyToMany(targetEntity = User.class, mappedBy = "projects", fetch = FetchType.LAZY, cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.PERSIST})
    @JsonSerialize(using = CustomListSerializer.class)
    private List<User> user = new ArrayList<>();


    public Project(String title, Date deadline, ProjectRole projectRole, List<User> user) {
        this.title = title;
        this.deadline = deadline;
        this.projectRole = projectRole;
        this.user = user;
    }

    public Project(String title, Date deadline, String description, ProjectRole projectRole, List<User> user) {
        this.title = title;
        this.deadline = deadline;
        this.description = description;
        this.projectRole = projectRole;
        this.user = user;
    }

    public Project(String title, Date deadline, Date examDate, String description, ProjectRole projectRole, List<User> user) {

        this.title = title;
        this.deadline = deadline;
        this.examDate = examDate;
        this.description = description;
        this.projectRole = projectRole;
        this.user = user;
    }
}
