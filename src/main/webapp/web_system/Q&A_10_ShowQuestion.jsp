<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>質問画面</title>
<link rel="stylesheet" href="css/style_10_ShowQuestion.css">
</head>
<body>
	<div class="top_button">
		<%-- ボタンに置き換え --%>
		<h1>TDU</h1>
		<div class="button">
		<form action="Q&A_2_Question.jsp" method="get">
			<button class="back_button" type="submit" name="back" value="send">戻る</button>
		</form>
		</div>
		<br>
		<a>質問</a>
		<br>
	</div>
	<br>
	<div class="post-list">
		<div class="post">
			<h3>投稿１</h3>
			<p>サンプル投稿を表示</p>
			<div class="button-post">
				<button class="like_button" type="submit" name="LikeButton" value="send">いいね</button>
				<button class="like_button" type="submit" name="FlagButton" value="send">フラグ</button>
			</div>
		</div>	
	</div>
	
	<div class="remaind-list">
	<h2>回答</h2>
		<div class="post">
			<h3>回答</h3>
			<p>サンプル投稿を表示</p>
			<div class="button-post">
				<button class="like_button" type="submit" name="LikeButton" value="send">いいね</button>
				<button class="like_button" type="submit" name="FlagButton" value="send">フラグ</button>
			</div>
		</div>
		
		<div class="answer">
			<button id="openAnswerModal" class="answer_button" type="button">回答作成</button>
		</div>
		<%-- 14画面 --%>
		<%-- モーダルウィンドウの作成 --%>
		<div id="answerModal" class="modal">
			<div class="modal-content">
				<span id="closeModal" class="close">&times;</span>
				<h2>回答を作成</h2>
				<form action="PostAnswerServlet" method="post" enctype="multipart/form-data">
					<textarea name="answerText" rows="5" cols="50" placeholder="ここに回答内容を入力"></textarea><br><br>
					<input type="file" name="imageFile" accept="image/*"><br><br>
					<button type="submit" class="submit_button">送信</button>
				</form>
			</div>
		</div>
	</div>
	<script>
		document.getElementById("openAnswerModal").onclick = function() {
		document.getElementById("answerModal").style.display = "block";
		};
		document.getElementById("closeModal").onclick = function() {
		document.getElementById("answerModal").style.display = "none";
		};
		// 背景クリックで閉じる処理
		window.onclick = function(event) {
		if (event.target == document.getElementById("answerModal")) {
				document.getElementById("answerModal").style.display = "none";
		}
		};
	</script>
	<br>
	<div class="bottom_buttons">
		<form class="form" action="" method="get">
			<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
		</form>
		<form class="form" action="Q&A_3_MyTime.jsp" method="get">
			<button class="pageButton" action="Sample_MyTime.jsp" type="submit" name="toTimetable">マイ時間割</button>
		</form>
		<form class="form" action="Q&A_4_User.jsp" method="get">
			<button class="pageButton" action="Sample_Uses.jsp" type="submit" name="toUserInformation">ユーザ画面</button>
		</form>
	</div>

</body>
</html>