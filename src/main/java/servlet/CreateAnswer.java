package servlet;

import java.io.IOException;

import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import listener.AppInitListener;

public class CreateAnswer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("token") == null) {
            request.setAttribute("error", "ログインしてください");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                   .forward(request, response);
            return;
        }

        String content = request.getParameter("content");
        String parentIdStr = request.getParameter("question_id");

        if (content == null || content.isBlank()) {
            request.setAttribute("error", "回答内容を入力してください");
            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                   .forward(request, response);
            return;
        }

        long parentId = Long.parseLong(parentIdStr);

        // Go API 用 JSON
        JSONObject json = new JSONObject();
        json.put("is_question", false);
        json.put("parent_id", parentId);
        json.put("contents_text", content);

        try {
            ApiClient api =
                (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            ApiResponse apires = api.postJson(request, "/posts", json.toString());

            if (apires.is2xx()) {
                response.sendRedirect(
                    request.getContextPath() + "/questions/answer"
                );
            } else {
                request.setAttribute("error", "回答の投稿に失敗しました");
                request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}