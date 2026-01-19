<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %> 
<%
    request.setCharacterEncoding("UTF-8");
    String subId = request.getParameter("subjectId");
    String rawWeekday = request.getParameter("weekday");
    String rawTime = request.getParameter("time");

    String cls  = request.getParameter("classneme");
    String tea  = request.getParameter("teacher");
    String room = request.getParameter("roomname");

    String errorMessage = "";
    String actionType = request.getParameter("actionType"); 

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (!"correction".equals(actionType)) {
            // バリデーション
            if (cls == null || cls.isEmpty()) { errorMessage = "授業名を入力してください。"; }
            else if (tea == null || tea.isEmpty()) { errorMessage = "教員名を入力してください。"; }
            else if (room == null || room.isEmpty()) { errorMessage = "教室名を入力してください。"; } 

            if (errorMessage.isEmpty()) {
                String params = "?subjectId=" + subId
                + "&classneme=" + URLEncoder.encode(cls, "UTF-8")
                + "&teacher=" + URLEncoder.encode(tea, "UTF-8")
                + "&roomname=" + URLEncoder.encode(room, "UTF-8")
                + "&weekday=" + rawWeekday
                + "&time=" + rawTime;

                response.sendRedirect("QA_29_CheckEditSubject.jsp" + params);
                return;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>科目編集画面</title>
		        <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_28_EditSubject.css">
	</head>
	<body>
		<%-- トップボタン --%>
		<header>
			<jsp:include page="header.jsp" /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
		</header>
		
		<!-- 戻るボタンとタイトル -->
		<div class="header_area">
			<form action="${pageContext.request.contextPath}/subjects/detail" method="get">
			    <input type="hidden" name="subjectId" value="<%= subId %>" />
                <input type="hidden" name="weekday" value="<%= rawWeekday %>" />
                <input type="hidden" name="time" value="<%= rawTime %>" />
				<button class="back_button" type="submit" name="back" value="send">戻る</button>
			</form>
			
		</div>
		<h1 class="page_title">科目編集</h1>
		<% if (!errorMessage.isEmpty()) { %>
			<p style="color:red; font-weight:bold;"><%= errorMessage %></p>
		<% } %>

		<div class="view_list">
			<form action="" method="post">
			<input type="hidden" name="subjectId" value="<%= subId %>" />
    		<input type="hidden" name="weekday" value="<%= rawWeekday %>" />
    		<input type="hidden" name="time" value="<%= rawTime %>" />
				<div class="info_box">
					<label>授業名：</label>
					<input class="content_box" type="text" name="classneme" value="<%= (cls != null ? cls : "") %>"/>
					<label>教員名：</label>
					<input class="content_box" type="text" name="teacher" value="<%= (tea != null ? tea : "") %>"/>
					<label>教室：</label>
					<input class="content_box" type="text" name="roomname" value="<%= (room != null ? room : "") %>"/>
					<button class="save_button" type="submit">確認</button>
				</div>
			</form>
			
			<br>
		</div>
		
		<nav>
			<div class="bottom_button">
                <form class="form" action="${pageContext.request.contextPath}/questions" method="get">
                    <button class="pageButton toQuestions" type="submit">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_home.png" alt="(質問一覧だよ！)" class="icon_toQuestions">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_home_hukidashi.png" alt="(質問一覧だよ！)" class="icon_toQuestions_hukidashi">
                    </button>
                </form>
                <form class="form" action="${pageContext.request.contextPath}/timetable" method="get">
                    <button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_calender.png" alt="(マイ時間割へ)"></button>
                </form>
                <form class="form" action="${pageContext.request.contextPath}/user" method="get">
                    <button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_gear.png" alt="(ユーザ情報へ)"></button>
                </form>
            </div>
		</nav>
		
	</body>
</html>