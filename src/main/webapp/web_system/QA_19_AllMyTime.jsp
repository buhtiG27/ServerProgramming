<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>時間割一覧画面</title>
<link rel="stylesheet" href="css/style_19_AllMyTime.css">
</head>
<body>
	<div class="top_button_area">
		<form action="QA_02_Questions.jsp" method="get">
			<button class="top_button" type="submit" name="back" value="send">TDU</button>
		</form>
	</div>
	<div class="header_area">
		<form action="QA_03_MyTime.jsp" method="get">
			<button class="cancel_button" type="submit" name="filterbyNew" value="send">キャンセル</button>
		</form>
		<h2>時間割一覧</h2>
		<form action="QA_20_CreateSubject.jsp">
			<button class="new_button" type="submit" name="filterbySameGrade" value="send">新規作成</button>
		</form>
	</div>
	<br>
	<div class="body_area">
		<form action="" method="get" class="search_form">
			<label>検索：</label>
			<input class="txt" type="text" size="20" value="" name="searchbyKeyword" />		
		</form>
		<div class="subject_area">
			<form action="QA_21_DetailSubject.jsp" method="get">
				<button class="show_button" type="submit" name="filterbyNew" value="send">科目1</button>
			</form>
			<p>サンプル表示</p>
				<form action="QA_03_MyTime.jsp" method="post">
				<input type="hidden" name="message" value="登録が完了しました。">
					<button class="register_button" type="submit" name="LikeButton" value="send">登録</button>
				</form>	
		</div>	
		<div class="subject_area">
			<h3>科目1</h3>
			<p>サンプル表示</p>
				<form action="QA_03_MyTime.jsp" method="post">
				<input type="hidden" name="message" value="登録が完了しました。">
					<button class="register_button" type="submit" name="LikeButton" value="send">登録</button>
				</form>	
		</div>	
		<div class="subject_area">
			<h3>科目1</h3>
			<p>サンプル表示</p>
				<form action="QA_03_MyTime.jsp" method="post">
				<input type="hidden" name="message" value="登録が完了しました。">	
					<button class="register_button" type="submit" name="LikeButton" value="send">登録</button>
				</form>	
		</div>	
	</div>
	<br>
	<br>
	<div class="bottom_buttons">
	<form class="form" action="QA_02_Questions.jsp" method="get">
		<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
	</form>
	<form class="form" action="" method="get">
		<button class="pageButton" type="submit" name="toTimetable">マイ時間割</button>
	</form>
	<form class="form" action="QA_04_User.jsp" method="get">
		<button class="pageButton" type="submit" name="toUserInformation">ユーザ画面</button>
	</form>
	</div>

</body>
</html>