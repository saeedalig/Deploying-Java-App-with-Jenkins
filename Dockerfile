# Stage 1: Build the Java application
FROM maven:3.8.2-openjdk-11 AS builder
WORKDIR /app
COPY . /app
RUN mvn install

# Stage 2: Create the final Docker image
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the built JAR file from the builder stage to the final image
COPY --from=builder /app/target/Uber.jar /app/
EXPOSE 9090
CMD ["java", "-jar", "Uber.jar"]
