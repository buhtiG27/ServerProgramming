package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Task;

public class AllTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AllTask() {
        super();
    }

    // POST も GET と同じ
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @SuppressWarnings("deprecation")
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        List<Task> taskList = new ArrayList<>();

        try {
            // ===== Go API 呼び出し =====
            URL url = new URL("http://localhost:8081/practice");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            if (con.getResponseCode() != HttpURLConnection.HTTP_OK) {
                throw new IOException("Go API error");
            }

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(con.getInputStream(), "UTF-8"));

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            // ===== JSON 解析 =====
            JSONObject json = new JSONObject(sb.toString());
            JSONArray practices = json.getJSONArray("practices");

            for (int i = 0; i < practices.length(); i++) {
                JSONObject p = practices.getJSONObject(i);

                Task task = new Task();
                task.setId(p.getInt("id"));
                task.setSubjectId(p.getInt("subject_id"));
                task.setContent(p.getString("practice_name"));
                task.setOutput(p.optString("place", ""));
                task.setDetail(p.optString("description", ""));
                task.setLimmit(p.optString("deadline", ""));

                // Subject 名（存在する場合）
                if (p.has("subject")) {
                    JSONObject s = p.getJSONObject("subject");
                    task.setClassname(s.optString("subject_name", ""));
                }

                taskList.add(task);
            }

            request.setAttribute("task", taskList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "課題一覧の取得に失敗しました");
        }

        // JSP へ
        request.getRequestDispatcher("/web_system/QA_17_AllTask.jsp")
               .forward(request, response);
    }
}