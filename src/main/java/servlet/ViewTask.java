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
import model.Task;

public class ViewTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        // 1. パラメータ取得（呼び出し元 JSP の name="taskId" に合わせる）
        String practiceId = request.getParameter("taskId");
        
        // 戻るボタンや科目名表示のために他のパラメータも取得しておく
        String classname = request.getParameter("classname");
        String weekday = request.getParameter("weekday");
        String time = request.getParameter("time");

        String destination = "/web_system/QA_13_ViewTask.jsp";

        if (practiceId == null || practiceId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/timetable");
            return;
        }

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            
            // 2. APIパスの修正（スラッシュを追加）
            ApiResponse apires = api.get(request, "/practices/" + practiceId);

            if (apires.is2xx()) {
                JSONObject json = new JSONObject(apires.body);
                // Go側が { "practice": { ... } } で返してくる想定
                JSONObject p = json.getJSONObject("practice");

                Task task = new Task();
                task.setId(p.getInt("ID")); // GoのGORMなら大文字の可能性あり
                task.setSubjectId(p.getInt("subject_id"));
                task.setContent(p.getString("practice_name"));
                task.setOutput(p.optString("place", "未設定"));
                task.setDetail(p.optString("description", "なし"));
                
                // 日付の整形（簡易版：TやZを除く）
                String rawDeadline = p.optString("deadline", "");
                task.setLimmit(rawDeadline.replace("T", " ").replace("Z", ""));

                // JSPへ渡す
                request.setAttribute("task", task);
                request.setAttribute("classname", classname);
                request.setAttribute("weekday", weekday);
                request.setAttribute("time", time);
            } else {
                request.setAttribute("error", "課題情報が見つかりませんでした");
            }

        } catch (Exception e) {
            getServletContext().log("ViewTask Error", e);
            request.setAttribute("error", "システムエラーが発生しました");
        }

        request.getRequestDispatcher(destination).forward(request, response);
    }
}