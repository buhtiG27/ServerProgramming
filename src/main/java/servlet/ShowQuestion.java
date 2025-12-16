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

@WebServlet("/ShowQuestion")
public class ShowQuestion extends HttpServlet {
	
	public ShowQuestion() {
        super();
    }

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String questionId = request.getParameter("questionId");

        try {
            // 親質問（posts から1件取得）
            URL qUrl = new URL("http://localhost:8081/posts?limit=1&offset=0");
            // ※ 本来は /posts/{id} を作るのが理想だが、構成変更不可のため省略

            // 返信取得
            URL rUrl = new URL(
                "http://localhost:8081/posts/" + questionId + "/replies?limit=20&offset=0"
            );

            HttpURLConnection conn = (HttpURLConnection) rUrl.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8")
            );

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);

            JSONObject json = new JSONObject(sb.toString());
            JSONArray replies = json.getJSONArray("replies");

            List<Map<String, Object>> answers = new ArrayList<>();
            for (int i = 0; i < replies.length(); i++) {
                answers.add(replies.getJSONObject(i).toMap());
            }

            request.setAttribute("questionId", questionId);
            request.setAttribute("answers", answers);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "質問の取得に失敗しました");
        }

        request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
               .forward(request, response);
    }
}