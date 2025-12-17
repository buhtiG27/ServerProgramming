package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import client.ApiClient;
import client.ApiResponse;
import config.AppConfig;
import listener.AppInitListener;

public class CreateQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rid = (String) request.getAttribute("rid");

        request.setCharacterEncoding("UTF-8");

        // JSP からの入力
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String teacher = request.getParameter("teacher");

        String username = (String) request.getSession().getAttribute("loggedInUsername");

        // JSON 作成
        Map<String, String> body = new HashMap<>();
        body.put("title", title);
        body.put("content", content);
        body.put("teacher", teacher);
        body.put("username", username);

        Gson gson = new Gson();
        String json = gson.toJson(body);

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse res = api.postJson("/questions", json);

            if (res.status == HttpURLConnection.HTTP_CREATED) {
                // 作成成功 → 一覧へ
                request.getRequestDispatcher("web_system/QA_02_Questions.jsp")
                        .forward(request, response);
            } else {
                // エラー
                request.setAttribute("error", res.body);
                request.getRequestDispatcher("/web_system/QA_12_CreateQuestion.jsp")
                        .forward(request, response);
            }
        } catch (Exception e) {
            // TODO: handle exception
            getServletContext().log("[rid=" + rid + "] CreateQuestion failed", e);
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}
