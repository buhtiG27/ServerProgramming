<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf-8">
	<title>質問画面</title>
	<link rel="stylesheet" href="css/style_10_ShowQuestion.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
</head>
<body>
	<header>
		<jsp:include page="header.jsp" /><!-- ヘッダ部分を1つの.jspにまとめた→こう書くだけで使いまわせる -->
	</header>

	<!-- 質問表示部 -->
	<div class="post-list">
		<div class="post" id="questionPost">
			<h3>投稿１</h3>
			<p id="questionText">サンプル投稿を表示</p>

			<div class="button-post">
				<button class="like_button" type="button">いいね</button>
				<button class="like_button" type="button">フラグ</button>

				<!-- 質問編集ボタン -->
				<button class="edit_button" type="button" onclick="openEditQuestionModal()">編集</button>
			</div>
		</div>
	</div>

	<!-- 回答一覧 -->
	<div class="remaind-list">
		<h2>回答</h2>

		<div class="post">
			<h3>回答</h3>

			<p class="answerText">サンプル投稿を表示</p>

			<div class="button-post">
				<button class="like_button" type="button">いいね</button>
				<button class="like_button" type="button">フラグ</button>

				<!-- 回答編集ボタン -->
				<button class="edit_button" type="button" onclick="openEditQuestionModal()">編集</button>
			</div>
		</div>

		<!-- 回答作成ボタン -->
		<div class="answer">
			<button id="openAnswerModal" class="answer_button" type="button">回答作成</button>
		</div>

		<!-- 回答作成モーダル -->
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

	<!-- 質問編集モーダル -->
	<div id="editQuestionModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeEditQuestionModal()">&times;</span>
			<h2>質問を編集</h2>

			<form action="EditQuestionServlet" method="post">
				<textarea id="editQuestionText" name="questionText" rows="5" cols="50"></textarea><br>
				<button type="submit" class="submit_button">変更を保存</button>
			</form>
		</div>
	</div>

	<!-- 回答編集モーダル -->
	<div id="editAnswerModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeEditAnswerModal()">&times;</span>
			<h2>回答を編集</h2>

			<form action="EditAnswerServlet" method="post">
				<textarea id="editAnswerText" name="answerText" rows="5" cols="50"></textarea><br>
				<button type="submit" class="submit_button">変更を保存</button>
			</form>
		</div>
	</div>

	<script>
		/* 回答作成モーダル */
		document.getElementById("openAnswerModal").onclick = function() {
			document.getElementById("answerModal").style.display = "block";
		};
		document.getElementById("closeModal").onclick = function() {
			document.getElementById("answerModal").style.display = "none";
		};
		window.onclick = function(event) {
			if (event.target == document.getElementById("answerModal")) {
				document.getElementById("answerModal").style.display = "none";
			}
		};


		/* 質問編集モーダル */
		function openEditQuestionModal() {
			const currentQuestion = document.getElementById("questionText").innerText;
			document.getElementById("editQuestionText").value = currentQuestion;
			document.getElementById("editQuestionModal").style.display = "block";
		}

		function closeEditQuestionModal() {
			document.getElementById("editQuestionModal").style.display = "none";
		}


		/* 回答編集モーダル */
		function openEditAnswerModal(answerText) {
			document.getElementById("editAnswerText").value = answerText;
			document.getElementById("editAnswerModal").style.display = "block";
		}

		function closeEditAnswerModal() {
			document.getElementById("editAnswerModal").style.display = "none";
		}
	</script>

	<br>

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