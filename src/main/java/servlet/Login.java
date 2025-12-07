package servlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Member;
import model.MemberDAO;

@WebServlet("/WSP/Login") 
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("Username");
        String password = request.getParameter("Password");

        // ★ 改善: 未入力チェック
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "ユーザ名とパスワードを入力してください");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp").forward(request, response);
            return;
        }

        Member member = new Member();
        member.setUsername(username);
        member.setPassword(password);

        MemberDAO dao = new MemberDAO();
        boolean result = false;

        try {
            result = dao.check(member);
        } catch (SQLException e) {
            e.printStackTrace();
            // ★ 改善: データベースエラー時のメッセージ
            request.setAttribute("error", "システムエラーが発生しました。時間をおいて再度お試しください。");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp").forward(request, response);
            return; // 処理を中断
        }

        if (result) {
        	// ログイン成功
        	request.getSession().setAttribute("loginUser", member);
        	request.getRequestDispatcher("/web_system/QA_02_Questions.jsp").forward(request, response); 
        	} else {
            // ログイン失敗
            request.setAttribute("error", "ユーザ名またはパスワードが違います");
            request.getRequestDispatcher("/web_system/QA_01_Login.jsp").forward(request, response);
        }
    }
}