#!/bin/bash

# Test script for airlines service to generate telemetry data

echo "Starting airlines service traffic generation..."

# Wait for service to be ready
echo "Waiting for service to start..."
sleep 10

# Function to make requests
make_requests() {
    echo "Making requests to generate telemetry data..."
    
    # Test health endpoint
    echo "Testing health endpoint..."
    curl -s http://localhost:8080/health
    echo ""
    
    # Test root endpoint  
    echo "Testing root endpoint..."
    curl -s http://localhost:8080/
    echo ""
    
    # Test airlines endpoint (normal)
    echo "Testing airlines endpoint..."
    curl -s http://localhost:8080/airlines
    echo ""
    
    # Test airlines endpoint (with exception to generate error traces)
    echo "Testing airlines endpoint with exception..."
    curl -s "http://localhost:8080/airlines?raise=true"
    echo ""
}

# Make initial requests
make_requests

# Keep making requests every 30 seconds
echo "Continuing to make requests every 30 seconds to generate ongoing telemetry..."
while true; do
    sleep 30
    echo "$(date): Making periodic requests..."
    make_requests
done