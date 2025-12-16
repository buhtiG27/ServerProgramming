package servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SubjectRegister")
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
            json.put("koma", 1);          // 必須
            json.put("weekday", "Mon");   // 必須
            json.put("time", "1");        // 必須

            // ===== Go API POST =====
            URL url = new URL("http://localhost:8080/subjects");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setDoOutput(true);

            OutputStream os = conn.getOutputStream();
            os.write(json.toString().getBytes("UTF-8"));
            os.close();

            if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
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