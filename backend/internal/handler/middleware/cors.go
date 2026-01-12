package middleware

import (
	"strings"

	"github.com/labstack/echo/v4"
	echoMw "github.com/labstack/echo/v4/middleware"

	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/config"
)

func CORS(cfg *config.Config) echo.MiddlewareFunc {
	// AllowedOrigins が空なら、local 開発では緩めにしておく（必要ならここを厳格化）
	origins := cfg.CORS.AllowedOrigins
	if len(origins) == 0 && cfg.EnvScale == "local" {
		origins = []string{"*"}
	}

	return echoMw.CORSWithConfig(echoMw.CORSConfig{
		AllowOrigins:     origins,
		AllowMethods:     cfg.CORS.AllowedMethods,
		AllowHeaders:     cfg.CORS.AllowedHeaders,
		AllowCredentials: cfg.CORS.AllowCredentials,

		// "*" + credentials はブラウザ的にNGなので、もし credentials を true にするなら origins を明示する
		Skipper: func(c echo.Context) bool {
			// credentials=true のとき "*" を許してしまわない安全弁（実運用では origins を明示）
			if cfg.CORS.AllowCredentials && contains(origins, "*") {
				return true
			}
			return false
		},
	})
}

func contains(list []string, v string) bool {
	for _, x := range list {
		if strings.TrimSpace(x) == v {
			return true
		}
	}
	return false
}
