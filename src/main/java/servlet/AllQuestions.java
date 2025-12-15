package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
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

public class AllQuestions extends HttpServlet {

    public AllQuestions() {
        super();
    }

    // POST も GET と同じ動作にする
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rid = (String) request.getAttribute("rid");

        request.setCharacterEncoding("UTF-8");

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse res = api.get("/posts");
            if (res.is2xx()) {
                var sb = res.body;
                JSONObject json = new JSONObject(sb);
                JSONArray posts = json.getJSONArray("posts");

                List<Map<String, Object>> questions = new ArrayList<>();
                for (int i = 0; i < posts.length(); i++) {
                    questions.add(posts.getJSONObject(i).toMap());
                }

                request.setAttribute("questions", questions);
                request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "質問一覧の取得に失敗しました");
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);
            getServletContext().log("[rid=" + rid + "] AllQuestionns failed", e);
            throw new ServletException(e);
        }
    }
}