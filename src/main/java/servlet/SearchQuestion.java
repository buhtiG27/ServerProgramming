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

public class SearchQuestion extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SearchQuestion() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String rid = (String) request.getAttribute("rid");
        request.setCharacterEncoding("UTF-8");

        // 1. パラメータの取得（キーワードを追加）
        String limitStr = request.getParameter("limit");
        String offsetStr = request.getParameter("offset");
        String keyword = request.getParameter("searchbyKeyword");

        int limit = 20;
        int offset = 0;

        try {
            if (limitStr != null)
                limit = Integer.parseInt(limitStr);
            if (offsetStr != null)
                offset = Integer.parseInt(offsetStr);
        } catch (NumberFormatException ignore) {
        }

        // 安全ガード（超重要）
        if (limit < 1)
            limit = 20;
        if (limit > 100)
            limit = 100;
        if (offset < 0)
            offset = 0;

        // 2. クエリ文字列の構築
        StringBuilder query = new StringBuilder();
        query.append("?limit=").append(limit).append("&offset=").append(offset);

        // キーワードが入力されている場合、APIの検索用パラメータ（例: q）に渡す
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append("&q=").append(java.net.URLEncoder.encode(keyword, "UTF-8"));
        }
        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log("[rid=" + rid + "] Call API GET /posts");

            // 認証付き GET
            ApiResponse apires = api.get(request, "/posts" + query);

            if (!apires.is2xx()) {
                request.setAttribute("error", "質問の取得に失敗しました");
                request.getRequestDispatcher("/web_system/QA_11_SearchQuestion.jsp")
                        .forward(request, response);
                return;
            }

            JSONObject json = new JSONObject(apires.body);
            JSONArray posts = json.getJSONArray("posts");

            DateTimeFormatter outFmt = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

            List<Map<String, Object>> questions = new ArrayList<>();
            for (int i = 0; i < posts.length(); i++) {
                JSONObject postJSON = posts.getJSONObject(i);
                
                // 1. 投稿内容 (contents_text) を取得
                String contentsText = postJSON.optString("contents_text", "");
                boolean isMatch = true;
                if (keyword != null && !keyword.trim().isEmpty()) {
                    // 大文字小文字を区別せずに検索したい場合は toLowerCase() を使う
                    if (!contentsText.contains(keyword)) {
                        isMatch = false; 
                    }
                }

                if (isMatch) {
                    Map<String, Object> postMap = postJSON.toMap();
                    String iso = (String) postMap.get("created_at");
                    if (iso != null) {
                        OffsetDateTime odt = OffsetDateTime.parse(iso);
                        postMap.put("created_at_fmt", odt.format(outFmt));
                    }
                    questions.add(postMap);
                }
            }

            request.setAttribute("questions", questions);
            request.setAttribute("limit", limit);
            request.setAttribute("offset", offset);
            request.setAttribute("keyword", keyword);

            String targetJsp;
            if (keyword != null && !keyword.trim().isEmpty()) {
                // キーワードがあれば「11: 検索結果画面」へ
                targetJsp = "/web_system/QA_11_SearchQuestion.jsp";
            } else {
                // キーワードがなければ「02: 通常の一覧画面」へ
                targetJsp = "/web_system/QA_02_Questions.jsp";
            }
            
            request.getRequestDispatcher(targetJsp).forward(request, response);
        } catch (Exception e) {
        	getServletContext().log("Search error", e);
            request.getRequestDispatcher("/web_system/QA_11_SearchQuestion.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}