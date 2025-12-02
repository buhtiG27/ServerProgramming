<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>登録内容確認</title>
<link rel="stylesheet" href="css/style_24_CheckNewTask.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // リクエスト・パラメータ取得 
    String cls = request.getParameter("classneme");
    String con = request.getParameter("content");
    String lim = request.getParameter("limmit");
    String output = request.getParameter("output");
    String ditail = request.getParameter("detailcontent");
%>

<div class="top_button">
    <h1>TDU</h1>
    <br>
    <a>登録内容確認</a>
</div>

<div class="request_list">

    <br>
    授業名：<%= cls %><br><br>
    内容：<%= con %><br><br>
    期限：<%= lim %><br><br>
    提出場所：<%= output %><br><br>
    補足説明：<%= ditail %><br><br>

    <div class="bottom_buttons">

        <form class="form" action="Q&A_23_NewCreateTask.jsp" method="post">
            <input type="hidden" name="actionType" value="correction"> 
            <input type="hidden" name="classname" value="<%= cls %>">
            <input type="hidden" name="content" value="<%= con %>">
            <input type="hidden" name="limmit" value="<%= lim %>">
            <input type="hidden" name="output" value="<%= output %>">
            <input type="hidden" name="detailcontent" value="<%= ditail %>">
            <button class="correctButton" type="submit">訂正</button>
        </form>

        <form class="form" action="Q&A_21_DetailSubject.jsp" method="post">
                        <input type="hidden" name="classname" value="<%= cls %>">
            <input type="hidden" name="content" value="<%= con %>">
            <input type="hidden" name="limmit" value="<%= lim %>">
            <input type="hidden" name="output" value="<%= output %>">
            <input type="hidden" name="detailcontent" value="<%= ditail %>">
            <input type="hidden" name="message" value="登録が完了しました。">
            
            <button class="registerButton" type="submit">登録</button>
        </form>

    </div>
</div>

</body>
</html>