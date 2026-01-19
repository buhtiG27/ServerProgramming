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
        String questionId = request.getParameter("questionId");
        String answerId = request.getParameter("answerId"); 
        String content = request.getParameter("answerText"); 

        try {
            JSONObject json = new JSONObject();
            json.put("contents_text", content); 

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse apires = api.putJson(request, "/posts/" + answerId, json.toString());
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