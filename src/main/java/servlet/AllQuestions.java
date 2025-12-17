package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;

@WebServlet("/AllQuestions")
public class AllQuestions extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            ApiClient api = (ApiClient) getServletContext()
                    .getAttribute(AppInitListener.API_KEY);

            ApiResponse res = api.get("/posts");

            if (!res.is2xx()) {
                request.setAttribute("error", "質問一覧の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                        .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(res.body);
            JSONArray posts = json.getJSONArray("posts");

            List<Map<String, Object>> questions = new ArrayList<>();
            for (int i = 0; i < posts.length(); i++) {
                questions.add(posts.getJSONObject(i).toMap());
            }

            request.setAttribute("questions", questions);
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "質問一覧の表示中にエラーが発生しました");
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}