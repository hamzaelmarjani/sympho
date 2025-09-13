package cc.hamzaelmarjani.sympho_api_java.middleware;

import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import cc.hamzaelmarjani.sympho_api_java.configs.decorators.SkipAuth;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.lang.NonNull;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull Object handler)
            throws Exception {

        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;

        if (handlerMethod.hasMethodAnnotation(SkipAuth.class) ||
                handlerMethod.getBeanType().isAnnotationPresent(SkipAuth.class)) {
            return true;
        }

        // We use "Authorization", you can replace it with your header name.
        String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            sendUnauthorizedResponse(response, "unauthorized-request");
            return false;
        }

        /// We use "Bearer ", which is 7 length, we need to substring it from the
        /// header value.
        String token = authHeader.substring(7);

        if (!isValidToken(token)) {
            sendUnauthorizedResponse(response, "unauthorized-request");
            return false;
        }

        return true;
    }

    private void sendUnauthorizedResponse(HttpServletResponse response, String message) throws Exception {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json");
        response.getWriter().write("{\"error\": \"unauthorized\", \"message\": \"" + message + "\"}");
    }

    private boolean isValidToken(String token) {
        // TODO: Handle the user check using the received token depending your
        // TODO: situation. You can use JWT service or any mechanism you want.
        // TODO: for now we will use just this fake token.
        if (!token.equals("f77cc4dd-b796-42e7-9c93-c7a69a83ec34")) {
            return false;
        }

        return !token.trim().isEmpty();
    }

}