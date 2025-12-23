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
            /* ===== 時間割取得 ===== */
            ApiResponse timeRes = api.get(request, "/timetables");
            if (!timeRes.is2xx()) {
                JSONObject errJSON = new JSONObject(timeRes.body);
                String error = errJSON.getString("error");
                getServletContext().log("[rid=" + rid + "] get alltasks failed status=" + timeRes.status);
                request.setAttribute("error", "課題一覧の取得に失敗しました: " + error);
                request.getRequestDispatcher("/web_system/QA_03_MyTime.jsp").forward(request, response);
            }
            JSONObject timeJSON = new JSONObject(timeRes.body);
            JSONArray timeArr = timeJSON.getJSONArray("timetables");
            for (int i = 0; i < timeArr.length(); i++) {
                JSONObject t = timeArr.getJSONObject(i);
                JSONObject s = t.getJSONObject("Subject");
                int subID = s.getInt("ID");

                ApiResponse apires = api.get(request, "/subjects/" + subID + "/practices"); // api.getかapi.postJsonを入れる

                if (!apires.is2xx()) {
                    // TODO:アクセス失敗時処理
                    throw new IOException("Go API error");
                }

                // ===== JSON 解析 =====
                JSONObject json = new JSONObject(apires.body);
                JSONArray practices = json.getJSONArray("practices");

                for (int j = 0; j < practices.length(); j++) {
                    JSONObject p = practices.getJSONObject(j);
                    JSONObject subject = p.getJSONObject("Subject");

                    Task task = new Task();
                    task.setId(p.getInt("ID"));
                    task.setSubjectId(subject.getInt("ID"));
                    task.setContent(p.getString("practice_name"));
                    task.setOutput(p.optString("place", ""));
                    task.setDetail(p.optString("description", ""));
                    task.setLimmit(p.optString("deadline", ""));
                    task.setSubjectWeekday(subject.getString("weekday"));
                    task.setSubjectTime(subject.getString("time"));

                    // Subject 名（存在する場合）
                    task.setClassname(subject.optString("subject_name", ""));

                    taskList.add(task);
                }

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