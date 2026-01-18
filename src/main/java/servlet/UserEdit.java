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

public class UserEdit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // フォームから新しいユーザー情報を取得
        String userName = request.getParameter("userName");
        String department = request.getParameter("department"); // 学科

        try {
            JSONObject json = new JSONObject();
            json.put("name", userName);
            json.put("department", department);

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            // ログイン中の自分を更新するエンドポイント
            ApiResponse apires = api.putJson(request, "/current_user", json.toString());

            if (apires.is2xx()) {
                // 成功したらユーザー情報表示画面へ
                response.sendRedirect(request.getContextPath() + "/user");
            } else {
                request.setAttribute("error", "プロフィールの更新に失敗しました");
                request.getRequestDispatcher("/web_system/QA_04_UserEdit.jsp").forward(request, response);
            }
        } catch (Exception e) {
            getServletContext().log("UserUpdate Error", e);
            request.setAttribute("error", "システムエラーが発生しました");
            request.getRequestDispatcher("/web_system/QA_04_UserEdit.jsp").forward(request, response);
        }
    }
}