package httpx

import (
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"

	"github.com/yukio-t/DEMO-Echo-Flutter-CounterApp/backend/internal/response"
)

func ErrorHandler() echo.HTTPErrorHandler {
	return func(err error, c echo.Context) {
		// 1) デフォルトの HTTPError に寄せる
		he, ok := err.(*echo.HTTPError)
		if !ok {
			he = echo.NewHTTPError(http.StatusInternalServerError, http.StatusText(http.StatusInternalServerError))
		}

		status := he.Code
		msg := extractMessage(he)

		// 2) /api 配下だけ JSON を強制（health等は今後も自由に）
		if strings.HasPrefix(c.Path(), "/api/") || strings.HasPrefix(c.Request().URL.Path, "/api/") {
			traceID := c.Response().Header().Get(echo.HeaderXRequestID)

			code := toAppCode(status)
			res := response.APIResponse[any]{
				Error: &response.APIError{
					Code:    code,
					Message: msg,
				},
				TraceID: traceID,
			}

			// 既にレスポンス送信済みなら何もしない
			if c.Response().Committed {
				return
			}

			_ = c.JSON(status, res)
			return
		}

		// 3) API以外はEchoの標準に近い挙動（必要ならHTMLハンドラ等に差し替え可能）
		if c.Response().Committed {
			return
		}
		_ = c.String(status, msg)
	}
}

func extractMessage(he *echo.HTTPError) string {
	// he.Message は string / error / map 等になり得るので丁寧に
	switch v := he.Message.(type) {
	case string:
		if v != "" {
			return v
		}
	case error:
		return v.Error()
	}
	// fallback
	if he.Code >= 500 {
		return http.StatusText(http.StatusInternalServerError)
	}
	return http.StatusText(he.Code)
}

func toAppCode(status int) string {
	switch status {
	case http.StatusBadRequest:
		return "bad_request"
	case http.StatusUnauthorized:
		return "unauthorized"
	case http.StatusForbidden:
		return "forbidden"
	case http.StatusNotFound:
		return "not_found"
	case http.StatusMethodNotAllowed:
		return "method_not_allowed"
	case http.StatusUnprocessableEntity:
		return "validation_error"
	default:
		if status >= 500 {
			return "internal_error"
		}
		return "error"
	}
}
