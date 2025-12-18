package servlet;

import java.io.IOException;
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

public class UpdateQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateQuestion() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rid = (String) request.getAttribute("rid");
        request.setCharacterEncoding("UTF-8");

        String questionId = request.getParameter("questionId");
        String content = request.getParameter("questionText");

        Map<String, String> body = new HashMap<>();
        body.put("content", content);

        Gson gson = new Gson();
        String json = gson.toJson(body);

        URL url = new URL("http:/go-api:8080/api/questions/" + questionId);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("PUT");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(json.getBytes("UTF-8"));
        }

        int status = conn.getResponseCode();

        // TODO:編集機能を実装したらコメントアウト
        // ApiClient api = (ApiClient)
        // getServletContext().getAttribute(AppInitListener.API_KEY);
        // ApiResponse res = api.put(request, "/questions/" + questionId, json);
        if (status == HttpURLConnection.HTTP_OK) {
            response.sendRedirect(
                    request.getContextPath() + "/questions/show?questionId=" + questionId);
        } else {
            request.setAttribute("error", "更新に失敗しました");
            request.getRequestDispatcher(
                    "/web_system/QA_10_ShowQuestion.jsp?questionId=" + questionId).forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}