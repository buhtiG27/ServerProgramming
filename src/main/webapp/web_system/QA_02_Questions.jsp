<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>質問一覧画面</title>
<link rel="stylesheet" href="css/style_2_Question.css">
</head>
<body>

<div class="top_button">
    <h1>TDU</h1>
    <form action="QA_11_SearchQuestion.jsp" method="get">
        検索：
        <input class="txt" type="text" name="searchbyKeyword" size="20" />
    </form>
    <button class="button" type="submit" name="filterbyNew" value="send">新着</button>
    <button class="button" type="submit" name="filterbySameGrade" value="send">学科</button>
    <button class="button" type="submit" name="filterbyFlag" value="send">フラグ付き</button>
</div>

<br>

<div class="post-list">
    <div class="post">
        <form action="QA_10_ShowQuestion.jsp" method="get">
            <button class="show_button" type="submit" name="questionId" value="1">投稿1</button>
        </form>

        <p>サンプル投稿を表示</p>

        <div class="button-post">
            <form action="LikeServlet" method="post" style="display:inline;">
                <input type="hidden" name="questionId" value="1">
                <button class="like_button" type="submit">いいね</button>
            </form>

            <form action="FlagServlet" method="post" style="display:inline;">
                <input type="hidden" name="questionId" value="1">
                <button class="like_button" type="submit">フラグ</button>
            </form>
        </div>
    </div>
</div>

<br><br>

<form action="QA_12_CreateQuestion.jsp" method="get">
    <button class="createbutton" type="submit">質問作成</button>
</form>

<br>

<div class="bottom_buttons">
    <form class="form" action="QA_02_Questions.jsp" method="get">
        <button class="pageButton" type="submit">質問一覧</button>
    </form>
    <form class="form" action="QA_03_MyTime.jsp" method="get">
        <button class="pageButton" type="submit">マイ時間割</button>
    </form>
    <form class="form" action="QA_04_User.jsp" method="get">
        <button class="pageButton" type="submit">ユーザ画面</button>
    </form>
</div>

</body>
</html>