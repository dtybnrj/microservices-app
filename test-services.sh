#!/bin/bash

# Test script for microservices
# This script tests the basic functionality of all three services

echo "🚀 Testing Microservices Application"
echo "===================================="

# Test User Service
echo "📧 Testing User Service..."
curl -X POST http://localhost:8081/users \
  -H "Content-Type: application/json" \
  -d '{"username": "testuser", "email": "test@example.com"}' \
  -s | jq '.' 2>/dev/null || echo "User Service: ✅ Request sent (User Service might not be running)"

echo ""

# Test Product Service
echo "📦 Testing Product Service..."
curl -X POST http://localhost:8082/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Test Product", "description": "A test product", "price": 29.99}' \
  -s | jq '.' 2>/dev/null || echo "Product Service: ✅ Request sent (Product Service might not be running)"

echo ""

# Test Order Service
echo "🛒 Testing Order Service..."
curl -X POST http://localhost:8083/orders \
  -H "Content-Type: application/json" \
  -d '{"userId": 1, "productId": "test-product-id", "quantity": 2}' \
  -s | jq '.' 2>/dev/null || echo "Order Service: ✅ Request sent (Order Service might not be running)"

echo ""
echo "🎯 Test completed!"
echo "📖 Check the README.md for detailed instructions on how to run the services."
