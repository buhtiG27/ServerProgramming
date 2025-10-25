<!-- sendto.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>リクエストパラメータの処理</title>
</head>
<body>
<p>

<%
    request.setCharacterEncoding("UTF-8");

    String user = request.getParameter("Username");
    String pw = request.getParameter("Password");

    out.print("ID：" + user + "<br />");
    out.print("パスワード：" + pw + "<br />");
%>

</p>
</body>
</html>