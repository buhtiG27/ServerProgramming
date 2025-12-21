X02Questions

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>質問一覧 | 電大生のQ&A</title>
		<%-- <%= request.getContextPath() %>/web_system/css/○○　このように書かないと反映されない --%>
		<link rel="icon" href="<%= request.getContextPath() %>/web_system/images/icon_qa.png" /><!-- ファビコン -->
		<link rel="stylesheet" href="<%= request.getContextPath() %>/web_system/css/style_2_Question.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
	</head>
	<body>

		<header>
			<jsp:include page="header.jsp" />
		</header>
		
		<main>
			<div class="post-list">
    		<%
				List<Map<String, Object>> questions = (List<Map<String, Object>>) request.getAttribute("questions");
			%>
    		<%
				if (questions == null || questions.isEmpty()) {
			%>
    			<p style="color:gray;">投稿されている質問はありません</p>
			<%
				} else {
    				for (Map<String, Object> q : questions) {
						pageContext.setAttribute("q", q);
			%>
			
				<div class="post">
				
					<div class="post_sideParts">
						<form action="" method="get">
							<!--アイコンを押したらこのユーザのユーザ情報を表示する？-->
							<button class="iconButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/kari_image_Monozu.png" alt="(ユーザ1のアイコン)"></button>
						</form>
					</div>
					
					<div class="post_upperParts">
						<form action="<%= request.getContextPath() %>/web_system/QA_10_ShowQuestion.jsp" method="get" class="post_upperParts_form">
							<button class="post_upperParts_atarihantei"></button><!-- post_upperPartsは空白の部分を押せば質問詳細を表示。これはその「空白の部分」。 -->
							<div class="creatorName">物津　玄師</div><!-- 投稿者名 -->
							<div class="created_at">12/21/20:59</div><!-- 投稿時刻 -->
						</form>
					</div>
					
					<div class="post_mainParts">
						<form action="<%= request.getContextPath() %>/web_system/QA_10_ShowQuestion.jsp" method="get" class="post_mainParts_form">
							<button class="post_mainParts_atarihantei"><!-- 投稿内容を押しても質問詳細を表示。これはその「投稿内容を押したかどうか」を判定する部分。 -->
								<div class="contents_text">サーバプログラミングの最終的な成果物っていつどこに提出するんですか？どっか資料に載ってますか？</div><!-- 投稿内容 -->
							</button>
						</form>
					</div>
					
					<div class="post_bottomParts">
						<form action="" method="get" class="post_bottomParts_form">
							<button class="goodButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_good_button.png" alt="(いいねボタン)" width="auto" height="90%" style="margin-top:10%;"></button>
						</form>
						<form action="<%= request.getContextPath() %>/web_system/QA_10_ShowQuestion.jsp" method="get" class="post_bottomParts_form">
							<button class="replyButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_chat.png" alt="(返信ボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
						</form>
						<form action="" method="get" class="post_bottomParts_form">
							<button class="flagButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_flag.png" alt="(フラグボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
						</form>
					</div>
					
				</div>
			<!--元のpostクラス -->

				<div class="post">
    				<form action="${pageContext.request.contextPath}/questions/show" method="get">
        				<input type="hidden" name="questionId" value="${q['id']}">
       					<button class="show_button" type="submit">
            			<%= q.get("title") %>
        				</button>
    				</form>

    				<p>ユーザ：${q['creator']['display_name']}</p>
					<p>${q['contents_text']}</p>
					<p>${q['created_at']}</p>

    				<div class="button-post">
        				<form action="${pageContext.request.contextPath}/LikeServlet" method="post">
            				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
            				<button class="like_button" type="submit">いいね</button>
        				</form>

        				<form action="${pageContext.request.contextPath}/FlagServlet" method="post">
            				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
           					<button class="like_button" type="submit">フラグ</button>
        				</form>
    				</div>
				</div>
			<%
    				}
				}
			%>
			<%
				Object limitObj = request.getAttribute("limit");
				Object offsetObj = request.getAttribute("offset");

				int limit  = (limitObj instanceof Integer) ? (Integer) limitObj : 20;
				int offset = (offsetObj instanceof Integer) ? (Integer) offsetObj : 0;

				int prev = Math.max(0, offset - limit);
				int next = offset + limit;
			%>

				<a href="<%= request.getContextPath() %>/questions?limit=<%= limit %>&offset=<%= prev %>">前へ</a>
				<a href="<%= request.getContextPath() %>/questions?limit=<%= limit %>&offset=<%= next %>">次へ</a>

			</div>

			<br><br>

			-->
			</div>
			
			<form action="${pageContext.request.contextPath}/web_system/QA_12_CreateQuestion.jsp" method="get">
    			<button class="createbutton" type="submit">質問作成</button>
			</form>

		</main>
		
	
		<nav>
			<div class="bottom_button">
                <form class="form" action="<%= request.getContextPath() %>/questions" method="get">
                    <button class="pageButton toQuestions" type="submit">
                        <img src="<%= request.getContextPath() %>/web_system/images/icon_home.png" alt="(質問一覧だよ！)" class="icon_toQuestions">
                        <img src="<%= request.getContextPath() %>/web_system/images/icon_home_hukidashi.png" alt="(質問一覧だよ！)" class="icon_toQuestions_hukidashi">
                    </button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/timetable" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_calender.png" alt="(マイ時間割へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/user" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_gear.png" alt="(ユーザ情報へ)"></button>
                </form>
            </div>
		</nav>

	</body>
</html>