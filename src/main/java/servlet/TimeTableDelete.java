package servlet;

import java.io.IOException;
import java.util.HashMap;
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

public class TimeTableDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TimeTableDelete() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Map<String, Map<String, Object>> timetable = new HashMap<>();
        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse timeRes = api.get(request, "/timetables");

            if (timeRes.is2xx()) {
                JSONObject timeJSON = new JSONObject(timeRes.body);
                JSONArray timeArr = timeJSON.getJSONArray("timetables");

                for (int i = 0; i < timeArr.length(); i++) {
                    JSONObject t = timeArr.getJSONObject(i);
                    JSONObject s = t.getJSONObject("Subject");

                    Map<String, Object> sub = new HashMap<>();
                    sub.put("id", s.getLong("ID")); // 削除に必要
                    sub.put("subject_name", s.getString("subject_name"));
                    
                    int time = s.getInt("time");
                    int day = convertWeekday(s.getString("weekday"));
                    timetable.put(time + ":" + day, sub);
                }
            }
            request.setAttribute("timetable", timetable);
        } catch (Exception e) {
            getServletContext().log("TimetableDelete GET error", e);
        }
        request.getRequestDispatcher("/web_system/QA_18_DeleteMyTime.jsp").forward(request, response);
    }

    // POST: 科目の削除実行
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String subjectId = request.getParameter("subjectId");
        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            // API仕様に合わせて DELETE リクエストを送信
            ApiResponse apires = api.delete(request, "/timetables/" + subjectId);

            if (!apires.is2xx()) {
                request.setAttribute("error", "削除に失敗しました");
            }
        } catch (Exception e) {
            getServletContext().log("TimetableDelete POST error", e);
        }
        // 削除後、再度削除画面（自身）へリダイレクト
        response.sendRedirect(request.getContextPath() + "/timetable/delete");
    }

    private int convertWeekday(String weekday) {
        return switch (weekday) {
            case "Mon" -> 0; case "Tue" -> 1; case "Wed" -> 2;
            case "Thu" -> 3; case "Fri" -> 4; default -> -1;
        };
    }
}
