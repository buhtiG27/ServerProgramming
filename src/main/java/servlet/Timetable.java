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

public class Timetable extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = (String) request.getAttribute("rid");
        response.setContentType("text/plain; charset=UTF-8");
        // API呼び出しをログに書き込む（任意）
        // getServletContext().log("[rid=" + rid + "] Login calling API /api/login");
        // ApiClient api = (ApiClient)
        // getServletContext().getAttribute(AppInitListener.API_KEY); // この行は基本固定
        // ApiResponse apires = api.get(request, "/timetables");

        // JSONObject timetableJSON = new JSONObject(apires.body)

        request.getRequestDispatcher("/web_system/QA_03_MyTime.jsp")
                .forward(request, response);
    }
}
