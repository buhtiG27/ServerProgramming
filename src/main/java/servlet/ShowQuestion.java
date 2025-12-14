package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/ShowQuestion")
public class ShowQuestion extends HttpServlet {
	
	public ShowQuestion() {
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
        String questionId = request.getParameter("questionId");

        try {
            URL url = new URL("http://localhost:8081/api/posts/" + questionId);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8")
            );

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);

            JSONObject json = new JSONObject(sb.toString());

            Map<String, Object> question =
                json.getJSONObject("question").toMap();

            List<Map<String, Object>> answers = new ArrayList<>();
            JSONArray ans = json.getJSONArray("answers");
            for (int i = 0; i < ans.length(); i++) {
                answers.add(ans.getJSONObject(i).toMap());
            }

            request.setAttribute("question", question);
            request.setAttribute("answers", answers);

            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "質問の取得に失敗しました");
            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                   .forward(request, response);
        }
    }
}