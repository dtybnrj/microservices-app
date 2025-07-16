<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# Microservices Application - Copilot Instructions

This is a Java microservices application built with Spring Boot 3.2.5 and Java 17. The project follows a multi-module Maven structure with three main services:

## Project Structure
- **User Service** (Port 8081): H2 Database
- **Product Service** (Port 8082): MongoDB
- **Order Service** (Port 8083): MySQL

## Code Style Guidelines
- Use Lombok annotations (@Data, @Entity, @RequiredArgsConstructor) for reducing boilerplate
- Follow Spring Boot best practices for controller, service, and repository layers
- Use proper REST API conventions (GET, POST, PUT, DELETE)
- Include Swagger/OpenAPI annotations for API documentation
- Use ResponseEntity for proper HTTP status codes

## Database Guidelines
- User Service: JPA entities with H2 database
- Product Service: MongoDB documents with @Document annotation
- Order Service: JPA entities with MySQL, includes service-to-service communication

## Docker Guidelines
- Each service has its own Dockerfile using openjdk:17-jdk-slim
- Use docker-compose.yml for orchestration
- Include health checks and proper networking

## Testing Guidelines
- Use Spring Boot Test annotations
- Include integration tests for repositories
- Test REST endpoints with proper HTTP status codes

## Dependencies
- Spring Boot Starter Web
- Spring Boot Starter Data JPA (User & Order services)
- Spring Boot Starter Data MongoDB (Product service)
- Spring Boot Starter Actuator (health checks)
- Springdoc OpenAPI (API documentation)
- Lombok (reducing boilerplate)

## Service Communication
- Order Service validates users by calling User Service REST API
- Use RestTemplate for inter-service communication
- Handle service failures gracefully

When generating code, ensure it follows these patterns and integrates well with the existing codebase.
