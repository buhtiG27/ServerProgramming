package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import client.ApiClient;
import client.ApiResponse;
import config.AppConfig;
import listener.AppInitListener;

public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rid = (String) request.getAttribute("rid");
        getServletContext().log("[rid=" + rid + "] Login start");

        request.setCharacterEncoding("UTF-8");

        String userId = request.getParameter("Username");
        String password = request.getParameter("Password");
        getServletContext().log("[rid=" + rid + "] Login Username=" + userId);

        if (userId == null || userId.isEmpty() ||
                password == null || password.isEmpty()) {

            request.setAttribute("error", "ユーザ名とパスワードを入力してください");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                    .forward(request, response);
            return;
        }

        // === Go API に送る JSON ===
        JSONObject json = new JSONObject();
        json.put("user_id", userId);
        json.put("password", password);

        try {
            getServletContext().log("[rid=" + rid + "] Login calling API /api/login");
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse apires = api.postJson("/login", json.toString());

            if (apires.is2xx()) {
                JSONObject res = new JSONObject(apires.body);

                String token = res.getString("token");
                JSONObject user = res.getJSONObject("user");

                HttpSession session = request.getSession();
                session.setAttribute("token", token);
                session.setAttribute("userId", user.getString("user_id"));
                session.setAttribute("displayName", user.getString("display_name"));
                session.setAttribute("login", true);

                getServletContext().log("[rid=" + rid + "] Login foward -> /questions");
                request.getRequestDispatcher("/questions")
                        .forward(request, response);

            } else {
                request.setAttribute("error", "ユーザ名またはパスワードが違います");
                getServletContext().log("[rid=" + rid + "] Login foward -> QA_01_Login.jsp");
                request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                        .forward(request, response);
            }
        } catch (Exception e) {
            // TODO:
            getServletContext().log("[rid=" + rid + "] Login failed", e);
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}