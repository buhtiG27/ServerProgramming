package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateQuestion")
public class CreateQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // JSP からの入力
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String teacher = request.getParameter("teacher");

        String username = (String) request.getSession().getAttribute("loggedInUsername");

        // JSON 作成
        Map<String, String> body = new HashMap<>();
        body.put("title", title);
        body.put("content", content);
        body.put("teacher", teacher);
        body.put("username", username);

        Gson gson = new Gson();
        String json = gson.toJson(body);

        // Go API 接続
        URL url = new URL("http://localhost:8080/api/questions");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(json.getBytes("UTF-8"));
        }

        int status = conn.getResponseCode();

        if (status == HttpURLConnection.HTTP_CREATED) {
            // 作成成功 → 一覧へ
            response.sendRedirect(request.getContextPath() + "/AllQuestions");
        } else {
            // エラー
            BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getErrorStream(), "UTF-8")
            );
            request.setAttribute("error", br.readLine());
            request.getRequestDispatcher("/web_system/QA_12_CreateQuestion.jsp")
                   .forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}
