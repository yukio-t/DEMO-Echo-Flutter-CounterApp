package handler

import (
	"net/http"

	"github.com/labstack/echo/v4"

	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/handler/middleware"
	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/usecase/counter"
)

const clientIDContextKey = "clientId"

type CounterV1Handler struct {
	svc *counter.Service
}

func NewCounterV1Handler(svc *counter.Service) *CounterV1Handler {
	return &CounterV1Handler{svc: svc}
}

type counterResponse struct {
	Value int `json:"value"`
}

// Register registers v1 counter routes under given group.
// 想定:
//
//	v1 := e.Group("/api/v1", auth_clientid.RequireClientID())
//	h.Register(v1)
func (h *CounterV1Handler) Register(v1 *echo.Group) {
	v1.GET("/counter", h.Get)
	v1.POST("/counter/increment", h.Increment)
	v1.POST("/counter/reset", h.Reset)
}

func (h *CounterV1Handler) Get(c echo.Context) error {
	clientID, _ := c.Get(middleware.ClientIDContextKey).(string)

	val, err := h.svc.Get(clientID)
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "internal error")
	}

	return c.JSON(http.StatusOK, counterResponse{Value: val})
}

func (h *CounterV1Handler) Increment(c echo.Context) error {
	clientID, _ := c.Get(middleware.ClientIDContextKey).(string)

	val, err := h.svc.Increment(clientID)
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "internal error")
	}

	return c.JSON(http.StatusOK, counterResponse{Value: val})
}

func (h *CounterV1Handler) Reset(c echo.Context) error {
	clientID, _ := c.Get(middleware.ClientIDContextKey).(string)

	val, err := h.svc.Reset(clientID)
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "internal error")
	}

	return c.JSON(http.StatusOK, counterResponse{Value: val})
}
