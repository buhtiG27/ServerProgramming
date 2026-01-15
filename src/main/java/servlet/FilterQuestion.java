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
        
        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            
            // 1. ログインユーザーの情報を取得
            ApiResponse userRes = api.get(request, "/user");
            JSONObject userJson = new JSONObject(userRes.body);
            String userDept = userJson.optString("department", ""); 

            // 2. 全投稿を取得
            ApiResponse postsRes = api.get(request, "/posts?limit=100"); 
            JSONObject postsJson = new JSONObject(postsRes.body);
            JSONArray posts = postsJson.getJSONArray("posts");

            List<Map<String, Object>> filteredList = new ArrayList<>();
            DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

            for (int i = 0; i < posts.length(); i++) {
                JSONObject postJSON = posts.getJSONObject(i);
                
                JSONObject creator = postJSON.optJSONObject("creator");
                String postDept = (creator != null) ? creator.optString("department", "") : "";

                // 学科が一致する場合のみリストに追加
                if ("department".equals(filterType)) {
                    if (userDept.equals(postDept) && !userDept.isEmpty()) {
                        Map<String, Object> postMap = postJSON.toMap();
                        String iso = (String) postMap.get("created_at");
                        if (iso != null) {
                            postMap.put("created_at_fmt", OffsetDateTime.parse(iso).format(outFmt));
                        }
                        filteredList.add(postMap);
                    }
                }
            }

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