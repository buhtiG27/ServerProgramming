package servlet;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;

public class CreateQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // JSP からの入力（Go 側と一致させる）
        String contentsText = request.getParameter("questionBody");

        if (contentsText == null || contentsText.isEmpty()) {
            request.setAttribute("error", "質問内容が入力されていません");
            request.getRequestDispatcher("/web_system/QA_12_CreateQuestion.jsp")
                   .forward(request, response);
            return;
        }

        // Go API 用 JSON 作成
        Map<String, Object> body = new HashMap<>();
        body.put("is_question", true);
        body.put("contents_text", contentsText);

        Gson gson = new Gson();
        String json = gson.toJson(body);

        try {
            ApiClient api = (ApiClient) getServletContext()
                    .getAttribute(AppInitListener.API_KEY);

            ApiResponse res = api.postJson("/posts", json);

            if (res.status == HttpURLConnection.HTTP_OK
             || res.status == HttpURLConnection.HTTP_CREATED) {

                // 成功 → 質問一覧へ
                response.sendRedirect(request.getContextPath() + "/questions");

            } else {
                request.setAttribute("error", res.body);
                request.getRequestDispatcher("/web_system/QA_12_CreateQuestion.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            getServletContext().log("CreateQuestion failed", e);
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/web_system/QA_12_CreateQuestion.jsp")
           .forward(req, res);
    }
}