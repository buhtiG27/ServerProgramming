package servlet;

import java.io.IOException;

import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;

public class UpdateQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String rid = (String) request.getAttribute("rid");

        // パラメータ取得
        String questionId = request.getParameter("questionId");
        String content = request.getParameter("contents_text"); 

        try {
            JSONObject json = new JSONObject();
            json.put("contents_text", content); 

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse apires = api.putJson(request, "/posts/" + questionId, json.toString());
            if (apires.is2xx()) {
                // 成功：詳細画面へ
                response.sendRedirect(request.getContextPath() + "/questions/show?questionId=" + questionId);
            } else {
                // 失敗
                request.setAttribute("error", "質問の更新に失敗しました");
                request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp?questionId=" + questionId).forward(request, response);
            }
        } catch (Exception e) {
            getServletContext().log("UpdateQuestion Error", e);
            request.setAttribute("error", "システムエラーが発生しました");
            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }
}