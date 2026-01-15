<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>ユーザ情報 | 電大生のQ&A</title>
        <link rel="icon" href="${pageContext.request.contextPath}/web_system/images/icon_qa.png" />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_4_User.css"
        />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- cssでスマホ用のデザインをするために書く -->
    </head>
    <body>
        <div class="top_button">
            <%-- ログアウト部分の作成 --%>
            <form
                action="${pageContext.request.contextPath}/logout"
                method="get"
                class="logout-area"
            >
                <button type="submit" class="logout-button">ログアウト</button>
            </form>
            <img src="${pageContext.request.contextPath}/web_system/images/kari_image_sky.jpeg" class="background_image" />
            <img src="${pageContext.request.contextPath}/web_system/images/kari_image_User.png" class="icon_image" />
            <div class="button">
                <form
                    action="${pageContext.request.contextPath}/web_system/QA_09_Edit.jsp"
                    method="get"
                >
                    <button
                        class="edit_button"
                        type="submit"
                        name="back"
                        value="send"
                    >
                        編集
                    </button>
                </form>
            </div>
            <br />
            <b class="username">${name}</b>
            <p class="intro_text">${description}</p>
        </div>
        <br />
		<main>
    		<div class="post-list">
        		<h2 style="padding: 10px 20px; font-size: 1.2em; border-bottom: 1px solid #eee;">自分の質問一覧</h2>
        
        		<%
            		// サーブレットでセットした "questions" を取得
            		List<Map<String, Object>> questions = (List<Map<String, Object>>) request.getAttribute("questions");
            		if (questions == null || questions.isEmpty()) {
        		%>
            	<p style="color:gray; padding: 20px;">まだ投稿した質問はありません。</p>
        		<%
            		} else {
                		for (Map<String, Object> q : questions) {
                    		pageContext.setAttribute("q", q);
        		%>
            	<div class="post">
                	<div class="post_sideParts">
                    	<form action="" method="get">
                        	<button class="iconButton" type="submit">
                            	<img src="${pageContext.request.contextPath}/web_system/images/kari_image_User.png" alt="(自分のアイコン)">
                        	</button>
                    	</form>
                	</div>
                
                <div class="post_upperParts">
                    <form action="${pageContext.request.contextPath}/questions/show" method="get" class="post_upperParts_form">
                        <input type="hidden" name="questionId" value="${q['id']}">
                        <button class="post_upperParts_atarihantei" type="submit"></button>
                        <div class="creatorName">${q['creator']['display_name']}</div>
                        <div class="created_at">${q['created_at_fmt']}</div>
                    </form>
                </div>
                
                <div class="post_mainParts">
                    <form action="${pageContext.request.contextPath}/questions/show" method="get" class="post_mainParts_form">
                        <input type="hidden" name="questionId" value="${q['id']}">
                        <button class="post_mainParts_atarihantei" type="submit">
                            <div class="contents_text">${q['contents_text']}</div>
                        </button>
                    </form>
                </div>

                <div class="post_bottomParts">
                    <form action="" method="get" class="post_bottomParts_form">
                        <button class="goodButton" type="submit">
                            <img src="${pageContext.request.contextPath}/web_system/images/icon_good_button.png" alt="(いいねボタン)" width="auto" height="90%" style="margin-top:10%;">
                        </button>
                    </form>
                    <form action="${pageContext.request.contextPath}/questions/show" method="get" class="post_bottomParts_form">
                        <input type="hidden" name="questionId" value="${q['id']}">
                        <button class="replyButton" type="submit">
                            <img src="${pageContext.request.contextPath}/web_system/images/icon_chat.png" alt="(返信ボタン)" width="auto" height="90%" style="margin-top:5%;">
                        </button>
                    </form>
                    <form action="" method="get" class="post_bottomParts_form">
                        <button class="flagButton" type="submit">
                            <img src="${pageContext.request.contextPath}/web_system/images/icon_flag.png" alt="(フラグボタン)" width="auto" height="90%" style="margin-top:5%;">
                        </button>
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
        	<div class="pagination" style="padding: 20px; text-align: center;">
            	<a href="${pageContext.request.contextPath}/user?limit=<%= limit %>&offset=<%= prev %>">前へ</a>
            	<span style="margin: 0 15px;"></span>
            	<a href="${pageContext.request.contextPath}/user?limit=<%= limit %>&offset=<%= next %>">次へ</a>
        	</div>

    	</div>
	</main>
			
			<button id="cycleButton" class="motchyButton">
				<img id="Shitsumotchy" src="<%= request.getContextPath() %>/web_system/images/Shitsumotchy_1.png" alt="">
			</button>
			<script>
			const button = document.getElementById("cycleButton");
			const img = document.getElementById("Shitsumotchy");
			
			let isVisible = true; 
			
			button.addEventListener("click", () => {
				if (!isVisible) return;
				 
				img.classList.add("flip");
				requestAnimationFrame(() => {
					img.classList.add("fade-out");
				});
				isVisible = false;
			});
			</script>
			
		</div>

		<nav>
			<div class="bottom_button">
                <form class="form" action="<%= request.getContextPath() %>/questions" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_home.png" alt="(質問一覧へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/timetable" method="get">
					<button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_calender.png" alt="(マイ時間割へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/user" method="get">
                    <button class="pageButton toUserinfo" type="submit">
						<img src="<%= request.getContextPath() %>/web_system/images/icon_gear.png" alt="(ユーザ情報だよ！)" class="icon_toUserinfo">
						<img src="<%= request.getContextPath() %>/web_system/images/icon_gear_hukidashi.png" alt="(ユーザ情報だよ！)" class="icon_toUserinfo_hukidashi">
					</button>
                </form>
            </div>
		</nav>
    </body>
</html>
