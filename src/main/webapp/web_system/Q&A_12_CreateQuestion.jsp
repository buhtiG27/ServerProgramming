<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>質問作成画面</title>
<link rel="stylesheet" href="css/style_12_CreateQuestion.css">
</head>
<body>
	<div class="create_list">
		<div class="button_left">
			<form action="Q&A_2_Question.jsp" method="get">
				<button class="back_button" type="submit" name="back" value="send">戻る</button>
			</form>
		</div>

		<div class="button_right">
			<form action="Q&A_2_Question.jsp" method="post" enctype="multipart/form-data">
				<button class="save_button" type="submit" name="save" value="send">保存</button>
			</form>
		</div>
		<div class="txtarea">
			<label>
				<img id="previewImage" src="" class="insert_Image"/>
				<input type="file" id="imageInput" name="InsertImage" accept=".jpg, .png" style="display:none"
				onchange="document.getElementById('previewImage').src = window.URL.createObjectURL(this.files[0])">
			</label>
			<br>
			<br>
			<textarea class="txt" name="questionBody" placeholder="質問内容を入力してください"></textarea>
		</div>
	</div>

	<div class="bottom_buttons">
		<form class="form" action="Q&A_2_Question.jsp" method="get">
			<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
		</form>
		<form class="form" action="Q&A_3_MyTime.jsp" method="get">
			<button class="pageButton" type="submit" name="toTimetable">マイ時間割</button>
		</form>
		<form class="form" action="Q&A_4_UserInfo.jsp" method="get">
			<button class="pageButton" type="submit" name="toUserInformation">ユーザ画面</button>
		</form>
	</div>
</body>
</html>