package dev.danvega.h2demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http
                .csrf(csrf -> csrf.ignoringAntMatchers("/h2-console/**", "/api/**"))  // เปลี่ยน "/api/user" เป็น "/api/**"
                .authorizeRequests(auth -> auth
                        .antMatchers("/api/**").permitAll()  // เปลี่ยน "/api/user" เป็น "/api/**"
                        .antMatchers("/h2-console/**").permitAll()
                        .anyRequest().authenticated()
                )
                .headers(headers -> headers.frameOptions().sameOrigin())
                .build();
    }

}
