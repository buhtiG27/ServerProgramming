package servlet;

import java.io.IOException;
import java.util.UUID;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class AccessLogFilter implements Filter {
    public static final String RID_ATTR = "rid";
    public static final String RID_HEADER = "X-Request-Id";

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String rid = request.getHeader(RID_HEADER);
        if (rid == null || rid.isBlank())
            rid = UUID.randomUUID().toString();

        request.setAttribute(RID_ATTR, rid);
        response.setHeader(RID_HEADER, rid);

        long start = System.currentTimeMillis();
        request.getServletContext().log("[rid=" + rid + "] -> " + request.getMethod() + " " + request.getRequestURI());

        try {
            chain.doFilter(req, res);
        } catch (Exception e) {
            request.getServletContext().log("[rid=" + rid + "] !! error", e);
            throw e;
        } finally {
            long ms = System.currentTimeMillis() - start;
            request.getServletContext().log(
                    "[rid=" + rid + "] <- " + request.getMethod() + " " + request.getRequestURI() + " " + ms + "ms");
        }
    }

}
