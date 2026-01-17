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
		        <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
		<link rel="icon" href="<%= request.getContextPath() %>/web_system/images/icon_qa.png" /><!-- ファビコン -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
        <link rel="stylesheet" href="${page.Context.request.contextPath}/web_system/css/style_10_ShowQuestion.css" />
    </head>
	<body>
	<header>
            <jsp:include
                page="header.jsp"
            /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
            
            <h2>質問</h2>
            
        </header>
        <div class="header_area">
            <form
                action="${pageContext.request.contextPath}/questions"
                method="get"
            >
                <button
                    class="back_button"
                    type="submit"
                >戻る
                </button>
            </form>
            </div>
	


	<br>

	<!-- 質問表示部 -->
	<div class="post-list" style="top: 0; margin-top: 20px;">
	<div class="post">
        
        <div class="post_upperParts" style="left: 2%; width: 96%;">
            <div class="creatorName">${question['creator']['display_name']}</div>
            <div class="created_at">${question['created_at_fmt']}</div>
        </div>

        <div class="post_mainParts" style="left: 2%; width: 96%;">
            <div class="contents_text" id="questionText">${question['contents_text']}</div>
        </div>

        <div class="post_bottomParts" style="left: 2%; width: 96%;">
            
            <form action="${pageContext.request.contextPath}/questions/like" method="post" class="post_bottomParts_form">
                <input type="hidden" name="questionId" value="${question['id']}">
                <input type="hidden" name="from" value="show">
                <button class="goodButton" type="submit">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_good_button.png" alt="いいね" width="auto" height="90%">
                </button>
                <span class="count-text">${question['like_count'] != null ? question['like_count'] : 0}</span>
            </form>

            <form action="${pageContext.request.contextPath}/questions/flag" method="post" class="post_bottomParts_form">
                <input type="hidden" name="questionId" value="${question['id']}">
                <input type="hidden" name="from" value="show">
                <button class="flagButton" type="submit">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_flag.png" alt="フラグ" width="auto" height="90%">
                </button>
                <span class="flag-mark">${question['is_flagged'] == true ? "○" : ""}</span>
            </form>

            <% if (loggedInUsername != null && loggedInUsername.equals(question.get("username"))) { %>
                <div class="post_bottomParts_form" style="text-align: right;">
                    <button class="edit_button" type="button" onclick="openEditQuestionModal()" 
                            style="background-color: #4caf50; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer;">
                        編集
                    </button>
                </div>
            <% } else { %>
                <div class="post_bottomParts_form"></div> <% } %>
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
    <div class="post" style="height: auto; min-height: 150px; margin-bottom: 20px;">
        
        <div class="post_upperParts" style="left: 2%; width: 96%; height: 30px;">
            <div class="creatorName" style="font-size: 16px;">${answer['creator']['display_name']}</div>
            <div class="created_at" style="font-size: 12px;">${answer['created_at_fmt']}</div>
        </div>

        <div class="post_mainParts" style="left: 2%; width: 96%; position: relative; top: 35px; height: auto; min-height: 60px;">
            <div class="contents_text" style="font-size: 20px; padding: 10px;">${answer['contents_text']}</div>
        </div>

        <div class="post_bottomParts" style="left: 2%; width: 96%; height: 40px; position: relative; margin-top: 40px;">
            
            <form action="${pageContext.request.contextPath}/answers/like" method="post" class="post_bottomParts_form">
                <input type="hidden" name="answerId" value="${answer['id']}">
                <input type="hidden" name="questionId" value="${question['id']}"> <button class="goodButton" type="submit">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_good_button.png" alt="いいね" width="auto" height="25px">
                </button>
                <span class="count-text">${answer['like_count'] != null ? answer['like_count'] : 0}</span>
            </form>

            <% if (loggedInUsername != null && loggedInUsername.equals(answerUser)) { %>
                <div class="post_bottomParts_form" style="text-align: right; flex: 1;">
                    <button class="edit_button" type="button" 
                            onclick="openEditAnswerModal('${answer['contents_text']}')"
                            style="background-color: #4caf50; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer;">
                        編集
                    </button>
                </div>
            <% } else { %>
                <div class="post_bottomParts_form" style="flex: 1;"></div>
            <% } %>
        </div>
    </div>
    <%
        }
    } else {
    %>
        <p style="color: gray;">まだ回答はありません</p>
    <% } %>
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