package listener;

import client.ApiClient;
import config.AppConfig;
import config.ConfigLoader;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import config.AppConfig;
import config.ConfigLoader;

@WebListener
public class AppInitListener implements ServletContextListener {
    public static final String CFG_KEY = "APP_CONFIG";
    public static final String API_KEY = "API_CLIENT";

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        AppConfig cfg = ConfigLoader.loadFromEnv();
        sce.getServletContext().setAttribute(CFG_KEY, cfg);

        ApiClient api = new ApiClient(cfg.apiBaseUrl, cfg.apiConnectTimeoutMs, cfg.apiReadTimeoutMs,
                sce.getServletContext());
        sce.getServletContext().setAttribute(API_KEY, api);

        sce.getServletContext().log("[Init] API_BASE_URL=" + cfg.apiBaseUrl);
    }
}
