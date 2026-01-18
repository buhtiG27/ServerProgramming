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
            
            // 全投稿を取得
            ApiResponse postsRes = api.get(request, "/posts?limit=100"); 
            JSONObject postsJson = new JSONObject(postsRes.body);
            JSONArray posts = postsJson.getJSONArray("posts");

            List<Map<String, Object>> filteredList = new ArrayList<>();
            DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

            for (int i = 0; i < posts.length(); i++) {
                JSONObject postJSON = posts.getJSONObject(i);

                // trueの場合、リストに追加
                if ("flagged".equals(filterType)) {
                    if (postJSON.optBoolean("is_flagged", false)) {
                        addPostToList(postJSON, filteredList, outFmt);
                    }
                }
            }
            
            request.setAttribute("type", filterType); 
            request.setAttribute("questions", filteredList); // JSP側が "${questions}" で受けている場合
            request.setAttribute("isFilterMode", true);
            
            request.getRequestDispatcher("/web_system/QA_02_Questions.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/questions");
        }
    }
    private void addPostToList(JSONObject postJSON, List<Map<String, Object>> list, DateTimeFormatter fmt) {
        Map<String, Object> postMap = postJSON.toMap();
        String iso = (String) postMap.get("created_at");
        if (iso != null) {
            postMap.put("created_at_fmt", OffsetDateTime.parse(iso).format(fmt));
        }
        list.add(postMap);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}