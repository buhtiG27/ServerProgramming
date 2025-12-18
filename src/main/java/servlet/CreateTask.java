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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            URL url = new URL("http://localhost:8081/practice");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setDoOutput(true);

            JSONObject body = new JSONObject();
            body.put("subject_id", Integer.parseInt(subjectId));
            body.put("practice_name", practiceName);
            body.put("place", place);
            body.put("description", description);
            body.put("deadline", deadline);

            OutputStream os = con.getOutputStream();
            os.write(body.toString().getBytes("UTF-8"));
            os.flush();

            if (con.getResponseCode() == 200) {
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