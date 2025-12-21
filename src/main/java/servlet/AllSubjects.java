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
        getServletContext().log("[rid=" + rid + "] AllSubjects start");

        request.setCharacterEncoding("UTF-8");

        String weekday = request.getParameter("weekday");
        String time    = request.getParameter("time");

        // クエリ組み立て（任意）
        StringBuilder query = new StringBuilder();
        if (weekday != null && !weekday.isBlank()) {
            query.append(query.length() == 0 ? "?" : "&")
                 .append("weekday=").append(URLEncoder.encode(weekday, "UTF-8"));
        }
        if (time != null && !time.isBlank()) {
            query.append(query.length() == 0 ? "?" : "&")
                 .append("time=").append(URLEncoder.encode(time, "UTF-8"));
        }

        try {
            ApiClient api =
                (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log(
                "[rid=" + rid + "] Call API GET /subjects" + query);

            ApiResponse apires = api.get(request, "/subjects" + query);

            if (!apires.is2xx()) {
                getServletContext().log(
                    "[rid=" + rid + "] API error status=" + apires.status);
                request.setAttribute("error", "科目一覧の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp")
                        .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(apires.body);
            JSONArray subjectsJson = json.getJSONArray("subjects");

            List<Map<String, Object>> subjects = new ArrayList<>();
            for (int i = 0; i < subjectsJson.length(); i++) {
                JSONObject s = subjectsJson.getJSONObject(i);
                subjects.add(s.toMap());
            }

            request.setAttribute("subjects", subjects);

            getServletContext().log(
                "[rid=" + rid + "] AllSubjects success count=" + subjects.size());

            request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] AllSubjects failed", e);
            request.setAttribute("error", "科目一覧の取得に失敗しました");
            request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}