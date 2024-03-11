package com.example.fullstack.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDateTime;

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
public class User {

    @Id
    private Long id;

    @NotEmpty(message = "")
    private String firstName;

    @NotEmpty(message = "")
    private String lastName;

    @NotEmpty(message = "")
    private String email;

    @NotEmpty(message = "")
    private String password;

    @NotEmpty(message = "")
    private String address;

    @NotEmpty(message = "")
    private String phone;

    @NotEmpty(message = "")
    private String title;

    @NotEmpty(message = "")
    private String bio;

    @NotEmpty(message = "")
    private String imageUrl;

    @NotEmpty(message = "")
    private Boolean enabled;

    @NotEmpty(message = "")
    private Boolean isNotLocked;

    @NotEmpty(message = "")
    private Boolean isUsingMfa;

    @NotEmpty(message = "")
    private LocalDateTime createdAt;

}
