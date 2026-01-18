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

public class FlagbyQuestion extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String questionId = request.getParameter("questionId");
        String offset = request.getParameter("offset");
        String type = request.getParameter("type");
        String from = request.getParameter("from");

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            ApiResponse resInfo = api.get(request, "/posts/" + questionId + "/flag");
            if (resInfo.is2xx()) {
                JSONObject json = new JSONObject(resInfo.body);
                if (json.optBoolean("is_flag", false)) {
                    // Goの定義：DELETE /api/user/flags/:id
                    int flagId = json.getInt("flag_id");
                    api.delete(request, "/user/flags/" + flagId);
                } else {
                    // Goの定義：POST /api/user/flags
                    api.postJson(request, "/user/flags", "{\"post_id\":" + questionId + "}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String redirectPath = "show".equals(from) ? 
            "/questions/show?questionId=" + questionId :
            "/questions" + (type != null && !type.isEmpty() ? "/filter?type=" + type : "") + 
            (offset != null ? (type != null && !type.isEmpty() ? "&" : "?") + "offset=" + offset : "");
        
        response.sendRedirect(request.getContextPath() + redirectPath);
    }
}