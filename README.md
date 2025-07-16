# Microservices Application

A complete Java microservices application built with Spring Boot, featuring three services: User Service, Product Service, and Order Service. This application demonstrates a modern microservices architecture with different databases, Docker containerization, and comprehensive API documentation.

## Project Overview

This microservices application consists of:

- **User Service** (Port 8081): Manages user data with H2 in-memory database
- **Product Service** (Port 8082): Manages product catalog with MongoDB
- **Order Service** (Port 8083): Manages orders with MySQL and validates users through User Service

### Architecture Features

- **Multi-module Maven project** with parent POM dependency management
- **Spring Boot 3.2.5** with Java 17
- **Different databases** for each service (H2, MongoDB, MySQL)
- **Service-to-service communication** using RestTemplate
- **Docker containerization** with Docker Compose
- **Health checks** using Spring Boot Actuator
- **API documentation** with Swagger/OpenAPI
- **RESTful APIs** with full CRUD operations

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher
- Docker and Docker Compose
- Git (for cloning the repository)

## How to Set Up and Build

### 1. Clone the Repository

```bash
git clone <repository-url>
cd microservices-app
```

### 2. Build the Project

Build all modules from the root directory:

```bash
mvn clean install
```

This will:
- Compile all three services
- Run tests
- Package each service into a JAR file
- Install dependencies

### 3. Build Individual Services (Optional)

To build individual services:

```bash
# User Service
cd user-service
mvn clean install

# Product Service
cd product-service
mvn clean install

# Order Service
cd order-service
mvn clean install
```

## How to Run the System

### Using Docker Compose (Recommended)

The easiest way to run the entire application stack:

```bash
# From the root directory
docker-compose up --build
```

This will:
- Build Docker images for all services
- Start MySQL and MongoDB databases
- Start all three microservices
- Configure networking between services
- Run health checks

### Running Individual Services (Development)

For development, you can run services individually:

```bash
# Terminal 1 - User Service
cd user-service
mvn spring-boot:run

# Terminal 2 - Product Service (requires MongoDB)
cd product-service
mvn spring-boot:run

# Terminal 3 - Order Service (requires MySQL and User Service)
cd order-service
mvn spring-boot:run
```

**Note**: When running individually, make sure to:
- Start databases (MySQL, MongoDB) separately
- Update `application.properties` to use `localhost` instead of container names
- Start services in order: User Service → Product Service → Order Service

## How to Test the System

### Service URLs

- **User Service**: http://localhost:8081
- **Product Service**: http://localhost:8082
- **Order Service**: http://localhost:8083

### Example API Tests

#### 1. Create a User

```bash
curl -X POST http://localhost:8081/users \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "email": "john@example.com"
  }'
```

Expected Response:
```json
{
  "id": 1,
  "username": "john_doe",
  "email": "john@example.com",
  "createdAt": "2024-01-15T10:30:00.000Z"
}
```

#### 2. Get All Users

```bash
curl http://localhost:8081/users
```

#### 3. Create a Product

```bash
curl -X POST http://localhost:8082/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Laptop",
    "description": "High-performance laptop",
    "price": 999.99
  }'
```

Expected Response:
```json
{
  "id": "64f8b1c2a1b2c3d4e5f6g7h8",
  "name": "Laptop",
  "description": "High-performance laptop",
  "price": 999.99
}
```

#### 4. Get All Products

```bash
curl http://localhost:8082/products
```

#### 5. Create an Order

```bash
curl -X POST http://localhost:8083/orders \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "productId": "64f8b1c2a1b2c3d4e5f6g7h8",
    "quantity": 2
  }'
```

Expected Response:
```json
{
  "id": 1,
  "userId": 1,
  "productId": "64f8b1c2a1b2c3d4e5f6g7h8",
  "quantity": 2,
  "orderDate": "2024-01-15T10:35:00.000Z"
}
```

#### 6. Get Orders by User

```bash
curl http://localhost:8083/orders/user/1
```

### Testing with Postman

A comprehensive Postman collection is provided for easy API testing:

#### 📦 **Postman Collection Files**

1. **Microservices-API-Collection.postman_collection.json** - Complete API collection
2. **Microservices-Development.postman_environment.json** - Development environment
3. **Microservices-Docker.postman_environment.json** - Docker environment
4. **POSTMAN_COLLECTION_README.md** - Detailed collection documentation

#### 🚀 **Quick Import Instructions**

1. **Import Collection**:
   - Open Postman
   - Click "Import" → Select `Microservices-API-Collection.postman_collection.json`

2. **Import Environment**:
   - Go to "Environments" tab
   - Click "Import" → Select `Microservices-Development.postman_environment.json`

