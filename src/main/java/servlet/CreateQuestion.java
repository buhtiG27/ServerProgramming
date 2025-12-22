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

import client.ApiClient;
import client.ApiResponse;
import config.AppConfig;
import listener.AppInitListener;

public class CreateQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");
        getServletContext().log("[rid=" + rid + "] CreateQuestion start");

        request.setCharacterEncoding("UTF-8");

        // JSP からの入力
        String content = (String) request.getParameter("questionBody");
        getServletContext().log("[rid=" + rid + "] questionBody is " + content);

        if (content == null || content.isBlank()) {
            request.setAttribute("error", "質問内容を入力してください");
            request.getRequestDispatcher("/web_system/QA_12_CreateQuestion.jsp")
                    .forward(request, response);
            return;
        }

        // === Go API 用 JSON ===
        JSONObject json = new JSONObject();
        json.put("is_question", true);
        json.put("contents_text", content);

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log("[rid=" + rid + "] Call API POST /posts");

            ApiResponse apires = api.postJson(request, "/posts", json.toString());

            if (apires.is2xx()) {
                getServletContext().log("[rid=" + rid + "] CreateQuestion success");
                response.sendRedirect(request.getContextPath() + "/questions");
            } else {
                getServletContext().log(
                        "[rid=" + rid + "] CreateQuestion failed status=" + apires.status);
                request.setAttribute("error", "質問の投稿に失敗しました");
                request.getRequestDispatcher("/web_system/QA_12_CreateQuestion.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] CreateQuestion error", e);
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