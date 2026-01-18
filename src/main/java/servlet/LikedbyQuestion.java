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

public class LikedbyQuestion extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    String questionId = request.getParameter("questionId");
	    String offset = request.getParameter("offset");
	    String type = request.getParameter("type");

	    try {
	        ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

	        ApiResponse resInfo = api.get(request, "/posts/" + questionId + "/like");
	        if (resInfo.is2xx()) {
	            JSONObject json = new JSONObject(resInfo.body);
	            if (json.optBoolean("is_liked", false)) {
	                // Goの定義：DELETE /api/posts/:id/like
	                api.delete(request, "/posts/" + questionId + "/like");
	            } else {
	                // Goの定義：POST /api/posts/like
	                api.postJson(request, "/posts/like", "{\"post_id\":" + questionId + "}");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    String redirectUrl = request.getContextPath() + "/questions";
	    if (type != null && !type.isEmpty() && !"null".equals(type)) {
	        redirectUrl += "/filter?type=" + type + "&offset=" + (offset != null ? offset : "0");
	    } else {
	        redirectUrl += "?offset=" + (offset != null ? offset : "0");
	    }
	    response.sendRedirect(redirectUrl);
	}
}