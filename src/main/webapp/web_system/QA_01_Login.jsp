<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>ログイン画面</title>
<link rel="stylesheet" href="css/style_1_Login.css">
</head>
<body align="center">

    <div class="top_button">
        <h1>TDU</h1>
    </div>

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
            <button class="button1" type="submit" name="Login" value="send">LOG IN</button>
        </form>

        <br><br>

        <form action="QA_05_NewRegister.jsp" method="get">
            <button class="button2" type="submit" name="Sign_Up" value="send">新規作成へ</button>
        </form>

    </div>

</body>
</html>