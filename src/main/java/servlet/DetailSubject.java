package servlet;

import java.io.IOException;
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

public class DetailSubject extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String subjectIdStr = request.getParameter("subjectId");
        String weekday = request.getParameter("weekday"); // 03画面から渡す必要がある
        String time = request.getParameter("time");       // 03画面から渡す必要がある

        // デバッグログ
        getServletContext().log("[DEBUG] Detail: id=" + subjectIdStr + ", day=" + weekday + ", time=" + time);

        if (subjectIdStr == null || weekday == null || time == null) {
            // パラメータが足りない場合は一覧へ（GoのAPI制約のため）
            getServletContext().log("[DEBUG] Missing parameters. Redirecting...");
            response.sendRedirect(request.getContextPath() + "/timetable");
            return;
        }

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            
            // 1. Goの曜日の形式に変換 (0->Mon など)
            String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri"};
            String dayStr = days[Integer.parseInt(weekday)];

            // 2. API呼び出し (requiredなクエリを送る)
            String query = String.format("?weekday=%s&time=%s", dayStr, time);
            ApiResponse apires = api.get(request, "/subjects" + query);

            if (apires.is2xx()) {
                JSONObject json = new JSONObject(apires.body);
                JSONArray array = json.getJSONArray("subjects");
                
                long targetId = Long.parseLong(subjectIdStr);
                Map<String, Object> foundSubject = null;

                // 3. 取得したリストからIDが一致するものを探す
                for (int i = 0; i < array.length(); i++) {
                    JSONObject obj = array.getJSONObject(i);
                    if (obj.getLong("ID") == targetId) {
                        foundSubject = obj.toMap();
                        break;
                    }
                }

                if (foundSubject != null) {
                    request.setAttribute("subject", foundSubject);
                    getServletContext().log("[DEBUG] Found subject: " + foundSubject.get("subject_name"));
                }
            }
        } catch (Exception e) {
            getServletContext().log("[DEBUG] Error", e);
        }

        request.getRequestDispatcher("/web_system/QA_21_DetailSubject.jsp").forward(request, response);
    }
}