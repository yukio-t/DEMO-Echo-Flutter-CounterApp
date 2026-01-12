package routes

import (
	"github.com/labstack/echo/v4"

	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/handler"
	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/handler/middleware"
	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/infra/memory"
	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/usecase/counter"
)

func registerV1(e *echo.Echo) {
	// v1 は Bearer clientId 必須（要件）
	v1 := e.Group("/api/v1", middleware.RequireClientID())

	// ping
	ping := handler.NewPingV1Handler()
	v1.GET("/ping", ping.Ping)

	// counter
	store := memory.NewCounterStore()
	svc := counter.NewService(store)
	counterHandler := handler.NewCounterV1Handler(svc)
	counterHandler.Register(v1)
}
