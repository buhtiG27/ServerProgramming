<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>質問一覧画面</title>
<link rel="stylesheet" href="css/style_5_New.css">
</head>
<body>
	<div class="top_button">
		<%-- ボタンに置き換え --%>
		<h1>TDU</h1>
		<form action="Q&A_1_Login.jsp" method="get">
			<button class="button" type="submit" name="back" value="send">戻る</button>
		</form>
		<br>
		<a>新規ログイン</a>
		<br>
	</div>
	<div class="request_list">
	<form action="Q&A_6_NewCheck.jsp" method="get">
		<label for="email">メールアドレス：</label>
		<br>
		<input class="txt" type="text" size="20" value="" name="EmailAddress" />
		<br><br>
		<label for="pw">パスワード：</label>
		<br>
		<input class="txt" type="password" size="32" value="" name="Password" />
		<br><br>
		<label for="name">ユーザ名：</label>
		<br>
		<input class="txt" type="text" size="20" value="" name="Username" />
		<br><br>
		<label for="grade">学年・学科：</label>
		<br>
		<input class="txt" type="text" size="20" value="" name="GradeAndDepartment" />
		<br><br>
		<label for="class">区分：</label>
		<br>
		<input class="txt" type="text" size="20" value="" name="Classification" />
		<br><br>
		<button class="button1" type="submit" name="Login" value="send">確認</button>
	</form>
	</div>

</body>
</html>