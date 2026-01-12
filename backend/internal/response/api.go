package response

type APIError struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}

type APIResponse[T any] struct {
	Data    *T        `json:"data,omitempty"`
	Error   *APIError `json:"error,omitempty"`
	TraceID string    `json:"traceId,omitempty"`
}
