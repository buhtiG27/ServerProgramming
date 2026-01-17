package servlet;

import java.io.IOException;

import client.ApiClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;


public class LikedbyAnswer extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LikedbyAnswer() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String answerId = request.getParameter("answerId");
        String questionId = request.getParameter("questionId");

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            // API側で回答のいいねを処理するエンドポイントを叩く
            api.postJson(request, "/answers/" + answerId + "/like", "{}");
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 処理が終わったら、元の質問詳細画面にリダイレクトして戻る
        response.sendRedirect(request.getContextPath() + "/questions/show?questionId=" + questionId);
    }
}
