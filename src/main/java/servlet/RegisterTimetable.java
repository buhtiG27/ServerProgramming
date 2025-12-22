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

/**
 * Servlet implementation class RegisterTimetable
 */
public class RegisterTimetable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public RegisterTimetable() {
        super();
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String subjectId = request.getParameter("subjectId");
        // 本来はセッション等からユーザーIDを取得
        // String userId = (String) request.getSession().getAttribute("userId");

        try {
            JSONObject json = new JSONObject();
            json.put("subject_id", Long.parseLong(subjectId));
            // json.put("user_id", userId);

            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            // マイ時間割に紐付けるAPIを叩く（Go側のエンドポイントに合わせてください）
            ApiResponse apires = api.postJson(request, "/me/timetable", json.toString());

            if (apires.is2xx()) {
                // 登録成功後、03画面（マイ時間割）へリダイレクト
                response.sendRedirect(request.getContextPath() + "/timetable");
            } else {
            	getServletContext().log("API Error: " + apires.status + " Body: " + apires.body);
                // エラー時は一覧に戻すなど
                response.sendRedirect(request.getContextPath() + "/subjects?error=failed");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

}
