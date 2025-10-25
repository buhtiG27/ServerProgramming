<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>マイ時間割画面</title>
<link rel="stylesheet" href="style2.css">
</head>
<body>
<%--　ロゴに置き換える --%>
	<div class="top_button">
		<%-- ボタンに置き換え --%>>
		<h1>TDU</h1>
		<button class="button" type="submit" name="filterbyNew" value="send">科目削除</button>
		<button class="button" type="submit" name="filterbySameGrade" value="send">課題一覧</button>
	</div>
	<br>
	<%-- 置き換え --%>
	<div class="time-list">
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
						<form action="" method="post">
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
	<div class="bottom_buttons">
	<form class="form" action="Sample_Question.jsp" method="get">
		<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
	</form>
	<form class="form" action="" method="get">
		<button class="pageButton" type="submit" name="toTimetable">マイ時間割</button>
	</form>
	<form class="form" action="Sample_User.jsp" method="get">
		<button class="pageButton" type="submit" name="toUserInformation">ユーザ画面</button>
	</form>
	</div>

</body>
</html>