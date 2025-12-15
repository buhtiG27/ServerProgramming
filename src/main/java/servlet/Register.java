package servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import client.ApiClient;
import client.ApiResponse;
import config.AppConfig;
import listener.AppInitListener;

@WebServlet("/Register")
@SuppressWarnings("deprecation")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");
        request.setCharacterEncoding("UTF-8");
        
        String user = request.getParameter("Username");
        String pw = request.getParameter("Password");
        String email = request.getParameter("Address");
        String gradeStr = request.getParameter("Grade");
        String clsStr = request.getParameter("Classification");
        
        if (user == null || pw == null || email == null
                || gradeStr == null || clsStr == null) {

            request.setAttribute("error", "登録情報が失われました。もう一度やり直してください。");
            request.getRequestDispatcher("/web_system/QA_05_NewRegister.jsp")
                   .forward(request, response);
            return;
        }

        int grade;
        int cls;

        try {
            grade = Integer.parseInt(gradeStr);
            cls = Integer.parseInt(clsStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "学年または区分の形式が不正です。");
            request.getRequestDispatcher("/web_system/QA_05_NewRegister.jsp")
                   .forward(request, response);
            return;
        }
        
        // 確認画面からの値取得
        JSONObject json = new JSONObject();
     
        json.put("user_id", user);
        json.put("password", pw);
        json.put("email", email);
        json.put("display_name", user);
        json.put("grade", grade);
        json.put("classification", cls);

        try {
            ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
            ApiResponse res = api.postJson("/register", json.toString());

            if (res.is2xx()) {
                request.getRequestDispatcher("/web_system/QA_01_Login.jsp")
                        .forward(request, response);
            } else {
                request.setAttribute("error", "登録に失敗しました");
                request.getRequestDispatcher("/web_system/QA_06_NewCheck.jsp")
                        .forward(request, response);
            }
        } catch (Exception e) {
            // TODO:
            getServletContext().log("[Register] failed", e);
            throw new ServletException(e);
=======



        }
    }
}