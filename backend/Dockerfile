# --- build ---
FROM golang:1.24.5 AS build
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /bin/api ./cmd/api/main.go

# --- run ---
FROM gcr.io/distroless/static:nonroot
ENV PORT=8080
EXPOSE 8080
COPY --from=build /bin/api /api
USER nonroot:nonroot
ENTRYPOINT ["/api"]
