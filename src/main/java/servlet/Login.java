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

        Member member = new Member();
        member.setUsername(request.getParameter("Username"));
        member.setPassword(request.getParameter("Password"));

        MemberDAO dao = new MemberDAO();
        boolean result = false;

        try {
            result = dao.check(member);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (result) {
        	request.getSession().setAttribute("loginUser", member);
        	request.getRequestDispatcher("/web_system/QA_02_Questions.jsp").forward(request, response); 
        	} else {
            // ログイン失敗
            request.setAttribute("error", "ユーザ名またはパスワードが違います");
            request.getRequestDispatcher("/web_system/QA_1_Login.jsp").forward(request, response);
        }
    }
}