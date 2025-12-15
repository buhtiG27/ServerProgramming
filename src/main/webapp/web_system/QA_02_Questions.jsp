<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>質問一覧画面</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/web_system/css/style_2_Question.css">
</head>
<body>

<div class="top_button">
    <h1>TDU</h1>
    <form action="" method="post">
        検索：
        <input class="txt" type="text" name="searchbyKeyword" size="20" />
    </form>
    <button class="button" type="submit" name="filterbyNew" value="send">新着</button>
    <button class="button" type="submit" name="filterbySameGrade" value="send">学科</button>
    <button class="button" type="submit" name="filterbyFlag" value="send">フラグ付き</button>
</div>

<br>

<div class="post-list">
    <%
	List<Map<String, Object>> questions =
    	(List<Map<String, Object>>) request.getAttribute("questions");
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
    <form action="<%= request.getContextPath() %>/ShowQuestion" method="get">
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

<div class="bottom_buttons">
    <form class="form" action="<%= request.getContextPath() %>/web_system/QA_02_Questions.jsp" method="get">
        <button class="pageButton" type="submit">質問一覧</button>
    </form>
    
    <form class="form" action="<%= request.getContextPath() %>/web_system/QA_03_MyTime.jsp" method="get">
        <button class="pageButton" type="submit">マイ時間割</button>
    </form>
    
    <form class="form" action="<%= request.getContextPath() %>/web_system/QA_04_User.jsp" method="get">
        <button class="pageButton" type="submit">ユーザ画面</button>
    </form>
</div>

</body>
</html>