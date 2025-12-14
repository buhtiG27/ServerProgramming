package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String userId = request.getParameter("Username");
        String password = request.getParameter("Password");

        if (userId == null || userId.isEmpty() ||
            password == null || password.isEmpty()) {

            request.setAttribute("error", "ユーザ名とパスワードを入力してください");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                   .forward(request, response);
            return;
        }

        // === Go API に送る JSON ===
        JSONObject json = new JSONObject();
        json.put("user_id", userId);
        json.put("password", password);

        URL url = new URL("http://localhost:8080/api/login");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(json.toString().getBytes("UTF-8"));
        }

        int status = conn.getResponseCode();

        if (status == 200) {
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8"));

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            JSONObject res = new JSONObject(sb.toString());

            String token = res.getString("token");
            JSONObject user = res.getJSONObject("user");

            HttpSession session = request.getSession();
            session.setAttribute("token", token);
            session.setAttribute("userId", user.getString("user_id"));
            session.setAttribute("displayName", user.getString("display_name"));
            session.setAttribute("login", true);

            request.getRequestDispatcher("/AllQuestions")
                   .forward(request, response);

        } else {
            request.setAttribute("error", "ユーザ名またはパスワードが違います");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                   .forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}