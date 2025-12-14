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

@WebServlet("/Register")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 確認画面からの値取得
        JSONObject json = new JSONObject();
        json.put("user_id", request.getParameter("Username"));
        json.put("password", request.getParameter("Password"));
        json.put("email", request.getParameter("Address"));
        json.put("display_name", request.getParameter("DisplayName"));
        json.put("year_of_enrollment",
                 Integer.parseInt(request.getParameter("Year")));
        json.put("grade",
                 Integer.parseInt(request.getParameter("Grade")));
        json.put("department_code",
                 request.getParameter("DepartmentCode"));
        json.put("classification",
                 Integer.parseInt(request.getParameter("Classification")));

        URL url = new URL("http://localhost:8081/api/register");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(json.toString().getBytes("UTF-8"));
        }

        int status = conn.getResponseCode();

        if (status == 201 || status == 200) {
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("error", "登録に失敗しました");
            request.getRequestDispatcher("/web_system/QA_06_NewCheck.jsp")
                   .forward(request, response);
        }
    }
}