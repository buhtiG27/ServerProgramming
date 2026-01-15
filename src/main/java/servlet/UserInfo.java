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
            
            // 1. ログインユーザー自身の情報を取得
         // 1. ログインユーザー自身の情報を取得
            ApiResponse userRes = api.get(request, "/user");
            if (!userRes.is2xx()) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            JSONObject userResponseJSON = new JSONObject(userRes.body);

            // デバッグ用：実際にどのようなJSONが返ってきているかコンソールに出力して確認
            System.out.println("DEBUG User JSON: " + userResponseJSON.toString());

            // 「data」というキーの中にユーザー情報が入っている場合を考慮
            JSONObject userInfo;
            if (userResponseJSON.has("data")) {
                userInfo = userResponseJSON.getJSONObject("data");
            } else {
                userInfo = userResponseJSON;
            }

            // キーが存在するか確認してから取得する（エラー回避）
            int myId = 0;
            if (userInfo.has("id")) {
                myId = userInfo.getInt("id");
            } else {
                // idが見つからない場合の処理（エラーログを出すなど）
                getServletContext().log("Error: User ID not found in API response");
            }

            String name = userInfo.optString("display_name", "");
            String description = userInfo.optString("description", "");

            // 2. 全投稿を取得して自分のものだけフィルタリング
            ApiResponse postsRes = api.get(request, "/posts?limit=100"); // 必要に応じてlimit調整
            List<Map<String, Object>> myQuestions = new ArrayList<>();
            
            if (postsRes.is2xx()) {
                JSONObject postsJson = new JSONObject(postsRes.body);
                JSONArray posts = postsJson.getJSONArray("posts");
                DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

                for (int i = 0; i < posts.length(); i++) {
                    JSONObject postJSON = posts.getJSONObject(i);
                    JSONObject creatorJSON = postJSON.optJSONObject("creator");
                    
                    if (creatorJSON != null && creatorJSON.getInt("id") == myId) {
                        Map<String, Object> postMap = new HashMap<>();
                        postMap.put("id", postJSON.optInt("id"));
                        postMap.put("contents_text", postJSON.optString("contents_text"));
                        
                        // creator情報を個別にMapとして格納
                        Map<String, Object> creatorMap = new HashMap<>();
                        creatorMap.put("display_name", creatorJSON.optString("display_name"));
                        postMap.put("creator", creatorMap);

                        String iso = postJSON.optString("created_at");
                        if (iso != null && !iso.isEmpty()) {
                            postMap.put("created_at_fmt", OffsetDateTime.parse(iso).format(outFmt));
                        }
                        myQuestions.add(postMap);
                    }
                }
            }

            // JSPへ渡すデータをセット
            request.setAttribute("name", name);
            request.setAttribute("description", description);
            request.setAttribute("questions", myQuestions); // 自分の投稿リスト

            request.getRequestDispatcher("/web_system/QA_04_User.jsp").forward(request, response);

        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] UserInfo failed", e);
            throw new ServletException(e);
        }
    }
}