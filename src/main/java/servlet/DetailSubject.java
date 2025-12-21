package servlet;

import java.io.IOException;
import java.net.URLEncoder;
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

        String rid = (String) request.getAttribute("rid");
        getServletContext().log("[rid=" + rid + "] DetailSubject start");

        request.setCharacterEncoding("UTF-8");

        String classname = request.getParameter("classname");
        if (classname == null || classname.isBlank()) {
            request.setAttribute("error", "科目名が不正です");
            request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp")
                    .forward(request, response);
            return;
        }

        try {
            String query = "?subject_name=" + URLEncoder.encode(classname, "UTF-8");

            ApiClient api =
                (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log(
                "[rid=" + rid + "] Call API GET /subjects" + query);

            String subjectId = request.getParameter("subjectId");
            ApiResponse apires = api.get(request, "/subjects/" + subjectId);

            if (!apires.is2xx()) {
                request.setAttribute("error", "科目情報の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_21_DetailSubject.jsp")
                        .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(apires.body);
            JSONArray subjects = json.getJSONArray("subjects");

            if (subjects.isEmpty()) {
                request.setAttribute("error", "該当する科目が見つかりません");
                request.getRequestDispatcher("/web_system/QA_21_DetailSubject.jsp")
                        .forward(request, response);
                return;
            }

            JSONObject subjectJson = subjects.getJSONObject(0);

            // ShowQuestion と同じく Map に変換
            Map<String, Object> subject = subjectJson.toMap();

            request.setAttribute("subject", subject);

            getServletContext().log("[rid=" + rid + "] DetailSubject success");

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] DetailSubject failed", e);
            request.setAttribute("error", "科目情報の取得に失敗しました");
        }

        request.getRequestDispatcher("/web_system/QA_21_DetailSubject.jsp")
                .forward(request, response);
    }
}