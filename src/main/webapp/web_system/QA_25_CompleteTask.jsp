<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="utf-8">
    <title>登録完了</title>
            <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
    <%-- パスを適切に設定 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_6_NewCheck.css">
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");

    // サーブレット側で setAttribute された値を取得
    String classname = (String)request.getAttribute("classname");
    String content   = (String)request.getAttribute("content");
    String limmit    = (String)request.getAttribute("limmit");
    String output    = (String)request.getAttribute("output");
    String detail    = (String)request.getAttribute("detailcontent");
    String msg       = (String)request.getAttribute("completeMessage");

    // 詳細画面に戻るために必要なID類（CreateTaskサーブレットから渡す必要がある）
    String subId   = (String)request.getAttribute("subjectId");
    String weekday = (String)request.getAttribute("weekday");
    String time    = (String)request.getAttribute("time");
%>

<div class="top_button">
    <h1>TDU</h1>
    <br>
    <%-- メッセージがない場合のデフォルト表示 --%>
    <p style="color: green; font-weight: bold;">
        <%= (msg != null) ? msg : "登録が完了しました" %>
    </p>
</div>

<div class="request_list">
    <br>
    <strong>授業名：</strong><%= (classname != null) ? classname : "---" %><br><br>
    <strong>内容：</strong><%= (content != null) ? content : "---" %><br><br>
    <strong>期限：</strong><%= (limmit != null) ? limmit : "---" %><br><br>
    <strong>提出場所：</strong><%= (output != null) ? output : "---" %><br><br>
    <strong>補足説明：</strong><%= (detail != null) ? detail : "---" %><br><br>

    <div class="bottom_buttons">
        <%-- 詳細画面（DetailSubject）に戻るためのフォーム --%>
        <form action="${pageContext.request.contextPath}/subjects/detail" method="get">
    		<%-- サーブレットから引き継いだ値をセット --%>
    		<input type="hidden" name="subjectId" value="<%= subId %>">
    		<input type="hidden" name="weekday" value="<%= weekday %>">
    		<input type="hidden" name="time" value="<%= time %>">
    		<button type="submit" class="registerButton">完了</button>
		</form>
    </div>
</div>

</body>
</html>