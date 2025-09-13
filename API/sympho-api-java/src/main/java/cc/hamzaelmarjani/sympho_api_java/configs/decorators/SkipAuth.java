package cc.hamzaelmarjani.sympho_api_java.configs.decorators;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

// We will use this Decorator `@SkipAuth` on the public routes to skip auth-token validation.
@Target({ ElementType.METHOD, ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
public @interface SkipAuth {
}