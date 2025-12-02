<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>ユーザ編集画面</title>
<link rel="stylesheet" href="css/style_9_Edit.css">
</head>
<body>
	<div class="edit_list">
		<%-- 背景画像 --%>
		<label>
			<img id="BackgroundImage" src="" class="background_image" />
			<input type="file" id="BackgroundImage" name="BackgroundImage" accept=".jpg, .png" style="display:none"
				onchange="document.getElementById('BackgroundImage').src = window.URL.createObjectURL(this.files[0])">
		</label>
		<div class="button_left">
			<form action="Q&A_4_User.jsp" method="get">
				<button class="cancel_button" type="submit" name="cancel" value="send">キャンセル</button>
			</form>
		</div>
		<div class="button_right">
			<form action="Q&A_4_User.jsp" method="get">
				<button class="save_button" type="submit" name="save" value="send">保存</button>
			</form>
		</div>
		<%-- アイコン画像 --%>
		<label>
			<img id="IconImage" src="" class="icon_image"/>
			<input type="file" id="IconImage" name="IconImage" accept=".jpg, .png" style="display:none"
				onchange="document.getElementById('IconImage').src = window.URL.createObjectURL(this.files[0])">
		</label>
		<br><br>
		<label for="name">名前：</label>
		<br>
		<input class="txt" type="text" size="20" value="" name="Username" />
		<br><br>
		<label for="pw">紹介：</label>
		<br>
		<input class="txt" type="password" size="32" value="" name="Password" />
		<br><br>
		<label for="grade">学年・学科：</label>
		<br>
		<input class="txt" type="text" size="20" value="" name="GradeAndDepartment" />
	</div>
	<div class="bottom_buttons">
		<form class="form" action="Q&A_2_Question.jsp" method="get" style="display:inline-flex;">
			<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
		</form>
		<form class="form" action="Q&A_3_MyTime.jsp" method="get" style="display:inline-flex;">
			<button class="pageButton" type="submit" name="toTimetable">マイ時間割</button>
		</form>
		<form class="form" action="" method="get" style="display:inline-flex;">
			<button class="pageButton" type="submit" name="toUserInformation">ユーザ画面</button>
		</form>
	</div>

</body>
</html>