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

        request.setCharacterEncoding("UTF-8");
        String rid = (String) request.getAttribute("rid");

        // --- 1. パラメータの取得 ---
        String weekday = request.getParameter("weekday");
        String time = request.getParameter("time");
        // JSP側の入力項目のname属性に合わせて取得
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
            
            ApiResponse apires = api.get(request, "/subjects" + queryString);

            List<Map<String, Object>> filteredSubjects = new ArrayList<>();

            if (apires.is2xx()) {
                JSONObject json = new JSONObject(apires.body);
                JSONArray subjectsJson = json.getJSONArray("subjects");

                // キーワードの正規化（nullチェックとトリミング）
                String searchWord = "";
                if (keyword != null && !keyword.trim().isEmpty()) {
                    searchWord = keyword.replaceAll("　", " ").trim().toLowerCase();
                }

                for (int i = 0; i < subjectsJson.length(); i++) {
                    JSONObject subJson = subjectsJson.getJSONObject(i);
                    
                    // 検索対象
                    String subjectName = subJson.optString("subject_name", "");
                    String teacher = subJson.optString("teacher", "");

                    // キーワードが空、または科目名・教員名に含まれる場合にリストに追加
                    if (searchWord.isEmpty() || 
                        subjectName.toLowerCase().contains(searchWord) || 
                        teacher.toLowerCase().contains(searchWord)) {
                        
                        filteredSubjects.add(subJson.toMap());
                    }
                }
            } else {
                request.setAttribute("error", "データの取得に失敗しました。");
            }

            // JSPへ渡す
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