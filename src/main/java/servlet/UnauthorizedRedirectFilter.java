package servlet;

import java.io.IOException;

import client.UnauthorizedException;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UnauthorizedRedirectFilter implements Filter {
    @Override
    public void doFilter(ServletRequest sreq, ServletResponse sresp, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) sreq;
        HttpServletResponse resp = (HttpServletResponse) sresp;

        try {
            chain.doFilter(req, resp);
        } catch (UnauthorizedException e) {
            // 期限切れ扱い：セッション破棄 → /loginへ
            var session = req.getSession(false);
            if (session != null)
                session.invalidate();

            if (!resp.isCommitted()) {
                resp.sendRedirect(req.getContextPath() + "/login?expired=1");
                return;
            }
            // commit済みならredirect不可。ログだけ残して終了（500にしない）
            req.getServletContext().log("[UnauthorizedRedirectFilter] response already committed", e);
            return;
        }
    }
}
