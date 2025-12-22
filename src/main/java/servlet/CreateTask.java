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

    	// パラメータ取得
    	String practiceName = request.getParameter("content");
    	String place        = request.getParameter("output");
    	String description  = request.getParameter("detailcontent"); 
    	String deadline     = request.getParameter("limmit");
    	String subjectId    = request.getParameter("subjectId");
    	String classname    = request.getParameter("classname"); // 授業名
    	String weekday      = request.getParameter("weekday");   // "Thu" 等
    	String time         = request.getParameter("time");      // "1" 等
    	
    	String weekdayNum = "0"; // デフォルト
    	if (weekday != null) {
    	    switch (weekday) {
    	        case "Mon": weekdayNum = "0"; break;
    	        case "Tue": weekdayNum = "1"; break;
    	        case "Wed": weekdayNum = "2"; break;
    	        case "Thu": weekdayNum = "3"; break;
    	        case "Fri": weekdayNum = "4"; break;
    	        default: weekdayNum = weekday; // すでに数字ならそのまま
    	    }
    	}

    	// 日付補正（2025年に修正）
    	String formattedDeadline = deadline;
    	if (deadline != null && deadline.contains("/")) {
    	    String[] parts = deadline.split("/");
    	    formattedDeadline = String.format("2025-%02d-%02d", Integer.parseInt(parts[0]), Integer.parseInt(parts[1]));
    	}
    	String isoDeadline = formattedDeadline + "T00:00:00Z";

    	try {
    	    // Goの SubjectSetInput 構造体のタグ名に完全に合わせる
    		if (subjectId == null || subjectId.trim().isEmpty() || subjectId.equals("null")) {
    	        throw new Exception("科目IDが正しく取得できませんでした。");
    	    }

    	    JSONObject json = new JSONObject();
    	    // 数値変換の前にトリムする
    	    json.put("subject_id", Integer.parseInt(subjectId.trim()));
    	    json.put("practice_name", practiceName);
    	    json.put("place", place);
    	    json.put("description", description);
    	    json.put("deadline", isoDeadline);
    	    ApiClient api = (ApiClient) getServletContext().getAttribute(AppInitListener.API_KEY);
    	    ApiResponse apires = api.postJson(request, "/practice/set", json.toString());

    	    if (apires.is2xx()) {
    	        // 完了画面（Success）へリダイレクト（パラメータをURLに含める）
    	    	request.setAttribute("classname", classname);
    	        request.setAttribute("content", practiceName);
    	        request.setAttribute("limmit", deadline);
    	        request.setAttribute("output", place);
    	        request.setAttribute("detailcontent", description);
    	        request.setAttribute("completeMessage", "課題の登録が完了しました。");

    	        request.setAttribute("subjectId", subjectId);
    	        request.setAttribute("weekday", weekdayNum);
    	        request.setAttribute("time", time);

    	        request.getRequestDispatcher("/web_system/QA_25_CompleteTask.jsp").forward(request, response);
    	        return;
    	    } else {
    	        // エラー内容をログと画面に出力
    	    	getServletContext().log("[DEBUG] API Error: " + apires.body);
    	        request.setAttribute("error", "APIエラー: " + apires.body);
    	        // 元の確認画面に戻す
    	        request.getRequestDispatcher("/web_system/QA_24_CheckNewTask.jsp").forward(request, response);
    	    }
    	} catch (Exception e) {
    	    getServletContext().log("[DEBUG] Exception: ", e);
    	    request.setAttribute("error", "システムエラー: " + e.getMessage());
    	    request.getRequestDispatcher("/web_system/QA_24_CheckNewTask.jsp").forward(request, response);
    	}
    }
}