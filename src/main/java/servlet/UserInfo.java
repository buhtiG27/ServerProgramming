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

public class UserInfo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");
        response.setContentType("text/plain; charset=UTF-8");
        try {
            // API呼び出しをログに書き込む（任意）
            getServletContext().log("[rid=" + rid + "] Login calling API /api/login");
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY); // この行は基本固定
            ApiResponse apires = api.get("/user");

            if (apires.is2xx()) {
                JSONObject userInfo = new JSONObject(apires.body);
                String name = userInfo.getString("display_name");
                String description = userInfo.getString("description");

                request.setAttribute("name", name);
                request.setAttribute("description", description);

                request.getRequestDispatcher("/web_system/QA_04_User.jsp")
                        .forward(request, response);
            } else {
                request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                        .forward(request, response);
            }
        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] Login failed", e);
            throw new ServletException(e);
        }
    }
}
