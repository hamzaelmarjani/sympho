# Use Eclipse Temurin JDK 17 with Ubuntu Focal as the base image
FROM eclipse-temurin:17-jdk-focal

# Set the working directory inside the container
WORKDIR /app

# Copy Maven wrapper and configuration first (for better caching)
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Pre-download dependencies to cache them in a separate layer
RUN ./mvnw dependency:go-offline

# Copy the source code into the container
COPY src ./src

# Expose port 8080 (Spring Boot default)
EXPOSE 8080

# Run the Spring Boot app using Maven wrapper
CMD ["./mvnw", "spring-boot:run"]