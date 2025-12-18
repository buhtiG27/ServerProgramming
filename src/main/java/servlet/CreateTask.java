package servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CreateTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CreateTask() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);
    }

    @SuppressWarnings("deprecation")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String practiceName = request.getParameter("content");
        String place = request.getParameter("output");
        String description = request.getParameter("detail");
        String deadline = request.getParameter("limmit");
        String subjectId = request.getParameter("subjectId");

        try {
            JSONObject json = new JSONObject();
            json.put("subject_id", Integer.parseInt(subjectId));
            json.put("practice_name", practiceName);
            json.put("place", place);
            json.put("description", description);
            json.put("deadline", deadline);

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);

            getServletContext().log("[rid=" + rid + "] Call API POST /posts");

            ApiResponse apires = api.postJson(request, "/practices", json.toString());

            if (apires.is2xx()) {
                request.getRequestDispatcher("/web_system/QA_25_CompleteTask.jsp")
                        .forward(request, response);
            } else {
                request.setAttribute("error", "課題作成に失敗しました");
                request.getRequestDispatcher("/web_system/QA_24_CheckNewTask.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "システムエラーが発生しました");
            request.getRequestDispatcher("/web_system/QA_24_CheckNewTask.jsp")
                    .forward(request, response);
        }
    }
}