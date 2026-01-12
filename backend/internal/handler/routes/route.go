package routes

import (
	"github.com/labstack/echo/v4"
)

func Register(e *echo.Echo) {
	registerHealth(e) // 直下
	registerV1(e)     // /api/v1
}
