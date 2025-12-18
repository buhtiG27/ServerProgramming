package config;

// 設定の型を表すクラス
public final class AppConfig {
    public final String apiBaseUrl;
    public final int apiConnectTimeoutMs;
    public final int apiReadTimeoutMs;

    public AppConfig(String apiBaseUrl, int connectMs, int readMs) {
        this.apiBaseUrl = apiBaseUrl;
        this.apiConnectTimeoutMs = connectMs;
        this.apiReadTimeoutMs = readMs;
    }
}
