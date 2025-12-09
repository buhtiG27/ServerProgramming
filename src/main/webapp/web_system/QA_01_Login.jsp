<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>ログイン画面</title>
		<link rel="stylesheet" href="css/style_1_Login.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
	</head>
	<body align="center">
		
		<header>
			<jsp:include page="header.jsp" /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
		</header>

    	<div class="login_list">
        	<h1>ログイン</h1>
        	<br>

        	<%-- 登録完了メッセージ表示 --%>
        	<%
            	String message = request.getParameter("message");
            	if (message != null && !message.isEmpty()) {
        	%>
            	<p style="color:green; font-weight:bold;"><%= message %></p>
        	<%
            	}
        	%>

        	<%-- 入力フォーム --%>
        	<form action="QA_02_Questions.jsp" method="get">
            	<label for="name">ユーザ名：</label>
            	<input class="txt" type="text" size="20" name="Username" />
            	<br><br>
            	<label for="pw">パスワード：</label>
            	<input class="txt" type="password" size="32" name="Password" />
            	<br><br>
            	
            	<button class="login_button" type="submit" name="Login" value="send">LOG IN</button>
        	</form>
        	<br><br>
        	<form action="QA_05_NewRegister.jsp" method="get">
            	<button class="create_new_account_button" type="submit" name="Sign_Up" value="send">新規作成へ</button>
        	</form>
    	</div>

	</body>
</html>