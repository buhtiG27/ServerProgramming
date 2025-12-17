package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import client.ApiClient;
import client.ApiResponse;
import config.AppConfig;
import listener.AppInitListener;

public class TimetableSearch extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rid = (String) request.getAttribute("rid");
        // getServletContext().log("[rid=" + rid + "] Login calling API /api/login"); //
        // API呼び出しをログに書き込む（任意）
        // ApiClient api = (ApiClient)
        // getServletContext().getAttribute(AppInitListener.API_KEY); // この行は基本固定
        // ApiResponse apires = api.postJson("/timetable", json.toString());

        response.setContentType("text/plain; charset=UTF-8");

        request.getRequestDispatcher("/web_system/QA_19_AllMyTime.jsp")
                .forward(request, response);
    }
}