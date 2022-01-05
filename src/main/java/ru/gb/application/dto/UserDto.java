package ru.gb.application.dto;


import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Data
public class UserDto {

    private Long id;

    @NotNull(message = "Name cannot be null")
    @Size(min = 2, max = 15, message
            = "username must be between 2 and 15 characters")
    private String userName;

    @NotBlank
    @Size(min = 3, max = 10, message
            = "Password must be between 3 and 10 characters")
    private String password;

    @NotBlank
    private String repeatPassword;

    @NotBlank
    @Size(min = 2, max = 15, message
            = "FirstName must be between 2 and 15 characters")
    private String firstName;

    @NotBlank
    @Size(min = 2, max = 15, message
            = "Lastname must be between 2 and 15 characters")
    private String lastName;

    @Email(message = "Email should be valid")
    private String email;

}