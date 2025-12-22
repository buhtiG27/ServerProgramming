package servlet;

import java.io.IOException;
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

public class DetailSubject extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String subjectIdStr = request.getParameter("subjectId");
        String weekday = request.getParameter("weekday"); // "3" または "Thu" が想定される
        String time = request.getParameter("time");

        getServletContext().log("[DEBUG] Detail Params: id=" + subjectIdStr + ", weekday=" + weekday + ", time=" + time);

        // 必須パラメータが完全にない場合のみ時間割へ
        if (subjectIdStr == null || weekday == null || time == null || subjectIdStr.equals("null")) {
            getServletContext().log("[WARN] Missing parameters. Redirecting to timetable.");
            response.sendRedirect(request.getContextPath() + "/timetable");
            return;
        }

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri"};
            int dayIndex = -1;

            // ---------- 1. 曜日(weekday)のパース（エラー対策） ----------
            try {
                // まず数値変換を試みる
                dayIndex = Integer.parseInt(weekday);
            } catch (NumberFormatException e) {
                // 数値変換に失敗した場合、文字列("Mon"等)として一致を確認する
                for (int i = 0; i < days.length; i++) {
                    if (days[i].equalsIgnoreCase(weekday)) {
                        dayIndex = i;
                        break;
                    }
                }
            }

            // それでもインデックスが不正ならデフォルト(Mon=0)にするかエラー
            if (dayIndex < 0 || dayIndex >= days.length) {
                throw new Exception("Invalid weekday parameter: " + weekday);
            }

            String dayStr = days[dayIndex];

            // ---------- 2. 科目情報取得 ----------
            String query = String.format("?weekday=%s&time=%s", dayStr, time);
            ApiResponse subjectRes = api.get(request, "/subjects" + query);

            Map<String, Object> foundSubject = null;
            if (subjectRes.is2xx()) {
                JSONObject json = new JSONObject(subjectRes.body);
                JSONArray array = json.getJSONArray("subjects");
                long targetId = Long.parseLong(subjectIdStr);

                for (int i = 0; i < array.length(); i++) {
                    JSONObject obj = array.getJSONObject(i);
                    if (obj.getLong("ID") == targetId) {
                        foundSubject = obj.toMap();
                        break;
                    }
                }
            }

            if (foundSubject != null) {
                request.setAttribute("subject", foundSubject);
            }

            // ---------- 3. 課題一覧取得 ----------
            ApiResponse practiceRes = api.get(request, "/subjects/" + subjectIdStr + "/practices");
            if (practiceRes.is2xx()) {
                getServletContext().log("[DEBUG] Practice API Response: " + practiceRes.body);
                
                JSONObject pJson = new JSONObject(practiceRes.body);
                
                if (pJson.has("practices")) {
                    JSONArray pArray = pJson.getJSONArray("practices");
                    List<Map<String, Object>> practicesList = new ArrayList<>();
                    
                    for (int i = 0; i < pArray.length(); i++) {
                        JSONObject item = pArray.getJSONObject(i);
                        // JSONObjectをMapに変換してリストに追加
                        practicesList.add(item.toMap()); 
                        // ※もしこれでも .toMap() でエラーが出るなら以下に書き換えてください
                        /*
                        Map<String, Object> map = new HashMap<>();
                        for (String key : item.keySet()) {
                            map.put(key, item.get(key));
                        }
                        practicesList.add(map);
                        */
                    }
                    request.setAttribute("practices", practicesList);
                }
            }

        } catch (Exception e) {
            getServletContext().log("[ERROR] DetailSubject error: ", e);
            request.setAttribute("error", "データの表示中にエラーが発生しました: " + e.getMessage());
        }

        // 何が起きても（Exceptionが発生しても）「時間割」ではなく「詳細画面JSP」へ飛ばす
        request.getRequestDispatcher("/web_system/QA_21_DetailSubject.jsp")
               .forward(request, response);
    }
}