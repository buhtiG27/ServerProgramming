package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

import org.json.JSONArray;
import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import listener.AppInitListener;

public class AllQuestions extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AllQuestions() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");
        getServletContext().log("[rid=" + rid + "] AllQuestions start");

        request.setCharacterEncoding("UTF-8");

        String limitStr = request.getParameter("limit");
        String offsetStr = request.getParameter("offset");

        int limit = 20; // デフォルト
        int offset = 0;

        try {
            if (limitStr != null)
                limit = Integer.parseInt(limitStr);
            if (offsetStr != null)
                offset = Integer.parseInt(offsetStr);
        } catch (NumberFormatException ignore) {
        }

        // 安全ガード（超重要）
        if (limit < 1)
            limit = 20;
        if (limit > 100)
            limit = 100;
        if (offset < 0)
            offset = 0;

        String query = "?limit=" + limit + "&offset=" + offset;

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log("[rid=" + rid + "] Call API GET /posts");

            // 認証付き GET
            ApiResponse apires = api.get(request, "/posts" + query);

            if (!apires.is2xx()) {
                getServletContext().log("[rid=" + rid + "] API error status=" + apires.status);
                request.setAttribute("error", "質問一覧の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                        .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(apires.body);
            JSONArray posts = json.getJSONArray("posts");

            DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

            List<Map<String, Object>> questions = new ArrayList<>();
            for (int i = 0; i < posts.length(); i++) {
                JSONObject postJSON = posts.getJSONObject(i);
                Map<String, Object> postMap = postJSON.toMap();
                String iso = (String) postMap.get("created_at");
                if (iso != null) {
                    OffsetDateTime odt = OffsetDateTime.parse(iso);
                    postMap.put("created_at_fmt", odt.format(outFmt));
                }
                questions.add(postMap);
            }

            request.setAttribute("questions", questions);
            request.setAttribute("limit", limit);
            request.setAttribute("offset", offset);

            getServletContext().log(
                    "[rid=" + rid + "] AllQuestions success count=" + questions.size());
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] AllQuestions failed", e);
            request.setAttribute("error", "質問一覧の取得に失敗しました");
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}