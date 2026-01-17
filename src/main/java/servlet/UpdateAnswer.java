package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateAnswer") 
public class UpdateAnswer extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public UpdateAnswer() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	this.doPost(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        // 書き換え
        String classname = request.getParameter("classname");
        String teacher = request.getParameter("teacher");
        String roomname = request.getParameter("roomname");



        boolean result = false;

        try {
        	

            request.setAttribute("subject", null);
        } catch (Exception e) {
            e.printStackTrace();
            // データベースエラー時のメッセージ
            request.setAttribute("error", "システムエラーが発生しました。時間をおいて再度お試しください。");
            // DBエラー時もclassnameを付与して編集画面に戻る
            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp?classname=" + classname).forward(request, response);
            return; // 処理を中断
        }
        if (result) {
        	// 更新成功時は詳細画面へリダイレクト
        	response.sendRedirect(request.getContextPath() + "/ShowQuestion?classname=" + classname);
        	return;
        } else {
            request.setAttribute("error", "更新に失敗しました");
            // 更新失敗時はエラーメッセージをセットして、編集画面へフォワード
            request.getRequestDispatcher("/web_system/QA_10_ShowQuestion.jsp?classname=" + classname).forward(request, response);
        }
    }
}
