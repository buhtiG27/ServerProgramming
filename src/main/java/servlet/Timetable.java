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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String rid = (String) request.getAttribute("rid");
        getServletContext().log("[rid=" + rid + "] CreateQuestion start");

        String subjectIDstr = request.getParameter("subjectId");
        int subjectID = Integer.parseInt(subjectIDstr);
        getServletContext().log("[rid=" + rid + "] subjectID is " + subjectID);

        // Go API に送るJSON
        JSONObject json = new JSONObject();
        json.put("subject_id", subjectID);

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            ApiResponse apires = api.postJson(request, "/timetables", json.toString());

            if (!apires.is2xx()) {
                JSONObject errJSON = new JSONObject(apires.body);
                String error = errJSON.getString("error");
                getServletContext().log("[rid=" + rid + "] post timetable failed status=" + apires.status);
                request.setAttribute("error", "時間割の登録に失敗しました: " + error);
                request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp").forward(request, response);
            }

            response.sendRedirect(request.getContextPath() + "/timetable");

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] CreateQuestion error", e);
            throw new ServletException(e);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String rid = (String) request.getAttribute("rid");

        Map<String, Map<String, Object>> timetable = new HashMap<>();
        Set<Long> registeredSubjectIds = new HashSet<>();
        List<Map<String, Object>> subjects = new ArrayList<>();

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            /* ===== 時間割取得 ===== */
            ApiResponse timeRes = api.get(request, "/timetables");
            if (!timeRes.is2xx()) {
                JSONObject errJSON = new JSONObject(timeRes.body);
                String error = errJSON.getString("error");
                getServletContext().log("[rid=" + rid + "] get timetable failed status=" + timeRes.status);
                request.setAttribute("error", "時間割情報の取得に失敗しました: " + error);
                request.getRequestDispatcher("/web_system/QA_03_MyTime.jsp").forward(request, response);
            }
            JSONObject timeJSON = new JSONObject(timeRes.body);
            JSONArray timeArr = timeJSON.getJSONArray("timetables");

            for (int i = 0; i < timeArr.length(); i++) {
                JSONObject t = timeArr.getJSONObject(i);
                JSONObject s = t.getJSONObject("Subject");

                Map<String, Object> sub = new HashMap<>();
                sub.put("id", s.getLong("ID"));
                sub.put("subject_name", s.getString("subject_name"));
                sub.put("teacher", s.optString("teacher"));
                sub.put("class_room", s.optString("class_room"));

                int time = s.getInt("time");
                int day = convertWeekday(s.getString("weekday"));

                timetable.put(time + ":" + day, sub);
            }

            /* ===== 科目一覧取得 ===== */
            // ApiResponse subRes = api.get(request, "/subjects");
            // if (!subRes.is2xx()) {
            // JSONObject errJSON = new JSONObject(subRes.body);
            // String error = errJSON.getString("error");
            // getServletContext().log("[rid=" + rid + "] get subjects failed status=" +
            // subRes.status);
            // request.setAttribute("error", "科目一覧の取得に失敗しました: " + error);
            // request.getRequestDispatcher("/web_system/QA_03_MyTime.jsp").forward(request,
            // response);
            // }
            // JSONObject subJSON = new JSONObject(subRes.body);
            // JSONArray subArr = subJSON.getJSONArray("subjects");
            // for (int i = 0; i < subArr.length(); i++) {
            // subjects.add(subArr.getJSONObject(i).toMap());
            // }

            request.setAttribute("timetable", timetable);
            // request.setAttribute("subjects", subjects);
            // request.setAttribute("registeredSubjectIds", registeredSubjectIds);

        } catch (Exception e) {
            request.setAttribute("error", "時間割データが取得できませんでした");
            getServletContext().log("[rid=" + rid + "] Timetable error", e);
            throw new ServletException(e);
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