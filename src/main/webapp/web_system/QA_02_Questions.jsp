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
				List<Map<String, Object>> questions =(List<Map<String, Object>>) request.getAttribute("questions");
			%>
    		<%
				if (questions == null || questions.isEmpty()) {
			%>
    			<p style="color:gray;">投稿されている質問はありません</p>
			<%
				} else {
    				for (Map<String, Object> q : questions) {
			%>
			
				<div class="post">
				
					<div class="post_sideParts">
						<form action="" method="get">
							<!--アイコンを押したらこのユーザのユーザ情報を表示する？-->
							<button class="iconButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_Monozu.png" alt="(ユーザ1のアイコン)"></button>
						</form>
					</div>
					
					<div class="post_upperParts">
						<form action="<%= request.getContextPath() %>/web_system/QA_10_ShowQuestion.jsp" method="get" class="post_upperParts_form">
							<button class="post_upperParts_atarihantei"></button><!-- post_upperPartsは空白の部分を押せば質問詳細を表示。これはその「空白の部分」。 -->
							<div class="creatorName">物津　玄師</div><!-- 投稿者名 -->
							<div class="created_at">昨日0:15</div><!-- 投稿時刻 -->
						</form>
					</div>
					
					<div class="post_mainParts">
						<form action="<%= request.getContextPath() %>/web_system/QA_10_ShowQuestion.jsp" method="get" class="post_mainParts_form">
							<button class="post_mainParts_atarihantei"><!-- 投稿内容を押しても質問詳細を表示。これはその「投稿内容を押したかどうか」を判定する部分。 -->
								<div class="contents_text">サーバープログラミング演習で「選択をサーバー上で実行できません」ってエラーを消すにはどうしたら良いのこれええ！！！</div><!-- 投稿内容 -->
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
			<%
    				}
				}
			%>
			<!--元のpostクラス

				<div class="post">
    				<form action="${pageContext.request.contextPath}/questions/show" method="get">
        				<input type="hidden" name="questionId" value="<%= q.get("id") %>">
       					<button class="show_button" type="submit">
            			<%= q.get("title") %>
        				</button>
    				</form>

    				<p>担当教員：<%= q.get("teacher") %></p>

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

			-->
			</div>			
			
			<!-- 
			<form action="${pageContext.request.contextPath}/web_system/QA_12_CreateQuestion.jsp" method="get">
    			<button class="createbutton" type="submit">質問作成</button>
			</form>
			 -->

		</main>
		
		<form action="${pageContext.request.contextPath}/web_system/QA_12_CreateQuestion.html" method="get">
    		<button class="createbutton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_create_new_question.png" alt="質問作成" style="display:block;margin:auto;"></button>
		</form>
	
		<nav>
			<div class="bottom_button">
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_02_Questions.jsp" method="get">
                    <button class="pageButton toQuestions" type="submit">
                        <img src="<%= request.getContextPath() %>/web_system/images/icon_home.png" alt="(質問一覧だよ！)" class="icon_toQuestions">
                        <img src="<%= request.getContextPath() %>/web_system/images/icon_home_hukidashi.png" alt="(質問一覧だよ！)" class="icon_toQuestions_hukidashi">
                    </button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_03_MyTime.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_calender.png" alt="(マイ時間割へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_04_User.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_gear.png" alt="(ユーザ情報へ)"></button>
                </form>
            </div>
		</nav>

	</body>
</html>