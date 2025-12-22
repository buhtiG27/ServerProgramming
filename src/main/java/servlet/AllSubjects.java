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

public class AllSubjects extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");

        request.setCharacterEncoding("UTF-8");

        String weekday = request.getParameter("weekday");
        String time    = request.getParameter("time");
        
        String[] weekdayLabels = {"Mon", "Tue", "Wed", "Thu", "Fri",""};
        String weekdayQuery = "Mon";
        if (weekday != null && !weekday.isEmpty()) {
            try {
                int idx = Integer.parseInt(weekday);
                if (idx >= 0 && idx < weekdayLabels.length) {
                    weekdayQuery = weekdayLabels[idx]; // "0" -> "Mon" に変換
                }
            } catch (NumberFormatException e) {
                weekdayQuery = "Mon"; // 既に文字列の場合はそのまま
            }
        }
        String timeQuery = (time != null && !time.isEmpty()) ? time : "1";
        
        String queryString = String.format("?weekday=%s&time=%s", 
                URLEncoder.encode(weekdayQuery, "UTF-8"),
                URLEncoder.encode(timeQuery, "UTF-8"));

        try {
            ApiClient api =
                (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log(
                "[rid=" + rid + "] Call API GET /subjects" + queryString);

            ApiResponse apires = api.get(request, "/subjects" + queryString);

            if (apires.is2xx()) {
                JSONObject json = new JSONObject(apires.body);
                JSONArray subjectsJson = json.getJSONArray("subjects");

                List<Map<String, Object>> subjects = new ArrayList<>();
                for (int i = 0; i < subjectsJson.length(); i++) {
                    // Mapに変換する際、キーは "subject_name" のまま保持される
                    subjects.add(subjectsJson.getJSONObject(i).toMap());
                }
                request.setAttribute("subjects", subjects);
            } else {
                request.setAttribute("error", "API Error: " + apires.status);
            }
            
            request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}