package com.example.isupervisionbackend;

import com.example.isupervisionbackend.model.Project;
import com.example.isupervisionbackend.model.ProjectRole;
import com.example.isupervisionbackend.model.User;
import com.example.isupervisionbackend.model.UserRole;
import com.example.isupervisionbackend.repository.ProjectRepository;
import com.example.isupervisionbackend.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jackson.JacksonAutoConfiguration;
import org.springframework.context.annotation.Bean;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

@SpringBootApplication
public class ISupervisionBackendApplication {

    public static void main(String[] args) throws Throwable {
        SpringApplication.run(ISupervisionBackendApplication.class, args);
    }

    @Bean
    public CommandLineRunner run(UserRepository userRepository, ProjectRepository projectRepository) throws Exception {
        return (String[] args) -> {

            Date date = new Date();

            List<Project> projects = new ArrayList<>();
            List<User> user = new ArrayList<>();

            User admin = new User("admin", "admin@gmail.com", "admin!", UserRole.Admin, projects);
            User student = new User("student", "student@gmail.com", "student!", UserRole.Student, projects);
            User assistant = new User("assistant", "assistant@gmail.com", "assistant!", UserRole.Assistant, projects);

            Project project = new Project("ISupervisionProject", date, ProjectRole.Project, user);
            Project bachelor = new Project("ISupervisionBachelor", date, "Description", ProjectRole.Bachelor, user);
            Project master = new Project("ISupervisionMaster", date, date, "Description", ProjectRole.Master, user);
            Project project2 = new Project("test1", date, ProjectRole.Project, user);
            Project bachelor2 = new Project("test2", date, "Description", ProjectRole.Bachelor, user);
            Project master2 = new Project("test3", date, date, "Description", ProjectRole.Master, user);

            student.setProjects(List.of(project, bachelor, master));

            admin.setProjects(List.of(project2));
            project2.setUser(List.of(admin));

            assistant.setProjects(List.of(project, bachelor, master));
            project.setUser(List.of(student, assistant));
            bachelor.setUser(List.of(student, assistant));
            master.setUser(List.of(student, assistant));

            userRepository.save(student);
            userRepository.save(assistant);
            userRepository.save(admin);

            projectRepository.save(project);
            projectRepository.save(bachelor);
            projectRepository.save(master);
            projectRepository.save(project2);
            projectRepository.save(bachelor2);
            projectRepository.save(master2);

        };
    }

}
