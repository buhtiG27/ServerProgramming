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

public class UpdateTask extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public UpdateTask() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String rid = (String) request.getAttribute("rid");
        
        // フォームからパラメータを取得
        String taskId = request.getParameter("taskId"); // 更新に必須
        String classname = request.getParameter("classname");
        String content = request.getParameter("content");
        String limmit = request.getParameter("limmit");
        String output = request.getParameter("output");
        String detail = request.getParameter("detail");

        try {
            // 1. APIに送るJSONデータを作成
            JSONObject json = new JSONObject();
            json.put("classname", classname);
            json.put("content", content);
            json.put("limit", limmit); // API側のキー名（limit/limmit）に合わせる
            json.put("output", output);
            json.put("detail", detail);

            // 2. ApiClientを取得してPUTリクエストを送信
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            // エンドポイント例: /tasks/123
            ApiResponse apires = api.putJson(request, "/tasks/" + taskId, json.toString());

            if (apires.is2xx()) {
                // 更新成功時は課題一覧または詳細画面へ
                getServletContext().log("[rid=" + rid + "] Update task success: " + taskId);
                response.sendRedirect(request.getContextPath() + "/tasks"); 
            } else {
                // API側でエラーになった場合
                getServletContext().log("[rid=" + rid + "] Update task failed status=" + apires.status);
                request.setAttribute("error", "更新に失敗しました（APIエラー）");
                request.getRequestDispatcher("/web_system/QA_26_EditTask.jsp").forward(request, response);
            }

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] UpdateTask error", e);
            request.setAttribute("error", "システムエラーが発生しました。");
            request.getRequestDispatcher("/web_system/QA_26_EditTask.jsp").forward(request, response);
        }
    }
}