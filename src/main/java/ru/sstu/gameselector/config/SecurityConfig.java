package ru.sstu.gameselector.config;

import lombok.SneakyThrows;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    public static final String ADMIN_ROLE = "ADMIN";

    @Override
    @SneakyThrows
    protected void configure(HttpSecurity http) {
        http
                .csrf().disable()
                .authorizeRequests()
                .antMatchers("/admin/**").hasRole(ADMIN_ROLE)
                .anyRequest().permitAll()
                .and()
                .formLogin()
                .defaultSuccessUrl("/");
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }

    @Override
    @SneakyThrows
    protected void configure(AuthenticationManagerBuilder auth) {
        auth.inMemoryAuthentication()
                .withUser("admin")
                .password("admin")
                .roles(ADMIN_ROLE);
    }
}
