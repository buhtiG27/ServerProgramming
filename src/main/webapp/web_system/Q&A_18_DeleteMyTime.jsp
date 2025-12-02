<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>マイ時間割削除画面</title>
<link rel="stylesheet" href="css/style_18_DeleteMyTime.css">
</head>
<body>
<%--　ロゴに置き換える --%>
	<div class="top_button_area">
		<form action="Q&A_2_Question.jsp" method="get">
			<button class="top_button" type="submit" name="back" value="send">TDU</button>
		</form>
	</div>
	<div class="header_area">
		<form action="Q&A_3_MyTime.jsp" method="get">
			<button class="cancel_button" type="submit" name="filterbyNew" value="send">キャンセル</button>
		</form>
		<h2>科目削除</h2>
		<form action="Q&A_3_MyTime.jsp" method="get">
			<button class="save_button" type="submit" name="filterbySameGrade" value="send">変更保存</button>
		</form>
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
 						<div class="cell-container">
        					<form class="delete-form" action="" method="post">
            					<input type="hidden" name="deleteSubject" />
            					<button class="deleteButton" type="submit">×</button>
        					</form>

        					<form action="" method="post">
            					<input type="hidden" name="searchSubject" />
            					<input type="hidden" name="showRegisteredSubject" />
            					<button class="displayButton" type="submit">登録/表示</button>
        					</form>
    					</div>
					</td>
			<% 	} %>
		</tr>
		<% } %>
	</table>
	</div>
	<br>
	<br>
	<div class="bottom_buttons">
	<form class="form" action="Q&A_2_Question.jsp" method="get">
		<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
	</form>
	<form class="form" action="" method="get">
		<button class="pageButton" type="submit" name="toTimetable">マイ時間割</button>
	</form>
	<form class="form" action="Q&A_4_User.jsp" method="get">
		<button class="pageButton" type="submit" name="toUserInformation">ユーザ画面</button>
	</form>
	</div>

</body>
</html>