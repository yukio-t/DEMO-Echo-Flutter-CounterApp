package config

import (
	"errors"
	"os"
	"strconv"
	"strings"
	"time"
)

type Config struct {
	EnvScale string // local | staging | production

	HTTP struct {
		Port string
	}

	App struct {
		ReadTimeout  time.Duration
		WriteTimeout time.Duration
	}

	CORS struct {
		AllowedOrigins   []string
		AllowedMethods   []string
		AllowedHeaders   []string
		AllowCredentials bool
	}
}

func Load() (*Config, error) {
	c := &Config{}

	c.EnvScale = getEnv("APP_ENV_SCALE", getEnv("GO_ENV", "local"))
	c.HTTP.Port = getEnv("HTTP_PORT", getEnv("PORT", "8080"))

	readSec, err := getEnvInt("HTTP_READ_TIMEOUT_SEC", 15)
	if err != nil {
		return nil, err
	}
	writeSec, err := getEnvInt("HTTP_WRITE_TIMEOUT_SEC", 15)
	if err != nil {
		return nil, err
	}
	c.App.ReadTimeout = time.Duration(readSec) * time.Second
	c.App.WriteTimeout = time.Duration(writeSec) * time.Second

	// CORS
	c.CORS.AllowedOrigins = splitCSV(getEnv("CORS_ALLOWED_ORIGINS", ""))
	c.CORS.AllowedMethods = splitCSV(getEnv("CORS_ALLOWED_METHODS", "GET,POST,PUT,PATCH,DELETE,OPTIONS"))
	c.CORS.AllowedHeaders = splitCSV(getEnv("CORS_ALLOWED_HEADERS", "Accept,Authorization,Content-Type,X-Requested-With"))
	c.CORS.AllowCredentials = getEnvBool("CORS_ALLOW_CREDENTIALS", false)

	if c.HTTP.Port == "" {
		return nil, errors.New("HTTP_PORT is empty")
	}

	return c, nil
}

func getEnv(key, def string) string {
	if v, ok := os.LookupEnv(key); ok && v != "" {
		return v
	}
	return def
}

func getEnvInt(key string, def int) (int, error) {
	v := getEnv(key, "")
	if v == "" {
		return def, nil
	}
	n, err := strconv.Atoi(v)
	if err != nil {
		return 0, errors.New(key + " must be an integer")
	}
	return n, nil
}

func getEnvBool(key string, def bool) bool {
	v := strings.ToLower(strings.TrimSpace(getEnv(key, "")))
	if v == "" {
		return def
	}
	return v == "1" || v == "true" || v == "yes" || v == "on"
}

func splitCSV(s string) []string {
	if strings.TrimSpace(s) == "" {
		return []string{}
	}
	parts := strings.Split(s, ",")
	out := make([]string, 0, len(parts))
	for _, p := range parts {
		v := strings.TrimSpace(p)
		if v != "" {
			out = append(out, v)
		}
	}
	return out
}
