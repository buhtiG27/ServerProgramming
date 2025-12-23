package servlet;

import java.io.IOException;

import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;

public class SubjectRegister extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @SuppressWarnings("deprecation")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String rid = (String) request.getAttribute("rid");

        // JSPの <input name="..."> と完全に一致させる
        String subjectName = request.getParameter("subjectName");
        String teacher = request.getParameter("teacher");
        String classRoom = request.getParameter("classRoom");

        // 前の画面（マイ時間割など）から渡されるパラメータ
        String weekdayParam = request.getParameter("weekday");
        String timeParam = request.getParameter("time");

        // --- パラメータの解析とデフォルト値の設定 ---
        String[] weekdayLabels = { "Mon", "Tue", "Wed", "Thu", "Fri" };
        String weekdayStr = "Mon"; // デフォルト
        int timeVal = 1; // デフォルト

        try {
            // weekdayParam のチェックと数値変換
            if (weekdayParam != null && !weekdayParam.isEmpty() && !weekdayParam.equals("null")) {
                int idx = Integer.parseInt(weekdayParam);
                if (idx >= 0 && idx < weekdayLabels.length) {
                    weekdayStr = weekdayLabels[idx];
                }
            }

            // timeParam のチェックと数値変換
            if (timeParam != null && !timeParam.isEmpty() && !timeParam.equals("null")) {
                timeVal = Integer.parseInt(timeParam);
            } else {
                // 届かなかった場合はログを出す
                getServletContext().log("WARNING: timeParam is null. Defaulting to 1.");
                timeVal = 1;
            }
        } catch (NumberFormatException e) {
            getServletContext().log("[rid=" + rid + "] Parameter parse error: " + e.getMessage());
            // 数字でない場合はデフォルト値のまま進む
        }

        try {
            // ===== API 送信用 JSON 作成 =====
            JSONObject json = new JSONObject();
            json.put("subject_name", subjectName);
            json.put("teacher", teacher);
            json.put("class_room", classRoom);
            json.put("koma", 1);
            json.put("weekday", weekdayStr);
            json.put("time", String.valueOf(timeVal));

            json.put("description", "");
            json.put("units", 2);
            json.put("period", "前期");

            // ===== Go API POST =====
            getServletContext().log("Sending JSON: " + json.toString());

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse apires = api.postJson(request, "/subjects", json.toString());

            if (apires.is2xx()) {
                // 登録成功後は科目一覧サーブレットへ
                String query = "?weekday=" + weekdayParam + "&time=" + timeParam;
                response.sendRedirect(request.getContextPath() + "/subjects" + query);
                return;
            }

            // APIがエラーを返した場合
            getServletContext().log("[rid=" + rid + "] API error: " + apires.status + " body: " + apires.body);
            request.setAttribute("error", "科目登録に失敗しました（APIエラー）");
            request.getRequestDispatcher("/web_system/QA_20_CreateSubject.jsp").forward(request, response);

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] SubjectRegister failed", e);
            throw new ServletException(e);
        }
    }
}