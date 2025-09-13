package cc.hamzaelmarjani.sympho_api_java.configs;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import cc.hamzaelmarjani.sympho_api_java.middleware.AuthInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private AuthInterceptor authInterceptor;

    @Override
    public void addInterceptors(@NonNull InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor)
                // Note: We apply `AuthInterceptor` on all routes
                .addPathPatterns("/**")
                // Note: You can ignore this method `excludePathPatterns` and use the decorator
                // `@SkipAuth` on all public routes.
                //
                // Note: We except those routes below as should be public.
                // TODO: Here you can add the public allowed routes
                // TODO: The applied routes below are the common used.
                // TODO: Remove what you want or remove the method `excludePathPatterns` call.
                .excludePathPatterns(
                        "/health", // Health check endpoint
                        "/actuator/**", // Spring Boot Actuator endpoints
                        "/auth/**", // Authentication routes (login, register, forget-password, etc.)
                        "/public/**", // Public routes
                        "/error/**", // Error pages
                        "/404" // 404 pages
                );
    }
}