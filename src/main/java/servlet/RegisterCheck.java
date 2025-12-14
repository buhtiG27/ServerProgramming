package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("Address");
        String pw = request.getParameter("Password");
        String uname = request.getParameter("Username");
        String grade = request.getParameter("Grade");
        String cls = request.getParameter("Classification");

        // 入力チェック
        String error = null;

        if (email == null || email.isEmpty()) {
            error = "メールアドレスを入力してください。";
        } else if (!email.endsWith("@ms.dendai.ac.jp")) {
            error = "メールアドレスは @ms.dendai.ac.jp ドメインでなければなりません。";
        } else if (pw == null || pw.isEmpty()) {
            error = "パスワードを入力してください。";
        } else if (!pw.matches(".*[A-Za-z].*")) {
            // パスワードに英字が含まれているか
            error = "パスワードには少なくとも1文字の英字を含めてください。";
        } else if (uname == null || uname.isEmpty()) {
            error = "ユーザ名を入力してください。";
        } else if (grade == null || grade.isEmpty()) {
            error = "学年・学科を入力してください。";
        } else if (cls == null || cls.isEmpty() || "0".equals(cls)) {
            error = "区分を選択してください。";
        }

        if (error != null) {
            request.setAttribute("error", error);

            // 入力値を戻す
            request.setAttribute("Address", email);
            request.setAttribute("Username", uname);
            request.setAttribute("Grade", grade);
            request.setAttribute("Classification", cls);

            request.getRequestDispatcher("/web_system/QA_05_NewRegister.jsp")
                    .forward(request, response);
            return;
        }

        // OK → 確認画面へ
        request.setAttribute("Address", email);
        request.setAttribute("Password", pw);
        request.setAttribute("Username", uname);
        request.setAttribute("Grade", grade);
        request.setAttribute("Classification", cls);

        request.getRequestDispatcher("/web_system/QA_06_NewCheck.jsp")
                .forward(request, response);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}