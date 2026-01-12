# 技術サンプル要件定義  
Flutter × Go(Echo) カウンターアプリ（Backend-driven State）

---

## 1. 目的・背景

本プロジェクトは、Flutter と Go(Echo) を用いた **最小構成の技術サンプル** として、以下を実証することを目的とする。

- フロントエンド（Flutter）とバックエンド（Go/Echo）の責務分離
- バックエンド主導の状態更新（Server-authoritative）
- Riverpod + Freezed による状態管理設計
- Web（GitHub Pages）と API（Cloud Run）の分離デプロイ
- CI/CD を前提としたモノレポ構成

本サンプルは **業務アプリの雛形** を意識し、実用に近い構成を採用する。

---

## 2. 全体構成

### 2.1 デプロイ構成

| 役割 | 技術 | デプロイ先 |
|----|----|----|
| フロントエンド | Flutter（Web） | GitHub Pages |
| バックエンドAPI | Go + Echo | Google Cloud Run |
| DB | 使用しない | - |

- GitHub Pages は静的ホスティングのため、バックエンドは別サービスに配置する
- Cloud Run は **scale-to-zero** を前提とし、費用を最小化する

---

## 3. フロントエンド要件（Flutter）

### 3.1 対応プラットフォーム
- iOS
- Android
- Web（GitHub Pages）

### 3.2 技術スタック
- Flutter
- 状態管理：**Riverpod**
- Immutable / State表現：**Freezed**
- HTTPクライアント：Dio（または http）

### 3.3 アーキテクチャ方針
- DDDを参考にした層分離（簡易）
  - domain
  - application
  - infrastructure
  - presentation
- UIは Repository / Usecase を直接操作しない

### 3.4 状態管理方針
- 状態は以下の union を Freezed で表現する
  - idle
  - loading
  - data
  - error
- カウンターの値は **APIレスポンスで確定**させる
- クライアント側での楽観的更新は行わない

### 3.5 クライアント識別
- 初回起動時に `clientId (UUID)` を生成
- `localStorage`（Web）等に永続化
- API 呼び出し時に以下のヘッダーを付与

---

## 4. バックエンド要件（Go + Echo）

### 4.1 技術スタック
- Go
- Echo framework
- 状態管理：インメモリ（DBは使用しない）
- アクセスログは`Echo v4`の`middleware.RequestLoggerWithConfig`を使用する

### 4.2 状態管理方針
- `clientId` 単位でカウンター状態を保持
- 状態はプロセス内メモリに保持
- サーバー再起動時に状態はリセットされる（仕様）

### 4.3 API設計方針
- 更新結果は常にサーバーが決定する
- クライアントから値を直接送らせない

#### 想定エンドポイント（例）
- `GET /api/v1/counter`
- `POST /api/v1/counter/increment`
- `POST /api/v1/counter/reset`
- `GET /api/v1/ping`（疎通確認）

### 4.4 同時実行・整合性
- 同一 `clientId` に対する更新は直列化する
- 排他制御により整合性を保証する
- 複数端末で同一カウンターを共有するケースは対象外とする

### 4.5 認証（擬似）
- 実ユーザー認証は行わない
- `Authorization: Bearer <clientId>` を必須とする
- `/api/v1`配下の全エンドポイントで`Authorization`を必須とする（`/api/v1/ping`を含む）
- 未指定・不正形式の場合は `401 Unauthorized` を返す

### 4.6 CORS
- GitHub Pages の Origin を許可
- Method / Header を明示的に許可する

---

## 5. 例外・エラーハンドリング

### 5.1 想定する例外
- 通信エラー
- タイムアウト
- 401 Unauthorized
- 429 Too Many Requests
- 500 Internal Server Error

### 5.2 疑似エラー注入
- デバッグ用に、意図的にエラーを返せる仕組みを用意する
- Query Parameter
- Header
- 環境変数

