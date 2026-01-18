package servlet;

import java.io.IOException;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
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

public class ShowQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ShowQuestion() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");
        getServletContext().log("[rid=" + rid + "] ShowQuestion start");

        request.setCharacterEncoding("UTF-8");

        String questionIdStr = request.getParameter("questionId");
        if (questionIdStr == null) {
            request.setAttribute("error", "質問IDが不正です");
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);
            return;
        }

        long questionId = Long.parseLong(questionIdStr);

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log("[rid=" + rid + "] ShowQuestion Call API GET /posts");

            ApiResponse apires = api.get(request, "/posts/" + questionId + "/replies");

            if (!apires.is2xx()) {
                request.setAttribute("error", "質問の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                        .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(apires.body);
            JSONObject post = json.getJSONObject("parent");
            JSONArray replies = json.getJSONArray("replies");

            Map<String, Object> question = post.toMap();
            List<Map<String, Object>> answers = new ArrayList<>();
            
            DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
            String iso = (String) question.get("created_at");
            if (iso != null) {
                OffsetDateTime odt = OffsetDateTime.parse(iso);
                question.put("created_at_fmt", odt.format(outFmt));
            }
            for (int i = 0; i < replies.length(); i++) {
            	JSONObject p = replies.getJSONObject(i);
                Map<String, Object> answerMap = p.toMap();
                
                String aIso = (String) answerMap.get("created_at");
                if (aIso != null) {
                    answerMap.put("created_at_fmt", OffsetDateTime.parse(aIso).format(outFmt));
                }
                answers.add(answerMap);
            }

            if (question == null) {
                request.setAttribute("error", "質問が見つかりません");
            } else {
                request.setAttribute("question", question);
                request.setAttribute("answers", answers);
            }

            request.setAttribute("questionId", questionId);

            getServletContext().log(
                    "[rid=" + rid + "] ShowQuestion success answers=" + answers.size());

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] ShowQuestion failed", e);
            request.setAttribute("error", "質問の取得に失敗しました");
        }

        request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                .forward(request, response);
    }
}