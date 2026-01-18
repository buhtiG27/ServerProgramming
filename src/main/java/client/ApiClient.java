package client;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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

    public ApiResponse get(HttpServletRequest request, String path) throws Exception {
        return request(request, "GET", path, null);
    }

    public ApiResponse postJson(HttpServletRequest request, String path, String jsonBody) throws Exception {
        return request(request, "POST", path, jsonBody);
    }

    private ApiResponse request(HttpServletRequest request, String method, String path, String jsonBody)
            throws Exception {
        String urlStr = baseUrl + path;
        HttpURLConnection conn = (HttpURLConnection) new URL(urlStr).openConnection();
        conn.setRequestMethod(method);
        conn.setConnectTimeout(connectTimeoutMs);
        conn.setReadTimeout(readTimeoutMs);
        conn.setRequestProperty("Accept", "application/json");

        HttpSession session = request.getSession(false);
        String token = (session == null) ? null : (String) session.getAttribute("token");
        if (token != null && !token.isBlank()) {
            conn.setRequestProperty("Authorization", "Bearer " + token);
        }

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
        if (status == 401 && token != null && !token.isBlank()) {
            throw new UnauthorizedException("expired or invalid token");
        }

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

    public ApiResponse delete(HttpServletRequest request, String path) throws Exception {
		 return request(request, "DELETE", path, null);
	}

    public ApiResponse putJson(HttpServletRequest request, String path, String jsonBody) throws Exception {
        return request(request, "PUT", path, jsonBody);
    }
}
