#!/bin/bash

# Postman Collection Test Script
# This script tests the Postman collection endpoints using curl commands

echo "🧪 Testing Postman Collection Endpoints"
echo "======================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Service URLs
USER_SERVICE="http://localhost:8081"
PRODUCT_SERVICE="http://localhost:8082"
ORDER_SERVICE="http://localhost:8083"

# Test counter
TOTAL_TESTS=0
PASSED_TESTS=0

# Function to test endpoint
test_endpoint() {
    local method=$1
    local url=$2
    local data=$3
    local expected_status=$4
    local description=$5
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "\n${YELLOW}Testing: $description${NC}"
    echo "Method: $method | URL: $url"
    
    if [ "$method" = "GET" ]; then
        response=$(curl -s -w "\n%{http_code}" "$url")
    elif [ "$method" = "POST" ]; then
        response=$(curl -s -w "\n%{http_code}" -X POST "$url" \
            -H "Content-Type: application/json" \
            -d "$data")
    elif [ "$method" = "PUT" ]; then
        response=$(curl -s -w "\n%{http_code}" -X PUT "$url" \
            -H "Content-Type: application/json" \
            -d "$data")
    elif [ "$method" = "DELETE" ]; then
        response=$(curl -s -w "\n%{http_code}" -X DELETE "$url")
    fi
    
    # Extract status code (last line)
    status_code=$(echo "$response" | tail -n1)
    body=$(echo "$response" | head -n -1)
    
    if [ "$status_code" = "$expected_status" ]; then
        echo -e "${GREEN}✅ PASSED${NC} (Status: $status_code)"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}❌ FAILED${NC} (Expected: $expected_status, Got: $status_code)"
        echo "Response: $body"
    fi
}

# Check if services are running
echo -e "\n${YELLOW}🔍 Checking service availability...${NC}"

# Health checks
test_endpoint "GET" "$USER_SERVICE/actuator/health" "" "200" "User Service Health Check"
test_endpoint "GET" "$PRODUCT_SERVICE/actuator/health" "" "200" "Product Service Health Check"
test_endpoint "GET" "$ORDER_SERVICE/actuator/health" "" "200" "Order Service Health Check"

# USER SERVICE TESTS
echo -e "\n${YELLOW}👤 Testing User Service Endpoints...${NC}"

# Test User CRUD operations
test_endpoint "GET" "$USER_SERVICE/users" "" "200" "Get All Users"

# Create User
USER_DATA='{"username": "testuser", "email": "test@example.com"}'
test_endpoint "POST" "$USER_SERVICE/users" "$USER_DATA" "201" "Create User"

# Get User by ID (assuming ID 1 exists after creation)
test_endpoint "GET" "$USER_SERVICE/users/1" "" "200" "Get User by ID"

# Update User
USER_UPDATE_DATA='{"username": "updateduser", "email": "updated@example.com"}'
test_endpoint "PUT" "$USER_SERVICE/users/1" "$USER_UPDATE_DATA" "200" "Update User"

# PRODUCT SERVICE TESTS
echo -e "\n${YELLOW}📦 Testing Product Service Endpoints...${NC}"

# Test Product CRUD operations
test_endpoint "GET" "$PRODUCT_SERVICE/products" "" "200" "Get All Products"

# Create Product
PRODUCT_DATA='{"name": "Test Laptop", "description": "A test laptop", "price": 999.99}'
test_endpoint "POST" "$PRODUCT_SERVICE/products" "$PRODUCT_DATA" "201" "Create Product"

# Search Products (may fail if no products match)
test_endpoint "GET" "$PRODUCT_SERVICE/products/search?name=laptop" "" "200" "Search Products by Name"

# Price Range Filter
test_endpoint "GET" "$PRODUCT_SERVICE/products/price-range?minPrice=500&maxPrice=1500" "" "200" "Get Products by Price Range"

# ORDER SERVICE TESTS
echo -e "\n${YELLOW}🛒 Testing Order Service Endpoints...${NC}"

# Test Order CRUD operations
test_endpoint "GET" "$ORDER_SERVICE/orders" "" "200" "Get All Orders"

# Create Order (requires existing user)
ORDER_DATA='{"userId": 1, "productId": "test-product-id", "quantity": 2}'
test_endpoint "POST" "$ORDER_SERVICE/orders" "$ORDER_DATA" "201" "Create Order"

# Get Orders by User
test_endpoint "GET" "$ORDER_SERVICE/orders/user/1" "" "200" "Get Orders by User ID"

# MONITORING ENDPOINTS
echo -e "\n${YELLOW}📊 Testing Monitoring Endpoints...${NC}"

test_endpoint "GET" "$USER_SERVICE/actuator/metrics" "" "200" "User Service Metrics"
test_endpoint "GET" "$PRODUCT_SERVICE/actuator/metrics" "" "200" "Product Service Metrics"
test_endpoint "GET" "$ORDER_SERVICE/actuator/metrics" "" "200" "Order Service Metrics"

# SWAGGER DOCUMENTATION
echo -e "\n${YELLOW}📖 Testing Swagger Documentation...${NC}"

test_endpoint "GET" "$USER_SERVICE/v3/api-docs" "" "200" "User Service API Docs"
test_endpoint "GET" "$PRODUCT_SERVICE/v3/api-docs" "" "200" "Product Service API Docs"
test_endpoint "GET" "$ORDER_SERVICE/v3/api-docs" "" "200" "Order Service API Docs"

# Results Summary
echo -e "\n${YELLOW}📋 Test Results Summary${NC}"
echo "======================="
echo "Total Tests: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed: ${RED}$((TOTAL_TESTS - PASSED_TESTS))${NC}"

if [ $PASSED_TESTS -eq $TOTAL_TESTS ]; then
    echo -e "\n${GREEN}🎉 All tests passed! Postman collection endpoints are working correctly.${NC}"
    exit 0
else
    echo -e "\n${RED}⚠️  Some tests failed. Please check the services and try again.${NC}"
    echo -e "\n${YELLOW}💡 Troubleshooting tips:${NC}"
    echo "1. Ensure all services are running: docker-compose up --build"
    echo "2. Check service logs: docker-compose logs <service-name>"
    echo "3. Verify health endpoints are accessible"
    echo "4. Wait a few seconds after starting services before running tests"
    exit 1
fi
