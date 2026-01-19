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

public class FilterQuestion extends HttpServlet {
	
	public FilterQuestion() {
        super();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String filterType = request.getParameter("type");
        
        String offsetStr = request.getParameter("offset");
        int offset = (offsetStr != null) ? Integer.parseInt(offsetStr) : 0;
        
        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            ApiResponse postsRes = api.get(request, "/posts?limit=100"); 
            JSONObject postsJson = new JSONObject(postsRes.body);
            JSONArray posts = postsJson.getJSONArray("posts");

            List<Map<String, Object>> filteredList = new ArrayList<>();
            DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
            
            for (int i = 0; i < posts.length(); i++) {
                JSONObject postJSON = posts.getJSONObject(i);

                Map<String, Object> postMap = postJSON.toMap();
                String qId = String.valueOf(postMap.get("id"));

                ApiResponse likeRes = api.get(request, "/posts/" + qId + "/like");
                if (likeRes.is2xx()) {
                    JSONObject likeData = new JSONObject(likeRes.body);
                    postMap.put("is_liked", likeData.optBoolean("is_liked", false));
                    
                    int count = 0;
                    if (likeData.has("count")) {
                        count = likeData.getInt("count");
                    } else if (likeData.has("like_count")) {
                        count = likeData.getInt("like_count");
                    } else if (likeData.has("likes")) {
                        count = likeData.getInt("likes");
                    }

                    postMap.put("like_count", count);
                }

                ApiResponse flagRes = api.get(request, "/posts/" + qId + "/flag");
                boolean isActuallyFlagged = false;
                if (flagRes.is2xx()) {
                    JSONObject flagData = new JSONObject(flagRes.body);
                    isActuallyFlagged = flagData.optBoolean("is_flag", false);
                    postMap.put("is_flag", isActuallyFlagged);
                }

                String iso = (String) postMap.get("created_at");
                if (iso != null) {
                    postMap.put("created_at_fmt", OffsetDateTime.parse(iso).format(outFmt));
                }

                if ("flagged".equals(filterType)) {
                    if (isActuallyFlagged) {
                        filteredList.add(postMap);
                    }
                } else {
                    filteredList.add(postMap);
                }
            }
            
            request.setAttribute("type", filterType); 
            request.setAttribute("questions", filteredList);
            
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/questions");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}