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
	public void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {

	    String questionId = request.getParameter("questionId");
	    String offset = request.getParameter("offset");
	    String type = request.getParameter("type");

	    try {
	        ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
	        ApiResponse resInfo = api.get(request, "/posts/" + questionId + "/like");

	        if (resInfo.is2xx()) {
	            JSONObject json = new JSONObject(resInfo.body);
	            boolean isLiked = json.optBoolean("is_liked", false);

	            if (isLiked) {

	                int likeId = json.optInt("like_id", -1); 
	                if (likeId != -1) {
	                    api.delete(request, "/posts/" + likeId + "/like");
	                }
	            } else {
	                api.postJson(request, "/posts/like", "{\"post_id\":" + questionId + "}");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    if (offset == null || offset.isEmpty() || "null".equals(offset)) {
	        offset = "0";
	    }

	    String redirectUrl = request.getContextPath() + "/questions";

	    if (type != null && !type.isEmpty() && !"null".equals(type)) {
	        redirectUrl += "/filter?type=" + type + "&offset=" + offset;
	    } else if (!"0".equals(offset)) {
	        redirectUrl += "?offset=" + offset;
	    }

	    response.sendRedirect(redirectUrl);
	}
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}