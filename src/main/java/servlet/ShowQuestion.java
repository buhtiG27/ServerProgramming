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

@WebServlet("/ShowQuestion")
public class ShowQuestion extends HttpServlet {

    public ShowQuestion() {
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
        String questionId = request.getParameter("questionId");

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse res = api.get("/posts" + questionId);

            JSONObject json = new JSONObject(res.body);

            Map<String, Object> question = json.getJSONObject("question").toMap();

            List<Map<String, Object>> answers = new ArrayList<>();
            JSONArray ans = json.getJSONArray("answers");
            for (int i = 0; i < ans.length(); i++) {
                answers.add(ans.getJSONObject(i).toMap());
            }

            request.setAttribute("question", question);
            request.setAttribute("answers", answers);

            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "質問の取得に失敗しました");
            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                    .forward(request, response);
            getServletContext().log("[rid=" + rid + "] ShowQuestion failed", e);
            throw new ServletException(e);
        }
    }
}