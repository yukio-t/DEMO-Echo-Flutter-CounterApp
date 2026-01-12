# ====== basic ======
.DEFAULT_GOAL := help
SHELL := /bin/bash

FRONT_DIR := frontend
BACK_DIR  := backend
API_PORT  := 8080
API_URL   := http://localhost:$(API_PORT)

.PHONY: help
help:
	@echo ""
	@echo "Targets:"
	@echo "  make api            # Run Echo locally (go run)"
	@echo "  make api-docker      # Run Echo with Docker Compose"
	@echo "  make api-down        # Stop Docker Compose"
	@echo "  make web             # Run Flutter web (dev)"
	@echo "  make web-build        # Build Flutter web"
	@echo "  make fmt             # fmt (go) + format (dart)"
	@echo "  make test            # test (go) + test (dart)"
	@echo "  make curl-sample     # curl samples"
	@echo ""

# ====== backend (local) ======
.PHONY: api
api:
	@echo "==> Running Echo locally on :$(API_PORT)"
	cd $(BACK_DIR) && go run ./cmd/api/main.go

# ====== backend (docker) ======
.PHONY: api-docker
api-docker:
	@echo "==> Running Echo with Docker Compose on :$(API_PORT)"
	docker compose -f docker-compose.yml up --build

.PHONY: api-down
api-down:
	docker compose -f docker-compose.yml down

# ===== frontend =====
API_BASE_URL ?= http://localhost:8080/api/v1
DEMO_CLIENT_ID = 00000000-0000-0000-0000-000000000000
DEMO_PING_FAIL=503

.PHONY: web
web:
	@echo "==> Flutter web (API_BASE_URL=$(API_BASE_URL))"
	cd frontend/app && \
	flutter run -d chrome \
	  --dart-define=API_BASE_URL=$(API_BASE_URL)

.PHONY: web-fail
web-fail:
	@echo "==> Flutter web failed (API_BASE_URL=$(API_BASE_URL))"
	cd frontend/app && \
	flutter run -d chrome \
	  --dart-define=API_BASE_URL=$(API_BASE_URL) \
	  --dart-define=DEMO_CLIENT_ID=$(DEMO_CLIENT_ID) \
	  --dart-define=DEMO_PING_FAIL=$(DEMO_PING_FAIL)

.PHONY: web-build
web-build:
	@echo "==> Flutter web build (API_BASE_URL=$(API_BASE_URL))"
	cd frontend/app && \
	flutter build web --release \
	  --dart-define=API_BASE_URL=$(API_BASE_URL)

# ====== quality ======
.PHONY: fmt
fmt:
	@echo "==> gofmt"
	cd $(BACK_DIR) && gofmt -w .
	@echo "==> dart format"
	cd $(FRONT_DIR) && dart format .

.PHONY: test
test:
	@echo "==> go test"
	cd $(BACK_DIR) && go test ./...
	@echo "==> flutter test"
	cd $(FRONT_DIR) && flutter test

# ====== misc ======
.PHONY: curl-sample
curl-sample:
	@echo "CID=11111111-1111-1111-1111-111111111111"
	@echo "curl -i -H 'Authorization: Bearer $$CID' $(API_URL)/api/v1/ping"
	@echo "curl -i -H 'Authorization: Bearer $$CID' $(API_URL)/api/v1/counter"
	@echo "curl -i -X POST -H 'Authorization: Bearer $$CID' $(API_URL)/api/v1/counter/increment"
	@echo "curl -i -X POST -H 'Authorization: Bearer $$CID' $(API_URL)/api/v1/counter/reset"
