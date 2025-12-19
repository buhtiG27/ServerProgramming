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

public class UserEdit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        /*
        if (session == null || session.getAttribute("token") == null) {
            request.setAttribute("error", "ログインしてください");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                   .forward(request, response);
            return;
        }
*/
        String token = (String) session.getAttribute("token");

        try {
            ApiClient api =
                (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            // ※ Go 側の CurrentUser
            ApiResponse apires = api.get(request,"/current_user");

            if (!apires.is2xx()) {
                request.setAttribute("error", "ユーザ情報の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_04_User.jsp")
                       .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(apires.body);
            JSONObject user = json.getJSONObject("data");

            request.setAttribute("user", user);

            request.getRequestDispatcher("/web_system/QA_04_UserEdit.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }
}