### 5.3 フロント側対応
- エラー状態は state として保持
- UI上でメッセージを表示
- 必要に応じて再試行可能

---

## 6. 構成

### 1. リポジトリ構成
project/
├ README.md
├ requirements.md
├ Makefile
├ docker-compose.yml // backend 用
├ frontend/ # Flutter
│  ├ pubspec.yaml
│  └ lib/
│     ├ main.dart
│     ├ apiapplication/
│     │  └ counter/
│     │     ├ counter_notifier.dart
│     │     └ counter_state.dart   // Freezed union: idle/loading/data/error
│     │  └ app_boot/
│     │     ├ app_boot_notifier.dart
│     │     └ app_boot_state.dart
│     ├ core/
│     │  ├ client_id/
│     │  │  └ client_id_store.dart // 生成&永続化（web/mobile分岐）
│     │  ├ config/
│     │  │  └ env.dart             // API_BASE_URL など
│     │  └ network/
│     │     └ dio_provider.dart    // Dio生成 + InterceptorでAuthorization付与
│     ├ domain/
│     │  └ counter/
│     │     └ counter.dart         // entity (valueなど)
│     ├ infrastructure/
│     │  └ counter/
│     │     ├ counter_api.dart     // REST呼び出し
│     │     └ counter_repository.dart
│     └ presentation/
│        └ counter/
│           └ counter_page.dart
├ backend/ # Go (Echo)
│  ├ Dockerfile
│  ├ go.mod
│  ├ go.sum
│  ├ cmd/
│  │  └ api/
│  │     └ main.go
│  └ internal/
│     ├config/
│     │  ├config.go
│     │  └dotenv.go
│     ├domain/
│     │  └counter/
│     ├handler/
│     │  ├middleware/
│     │  │  ├auth_clientid.go
│     │  │  ├cors.go
│     │  │  ├request_id.go
│     │  │  └security_headers.go
│     │  ├routes/
│     │  │  ├health.go
│     │  │  ├route.go
│     │  │  └v1.go
│     │  ├counter_v1.go
│     │  ├health.go
│     │  └ping_v1.go
│     ├httpx/
│     │  └error_hendler.go
│     ├infra/
│     │  └memory/
│     │      └counter_store.go
│     ├response/
│     │  └api.go
│     └usecase/
│        └counter/
│          └service.go
├ .github/
   └ workflows/
      ├ deploy_web.yml
      └ deploy_api.yml

### 2. 責務分担
| ファイル                    | 役割                   |
| --------------------------- | -------------------- |
| routes/route.go             | 全体の Register         |
| routes/health.go            | ヘルスチェック              |
| routes/v1.go                | v1 API の DI & ルーティング |
| handler/counter_v1.go       | HTTP handler         |
| middleware/auth_clientid.go | clientId 認証          |
| usecase/counter             | 業務ロジック               |
| infra/memory                | 状態保持                 |


---

## 7. CI/CD 要件

### 7.1 Web（Flutter）
- GitHub Actions で Web ビルド
- GitHub Pages へ自動デプロイ
- `API_BASE_URL` を build 時に注入

### 7.2 API（Go）
- Docker build
- Cloud Run へ自動デプロイ
- 最小インスタンス数は 0

---

## 8. 環境変数・設定

### 8.1 フロントエンド
- `API_BASE_URL`

### 8.2 バックエンド
- `CORS_ORIGINS`
- `DEBUG_FAIL_RATE`（任意）
- `LOG_LEVEL`

---

## 9. テスト要件

### 9.1 バックエンド
- HTTPハンドラのユニットテスト
- 正常系 / 異常系（401, 500 等）

### 9.2 フロントエンド
- Riverpod Notifier の状態遷移テスト
- 成功・失敗時の state 検証

---

## 10. 非対象範囲
- 永続DB
- 実ユーザー認証（OAuth 等）
- 複数端末間の状態共有
- オフライン同期
