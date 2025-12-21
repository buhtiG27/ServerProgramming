package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ===== パラメータ取得（1回だけ）=====
        String user = request.getParameter("Username");
        String pw = request.getParameter("Password");
        String email = request.getParameter("Address");
        String grade = request.getParameter("Grade");
        String cls = request.getParameter("Classification");
        
        
        // ===== 入力チェック =====
        String error = null;

        if (email == null || email.isBlank()) {
            error = "メールアドレスを入力してください。";
        } else if (!email.endsWith("@ms.dendai.ac.jp")) {
            error = "メールアドレスは @ms.dendai.ac.jp ドメインのみ使用可能です。";
        } else if (pw.length() < 8) {
            error = "パスワードは8文字以上必要です。";
        } else if (pw == null || pw.isBlank()) {
            error = "パスワードを入力してください。";
        } else if (!pw.matches(".*[A-Za-z].*")) {
            error = "パスワードには英字を1文字以上含めてください。";
        } else if (user == null || user.isBlank()) {
            error = "ユーザ名を入力してください。";
        } else if (grade == null || grade.isBlank()) {
            error = "学年を入力してください。";
        } else if (cls == null || cls.isBlank() || "0".equals(cls)) {
            error = "区分を選択してください。";
        }

        // ===== すべて attribute に詰める =====
        request.setAttribute("Password", pw);
        request.setAttribute("Username", user);
        request.setAttribute("Address", email);
        request.setAttribute("Grade", grade);
        request.setAttribute("Classification", cls);

        // ===== エラーあり → 入力画面へ =====
        if (error != null) {
            request.setAttribute("error", error);

            request.getRequestDispatcher("/web_system/QA_05_NewRegister.jsp")
                    .forward(request, response);
            return;
        }

        // ===== OK → 確認画面へ =====
        request.getRequestDispatcher("/web_system/QA_06_NewCheck.jsp")
                .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doPost(req, res);
    }
}