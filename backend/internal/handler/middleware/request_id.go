package middleware

import (
	"github.com/labstack/echo/v4"
	echoMw "github.com/labstack/echo/v4/middleware"
)

func RequestID() echo.MiddlewareFunc {
	// 既に標準であるのでラップするだけ（ヘッダはX-Request-ID）
	return echoMw.RequestID()
}
