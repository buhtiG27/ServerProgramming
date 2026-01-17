package servlet;

import java.io.IOException;

import client.ApiClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;

public class LikedbyQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public LikedbyQuestion() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String questionId = request.getParameter("questionId");
        String offset = request.getParameter("offset");
        String type = request.getParameter("type");
        String from = request.getParameter("from");

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            // API側で「いいね」の状態を反転
            api.postJson(request, "/posts/" + questionId + "/like", "{}");
        } catch (Exception e) {
            e.printStackTrace();
        }

        // --- 遷移先の決定ロジック ---
        if ("show".equals(from)) {
            // 詳細画面から来た場合は、その質問の詳細画面へ
            response.sendRedirect(request.getContextPath() + "/questions/show?questionId=" + questionId);
        } else {
            // 一覧画面から来た場合（通常またはフィルタ適用中）
            String redirectPath = request.getContextPath() + "/questions";
            
            if (type != null && !type.isEmpty()) {
                // 学科フィルタやフラグフィルタ適用中の場合
                redirectPath += "/filter?type=" + type + "&offset=" + (offset != null ? offset : "0");
            } else {
                // 通常の新着一覧の場合
                redirectPath += "?offset=" + (offset != null ? offset : "0");
            }
            response.sendRedirect(redirectPath);
        }
    }
}