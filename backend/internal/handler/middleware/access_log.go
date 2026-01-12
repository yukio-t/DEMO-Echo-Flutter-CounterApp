package middleware

import (
	"github.com/labstack/echo/v4"
	echoMw "github.com/labstack/echo/v4/middleware"
)

// AccessLog sets Echo v4 request logger middleware.
// NOTE: echo middleware.Logger() is deprecated; use RequestLogger instead.
func AccessLog(e *echo.Echo) echo.MiddlewareFunc {
	return echoMw.RequestLoggerWithConfig(echoMw.RequestLoggerConfig{
		LogStatus:   true,
		LogMethod:   true,
		LogURI:      true,
		LogLatency:  true,
		LogError:    true,
		LogRemoteIP: true,
		LogValuesFunc: func(c echo.Context, v echoMw.RequestLoggerValues) error {
			if v.Error != nil {
				e.Logger.Error(v.Error)
			} else {
				e.Logger.Infof("%s %s %d %v", v.Method, v.URI, v.Status, v.Latency)
			}
			return nil
		},
	})
}
