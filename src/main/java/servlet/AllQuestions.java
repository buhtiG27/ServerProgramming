package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

@WebServlet("/questions")
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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("token") == null) {
            // 未ログイン
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

            // 認証付き GET
            ApiResponse apires = api.get("/posts", token);

            if (!apires.is2xx()) {
                getServletContext().log("[rid=" + rid + "] API error status=" + apires.status);
                request.setAttribute("error", "質問一覧の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                       .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(apires.body);
            JSONArray posts = json.getJSONArray("posts");

            List<JSONObject> questions = new ArrayList<>();
            for (int i = 0; i < posts.length(); i++) {
                questions.add(posts.getJSONObject(i));
            }

            request.setAttribute("questions", questions);

            getServletContext().log(
                "[rid=" + rid + "] AllQuestions success count=" + questions.size()
            );
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] AllQuestions failed", e);
            request.setAttribute("error", "質問一覧の取得に失敗しました");
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
                    .forward(request, response);
            throw new ServletException(e);
        }

        request.getRequestDispatcher("/web_system/QA_02_Questions.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}