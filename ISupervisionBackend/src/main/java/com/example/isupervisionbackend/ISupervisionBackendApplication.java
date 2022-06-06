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

import java.sql.Date;
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
            

            Date finished = new Date(121,11,19);
            Date date = new Date(122,7,10);
            Date date1 = new Date(122,9,11);
            Date date2 = new Date(123,7,10);


            User admin = new User("Admin", "admin@gmail.com",  "admin!", UserRole.Admin, null);

            User student = new User("Student", "student@gmail.com",  "student!", UserRole.Student, null);
            User kapellari = new User("Kapellari", "kapellari@gmail.com",  "123456!", UserRole.Student, null);
            User alamer = new User("Alamer", "alamer@gmail.com",  "AlamerIsCool!", UserRole.Student, null);
            User sekic = new User("Sekic", "sekic@gmail.com",  "Password!", UserRole.Student, null);

            User assistant = new User("Assistant", "assistant@gmail.com",  "assistant!", UserRole.Assistant, 10,5,5, null);
            User stettinger = new User("Stettinger", "stettinger@gmail.com",  "bestPasswordOnEarth!", UserRole.Assistant,5,3,3, null);

            Project project = new Project("ISupervisionProject", finished, ProjectRole.Project, null);
            Project bachelor = new Project("ISupervisionBachelor", finished, "Description", ProjectRole.Bachelor, null);
            Project master = new Project("ISupervisionMaster", finished, date, "Description", ProjectRole.Master, null);
            Project dynamicMenu = new Project("DynamicMenu", date1, ProjectRole.Project, null);
            Project autoGrowBox = new Project("AutoGrowBox", date1, "Full automatic box to grow plants", ProjectRole.Bachelor, null);
            Project smartFan = new Project("SmartFan", date1, date2, "Obviously a smart fan", ProjectRole.Master, null);

            assistant.setProjects(List.of(dynamicMenu));
            stettinger.setProjects(List.of(autoGrowBox, smartFan));

            student.setProjects(List.of(project, bachelor, master));
            kapellari.setProjects(List.of(project, dynamicMenu));
            alamer.setProjects(List.of(project, bachelor, smartFan));
            sekic.setProjects(List.of(project,bachelor,master,autoGrowBox));

            project.setUser(List.of(student, kapellari,alamer, sekic));
            bachelor.setUser(List.of(student,alamer, sekic));
            master.setUser(List.of(student,alamer));
            dynamicMenu.setUser(List.of(kapellari, assistant));
            autoGrowBox.setUser(List.of(stettinger, sekic));
            smartFan.setUser(List.of(stettinger, alamer));


            userRepository.save(student);
            userRepository.save(assistant);
            userRepository.save(admin);
            userRepository.save(kapellari);
            userRepository.save(sekic);
            userRepository.save(alamer);

            projectRepository.save(project);
            projectRepository.save(bachelor);
            projectRepository.save(master);
            projectRepository.save(dynamicMenu);
            projectRepository.save(smartFan);
            projectRepository.save(autoGrowBox);

        };
    }

}
