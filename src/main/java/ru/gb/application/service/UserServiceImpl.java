package ru.gb.application.service;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.gb.application.entity.User;
import ru.gb.application.repositories.UserRepository;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserDetailsService {

   private final UserRepository userRepository;


    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

        Optional<User> mayBeUser = userRepository.findByEmail(userName);
        if (mayBeUser.isEmpty()) {
            throw new UsernameNotFoundException("User cannot be found by passed name: " + userName);
        }

        User user = mayBeUser.get();
        return new org.springframework.security.core.userdetails.User(user.getEmail(), mayBeUser.get().getPassword(),
                user.getRoles()
                        .stream()
                        .map(role -> new SimpleGrantedAuthority(role.getName()))
                        .toList()
        );
    }

}
