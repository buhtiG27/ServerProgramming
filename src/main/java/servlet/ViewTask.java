package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Task;

public class ViewTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("deprecation")
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // パラメータ取得（課題ID）
        String practiceId = request.getParameter("id");

        // 遷移先
        String destination = "/web_system/QA_13_ViewTask.jsp";

        if (practiceId == null || practiceId.isEmpty()) {
            request.setAttribute("error", "課題IDが指定されていません");
            request.getRequestDispatcher(destination).forward(request, response);
            return;
        }

        try {
            // Go API 呼び出し
            URL url = new URL("http://localhost:8081/practice/" + practiceId);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            if (con.getResponseCode() != HttpURLConnection.HTTP_OK) {
                request.setAttribute("error", "課題情報の取得に失敗しました");
                request.getRequestDispatcher(destination).forward(request, response);
                return;
            }

            // レスポンス読み込み
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(con.getInputStream(), "UTF-8"));

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            // JSON 解析
            JSONObject json = new JSONObject(sb.toString());
            JSONObject p = json.getJSONObject("practice");

            // Task に詰め替え
            Task task = new Task();
            task.setId(p.getInt("id"));
            task.setSubjectId(p.getInt("subject_id"));
            task.setContent(p.getString("practice_name"));
            task.setOutput(p.optString("place", ""));
            task.setDetail(p.optString("description", ""));
            task.setLimmit(p.optString("deadline", ""));

            // JSP へ渡す
            request.setAttribute("task", task);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "システムエラーが発生しました");
        }

        // 詳細画面へ
        request.getRequestDispatcher(destination).forward(request, response);
    }
}