3. **Select Environment**:
   - Choose "Microservices Development Environment" from the dropdown

#### 📋 **Collection Structure**

The collection includes organized folders for:

- **User Service** (8081): Complete CRUD operations + health checks
- **Product Service** (8082): CRUD + search/filter operations + health checks
- **Order Service** (8083): CRUD + user/product filters + health checks
- **Health Checks**: Monitoring endpoints for all services

#### 🔧 **Features Included**

- ✅ **All CRUD endpoints** for each service
- ✅ **Environment variables** for easy configuration
- ✅ **Sample request bodies** with realistic data
- ✅ **Response examples** for all endpoints
- ✅ **Health check endpoints** for monitoring
- ✅ **Error handling examples** (404, 400, 500)
- ✅ **Service-specific search/filter operations**

#### 📖 **For detailed instructions**, see: `POSTMAN_COLLECTION_README.md`

## API Documentation

Each service includes interactive API documentation using Swagger/OpenAPI:

### Swagger UI URLs

- **User Service**: http://localhost:8081/swagger-ui.html
- **Product Service**: http://localhost:8082/swagger-ui.html
- **Order Service**: http://localhost:8083/swagger-ui.html

### API Docs (JSON)

- **User Service**: http://localhost:8081/v3/api-docs
- **Product Service**: http://localhost:8082/v3/api-docs
- **Order Service**: http://localhost:8083/v3/api-docs

The Swagger UI provides:
- Interactive API testing
- Request/response examples
- Parameter descriptions
- Authentication details
- Response schemas

## Health Checks

Health checks are implemented using Spring Boot Actuator:

### Health Check URLs

- **User Service**: http://localhost:8081/actuator/health
- **Product Service**: http://localhost:8082/actuator/health
- **Order Service**: http://localhost:8083/actuator/health

### Additional Actuator Endpoints

- **Info**: `/actuator/info`
- **Metrics**: `/actuator/metrics`

Example health check response:
```json
{
  "status": "UP",
  "components": {
    "db": {
      "status": "UP",
      "details": {
        "database": "H2",
        "validationQuery": "isValid()"
      }
    },
    "diskSpace": {
      "status": "UP",
      "details": {
        "total": 250685575168,
        "free": 123456789012,
        "threshold": 10485760,
        "exists": true
      }
    }
  }
}
```

## Database Configuration

### User Service - H2 Database

- **URL**: `jdbc:h2:mem:userdb`
- **Console**: http://localhost:8081/h2-console
- **Username**: `sa`
- **Password**: `password`

### Product Service - MongoDB

- **URL**: `mongodb://mongo:27017/productdb`
- **Database**: `productdb`
- **Collection**: `products`

### Order Service - MySQL

- **URL**: `jdbc:mysql://mysql:3306/orderdb`
- **Username**: `root`
- **Password**: `rootpassword`
- **Database**: `orderdb`

## Project Structure

```
microservices-app/
├── pom.xml                 # Parent POM
├── docker-compose.yml      # Docker Compose configuration
├── README.md              # This file
│
├── user-service/
│   ├── pom.xml
│   ├── Dockerfile
│   └── src/main/java/com/microservices/user/
│       ├── UserServiceApplication.java
│       ├── controller/UserController.java
│       ├── model/User.java
│       └── repository/UserRepository.java
│
├── product-service/
│   ├── pom.xml
│   ├── Dockerfile
│   └── src/main/java/com/microservices/product/
│       ├── ProductServiceApplication.java
│       ├── controller/ProductController.java
│       ├── model/Product.java
│       └── repository/ProductRepository.java
│
└── order-service/
    ├── pom.xml
    ├── Dockerfile
    └── src/main/java/com/microservices/order/
        ├── OrderServiceApplication.java
        ├── controller/OrderController.java
        ├── model/Order.java
        ├── repository/OrderRepository.java
        ├── service/OrderService.java
        └── config/AppConfig.java
```

## Troubleshooting

### Common Issues

1. **Port Already in Use**
   ```bash
   # Check what's using the port
   lsof -i :8081
   
   # Kill the process
   kill -9 <PID>
   ```

2. **Database Connection Issues**
   - Ensure databases are running
   - Check database credentials in `application.properties`
   - Verify network connectivity in Docker

3. **Service Communication Issues**
   - Check service health endpoints
   - Verify service discovery configuration
   - Ensure proper network configuration in Docker

4. **Build Issues**
   ```bash
   # Clean and rebuild
   mvn clean install -U
   
   # Skip tests if needed
   mvn clean install -DskipTests
   ```

### Logs

To view logs in Docker:
```bash
# All services
docker-compose logs

# Specific service
docker-compose logs user-service
docker-compose logs product-service
docker-compose logs order-service
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request