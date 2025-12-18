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

import client.ApiClient;
import client.ApiResponse;
import config.AppConfig;
import listener.AppInitListener;

public class AllTasks extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AllTasks() {
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
        String rid = (String) request.getAttribute("rid");

        List<Task> taskList = new ArrayList<>();

        try {
            // ===== Go API 呼び出し =====
            getServletContext().log("[rid=" + rid + "] AllTask calling API /api/practices"); // API呼び出しをログに書き込む（任意）
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY); // この行は基本固定
            ApiResponse apires = api.get(request, "/practices"); // api.getかapi.postJsonを入れる

            if (!apires.is2xx()) {
                // TODO:アクセス失敗時処理
                throw new IOException("Go API error");
            }

            // ===== JSON 解析 =====
            JSONObject json = new JSONObject(apires.body);
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

            request.setAttribute("tasks", taskList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "課題一覧の取得に失敗しました");
        }

        // JSP へ
        request.getRequestDispatcher("/web_system/QA_17_AllTasks.jsp")
                .forward(request, response);
    }
}