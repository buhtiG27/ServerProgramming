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
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
	</head>
	<body>

		<header>
			<jsp:include page="header.jsp" />
		</header>
		
		<main>
			<div class="searchbyKeyword">
				<form action="" method="post">
        			<input class="txt" type="text" name="searchbyKeyword" size="20" placeholder="質問を検索">
					<span class="fa-solid fa-magnifying-glass"></span><!-- Font Awesomeの虫眼鏡アイコンを使用 -->
    			</form>
			</div>
			<div class="filters">
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
    				<form action="${pageContext.request.contextPath}/questions/show" method="get">
        				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
       					<button class="show_button" type="submit">
            			<%= q.get("title") %>
        				</button>
    				</form>

    				<p>担当教員：<%= q.get("teacher") %></p>

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