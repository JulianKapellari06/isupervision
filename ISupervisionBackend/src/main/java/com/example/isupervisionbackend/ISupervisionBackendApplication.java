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
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

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

            List<Project> projects = new ArrayList<>();
            List<User> user = new ArrayList<>();
            User admin = new User("admin", "admin@gmail.com", "admin!", UserRole.Admin, projects);
            User student = new User("student", "student@gmail.com", "student!", UserRole.Student, projects);
            User assistant = new User("assistant", "assistant@gmail.com", "assistant!", UserRole.Assistant, projects);
            Project project = new Project("ISupervisionProject", "03-06-2022", ProjectRole.Project, user);
            Project bachelor = new Project("ISupervisionBachelor", "03-06-2022", "Description", ProjectRole.Bachelor, user);
            Project master = new Project("ISupervisionMaster", "03-06-2022", "12-12-2023", "Description", ProjectRole.Master, user);

            userRepository.save(student);
            userRepository.save(assistant);
            userRepository.save(admin);
            projectRepository.save(project);
            projectRepository.save(bachelor);
            projectRepository.save(master);

        };
    }

}
