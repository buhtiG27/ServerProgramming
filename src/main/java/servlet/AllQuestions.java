package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AllQuestions extends HttpServlet {

    public AllQuestions() {
        super();
    }

    // POST も GET と同じ動作にする
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            URL url = new URL("http://localhost:8080/api/posts");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8"));

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null)
                sb.append(line);

            JSONObject json = new JSONObject(sb.toString());
            JSONArray posts = json.getJSONArray("posts");

            List<Map<String, Object>> questions = new ArrayList<>();
            for (int i = 0; i < posts.length(); i++) {
                questions.add(posts.getJSONObject(i).toMap());
            }

            request.setAttribute("questions", questions);
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "質問一覧の取得に失敗しました");
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);
        }
    }
}