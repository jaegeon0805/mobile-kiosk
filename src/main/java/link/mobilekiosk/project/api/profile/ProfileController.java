package link.mobilekiosk.project.api.profile;

import java.util.Arrays;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ProfileController {

  private final Environment environment;

  @GetMapping("/profile")
  public String checkProfile() {
    List<String> profiles = Arrays.asList(environment.getActiveProfiles());
    List<String> deployProfiles = Arrays.asList("deploy1", "deploy2");

    String defaultProfile = profiles.isEmpty() ? "default" : profiles.get(0);

    return profiles.stream().filter(deployProfiles::contains).findAny().orElse(defaultProfile);
  }
}
