package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;

public class Timetable extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Map<String, Object>[][] myTimeTable = new HashMap[9][5];
        Set<Long> registeredSubjectIds = new HashSet<>();
        List<Map<String, Object>> subjects = new ArrayList<>();

        try {
            ApiClient api =
                (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            /* ===== 時間割取得 ===== */
            ApiResponse timeRes = api.get(request, "/timetable");
            if (timeRes.is2xx()) {
                JSONObject json = new JSONObject(timeRes.body);
                JSONArray arr = json.getJSONArray("timetables");

                for (int i = 0; i < arr.length(); i++) {
                    JSONObject t = arr.getJSONObject(i);
                    JSONObject s = t.getJSONObject("subject");

                    Map<String, Object> sub = new HashMap<>();
                    sub.put("id", s.getLong("id"));
                    sub.put("subject_name", s.getString("subject_name"));
                    sub.put("teacher", s.optString("teacher"));
                    sub.put("class_room", s.optString("class_room"));;

                    int period = s.getInt("koma");
                    int day = convertWeekday(s.getString("weekday"));

                    if (period >= 1 && period <= 8 && day >= 0 && day < 5) {
                        myTimeTable[period][day] = sub;
                    }
                }
            }

            /* ===== 科目一覧取得 ===== */
            ApiResponse subRes = api.get(request, "/subjects");
            if (subRes.is2xx()) {
                JSONObject json = new JSONObject(subRes.body);
                JSONArray arr = json.getJSONArray("subjects");
                for (int i = 0; i < arr.length(); i++) {
                    subjects.add(arr.getJSONObject(i).toMap());
                }
            }

            request.setAttribute("myTimeTable", myTimeTable);
            request.setAttribute("subjects", subjects);
            request.setAttribute("registeredSubjectIds", registeredSubjectIds);

        } catch (Exception e) {
            request.setAttribute("error", "時間割データが取得できませんでした");
        }

        request.getRequestDispatcher("/web_system/QA_03_MyTime.jsp")
                .forward(request, response);
    }

    private int convertWeekday(String weekday) {
        return switch (weekday) {
            case "Mon" -> 0;
            case "Tue" -> 1;
            case "Wed" -> 2;
            case "Thu" -> 3;
            case "Fri" -> 4;
            default -> -1;
        };
    }
}