<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>ログイン画面</title>
<link rel="stylesheet" href="style.css">
</head>
<body align = center>
	<h1>ログイン</h1>
	<br>
	<%-- 入力フォーム --%>
	<%-- form action="sendto.jsp" method="get" --%>
	<form action="Sample_Question.jsp" method="get">
		<label for="name">ユーザ名：</label>
		<input class="txt" type="text" size="20" value="" name="Username" />
		<br><br>
		<label for="pw">パスワード：</label>
		<input class="txt" type="password" size="32" value="" name="Password" />
		<br><br>
		<button class="button1" type="submit" name="Login" value="send">LOG IN</button>
		
</form>
<br><br>
<button class="botton2" type="submit" name="Sign_Up" value="send">新規作成へ</button>
</body>
</html>