<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>科目作成画面</title>
		<link rel="stylesheet" href="css/style_20_CreateSubject.css">
	</head>
	<body>
		<%--　ロゴに置き換える --%>
		<div class="top_button_area">
			<form action="QA_02_Questions.jsp" method="get">
				<button class="top_button" type="submit" name="back" value="send">TDU</button>
			</form>
		</div>
		
		<!-- 戻るボタンとタイトル -->
		<div class="header_area">
			<form action="QA_19_AllMyTime.jsp" method="get">
				<button class="back_button" type="submit" name="back" value="send">戻る</button>
			</form>
			<h1 class="page_title">科目作成</h1>
		</div>
		<div class="create_list">
			<br>
			<p>科目作成</p>
			<form action="QA_19_AllMyTime.jsp" method="get">
				<label for="classname">授業名：</label>
				<br>	
				<input class="txt" type="text" size="20" value="" name="Classname" />
				<br><br>
				<label for="teacher">教員名：</label>
				<br>
				<input class="txt" type="text" size="20" value="" name="Teacher" />
				<br><br>	
				<label for="roomname">教室：</label>
				<br>
				<input class="txt" type="text" size="20" value="" name="Roomname" />
				<br><br>
				<button class="regist_button" type="submit" name="Login" value="send">登録</button>
			</form>
		</div>
	</body>
</html>