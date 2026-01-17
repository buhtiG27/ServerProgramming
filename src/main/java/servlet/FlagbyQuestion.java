package servlet;

import java.io.IOException;

import client.ApiClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import listener.AppInitListener;

public class FlagbyQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public FlagbyQuestion() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String questionId = request.getParameter("questionId");
        String offset = request.getParameter("offset");
        String type = request.getParameter("type");
        String from = request.getParameter("from");

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            // API側で「フラグ」の状態を反転
            api.postJson(request, "/posts/" + questionId + "/flag", "{}");
        } catch (Exception e) {
            e.printStackTrace();
        }

        if ("show".equals(from)) {
            response.sendRedirect(request.getContextPath() + "/questions/show?questionId=" + questionId);
        } else {
            String redirectPath = request.getContextPath() + "/questions";
            if (type != null && !type.isEmpty()) {
                redirectPath += "/filter?type=" + type + "&offset=" + (offset != null ? offset : "0");
            } else {
                redirectPath += "?offset=" + (offset != null ? offset : "0");
            }
            response.sendRedirect(redirectPath);
        }
    }
}