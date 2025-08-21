# Step 1: Use an official Gradle image to build the application
FROM gradle:8.3.0-jdk17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project to the container
COPY . .

# Build the application
RUN gradle clean bootJar

# Step 2: Use a lightweight JDK image for running the app
FROM openjdk:17-jdk-slim

# Set the working directory for the runtime container
WORKDIR /app
COPY grafana-opentelemetry-java.jar g-o-j.jar

# Copy the JAR file from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Variables
ENV OTEL_RESOURCE_ATTRIBUTES="service.name=airlines,service.namespace=orange2,deployment.environment=dev"
ENV OTEL_EXPORTER_OTLP_ENDPOINT="https://otlp-gateway-prod-eu-west-2.grafana.net/otlp"
ENV OTEL_EXPORTER_OTLP_HEADERS=${OTEL_EXPORTER_OTLP_HEADERS}
ENV OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"

# Set the command to run the application
ENTRYPOINT ["java", "-javaagent:g-o-j.jar", "-jar", "app.jar"]