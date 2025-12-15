package servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import client.ApiClient;
import client.ApiResponse;
import config.AppConfig;
import listener.AppInitListener;

public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");
        request.setCharacterEncoding("UTF-8");

        // 確認画面からの値取得
        JSONObject json = new JSONObject();
        json.put("user_id", request.getParameter("Username"));
        json.put("password", request.getParameter("Password"));
        json.put("email", request.getParameter("Address"));
        json.put("display_name", request.getParameter("Username"));
        json.put("grade",
                Integer.parseInt(request.getParameter("Grade")));
        json.put("classification",
                Integer.parseInt(request.getParameter("Classification")));

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse res = api.postJson("/register", json.toString());

            if (res.is2xx()) {
                request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                        .forward(request, response);
            } else {
                request.setAttribute("error", "登録に失敗しました");
                request.getRequestDispatcher("/web_system/QA_06_NewCheck.jsp")
                        .forward(request, response);
            }
        } catch (Exception e) {
            // TODO:
            getServletContext().log("[Register] failed", e);
            throw new ServletException(e);
        }
    }
}