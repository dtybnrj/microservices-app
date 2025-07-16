#!/bin/bash

# Maven wrapper script for running microservices
# Usage: ./mvnw.sh <command> [service]

case "$1" in
  "build")
    echo "Building all services..."
    mvn clean install
    ;;
  "run-user")
    echo "Running User Service on port 8081..."
    cd user-service && mvn spring-boot:run
    ;;
  "run-product")
    echo "Running Product Service on port 8082..."
    cd product-service && mvn spring-boot:run
    ;;
  "run-order")
    echo "Running Order Service on port 8083..."
    cd order-service && mvn spring-boot:run
    ;;
  "docker-build")
    echo "Building Docker images..."
    docker-compose build
    ;;
  "docker-up")
    echo "Starting all services with Docker Compose..."
    docker-compose up --build
    ;;
  "docker-down")
    echo "Stopping all services..."
    docker-compose down
    ;;
  *)
    echo "Usage: $0 {build|run-user|run-product|run-order|docker-build|docker-up|docker-down}"
    echo ""
    echo "Commands:"
    echo "  build        - Build all services"
    echo "  run-user     - Run User Service"
    echo "  run-product  - Run Product Service"
    echo "  run-order    - Run Order Service"
    echo "  docker-build - Build Docker images"
    echo "  docker-up    - Start all services with Docker"
    echo "  docker-down  - Stop all services"
    exit 1
    ;;
esac
