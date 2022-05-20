package com.example.isupervisionbackend.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Entity;
import java.util.Date;

@Entity
@Setter
@Getter
@NoArgsConstructor
public class MasterProject extends Work{

    private String examDate;

    private String description;

}
