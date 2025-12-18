package servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SubjectRegister extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @SuppressWarnings("deprecation")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String classname = request.getParameter("Classname");
        String teacher = request.getParameter("Teacher");
        String roomname = request.getParameter("Roomname");

        try {
            // ===== JSON 作成 =====
            JSONObject json = new JSONObject();
            json.put("subject_name", classname);
            json.put("teacher", teacher);
            json.put("class_room", roomname);
            json.put("koma", 1); // 必須
            json.put("weekday", "Mon"); // 必須
            json.put("time", "1"); // 必須

            // ===== Go API POST =====
            getServletContext().log("[rid=" + rid + "] SubjectRegister calling API /api/subjects");
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse apires = api.postJson(request, "/subjects", json.toString());

            if (!apires.is2xx()) {
                throw new IOException("API error");
            }

            // 成功
            request.setAttribute("Register", classname);
            request.getRequestDispatcher("/web_system/QA_22_CompleteSubject.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "科目登録に失敗しました");
            request.getRequestDispatcher("/web_system/QA_20_CreateSubject.jsp")
                    .forward(request, response);
        }
    }
}