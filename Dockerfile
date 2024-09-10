# Use the official Go image with the specified version
FROM golang:1.22.5 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files to the working directory
COPY go.mod go.sum ./

# Install dependencies using Go modules
RUN go mod download

# Copy the remaining application source code to the working directory
COPY . .

# Build the Go application
RUN go build -o main .

# Use a minimal Alpine Linux image as the final image
FROM alpine:latest

# Set the working directory in the final image
WORKDIR /root

# Copy the built executable and static assets from the builder stage
COPY --from=builder /app/main .
COPY --from=builder /app/static ./static

# Expose the port on which your application will listen
EXPOSE 8082

# Define the command to run when the container starts
CMD ["./main"]