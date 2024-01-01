package dev.danvega.h2demo;

import dev.danvega.h2demo.model.Users;
import dev.danvega.h2demo.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class H2DemoApplication {

	public static void main(String[] args) {
		ConfigurableApplicationContext context = SpringApplication.run(H2DemoApplication.class, args);
		Object dataSource = context.getBean("dataSource");
		System.out.println(dataSource);
	}

	@Bean
	CommandLineRunner commandLineRunner(UserRepository repository) {
		return args -> {
			repository.save(new Users(null,"Mark Heckler","Mark","12123"));
		};
	}

}
