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

public class UpdateSubject extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public UpdateSubject() {
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
        
        // 1. フォームからパラメータを取得
        String subjectId = request.getParameter("subjectId"); // 更新対象を特定するID
        String subjectName = request.getParameter("subjectName");
        String teacher = request.getParameter("teacher");
        String classroom = request.getParameter("classroom");

        try {
            // 2. APIに送るJSONデータを作成 (Go側の構造体タグに合わせる)
            JSONObject json = new JSONObject();
            json.put("subject_name", subjectName);
            json.put("teacher", teacher);
            json.put("class_room", classroom);

            // 3. ApiClientを取得してPUTリクエストを送信
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            
            // エンドポイント例: /subjects/123
            getServletContext().log("[rid=" + rid + "] Call API PUT /subjects/" + subjectId);
            ApiResponse apires = api.putJson(request, "/subjects/" + subjectId, json.toString());

            if (apires.is2xx()) {
                // 更新成功時は時間割画面（または詳細画面）へ
                getServletContext().log("[rid=" + rid + "] Update subject success: " + subjectId);
                response.sendRedirect(request.getContextPath() + "/timetable"); 
            } else {
                // API側でエラー（バリデーション失敗など）になった場合
                getServletContext().log("[rid=" + rid + "] Update subject failed status=" + apires.status);
                request.setAttribute("error", "科目の更新に失敗しました");
                request.getRequestDispatcher("/web_system/QA_28_EditSubject.jsp").forward(request, response);
            }

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] UpdateSubject error", e);
            request.setAttribute("error", "システムエラーが発生しました。");
            request.getRequestDispatcher("/web_system/QA_28_EditSubject.jsp").forward(request, response);
        }
    }
}