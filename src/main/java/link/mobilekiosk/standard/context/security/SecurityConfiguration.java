package link.mobilekiosk.standard.context.security;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
public class SecurityConfiguration {

  public static final String[] PUBLIC_PATH = new String[] {"/profile"};

  @Bean
  protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http.httpBasic()
        .disable()
        .csrf()
        .disable()
        .logout()
        .disable()
        .sessionManagement()
        .sessionCreationPolicy(SessionCreationPolicy.STATELESS);

    http.authorizeRequests().antMatchers(PUBLIC_PATH).permitAll().anyRequest().authenticated();
    return http.build();
  }
}
