package servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;

public class TimetableSearch extends HttpServlet {
    private static final long serialVersionUID = 1L;    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 文字エンコーディングの設定（パラメータ取得前に必須）
        request.setCharacterEncoding("UTF-8");
        String rid = (String) request.getAttribute("rid");

        // --- 1. パラメータの取得 ---
        String weekday = request.getParameter("weekday");
        String time = request.getParameter("time");
        String keyword = request.getParameter("searchbyKeyword");

        // --- 2. 曜日変換ロジック ---
        String[] weekdayLabels = {"Mon", "Tue", "Wed", "Thu", "Fri", ""};
        String weekdayQuery = "Mon";
        if (weekday != null && !weekday.isEmpty()) {
            try {
                int idx = Integer.parseInt(weekday);
                if (idx >= 0 && idx < weekdayLabels.length) {
                    weekdayQuery = weekdayLabels[idx];
                }
            } catch (NumberFormatException e) {
                weekdayQuery = weekday; 
            }
        }
        String timeQuery = (time != null && !time.isEmpty()) ? time : "1";

        // --- 3. APIリクエストURLの構築 ---
        String queryString = String.format("?weekday=%s&time=%s",
                URLEncoder.encode(weekdayQuery, "UTF-8"),
                URLEncoder.encode(timeQuery, "UTF-8"));

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            getServletContext().log("[rid=" + rid + "] Call API GET /subjects/search" + queryString);

            ApiResponse apires = api.get(request, "/subjects/search" + queryString);

            List<Map<String, Object>> filteredSubjects = new ArrayList<>();

            if (apires.is2xx()) {
                JSONObject json = new JSONObject(apires.body);
                JSONArray subjectsJson = json.getJSONArray("subjects");

                String lowerKeyword = (keyword != null) ? keyword.replaceAll("　", " ").trim().toLowerCase() : "";

                for (int i = 0; i < subjectsJson.length(); i++) {
                    JSONObject subJson = subjectsJson.getJSONObject(i);
                    
                    // キーワードが空の場合は、その時限の科目をすべて追加
                    if (lowerKeyword.isEmpty()) {
                        filteredSubjects.add(subJson.toMap());
                    } else {
                        String subjectName = subJson.optString("subject_name", "").toLowerCase();
                        String teacher = subJson.optString("teacher", "").toLowerCase();

                        if (subjectName.contains(lowerKeyword) || teacher.contains(lowerKeyword)) {
                            filteredSubjects.add(subJson.toMap());
                            System.out.println("Match found: " + subjectName);
                        }
                    }
                }
            } else {
                request.setAttribute("error", "APIからのデータ取得に失敗しました。Status: " + apires.status);
            }

            // --- 6. JSPへのデータ受け渡し ---
            request.setAttribute("subjects", filteredSubjects);
            request.setAttribute("keyword", keyword); 
            request.setAttribute("weekday", weekday); 
            request.setAttribute("time", time);

            request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp").forward(request, response);

        } catch (Exception e) {
            getServletContext().log("Search error", e);
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}