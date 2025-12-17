02Questions

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>質問一覧画面</title>
		<%-- <%= request.getContextPath() %>/web_system/css/○○　このように書かないと反映されない --%>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/web_system/css/style_2_Question.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
	</head>
	<body>

		<header>
			<jsp:include page="header.jsp" /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
		</header>
		
		<main>
			<div class="filters">
				<form action="" method="post">検索：
        			<input class="txt" type="text" name="searchbyKeyword" size="20" />
    			</form>
    			<button class="button" type="submit" name="filterbyNew" value="send">新着</button>
    			<button class="button" type="submit" name="filterbySameGrade" value="send">学科</button>
    			<button class="button" type="submit" name="filterbyFlag" value="send">フラグ付き</button>
			</div>
			<div class="post-list">
    		<%
				List<Map<String, Object>> questions =(List<Map<String, Object>>) request.getAttribute("questions");
			%>
    		<%
				if (questions == null || questions.isEmpty()) {
			%>
    			<p style="color:gray;">投稿されている質問はありません</p>
			<%
				} else {
    				for (Map<String, Object> q : questions) {
			%>
				<div class="post">
    				<form action="<%= request.getContextPath() %>/questions/show" method="get">
        				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
       					<button class="show_button" type="submit">
            			<%= q.get("title") %>
        				</button>
    				</form>

    				<p>担当教員：<%= q.get("teacher") %></p>

    				<div class="button-post">
        				<form action="<%= request.getContextPath() %>/LikeServlet" method="post">
            				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
            				<button class="like_button" type="submit">いいね</button>
        				</form>

        				<form action="<%= request.getContextPath() %>/FlagServlet" method="post">
            				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
           					<button class="like_button" type="submit">フラグ</button>
        				</form>
    				</div>
				</div>
			<%
    				}
				}
			%>
			</div>

			<br><br>

			<form action="<%= request.getContextPath() %>/web_system/QA_12_CreateQuestion.jsp" method="get">
    			<button class="createbutton" type="submit">質問作成</button>
			</form>

			<br>
		</main>
	
		<nav>
			<jsp:include page="navigation.jsp" />
		</nav>

	</body>
</html>