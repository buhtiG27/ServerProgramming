package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Subject;

@SuppressWarnings("deprecation")
public class AllSubjects extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
            // ===== Go API 呼び出し =====
            String weekday = request.getParameter("weekday");
            String time = request.getParameter("time");
            String query = "?weekday=" + URLEncoder.encode(weekday, "UTF-8") + "&time="
                    + URLEncoder.encode(time, "UTF-8");

            getServletContext().log("[rid=" + rid + "] AllSubjects calling API /api/subjects"); // API呼び出しをログに書き込む（任意）
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY); // この行は基本固定
            ApiResponse apires = api.get(request, "/subjects" + query); // api.getかapi.postJsonを入れる

            if (!apires.is2xx()) {
                // TODO:アクセス失敗時処理
                throw new IOException("Go API error");
            }
            // ===== JSON → Subject List =====
            JSONObject json = new JSONObject(apires.body);
            JSONArray array = json.getJSONArray("subjects");

            List<Subject> list = new ArrayList<>();
            for (int i = 0; i < array.length(); i++) {
                JSONObject o = array.getJSONObject(i);
                Subject s = new Subject();
                s.setSubjectName(o.getString("subject_name"));
                s.setTeacher(o.optString("teacher"));
                s.setClassRoom(o.optString("class_room"));
                list.add(s);
            }

            request.setAttribute("subjects", list);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "科目一覧の取得に失敗しました");
        }

        request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp")
                .forward(request, response);
    }
}