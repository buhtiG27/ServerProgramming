#!/usr/bin/env bash
set -euo pipefail

# ====== 設定（必要ならここだけ変える）======
DB_NAME="${TEST_DB_NAME:-serverprogramming_test}"
DB_USER="${TEST_DB_USER:-postgres}"
DB_PASS="${TEST_DB_PASS:-postgres}"
DB_HOST="${TEST_DB_HOST:-127.0.0.1}"
DB_PORT="${TEST_DB_PORT:-5432}"

# Postgresコンテナ名（分からなければ env で指定）
PG_CONTAINER="${PG_CONTAINER:-}"

# JWT系（プロジェクト側が参照してるenv名に合わせてね）
export JWT_SECRET="${JWT_SECRET:-test-secret}"
export TOKEN_EXPIRATION="${TOKEN_EXPIRATION:-60}"

# Goテストで使うDSN
export TEST_DB_DSN="${TEST_DB_DSN:-host=${DB_HOST} port=${DB_PORT} user=${DB_USER} password=${DB_PASS} dbname=${DB_NAME} sslmode=disable TimeZone=Asia/Tokyo}"

# ====== ここから処理 ======
echo "[info] TEST_DB_DSN=$TEST_DB_DSN"

# docker/podman どっち使うか自動判定
RUNTIME=""
if command -v docker >/dev/null 2>&1; then RUNTIME="docker"; fi
if command -v podman >/dev/null 2>&1; then RUNTIME="${RUNTIME:-podman}"; fi
if [[ -z "$RUNTIME" ]]; then
  echo "[error] docker or podman が見つからない"
  exit 1
fi

# コンテナ名が未指定なら、postgresっぽいのを雑に拾う（ダメなら env で指定して）
if [[ -z "$PG_CONTAINER" ]]; then
  PG_CONTAINER="$($RUNTIME ps --format '{{.Names}}' | grep -E 'postg|postgres|db' | head -n 1 || true)"
fi
if [[ -z "$PG_CONTAINER" ]]; then
  echo "[error] Postgresコンテナ名が特定できない。PG_CONTAINER を env で指定して！"
  echo "        例: PG_CONTAINER=postgres_db ./scripts/test-e2e.sh"
  exit 1
fi

echo "[info] runtime=$RUNTIME container=$PG_CONTAINER"

echo "[1/4] create test database if not exists: $DB_NAME"
$RUNTIME exec -e PGPASSWORD="$DB_PASS" -it "$PG_CONTAINER" \
  psql -U "$DB_USER" -d postgres -v ON_ERROR_STOP=1 \
  -c "SELECT 'skip' WHERE EXISTS (SELECT 1 FROM pg_database WHERE datname='${DB_NAME}');" >/dev/null 2>&1 \
  || $RUNTIME exec -e PGPASSWORD="$DB_PASS" -it "$PG_CONTAINER" \
     psql -U "$DB_USER" -d postgres -v ON_ERROR_STOP=1 \
     -c "CREATE DATABASE ${DB_NAME};"

echo "[2/4] gofmt"
gofmt -w .

echo "[3/4] go test"
go test ./... -count=1

echo "[4/4] done ✅"
