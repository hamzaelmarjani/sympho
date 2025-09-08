# Multi-stage build for optimized Rust container
FROM rust:1.83-slim AS builder

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy manifests first (for better layer caching)
COPY Cargo.toml Cargo.lock ./

# Create a dummy main.rs to build dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs

# Build dependencies (this layer will be cached unless Cargo.toml changes)
RUN cargo build --release --bin sympho-api-rust && rm src/main.rs

# Copy source code
COPY src ./src

# Build the actual application
# Touch main.rs to ensure it's rebuilt
RUN touch src/main.rs && cargo build --release --bin sympho-api-rust

# Runtime stage - use distroless for minimal size
FROM gcr.io/distroless/cc-debian12

# Create non-root user (distroless provides nonroot user)
USER nonroot:nonroot

# Copy the binary from builder stage
COPY --from=builder /app/target/release/sympho-api-rust /app/server

# Copy any required config files if needed
# COPY --from=builder /app/.env /app/.env

# Expose port
EXPOSE 8080

# Set working directory
WORKDIR /app

# Run the application
CMD ["./server"]