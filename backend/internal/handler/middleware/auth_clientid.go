package middleware

import (
	"net/http"
	"regexp"
	"strings"

	"github.com/labstack/echo/v4"
)

const ClientIDContextKey = "clientId"

var uuidLike = regexp.MustCompile(`^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$`)

func RequireClientID() echo.MiddlewareFunc {
	return func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {
			auth := c.Request().Header.Get("Authorization")
			if auth == "" {
				return echo.NewHTTPError(http.StatusUnauthorized, "missing authorization header")
			}

			const prefix = "Bearer "
			if !strings.HasPrefix(auth, prefix) {
				return echo.NewHTTPError(http.StatusUnauthorized, "invalid authorization scheme")
			}

			clientID := strings.TrimSpace(strings.TrimPrefix(auth, prefix))
			if clientID == "" {
				return echo.NewHTTPError(http.StatusUnauthorized, "missing clientId")
			}

			if !uuidLike.MatchString(clientID) {
				return echo.NewHTTPError(http.StatusUnauthorized, "invalid clientId format")
			}

			c.Set(ClientIDContextKey, clientID)
			return next(c)
		}
	}
}
