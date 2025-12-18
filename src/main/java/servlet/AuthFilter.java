package servlet;

import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest sreq, ServletResponse sresp, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) sreq;
        HttpServletResponse resp = (HttpServletResponse) sresp;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // ログイン不要の例外
        if (path.equals("/health") || path.equals("/register") || path.equals("/login")
                || path.startsWith("/web_system/css/")
                || path.startsWith("/web_system/images/")) {
            chain.doFilter(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        String token = (session == null) ? null : (String) session.getAttribute("token");

        if (token == null || token.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 下流のServletが使いやすいようにリクエストに載せる
        req.setAttribute("token", token);

        chain.doFilter(req, resp);
    }
}
