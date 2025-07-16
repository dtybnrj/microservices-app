# Postman Collection for Microservices API

This directory contains comprehensive Postman collection files for testing the Java Microservices application.

## Files Included

1. **Microservices-API-Collection.postman_collection.json** - Complete API collection with all endpoints
2. **Microservices-Development.postman_environment.json** - Environment for local development
3. **Microservices-Docker.postman_environment.json** - Environment for Docker deployment

## How to Import

### 1. Import Collection
1. Open Postman
2. Click "Import" button
3. Select `Microservices-API-Collection.postman_collection.json`
4. Click "Import"

### 2. Import Environment
1. In Postman, go to "Environments" tab
2. Click "Import"
3. Select `Microservices-Development.postman_environment.json`
4. Click "Import"
5. Repeat for `Microservices-Docker.postman_environment.json` if needed

### 3. Select Environment
1. In the top-right corner of Postman, select the environment:
   - "Microservices Development Environment" for local development
   - "Microservices Docker Environment" for Docker deployment

## Collection Structure

The collection is organized into the following folders:

### 1. User Service (Port 8081)
- **Get All Users** - Retrieve all users
- **Get User by ID** - Get specific user
- **Create User** - Create new user
- **Update User** - Update existing user
- **Delete User** - Delete user
- **User Service Health Check** - Health status

### 2. Product Service (Port 8082)
- **Get All Products** - Retrieve all products
- **Get Product by ID** - Get specific product
- **Search Products by Name** - Search by name
- **Get Products by Price Range** - Filter by price
- **Create Product** - Create new product
- **Update Product** - Update existing product
- **Delete Product** - Delete product
- **Product Service Health Check** - Health status

### 3. Order Service (Port 8083)
- **Get All Orders** - Retrieve all orders
- **Get Order by ID** - Get specific order
- **Get Orders by User ID** - Get orders for user
- **Get Orders by Product ID** - Get orders for product
- **Create Order** - Create new order (validates user)
- **Update Order** - Update existing order
- **Delete Order** - Delete order
- **Order Service Health Check** - Health status

### 4. Health Checks
- **All Services Health Check** - General health check
- **User Service Metrics** - Detailed metrics
- **Product Service Metrics** - Detailed metrics
- **Order Service Metrics** - Detailed metrics

## Environment Variables

The collection uses the following variables:

| Variable | Description | Default Value |
|----------|-------------|---------------|
| `baseUrl` | User Service base URL | `http://localhost:8081` |
| `productBaseUrl` | Product Service base URL | `http://localhost:8082` |
| `orderBaseUrl` | Order Service base URL | `http://localhost:8083` |
| `userId` | Sample user ID for testing | `1` |
| `productId` | Sample product ID for testing | `64f8b1c2a1b2c3d4e5f6g7h8` |
| `orderId` | Sample order ID for testing | `1` |

## Testing Workflow

### Step 1: Start Services
Make sure all services are running:
```bash
# Using Docker Compose
docker-compose up --build

# Or individually
mvn spring-boot:run
```

### Step 2: Test User Service
1. Run "User Service Health Check" to verify service is up
2. Create a user with "Create User"
3. Get all users with "Get All Users"
4. Update the user with "Update User"
5. Get user by ID with "Get User by ID"

### Step 3: Test Product Service
1. Run "Product Service Health Check"
2. Create a product with "Create Product"
3. Get all products with "Get All Products"
4. Search products by name
5. Filter by price range

### Step 4: Test Order Service
1. Run "Order Service Health Check"
2. Create an order with "Create Order" (requires valid userId)
3. Get orders by user ID
4. Get orders by product ID
5. Update and delete orders

## Sample Request Bodies

### Create User
```json
{
  "username": "john_doe",
  "email": "john@example.com"
}
```

### Create Product
```json
{
  "name": "Laptop",
  "description": "High-performance laptop for gaming and work",
  "price": 999.99
}
```

### Create Order
```json
{
  "userId": 1,
  "productId": "64f8b1c2a1b2c3d4e5f6g7h8",
  "quantity": 2
}
```

## Response Examples

### User Response
```json
{
  "id": 1,
  "username": "john_doe",
  "email": "john@example.com",
  "createdAt": "2024-01-15T10:30:00.000Z"
}
```

### Product Response
```json
{
  "id": "64f8b1c2a1b2c3d4e5f6g7h8",
  "name": "Laptop",
  "description": "High-performance laptop for gaming and work",
  "price": 999.99
}
```

### Order Response
```json
{
  "id": 1,
  "userId": 1,
  "productId": "64f8b1c2a1b2c3d4e5f6g7h8",
  "quantity": 2,
  "orderDate": "2024-01-15T10:35:00.000Z"
}
```

## Error Handling

The collection includes examples of common error responses:

- **404 Not Found** - Resource doesn't exist
- **400 Bad Request** - Invalid request data
- **500 Internal Server Error** - Server error

## Automated Testing

You can run the entire collection programmatically using Newman:

```bash
# Install Newman
npm install -g newman

# Run collection
newman run Microservices-API-Collection.postman_collection.json \
  -e Microservices-Development.postman_environment.json
```

## Monitoring

Use the health check endpoints to monitor service status:

- User Service: `http://localhost:8081/actuator/health`
- Product Service: `http://localhost:8082/actuator/health`
- Order Service: `http://localhost:8083/actuator/health`

## Documentation

For detailed API documentation, visit the Swagger UI endpoints:

- User Service: `http://localhost:8081/swagger-ui.html`
- Product Service: `http://localhost:8082/swagger-ui.html`
- Order Service: `http://localhost:8083/swagger-ui.html`

## Troubleshooting

### Common Issues

1. **Connection Refused**: Ensure services are running on correct ports
2. **404 Not Found**: Check URL paths and service availability
3. **Validation Errors**: Verify request body format matches expected schema
4. **Service Dependencies**: Order service requires User service to be running

### Service Dependencies

- **Order Service** depends on **User Service** for user validation
- All services can run independently except for the order creation validation

## Advanced Features

### Pre-request Scripts
The collection includes pre-request scripts for:
- Setting dynamic timestamps
- Generating test data
- Environment variable management

### Test Scripts
Post-request test scripts validate:
- Response status codes
- Response body structure
- Required fields presence
- Data type validation

## Support

For issues or questions:
1. Check service logs: `docker-compose logs <service-name>`
2. Verify health endpoints
3. Review API documentation in Swagger UI
4. Check environment variable values
