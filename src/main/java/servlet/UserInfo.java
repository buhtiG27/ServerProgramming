package servlet;
import java.io.IOException;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
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

public class UserInfo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");
        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            
            // 1. ユーザー自身の情報を取得 (/user)
            ApiResponse userRes = api.get(request, "/user");
            if (!userRes.is2xx()) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            JSONObject userResponseJSON = new JSONObject(userRes.body);
            JSONObject userInfo = userResponseJSON.has("data") ? userResponseJSON.getJSONObject("data") : userResponseJSON;

            String name = userInfo.optString("display_name", "");
            String description = userInfo.optString("description", "");
            String department = userInfo.optString("department", ""); 

            // 2. 「自分の投稿一覧」を専用エンドポイントから取得 (/user/posts)
            // Go側の controllers.GetUserPosts が対応します
            ApiResponse postsRes = api.get(request, "/user/posts"); 
            List<Map<String, Object>> myQuestions = new ArrayList<>();
            
            if (postsRes.is2xx()) {
                JSONObject postsJson = new JSONObject(postsRes.body);
                // Go側のレスポンスキー "usersPost" に合わせる
                JSONArray posts = postsJson.optJSONArray("usersPost");
                
                if (posts != null) {
                    DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

                    for (int i = 0; i < posts.length(); i++) {
                        JSONObject postJSON = posts.getJSONObject(i);
                        Map<String, Object> postMap = new HashMap<>();
                        
                        postMap.put("id", postJSON.optInt("id"));
                        postMap.put("contents_text", postJSON.optString("contents_text"));
                        if (!postJSON.isNull("parent")) {
                            JSONObject parentJSON = postJSON.getJSONObject("parent");
                            Map<String, Object> parentMap = new HashMap<>();
                            parentMap.put("contents_text", parentJSON.optString("contents_text"));
                            
                            // 親投稿の作成者情報がある場合
                            if (!parentJSON.isNull("creator")) {
                                parentMap.put("creator_name", parentJSON.getJSONObject("creator").optString("display_name"));
                            }
                            postMap.put("parent", parentMap);
                        }
                        // 作成日時フォーマット (created_at)
                        String iso = postJSON.optString("created_at");
                        if (iso != null && !iso.isEmpty()) {
                            try {
                                postMap.put("created_at_fmt", OffsetDateTime.parse(iso).format(outFmt));
                            } catch (Exception e) {
                                postMap.put("created_at_fmt", iso);
                            }
                        }
                        myQuestions.add(postMap);
                    }
                }
            }

            // JSPへデータをセット
            request.setAttribute("name", name);
            request.setAttribute("description", description);
            request.setAttribute("department", department);
            request.setAttribute("questions", myQuestions); // 自分の投稿のみが入ったリスト

            request.getRequestDispatcher("/web_system/QA_04_User.jsp").forward(request, response);

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] UserInfo failed", e);
            throw new ServletException(e);
        }
    }
}