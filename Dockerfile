# Use Maven image to build the project
FROM maven:3.8.1-openjdk-11-slim AS build

# Set environment variables for Maven
ENV MAVEN_CONFIG=/root/.m2

# Create the Maven local repository directory
RUN mkdir -p /root/.m2/repository

# Set the working directory
WORKDIR /app

# Copy the Maven settings (if any) and the application source
COPY settings.xml /root/.m2/settings.xml
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package

# Use a smaller JRE image to run the tests
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built application and test resources
COPY --from=build /app/target/my-app.jar /app/my-app.jar
COPY src/test/resources /app/src/test/resources
COPY src/test/java /app/src/test/java

# Set the entry point to run the Cucumber tests
ENTRYPOINT ["java", "-cp", "my-app.jar:dependencies/*", "io.cucumber.core.cli.Main", "-g", "com.example", "src/test/resources/features"]

