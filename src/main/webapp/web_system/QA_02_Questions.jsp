X02Questions

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>質問一覧 | 電大生のQ&A</title>
		<%-- <%= request.getContextPath() %>/web_system/css/○○　このように書かないと反映されない --%>
		<link rel="icon" href="<%= request.getContextPath() %>/web_system/images/icon_qa.png" /><!-- ファビコン -->
		<link rel="stylesheet" href="<%= request.getContextPath() %>/web_system/css/style_2_Question.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
	</head>
	<body>

		<header>
			<jsp:include page="header.jsp" />
		</header>
		
		<main>
			<div class="filters">
				<form action="" method="post">：
        			<input class="txt" type="text" name="searchbyKeyword" size="20" />
    			</form>
    			<button class="button" type="submit" name="filterbyNew" value="send">新着</button>
    			<button class="button" type="submit" name="filterbySameGrade" value="send">学科</button>
    			<button class="button" type="submit" name="filterbyFlag" value="send">フラグ付き</button>
			</div>
			<div class="post-list">
    		<%
				List<Map<String, Object>> questions = (List<Map<String, Object>>) request.getAttribute("questions");
			%>
    		<%
				if (questions == null || questions.isEmpty()) {
			%>
    			<p style="color:gray;">投稿されている質問はありません</p>
			<%
				} else {
    				for (Map<String, Object> q : questions) {
						pageContext.setAttribute("q", q);
			%>
				<div class="post">
    				<form action="${pageContext.request.contextPath}/questions/show" method="get">
        				<input type="hidden" name="questionId" value="${q['id']}">
       					<button class="show_button" type="submit">
            			<%= q.get("title") %>
        				</button>
    				</form>

    				<p>ユーザ：${q['creator']['display_name']}</p>
					<p>${q['contents_text']}</p>
					<p>${q['created_at']}</p>

    				<div class="button-post">
        				<form action="${pageContext.request.contextPath}/LikeServlet" method="post">
            				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
            				<button class="like_button" type="submit">いいね</button>
        				</form>

        				<form action="${pageContext.request.contextPath}/FlagServlet" method="post">
            				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
           					<button class="like_button" type="submit">フラグ</button>
        				</form>
    				</div>
				</div>
			<%
    				}
				}
			%>
			<%
				Object limitObj = request.getAttribute("limit");
				Object offsetObj = request.getAttribute("offset");

				int limit  = (limitObj instanceof Integer) ? (Integer) limitObj : 20;
				int offset = (offsetObj instanceof Integer) ? (Integer) offsetObj : 0;

				int prev = Math.max(0, offset - limit);
				int next = offset + limit;
			%>

				<a href="<%= request.getContextPath() %>/questions?limit=<%= limit %>&offset=<%= prev %>">前へ</a>
				<a href="<%= request.getContextPath() %>/questions?limit=<%= limit %>&offset=<%= next %>">次へ</a>

			</div>

			<br><br>

			<form action="${pageContext.request.contextPath}/web_system/QA_12_CreateQuestion.jsp" method="get">
    			<button class="createbutton" type="submit">質問作成</button>
			</form>

			<br>
		</main>
	
		<nav>
			<div class="bottom_button">
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_02_Questions.jsp" method="get">
                    <button class="pageButton toQuestions" type="submit">
                        <img src="<%= request.getContextPath() %>/web_system/images/icon_home.png" alt="(質問一覧だよ！)" class="icon_toQuestions">
                        <img src="<%= request.getContextPath() %>/web_system/images/icon_home_hukidashi.png" alt="(質問一覧だよ！)" class="icon_toQuestions_hukidashi">
                    </button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_03_MyTime.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_calender.png" alt="(マイ時間割へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_04_User.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_gear.png" alt="(ユーザ情報へ)"></button>
                </form>
            </div>
		</nav>

	</body>
</html>