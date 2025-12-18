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
            String apiUrl = "http://localhost:8080/subjects?subject_name="
                    + URLEncoder.encode(classname, "UTF-8");

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            br.close();

            JSONObject json = new JSONObject(sb.toString());
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