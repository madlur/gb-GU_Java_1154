package ru.gb.application.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import ru.gb.application.dto.UserDto;
import ru.gb.application.entity.User;
import ru.gb.application.service.UserService;
import ru.gb.application.service.UserServiceImpl;

import javax.validation.Valid;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;


@Controller
public class MainController {

    private final UserServiceImpl userServiceImpl;
    private final UserService userService;

    @Autowired
    public MainController(UserServiceImpl userServiceImpl, UserService userService) {
        this.userServiceImpl = userServiceImpl;
        this.userService = userService;
    }


    @GetMapping("/")
    public String homePage(Model model) {
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, Locale.getDefault());
        model.addAttribute("serverTime", dateFormat.format(new Date()));
        return "index";
    }

    @GetMapping("/login")
    public String authPage() {

        return "login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("userDto", new UserDto());
        return "register";
    }

    @PostMapping("/register")
    public String registerPage(@Valid @ModelAttribute("userDto") UserDto userDto, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "register";
        }
        if (!userDto.getPassword().equals(userDto.getRepeatPassword())) {
            bindingResult.rejectValue("password", "", "Пароли не совпадают");
            return "register";
        }

        userService.create(userDto);

        return "redirect:/";
    }
}
