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

public class CreateTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CreateTask() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
    }

    @SuppressWarnings("deprecation")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        // JSPのname属性と完全に一致させる
        String practiceName = request.getParameter("content");
        String place        = request.getParameter("output");
        String description  = request.getParameter("detail"); // JSP側も"detail"にする
        String deadline     = request.getParameter("limmit");
        String subjectId    = request.getParameter("subjectId");

        try {
            // デバッグログ
            getServletContext().log("[DEBUG] CreateTask - subjectId: " + subjectId);

            if (subjectId == null || subjectId.isEmpty()) {
                throw new Exception("subjectId is missing");
            }

            JSONObject json = new JSONObject();
            json.put("subject_id", Integer.parseInt(subjectId)); // ここで数値に変換
            json.put("practice_name", practiceName);
            json.put("place", place);
            json.put("description", description);
            json.put("deadline", deadline);

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            
            // Go側のエンドポイントが "/practices" か "/me/practices" か確認
            ApiResponse apires = api.postJson(request, "/practices", json.toString());

            if (apires.is2xx()) {
                request.getRequestDispatcher("/web_system/QA_25_CompleteTask.jsp").forward(request, response);
            } else {
                getServletContext().log("[DEBUG] API Error: " + apires.body);
                request.setAttribute("error", "APIエラー: " + apires.status);
                request.getRequestDispatcher("/web_system/QA_24_CheckNewTask.jsp").forward(request, response);
            }
        } catch (Exception e) {
            getServletContext().log("[DEBUG] Exception: ", e);
            request.setAttribute("error", "システムエラー: " + e.getMessage());
            request.getRequestDispatcher("/web_system/QA_24_CheckNewTask.jsp").forward(request, response);
        }
    }
}