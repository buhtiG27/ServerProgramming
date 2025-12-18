package servlet;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import listener.AppInitListener;

@WebServlet("/ShowQuestion")
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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("token") == null) {
            request.setAttribute("error", "ログインしてください");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                   .forward(request, response);
            return;
        }

        String token = (String) session.getAttribute("token");

        try {
            ApiClient api =
                (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log("[rid=" + rid + "] Call API GET /posts");

<<<<<<< HEAD
=======
            //ApiResponse apires = api.get("/posts", token);
>>>>>>> refs/remotes/origin/main
            ApiResponse apires = api.get("/posts");

            if (!apires.is2xx()) {
                request.setAttribute("error", "質問の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
                       .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(apires.body);
            JSONArray posts = json.getJSONArray("posts");

            JSONObject question = null;
            List<JSONObject> answers = new ArrayList<>();

            for (int i = 0; i < posts.length(); i++) {
                JSONObject p = posts.getJSONObject(i);

                long id = p.getLong("id");

                if (id == questionId) {
                    question = p;
                }

                if (p.has("parent_id") &&
                    !p.isNull("parent_id") &&
                    p.getLong("parent_id") == questionId) {

                    answers.add(p);
                }
            }

            if (question == null) {
                request.setAttribute("error", "質問が見つかりません");
            } else {
                request.setAttribute("question", question);
                request.setAttribute("answers", answers);
            }

            request.setAttribute("questionId", questionId);

            getServletContext().log(
                "[rid=" + rid + "] ShowQuestion success answers=" + answers.size()
            );

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] ShowQuestion failed", e);
            request.setAttribute("error", "質問の取得に失敗しました");
        }

        request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp")
               .forward(request, response);
    }
}