<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>マイ時間割画面</title>
		<link rel="stylesheet" href="css/style_3_MyTime.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
	</head>
	<body>
		<header>
			<jsp:include page="header.jsp" /><!-- ヘッダ -->
		</header>
		
		<div class="header_area">
			<form action="QA_18_DeleteMyTime.jsp" method="get">
				<button class="delete_button" type="submit" name="filterbyNew" value="send">科目削除</button>
			</form>
			<h2>マイ時間割</h2>
			<form action="QA_17_AllTask.jsp" method="get"> 
				<button class="task_button" type="submit" name="filterbySameGrade" value="send">課題一覧</button>
			</form>
		
		</div>
		<%-- 置き換え --%>
		<div class="time-list">
		<%
            	String message = request.getParameter("message");
            	if (message != null && !message.isEmpty()) {
       		%>
            	<p style="color:green; font-weight:bold;"><%= message %></p>
        	<%
            	}
        	%>
		<table>
			<tr>
			<%String[] days = {" ","月","火","水","木","金","土"};%>
			<% for (int d = 0; d < 7; d++) { %>
            	<th><%= days[d] %></th>
        	<% } %>
        	</tr>
			<% 
				for(int i = 1; i < 9; i++){ 
			%>
			<tr>
				<th><%= i%>限</th>
				<% for(int j = 0; j < 6; j++){ %>
						<td>
							<form action="QA_19_AllMyTime.jsp" method="post">
								<input type="hidden" name="searchSubject" />
								<input type="hidden" name="showRegisteredSubject" />
								<button class="displayButton" type="submit">
									<%= "登録/表示"  %>
								</button>
							</form>
						</td>
				<% 	} %>
			</tr>
			<% } %>
		</table>
		</div>
		<br>
		<br>
		
		<nav>
			<jsp:include page="navigation.jsp" />
		</nav>

	</body>
</html>