# Use the official Go image as the base stage
FROM golang:1.22.5 as base

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy Go module files to the working directory
COPY go.mod go.sum ./

# Download and verify Go module dependencies
RUN go mod download && go mod verify

# Copy the rest of the application source code
COPY . .

# Build the Go application with the binary named 'main'
RUN go build -v -o /usr/local/bin/main ./...

# Use a minimal Alpine Linux image for the final image
FROM alpine:latest

# Set the working directory in the final image
WORKDIR /root

# Copy the built executable from the base stage
COPY --from=base /usr/local/bin/main .

# Expose the new port on which the application will listen
EXPOSE 9090

# Define the command to run when the container starts
CMD ["./main"]
