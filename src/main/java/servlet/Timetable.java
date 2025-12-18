package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Subject;

public class MyTimeCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

        // [時限1～8][曜日0～5]
        Subject[][] myTimeTable = new Subject[9][6];

        try {
            // ===== Go API 呼び出し =====
            getServletContext().log("[rid=" + rid + "] Timetable calling API /api/timetable"); // API呼び出しをログに書き込む（任意）
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY); // この行は基本固定
            ApiResponse apires = api.get(request, "/timetable"); // api.getかapi.postJsonを入れる

            if (!apires.is2xx()) {
                // TODO:アクセス失敗時処理
                throw new IOException("Go API error");
            }

            JSONObject json = new JSONObject(apires.body);
            JSONArray arr = json.getJSONArray("timetables");
            // json.put("subject_id", subjectId);
            for (int i = 0; i < arr.length(); i++) {
                JSONObject t = arr.getJSONObject(i);
                JSONObject s = t.getJSONObject("subject");

                Subject sub = new Subject();
                sub.setId(s.getLong("id"));
                sub.setSubjectName(s.getString("subject_name"));
                sub.setTeacher(s.optString("teacher"));
                sub.setClassRoom(s.optString("class_room"));

                int period = s.getInt("koma"); // 時限
                int day = convertWeekday(s.getString("weekday"));

                myTimeTable[period][day] = sub;
            }

            request.setAttribute("myTimeTable", myTimeTable);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "時間割の取得に失敗しました");
        }

        request.getRequestDispatcher("/web_system/QA_03_MyTime.jsp")
                .forward(request, response);
    }

    // 月〜金 → 0〜4
    private int convertWeekday(String weekday) {
        switch (weekday) {
            case "Mon":
                return 0;
            case "Tue":
                return 1;
            case "Wed":
                return 2;
            case "Thu":
                return 3;
            case "Fri":
                return 4;
            default:
                return 5;
        }
    }
}