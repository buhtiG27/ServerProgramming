<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>課題詳細画面</title>
<link rel="stylesheet" href="css/style_13_ViewTask.css">
</head>
<body>

<%-- トップボタン --%>
<div class="top_button_area">
	<form action="QA_2_Questions.jsp" method="get">
		<button class="top_button" type="submit" name="back" value="send">TDU</button>
	</form>
</div>

<div class="header_area">
	<form action="QA_21_DetailSubject.jsp" method="get">
		<button class="back_button" type="submit" name="back" value="send">戻る</button>
	</form>
	<h1 class="page_title">課題詳細</h1>
</div>

<div class="filter_buttons">
	<button class="button" type="submit" name="filterbyNew" value="send">課題詳細</button>
	<button class="button" type="submit" name="filterbySameGrade" value="send">人気</button>
	<button class="button" type="submit" name="filterbyFlag" value="send">新着</button>
</div>

	<br>
	<%-- 置き換え --%>
<div class="view_list">
	<h2 class="task_title">課題名サンプル</h2>
	<div class="edit">
		<form action="QA_26_EditTask.jsp" method="get">
			<button class="edit_button" type="submit" name="edit" value="send">編集</button>
		</form>
	</div>

	<div class="info_box">
		<label>授業名：</label>
		<div class="content_box">プログラミング応用Ⅰ</div>

		<label>内容：</label>
		<div class="content_box">第5回レポート提出（Javaのクラス構成について）</div>

		<label>期限：</label>
		<div class="content_box">2025年11月10日（月）23:59</div>

		<label>提出場所：</label>
		<div class="content_box">LMS提出フォーム</div>

		<label>補足説明：</label>
		<div class="textarea_box">
			提出形式はPDFで統一してください。ファイル名は「学籍番号_氏名.pdf」とすること。
			内容が長い場合でも自動で折り返して表示されます。
		</div>
	</div>
</div>
	<div class="bottom_buttons">
		<form class="form" action="" method="get">
			<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
		</form>
		<form class="form" action="QA_03_MyTime.jsp" method="get">
			<button class="pageButton" type="submit" name="toTimetable">マイ時間割</button>
		</form>
		<form class="form" action="QA_04_User.jsp" method="get">
			<button class="pageButton" type="submit" name="toUserInformation">ユーザ画面</button>
		</form>
	</div>

</body>
</html>