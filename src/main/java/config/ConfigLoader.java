package config;

// 環境変数を読み取り検証するクラス
public final class ConfigLoader {
    private ConfigLoader() {
    }

    public static AppConfig loadFromEnv() {
        String base = System.getenv("API_BASE_URL");
        if (base == null || base.isBlank()) {
            throw new IllegalStateException("API_BASE_URL is not set");
        }
        base = base.endsWith("/") ? base.substring(0, base.length() - 1) : base;

        int connectMs = parseIntOrDefault(System.getenv("API_CONNECT_TIMEOUT_MS"), 3000);
        int readMs = parseIntOrDefault(System.getenv("API_READ_TIMEOUT_MS"), 5000);

        return new AppConfig(base, connectMs, readMs);
    }

    private static int parseIntOrDefault(String v, int def) {
        if (v == null || v.isBlank())
            return def;
        return Integer.parseInt(v);
    }
}
