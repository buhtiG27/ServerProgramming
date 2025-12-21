package servlet;

import java.io.IOException;

import org.json.JSONObject;

import client.ApiClient;
import client.ApiResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import listener.AppInitListener;

public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rid = (String) request.getAttribute("rid");
        getServletContext().log("[rid=" + rid + "] Login start");

        request.setCharacterEncoding("UTF-8");

        String userID = request.getParameter("Username");
        String password = request.getParameter("Password");
        getServletContext().log("[rid=" + rid + "] Login Username=" + userID);

        if (userID == null || userID.isEmpty() ||
                password == null || password.isEmpty()) {

            request.setAttribute("error", "メールアドレスとパスワードを入力してください");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                    .forward(request, response);
            return;
        }

        // === Go API に送る JSON ===
        JSONObject json = new JSONObject();
        json.put("account_id", userID);
        json.put("password", password);

        try {
            getServletContext().log("[rid=" + rid + "] Login calling API /api/login");
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse apires = api.postJson(request, "/login", json.toString());

            if (apires.is2xx()) {
                JSONObject res = new JSONObject(apires.body);

                String token = res.getString("token");
                JSONObject user = res.getJSONObject("user");

                HttpSession session = request.getSession();
                session.setAttribute("token", token);
                session.setAttribute("userId", user.getString("account_id"));
                session.setAttribute("displayName", user.getString("display_name"));
                session.setAttribute("login", true);

                getServletContext().log("[rid=" + rid + "] Login foward -> /questions");
                // request.getRequestDispatcher("/questions") .forward(request, response);
                response.sendRedirect(request.getContextPath() + "/questions");

            } else {
                request.setAttribute("error", "ユーザ名またはパスワードが違います");
                getServletContext().log("[rid=" + rid + "] Login foward -> QA_01_Login.jsp");
                request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                        .forward(request, response);
            }
        } catch (Exception e) {
            // TODO:
            getServletContext().log("[rid=" + rid + "] Login failed", e);
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                .forward(request, response);
    }
}