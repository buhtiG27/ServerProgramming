<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%
String error = (String) request.getAttribute("error");
	pageContext.setAttribute("error", error);

Map<String, Object> question =
    (Map<String, Object>) request.getAttribute("question");
	pageContext.setAttribute("question", question);

List<Map<String, Object>> answers =
    (List<Map<String, Object>>) request.getAttribute("answers");

String loggedInUsername =
    (String) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>質問一覧 | 電大生のQ&A</title>
		<link rel="icon" href="<%= request.getContextPath() %>/web_system/images/icon_qa.png" /><!-- ファビコン -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
        <link rel="stylesheet" href="${page.Context.request.contextPath}/web_system/css/style_10_ShowQuestion.css" />
    </head>
	<body>

	<div class="top_button">
		<h1>TDU</h1>
		<div class="button">
			<form action="${page.Context.request.contextPath}/questions" method="get">
				<button class="back_button" type="submit">戻る</button>
			</form>
		</div>

		<br>
		<a>質問</a><br />
		${error}
		<br>
	</div>

	<br>

	<!-- 質問表示部 -->
	<div class="post-list">
		<div class="post" id="questionPost">
			<h3>投稿</h3>
			<p id="questionText">${question['contents_text']}</p>

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
		if (answers != null && answers.size() > 0) {
			for (Map<String, Object> answer : answers) {
				Map<String, Object> creator = (Map<String, Object>) answer.get("creator");
				pageContext.setAttribute("answer", answer);
				String answerUser = creator == null ? "" : (String) creator.get("user_id");
				%>
		<div class="post">
    		<p class="answerText">${answer['contents_text']}</p>
			<p class="answerUser">${answer['creator']['display_name']}</p>
    		<div class="button-post">
        		<% 
        		if (loggedInUsername != null &&loggedInUsername.equals(answerUser)) { 
        		%>
            		<button class="edit_button" onclick="openEditAnswerModal('${answer['content_text']}')">編集</button>
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
				<form action="${page.Context.request.contextPath}/questions/answercreate" method="post">
					<textarea name="answerText" rows="5" cols="50" placeholder="ここに回答内容を入力"></textarea><br><br>
					<!-- <input type="file" name="imageFile" accept="image/*"><br><br> -->
					 <input type="hidden" name="question_id" value="${question['id']}" />
					<button type="submit" class="submit_button">送信</button>
				</form>
			</div>
		</div>

	<!-- 質問編集モーダル -->
	<div id="editQuestionModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeEditQuestionModal()">&times;</span>
			<h2>質問を編集</h2>

			<form action="" method="post">
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

			<form action="" method="post">
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

		<nav>
			<div class="bottom_button">
                <form class="form" action="${pageContext.request.contextPath}/questions" method="get">
                    <button class="pageButton toQuestions" type="submit">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_home.png" alt="(質問一覧だよ！)" class="icon_toQuestions">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_home_hukidashi.png" alt="(質問一覧だよ！)" class="icon_toQuestions_hukidashi">
                    </button>
                </form>
                <form class="form" action="${pageContext.request.contextPath}/timetable" method="get">
                    <button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_calender.png" alt="(マイ時間割へ)"></button>
                </form>
                <form class="form" action="${pageContext.request.contextPath}/user" method="get">
                    <button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_gear.png" alt="(ユーザ情報へ)"></button>
                </form>
            </div>
		</nav>

	</body>
</html>