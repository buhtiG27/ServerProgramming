<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>

<%
    request.setCharacterEncoding("UTF-8");

    String taskId = request.getParameter("taskId");
    String weekday = request.getParameter("weekday");
    String time = request.getParameter("time");

    String cls    = request.getParameter("classneme"); 
    String con    = request.getParameter("content");
    String lim    = request.getParameter("limmit");
    String output = request.getParameter("output");
    String detail = request.getParameter("detailcontent");

    String errorMessage = "";
    String actionType = request.getParameter("actionType");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (!"correction".equals(actionType)) {
            if (cls == null || cls.isEmpty()) { errorMessage = "授業名を入力してください。"; }
            else if (con == null || con.isEmpty()) { errorMessage = "内容を入力してください。"; }
            else if (lim == null || lim.isEmpty()) { errorMessage = "期限を入力してください。"; }
            else if (output == null || output.isEmpty()) { errorMessage = "提出場所を入力してください。"; }
            else if (detail == null || detail.isEmpty()) { errorMessage = "補足説明を入力してください。"; }

            if (errorMessage.isEmpty()) {
                String params = "?taskId=" + taskId 
                              + "&weekday=" + weekday 
                              + "&time=" + time
                              + "&classneme=" + URLEncoder.encode(cls, "UTF-8")
                              + "&content=" + URLEncoder.encode(con, "UTF-8")
                              + "&limmit=" + URLEncoder.encode(lim, "UTF-8")
                              + "&output=" + URLEncoder.encode(output, "UTF-8")
                              + "&detailcontent=" + URLEncoder.encode(detail, "UTF-8");

                response.sendRedirect("QA_27_CheckEditTask.jsp" + params);
                return;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>課題編集画面</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_26_EditTask.css" />
    </head>
    <body>
        <header><jsp:include page="header.jsp" /></header>
		<div class="header_area">
        <form action="${pageContext.request.contextPath}/tasks/view" method="get">
            <input type="hidden" name="taskId" value="<%= taskId %>">
            <input type="hidden" name="weekday" value="<%= weekday %>">
            <input type="hidden" name="time" value="<%= time %>">
            <button class="back_button" type="submit">戻る</button>
        </form>
		</div>
        <h1 class="page_title">課題編集</h1>

        <div class="view_list">
            <div class="info_box">
                <form action="" method="post">
                    <input type="hidden" name="taskId" value="<%= taskId %>">
                    <input type="hidden" name="weekday" value="<%= weekday %>">
                    <input type="hidden" name="time" value="<%= time %>">

                    <label>授業名：</label><br />
                    <input class="content_box" type="text" name="classneme" value="<%= (cls != null ? cls : "") %>"><br /><br />

                    <label>内容：</label><br />
                    <input class="content_box" type="text" name="content" value="<%= (con != null ? con : "") %>"><br /><br />

                    <label>期限：</label><br />
                    <input class="content_box" type="text" name="limmit" value="<%= (lim != null ? lim : "") %>"><br /><br />

                    <label>提出場所：</label><br />
                    <input class="content_box" type="text" name="output" value="<%= (output != null ? output : "") %>"><br /><br />

                    <label>補足説明：</label><br />
                    <input class="textarea_box" type="text" name="detailcontent" value="<%= (detail != null ? detail : "") %>"><br /><br />

                    <button class="regist_button" type="submit">確認</button>
                </form>
            </div>
        </div>

	<nav>
    	<div class="bottom_button">
        	<form class="form" action="${pageContext.request.contextPath}/questions" method="get">
            	<button class="pageButton toQuestions" type="submit">
                	<img src="${pageContext.request.contextPath}/web_system/images/icon_home.png" alt="(質問一覧)" class="icon_toQuestions">
                	<img src="${pageContext.request.contextPath}/web_system/images/icon_home_hukidashi.png" alt="(質問一覧)" class="icon_toQuestions_hukidashi">
            	</button>
        	</form>
        	<form class="form" action="${pageContext.request.contextPath}/timetable" method="get">
            	<button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_calender.png" alt="(マイ時間割)"></button>
        	</form>
        	<form class="form" action="${pageContext.request.contextPath}/user" method="get">
            	<button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_gear.png" alt="(ユーザ情報)"></button>
        	</form>
    	</div>
	</nav>
    </body>
</html>
