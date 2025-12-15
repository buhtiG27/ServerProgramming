package client;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletContext;

public final class ApiClient {
    private final String baseUrl;
    private final int connectTimeoutMs;
    private final int readTimeoutMs;
    private final ServletContext log;

    public ApiClient(String baseUrl, int connectTimeoutMs, int readTimeoutMs, ServletContext log) {
        this.baseUrl = baseUrl;
        this.connectTimeoutMs = connectTimeoutMs;
        this.readTimeoutMs = readTimeoutMs;
        this.log = log;
    }

    public ApiResponse get(String path) throws Exception {
        return request("GET", path, null);
    }

    public ApiResponse postJson(String path, String jsonBody) throws Exception {
        return request("POST", path, jsonBody);
    }

    private ApiResponse request(String method, String path, String jsonBody) throws Exception {
        String urlStr = baseUrl + path;
        HttpURLConnection conn = (HttpURLConnection) new URL(urlStr).openConnection();
        conn.setRequestMethod(method);
        conn.setConnectTimeout(connectTimeoutMs);
        conn.setReadTimeout(readTimeoutMs);
        conn.setRequestProperty("Accept", "application/json");

        if (jsonBody != null) {
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            try (OutputStream os = conn.getOutputStream()) {
                os.write(jsonBody.getBytes(StandardCharsets.UTF_8));
            }
        }

        int status = conn.getResponseCode();
        String body = readBody(conn, status);

        log.log("[ApiClient] " + method + " " + urlStr + " -> " + status + " body=" + body);

        return new ApiResponse(status, body);
    }

    private static String readBody(HttpURLConnection conn, int status) throws Exception {
        InputStream is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();
        if (is == null)
            return "";
        try (is) {
            return new String(is.readAllBytes(), StandardCharsets.UTF_8);
        }
    }
}
