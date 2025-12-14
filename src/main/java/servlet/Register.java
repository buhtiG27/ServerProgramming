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
        
        String user = (String) request.getAttribute("Username");
        String pw = (String) request.getAttribute("Password");
        String email = (String) request.getAttribute("Address");
        String grade = (String) request.getAttribute("Grade");
        String cls = (String) request.getAttribute("Classification");

        // 確認画面からの値取得
        JSONObject json = new JSONObject();
        json.put("user_id", user);
        json.put("password", pw);
        json.put("email", email);
        json.put("display_name", user);
        json.put("grade", Integer.parseInt(grade));
        json.put("classification", Integer.parseInt(cls));

        @SuppressWarnings("deprecation")
		URL url = new URL("http://localhost:8080/api/register");
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