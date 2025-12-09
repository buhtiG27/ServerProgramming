<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>質問一覧画面</title>
		<link rel="stylesheet" href="css/style_2_Question.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"><!-- cssでスマホ用のデザインをするために書く -->
	</head>
	<body>

		<header>
			<jsp:include page="header.jsp" /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
		</header>
		
		<main>
			<div class="post-list">
				<div class="post">
        			<form action="QA_10_ShowQuestion.jsp" method="get">
            			<button class="show_button" type="submit" name="questionId" value="1">投稿1</button>
        			</form>
					
        			<p>サンプル投稿を表示</p>
				
        			<div class="button-post">
            			<form action="LikeServlet" method="post" style="display:inline;">
                			<input type="hidden" name="questionId" value="1">
                			<button class="like_button" type="submit">いいね</button>
            			</form>

            			<form action="FlagServlet" method="post" style="display:inline;">
                			<input type="hidden" name="questionId" value="1">
                			<button class="like_button" type="submit">フラグ</button>
            			</form>
        			</div>
    			</div>
			</div>

			<br><br>

			<form action="QA_12_CreateQuestion.jsp" method="get">
    			<button class="createbutton" type="submit">質問作成</button>
			</form>

			<br>
		</main>
	
		<footer>
			<div class="bottom_buttons">
    			<form class="form" action="QA_02_Questions.jsp" method="get">
        			<button class="pageButton" type="submit">質問一覧</button>
    			</form>
    			<form class="form" action="QA_03_MyTime.jsp" method="get">
        			<button class="pageButton" type="submit">マイ時間割</button>
    			</form>
    			<form class="form" action="QA_04_User.jsp" method="get">
        			<button class="pageButton" type="submit">ユーザ画面</button>
    			</form>
			</div>
		</footer>

	</body>
</html>