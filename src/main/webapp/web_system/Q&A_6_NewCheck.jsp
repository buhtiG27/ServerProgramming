<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>質問一覧画面</title>
<link rel="stylesheet" href="css/style_6_NewCheck.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
	//リクエスト・パラメータ取得
    String email = request.getParameter("EmailAddress");
    String pw = request.getParameter("Password");
    String user = request.getParameter("Username");
    String grade = request.getParameter("GradeAndDepartment");
    String classification = request.getParameter("Classification");

%>
	<div class="top_button">
		<%-- ボタンに置き換え --%>
		<h1>TDU</h1>
		<form action="Q&A_1_Login.jsp" method="get">
			<button class="button" type="submit" name="back" value="send">戻る</button>
		</form>
		<br>
		<a>登録内容確認</a>
		<br>
	</div>
	<div class="request_list">
		<br>
		<%
			//メアドのリクエスト表示
		 	out.print("メールアドレス：" + email + "<br />");
		%>
		<br>
		<br>
		<%
		 	//PWのリクエスト表示
			out.print("パスワード：" + pw + "<br />");
		%>
		<br>
		<br>
		<%
			//ユーザ名のリクエスト表示
			out.print("ユーザ名：" + user + "<br />");
		%>
		<br>
		<br>
		<%
		 	//学年・学科のリクエスト表示
		 	out.print("学年・学科：" + grade + "<br />");
		%>
		<br>
		<br>
		<%
		 	//区分のリクエスト表示
		 	out.print("区分：" + classification + "<br />");
		%>
		<br><br>
		<div class="bottom_buttons">
			<form class="form" action="Q&A_5_New.jsp" method="get" style="display:inline-flex;">
				<button class="correctButton" type="submit" name="correct">訂正</button>
			</form>
			<form class="form" action="Q&A_1_Login.jsp" method="get" style="display:inline-flex;">
				<button class="registerButton" type="submit" name="register">登録</button>
			</form>
		</div>
	</div>

</body>
</html>