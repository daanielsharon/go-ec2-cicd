## Overview
This is a simple Go web server with a single endpoint that returns "Hello, World!". Note that implementation details might change later with push functionality.

## Running the Application

```bash
go run main.go
```

The server will start on port 8080. Access the endpoint at http://localhost:8080/

## Testing

Run the tests with:

```bash
go test -v
```

## CI/CD Setup
This repository is designed to be used with a simple CI/CD pipeline using GitHub Actions and EC2.
