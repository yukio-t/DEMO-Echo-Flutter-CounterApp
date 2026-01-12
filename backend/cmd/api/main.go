package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
	echoMw "github.com/labstack/echo/v4/middleware"

	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/config"
	appMw "github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/handler/middleware"
	routes "github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/handler/routes"
	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/httpx"
)

func main() {
	// localなら .env.local を読む
	config.LoadDotEnvIfLocal()

	cfg, err := config.Load()
	if err != nil {
		panic(err)
	}

	// Echoの初期化
	e := echo.New()
	e.HideBanner = true

	// ミドルウェア設定
	e.Use(appMw.RequestID())       // Request ID を付与
	e.Use(appMw.AccessLog(e))      // アクセスログ
	e.Use(echoMw.Recover())        // Panic 回復(500変換)
	e.Use(appMw.SecurityHeaders()) // セキュリティ系レスポンスヘッダ
	e.Use(appMw.CORS(cfg))         // CORS（Flutter Web / ローカル向け）

	// API用の統一エラーハンドラ（JSON + traceId）
	e.HTTPErrorHandler = httpx.ErrorHandler()

	// ルーティング設定
	routes.Register(e)

	// サーバ起動
	s := &http.Server{
		Addr:         ":" + cfg.HTTP.Port,
		ReadTimeout:  cfg.App.ReadTimeout,
		WriteTimeout: cfg.App.WriteTimeout,
	}
	e.Logger.Fatal(e.StartServer(s)) // 致命的エラーはログ出力して終了するように設定

}
