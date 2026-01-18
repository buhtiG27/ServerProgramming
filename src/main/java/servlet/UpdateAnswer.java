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

public class UpdateAnswer extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // パラメータの取得
        String questionId = request.getParameter("questionId"); // 戻り先URL用
        String answerId = request.getParameter("answerId");     // 更新対象ID
        String content = request.getParameter("answerText");    // 修正後の本文

        try {
            JSONObject json = new JSONObject();
            json.put("content", content);

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            // Go API側のエンドポイント例: /answers/123
            ApiResponse apires = api.putJson(request, "/answers/" + answerId, json.toString());

            if (apires.is2xx()) {
                // 成功時は元の質問詳細画面へ戻る
                response.sendRedirect(request.getContextPath() + "/questions/show?questionId=" + questionId);
            } else {
                request.setAttribute("error", "回答の更新に失敗しました");
                request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp?questionId=" + questionId).forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "システムエラーが発生しました。");
            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}