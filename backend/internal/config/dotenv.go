package config

import (
	"os"

	"github.com/joho/godotenv"
)

// LoadDotEnvIfLocal loads .env.local only when GO_ENV or APP_ENV_SCALE is "local".
func LoadDotEnvIfLocal() {
	env := os.Getenv("APP_ENV_SCALE")
	if env == "" {
		env = os.Getenv("GO_ENV")
	}
	if env == "" {
		env = "local"
	}

	if env == "local" {
		// 読めなくても落とさない
		_ = godotenv.Load(".env.local")
	}
}
