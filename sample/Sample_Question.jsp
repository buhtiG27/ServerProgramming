<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>質問一覧画面</title>
<link rel="stylesheet" href="style1.css">
</head>
<body>
<%--　ロゴに置き換える --%>
<div class="top_button">
	<h1>TDU</h1>
	<%-- 入力フォーム --%>
	<%-- form action="sendto.jsp" method="get" --%>
		<form action="" method="get">
			検索：
			<input class="txt" type="text" size="20" value="" name="searchbyKeyword" />
		</form>
			<button class="button" type="submit" name="filterbyNew" value="send">新着</button>
			<button class="button" type="submit" name="filterbySameGrade" value="send">学科</button>
			<button class="button" type="submit" name="filterbyFlag" value="send">フラグ付き</button>
	</div>
	<br>
	<%-- 置き換え --%>
	<div class="post-list">
		<div class="post">
			<h3>投稿１</h3>
			<p>サンプル投稿を表示</p>
			<div class="button-post">
				<button class="like_button" type="submit" name="LikeButton" value="send">いいね</button>
				<button class="like_button" type="submit" name="FlagButton" value="send">フラグ</button>
			</div>
		</div>	
		<div class="post">
			<h3>投稿2</h3>
			<p>サンプル投稿を表示</p>
			<div class="button-post">
				<button class="like_button" type="submit" name="LikeButton" value="send">いいね</button>
				<button class="like_button" type="submit" name="FlagButton" value="send">フラグ</button>
			</div>
		</div>	
		<div class="post">
			<h3>投稿3</h3>
			<p>サンプル投稿を表示</p>
			<div class="button-post">
				<button class="like_button" type="submit" name="LikeButton" value="send">いいね</button>
				<button class="like_button" type="submit" name="FlagButton" value="send">フラグ</button>
			</div>
		</div>
		<div class="post">
			<h3>投稿4</h3>
			<p>サンプル投稿を表示</p>
			<div class="button-post">
				<button class="button3" type="submit" name="LikeButton" value="send">いいね</button>
				<button class="button3" type="submit" name="FlagButton" value="send">フラグ</button>
			</div>
		</div>
	</div>
	<br>
	<br>
	<button class="createbutton"type="submit" name="createQuestion" value="send">質問作成</button>
	
	<br>
	<div class="bottom_buttons">
		<form class="form" action="" method="get">
			<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
		</form>
		<form class="form" action="Sample_MyTime.jsp" method="get">
			<button class="pageButton" action="Sample_MyTime.jsp" type="submit" name="toTimetable">マイ時間割</button>
		</form>
		<form class="form" action="Sample_User.jsp" method="get">
			<button class="pageButton" action="Sample_Uses.jsp" type="submit" name="toUserInformation">ユーザ画面</button>
		</form>
	</div>

</body>
</html>