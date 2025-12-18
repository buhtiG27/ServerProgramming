package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Subject;

@WebServlet("/DetailSubject")
public class DetailSubject extends HttpServlet {

    @SuppressWarnings("deprecation")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String classname = request.getParameter("classname");

        try {
            String query = "?subject_name=" + URLEncoder.encode(classname, "UTF-8");
            getServletContext().log("[rid=" + rid + "] DetailSubject calling API /api/subjects"); // API呼び出しをログに書き込む（任意）
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY); // この行は基本固定
            ApiResponse apires = api.get(request, "/subjects" + query); // api.getかapi.postJsonを入れる

            if (!apires.is2xx()) {
                // TODO:アクセス失敗時処理
                throw new IOException("Go API error");
            }

            JSONObject json = new JSONObject(apires.body);
            JSONObject o = json.getJSONArray("subjects").getJSONObject(0);

            Subject subject = new Subject();
            subject.setSubjectName(o.getString("subject_name"));
            subject.setTeacher(o.optString("teacher"));
            subject.setClassRoom(o.optString("class_room"));
            request.setAttribute("subject", subject);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "科目情報の取得に失敗しました");
        }

        request.getRequestDispatcher("/web_system/QA_21_DetailSubject.jsp")
                .forward(request, response);
    }
}