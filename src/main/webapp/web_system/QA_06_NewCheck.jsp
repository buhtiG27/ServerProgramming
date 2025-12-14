<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>登録内容確認</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/web_system/css/style_6_NewCheck.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // リクエスト・パラメータ取得 
	String email = (String) request.getAttribute("Address");
	String pw = (String) request.getAttribute("Password");
	String user = (String) request.getAttribute("Username");
	String grade = (String) request.getAttribute("Grade");
	String classification = (String) request.getAttribute("Classification");
%>

<div class="top_button">
    <h1>TDU</h1>
    <form action="<%= request.getContextPath() %>/web_system/QA_01_Login.jsp" method="get">
        <button class="button" type="submit">戻る</button>
    </form>
    <br>
    <a>登録内容確認</a>
</div>
<%
    // エラーメッセージの取得と表示を追加
    String errorMessage = (String) request.getAttribute("error");
    if (errorMessage != null) {
%>
        <p style="color: red; font-weight: bold;">【エラー】<%= errorMessage %></p>
<%
    }
%>
<div class="request_list">

    <br>
    メールアドレス：<%= email %><br><br>
    パスワード：<%= pw %><br><br>
    ユーザ名：<%= user %><br><br>
    学年：<%= grade %><br><br>
    区分：<%= classification %><br><br>

    <div class="bottom_buttons">
        <form class="form" action="<%= request.getContextPath() %>/RegisterCheck" method="post">
            <input type="hidden" name="actionType" value="correction"> 
            <button class="correctButton" type="submit">訂正</button>
        </form>

        <form class="form" action="<%= request.getContextPath() %>/Register" method="post">
    		<button class="registerButton" type="submit">登録</button>
		</form>
    </div>
</div>

</body>
</html>