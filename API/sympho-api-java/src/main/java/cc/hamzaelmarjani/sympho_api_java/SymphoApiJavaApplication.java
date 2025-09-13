package cc.hamzaelmarjani.sympho_api_java;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

@SpringBootApplication
public class SymphoApiJavaApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(SymphoApiJavaApplication.class, args);
        String port = context.getEnvironment().getProperty("server.port", "8080");
        System.out.println("Sympho API Java is running on http://localhost:" + port);
    }

}
