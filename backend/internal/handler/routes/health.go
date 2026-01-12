package routes

import (
	"github.com/labstack/echo/v4"
	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/handler"
)

func registerHealth(e *echo.Echo) {
	h := handler.NewHealthHandler()
	e.GET("/health", h.Health)
}
