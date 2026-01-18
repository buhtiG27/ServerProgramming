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

            // 現在のいいね状態を取得する
            ApiResponse resInfo = api.get(request, "/posts/" + answerId + "/like");

            if (resInfo.is2xx()) {
                JSONObject json = new JSONObject(resInfo.body);
                boolean isLiked = json.getBoolean("is_liked");

                if (isLiked) {
                    // 「いいね」されている場合は削除する
                    int likeId = json.getInt("like_id");
                    api.delete(request, "/posts/like/" + likeId);
                } else {
                    // 「いいね」されていない場合は保存する 
                    String jsonBody = "{\"post_id\":" + answerId + "}";
                    api.postJson(request, "/posts/like", jsonBody);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/questions/show?questionId=" + questionId);
    }
}