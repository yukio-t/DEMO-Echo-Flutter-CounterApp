package handler

import (
	"net/http"
	"strconv"

	"github.com/labstack/echo/v4"
	appMw "github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/handler/middleware"
)

const demoClientID = "00000000-0000-0000-0000-000000000000"

func isAllowedFailCode(code int) bool {
	switch code {
	case http.StatusNotFound, // 404
		http.StatusTooManyRequests,    // 429
		http.StatusServiceUnavailable: // 503
		return true
	default:
		return false
	}
}

type PingV1Handler struct{}

func NewPingV1Handler() *PingV1Handler {
	return &PingV1Handler{}
}

func (h *PingV1Handler) Ping(c echo.Context) error {
	// clientId を middleware が Context に入れている前提
	clientID, _ := c.Get(appMw.ClientIDContextKey).(string)

	// デモ用 clientId のときだけ ?fail= を有効化
	// 例: /api/v1/ping?fail=500
	if clientID == demoClientID {
		if s := c.QueryParam("fail"); s != "" {
			code, err := strconv.Atoi(s)
			if err == nil {
				// 500 を指定されたら 503 に丸める（「障害」に見えにくくする）
				if code == http.StatusInternalServerError {
					code = http.StatusServiceUnavailable
				}

				if isAllowedFailCode(code) {
					return c.JSON(code, map[string]any{
						"message": "forced error (demo)",
						"status":  code,
						"version": "v1",
					})
				}
			}
		}
	}

	return c.JSON(http.StatusOK, map[string]any{
		"message": "pong",
		"version": "v1",
	})
}
