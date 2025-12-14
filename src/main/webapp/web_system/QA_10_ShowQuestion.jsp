<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%
Map<String, Object> question =
    (Map<String, Object>) request.getAttribute("question");

List<Map<String, Object>> answers =
    (List<Map<String, Object>>) request.getAttribute("answers");

String loggedInUsername =
    (String) session.getAttribute("loggedInUsername");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>質問画面</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/web_system/css/style_10_ShowQuestion.css">
</head>
<body>

	<div class="top_button">
		<h1>TDU</h1>
		<div class="button">
			<form action="<%= request.getContextPath() %>/AllQuestions" method="get">
				<button class="back_button" type="submit">戻る</button>
			</form>
		</div>

		<br>
		<a>質問</a>
		<br>
	</div>

	<br>

	<!-- 質問表示部 -->
	<div class="post-list">
		<div class="post" id="questionPost">
			<h3>投稿</h3>
			<p id="questionText"><%= question.get("content") %></p>

			<div class="button-post">
				<button class="like_button" type="button">いいね</button>
				<button class="like_button" type="button">フラグ</button>

				<!-- 質問編集ボタン -->
				<%
					if (loggedInUsername != null &&
    					loggedInUsername.equals(question.get("username"))) {
				%>
				<button class="edit_button" type="button"
				    onclick="openEditQuestionModal()">編集</button>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<div class="remaind-list">
		<h2>回答</h2>

		<%
		if (answers != null) {
			for (Map<String, Object> answer : answers) {
				String answerUser = (String) answer.get("username");
				%>
		<div class="post">
    		<p class="answerText"><%= answer.get("content") %></p>

    		<div class="button-post">
        		<% 
        		if (loggedInUsername != null &&loggedInUsername.equals(answerUser)) { 
        		%>
            		<button class="edit_button" onclick="openEditAnswerModal('<%= answer.get("content") %>')">編集</button>
        		<% } %>
    		</div>
		</div>
		<%
		    }
		}
		%>
        
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
		<form class="form" action="<%= request.getContextPath() %>/web_system/QA_03_MyTime.jsp" method="get">
			<button class="pageButton" type="submit" name="toTimetable">マイ時間割</button>
		</form>
		<form class="form" action="<%= request.getContextPath() %>/web_system/QA_04_User.jsp" method="get">
			<button class="pageButton" type="submit" name="toUserInformation">ユーザ画面</button>
		</form>
	</div>

</body>
</html>