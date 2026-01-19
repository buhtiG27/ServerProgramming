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

public class UpdateTask extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public UpdateTask() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String rid = (String) request.getAttribute("rid");

        String taskId = request.getParameter("taskId");
        String content = request.getParameter("content");
        String limit = request.getParameter("limmit");
        String output = request.getParameter("output");
        String detail = request.getParameter("detailcontent");
        String weekday = request.getParameter("weekday");
        String time = request.getParameter("time");

        try {
            JSONObject json = new JSONObject();
            json.put("practice_name", request.getParameter("classneme")); 
            json.put("description", detail);
            json.put("place", output);
            json.put("contents_text", content);
            json.put("deadline", limit);

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            ApiResponse apires = api.putJson(request, "/tasks/" + taskId, json.toString());

            if (apires.is2xx()) {
                getServletContext().log("[rid=" + rid + "] Update success: " + taskId);
                response.sendRedirect(request.getContextPath() + "/tasks/view?taskId=" + taskId + "&weekday=" + weekday + "&time=" + time);
            } else {
                request.setAttribute("error", "課題の更新に失敗しました");
                request.getRequestDispatcher("/web_system/QA_26_EditTask.jsp").forward(request, response);
            }
        } catch (Exception e) {
            getServletContext().log("[rid=" + rid + "] UpdateTask error", e);
            request.setAttribute("error", "システムエラーが発生しました。");
            request.getRequestDispatcher("/web_system/QA_26_EditTask.jsp").forward(request, response);
        }
    }
}