<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>登録内容確認</title>
<link rel="stylesheet" href="css/style_6_NewCheck.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // リクエスト・パラメータ取得 
String email = request.getParameter("EmailAddress");
String pw = request.getParameter("Password");
String user = request.getParameter("Username");
String grade = request.getParameter("GradeAndDepartment");
String classification = request.getParameter("Classification");
%>

<div class="top_button">
    <h1>TDU</h1>
    <form action="QA_01_Login.jsp" method="get">
        <button class="button" type="submit">戻る</button>
    </form>
    <br>
    <a>登録内容確認</a>
</div>

<div class="request_list">

    <br>
    メールアドレス：<%= email %><br><br>
    パスワード：<%= pw %><br><br>
    ユーザ名：<%= user %><br><br>
    学年・学科：<%= grade %><br><br>
    区分：<%= classification %><br><br>

    <div class="bottom_buttons">
		<%-- <%= request.getContextPath() %>/web_system/ --%>
        <form class="form" action="QA_05_NewRegister.jsp" method="post">
            <input type="hidden" name="actionType" value="correction"> 
            <input type="hidden" name="EmailAddress" value="<%= email %>">
            <input type="hidden" name="Password" value="<%= pw %>">
            <input type="hidden" name="Username" value="<%= user %>">
            <input type="hidden" name="GradeAndDepartment" value="<%= grade %>">
            <input type="hidden" name="Classification" value="<%= classification %>">
            <button class="correctButton" type="submit">訂正</button>
        </form>
		<%-- <%= request.getContextPath() %>/register --%>
        <form class="form" action="QA_01_Login.jsp" method="post">
    		<input type="hidden" name="EmailAddress" value="<%= email %>">
    		<input type="hidden" name="Password" value="<%= pw %>">
    		<input type="hidden" name="Username" value="<%= user %>">
    		<input type="hidden" name="GradeAndDepartment" value="<%= grade %>">
    		<input type="hidden" name="Classification" value="<%= classification %>">
    		<button class="registerButton" type="submit">登録</button>
		</form>
    </div>
</div>

</body>
</html>