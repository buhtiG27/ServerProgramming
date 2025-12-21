<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>ユーザ情報 | 電大生のQ&A</title>
        <link
            rel="icon"
            href="${page.Context.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${page.Context.request.contextPath}/web_system/css/style_4_User.css"
        />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- cssでスマホ用のデザインをするために書く -->
    </head>
    <body>
        <div class="top_button">
            <%-- ログアウト部分の作成 --%>
            <form
                action="${page.Context.request.contextPath}/logout"
                method="get"
                class="logout-area"
            >
                <button type="submit" class="logout-button">ログアウト</button>
            </form>
            <img src="" class="<%= request.getContextPath() %>/web_system/images/kari_image_sky.jpeg" class="background_image" />
            <img src="" class="<%= request.getContextPath() %>/web_system/images/kari_image_User.png" class="icon_image" />
            <div class="button">
                <form
                    action="${page.Context.request.contextPath}/web_system/QA_09_Edit.jsp"
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
        <%-- 置き換え --%>
		<div class="post-list">
			<div class="post">
				<div class="post_sideParts">
					<form action="" method="get"><!--このユーザのユーザ情報を表示する？-->
						<button class="iconButton" type="submit"><img src="images/kari_image_User.png" alt="(ユーザ1のアイコン)" style="background-size:cover;"></button>
					</form>
				</div>
				<div class="post_upperParts">
					<form action="QA_10_ShowQuestion.html" method="get" class="post_upperParts_form">
						<button class="post_upperParts_atarihantei"></button>
						<div class="creatorName">匿名ウサギ</div>
						<div class="created_at">昨日23:11</div>
					</form>
				</div>
				<div class="post_mainParts">
					<form action="QA_10_ShowQuestion.html" method="get" class="post_mainParts_form">
						<button class="post_mainParts_atarihantei">
							<div class="contents_text">「寝たいけどみんなが頑張ってるしもう少しやらなきゃ...でも眠い...」ってとき、どうしてますか？</div>
						</button>
					</form>
				</div>
				<div class="post_bottomParts">
					<form action="" method="get" class="post_bottomParts_form">
						<button class="goodButton" type="submit" name="LikeButton" value="send"><img src="images/icon_good_button.png" alt="(いいねボタン)" width="auto" height="90%" style="margin-top:10%;"></button>
					</form>
					<form action="QA_10_ShowQuestion.html" method="get" class="post_bottomParts_form">
						<button class="replyButton" type="submit"><img src="images/icon_chat.png" alt="(返信ボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
					</form>
					<form action="" method="get" class="post_bottomParts_form">
						<button class="flagButton" type="submit" name="FlagButton" value="send"><img src="images/icon_flag.png" alt="(フラグボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
					</form>
				</div>
			</div>
			
			
			<div class="post">
				<div class="post_sideParts">
					<form action="" method="get"><!--このユーザのユーザ情報を表示する？-->
						<button class="iconButton" type="submit"><img src="images/kari_image_User.png" alt="(ユーザ1のアイコン)"></button>
					</form>
				</div>
				<div class="post_upperParts">
					<form action="QA_10_ShowQuestion.html" method="get" class="post_upperParts_form">
						<button class="post_upperParts_atarihantei"></button>
						<div class="creatorName">匿名ウサギ</div>
						<div class="created_at">12/13/1:30</div>
					</form>
				</div>
				<div class="post_mainParts">
					<form action="QA_10_ShowQuestion.html" method="get" class="post_mainParts_form">
						<button class="post_mainParts_atarihantei">
							<div class="contents_text">サーバープログラミング演習で「選択をサーバー上で実行できません」ってエラーを消すにはどうしたら良いのこれええ！！！</div>
						</button>
					</form>
				</div>
				<div class="post_bottomParts">
					<form action="" method="get" class="post_bottomParts_form">
						<button class="goodButton" type="submit" name="LikeButton" value="send"><img src="images/icon_good_button.png" alt="(いいねボタン)" width="auto" height="90%" style="margin-top:10%;"></button>
					</form>
					<form action="QA_10_ShowQuestion.html" method="get" class="post_bottomParts_form">
						<button class="replyButton" type="submit"><img src="images/icon_chat.png" alt="(返信ボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
					</form>
					<form action="" method="get" class="post_bottomParts_form">
						<button class="flagButton" type="submit" name="FlagButton" value="send"><img src="images/icon_flag.png" alt="(フラグボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
					</form>
				</div>
			</div>
			
			
			<div class="post">
				<div class="post_sideParts">
					<form action="" method="get"><!--このユーザのユーザ情報を表示する？-->
						<button class="iconButton" type="submit"><img src="images/kari_image_User.png" alt="(ユーザ1のアイコン)"></button>
					</form>
				</div>
				<div class="post_upperParts">
					<form action="QA_10_ShowQuestion.html" method="get" class="post_upperParts_form">
						<button class="post_upperParts_atarihantei"></button>
						<div class="creatorName">匿名ウサギ</div>
						<div class="created_at">11/28/18:29</div>
					</form>
				</div>
				<div class="post_mainParts">
					<form action="QA_10_ShowQuestion.html" method="get" class="post_mainParts_form">
						<button class="post_mainParts_atarihantei">
							<div class="contents_text">機械学習第10回の課題で提出するものって、実行結果のpngファイルですか？それともソースコードですか？</div>
						</button>
					</form>
				</div>
				<div class="post_bottomParts">
					<form action="" method="get" class="post_bottomParts_form">
						<button class="goodButton" type="submit" name="LikeButton" value="send"><img src="images/icon_good_button.png" alt="(いいねボタン)" width="auto" height="90%" style="margin-top:10%;"></button>
					</form>
					<form action="QA_10_ShowQuestion.html" method="get" class="post_bottomParts_form">
						<button class="replyButton" type="submit"><img src="images/icon_chat.png" alt="(返信ボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
					</form>
					<form action="" method="get" class="post_bottomParts_form">
						<button class="flagButton" type="submit" name="FlagButton" value="send"><img src="images/icon_flag.png" alt="(フラグボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
					</form>
				</div>
			</div>
			
			
			<div class="post">
				<div class="post_sideParts">
					<form action="" method="get"><!--このユーザのユーザ情報を表示する？-->
						<button class="iconButton" type="submit"><img src="images/kari_image_User.png" alt="(ユーザ1のアイコン)"></button>
					</form>
				</div>
				<div class="post_upperParts">
					<form action="QA_10_ShowQuestion.html" method="get" class="post_upperParts_form">
						<button class="post_upperParts_atarihantei"></button>
						<div class="creatorName">匿名ウサギ</div>
						<div class="created_at">2024/12/16/19:42</div>
					</form>
				</div>
				<div class="post_mainParts">
					<form action="QA_10_ShowQuestion.html" method="get" class="post_mainParts_form">
						<button class="post_mainParts_atarihantei">
							<div class="contents_text">明日ってメディア信号処理のテストかと思いますが、開始時間っていつからでしたっけ？</div>
						</button>
					</form>
				</div>
				<div class="post_bottomParts">
					<form action="" method="get" class="post_bottomParts_form">
						<button class="goodButton" type="submit" name="LikeButton" value="send"><img src="images/icon_good_button.png" alt="(いいねボタン)" width="auto" height="90%" style="margin-top:10%;"></button>
					</form>
					<form action="QA_10_ShowQuestion.html" method="get" class="post_bottomParts_form">
						<button class="replyButton" type="submit"><img src="images/icon_chat.png" alt="(返信ボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
					</form>
					<form action="" method="get" class="post_bottomParts_form">
						<button class="flagButton" type="submit" name="FlagButton" value="send"><img src="images/icon_flag.png" alt="(フラグボタン)" width="auto" height="90%" style="margin-top:5%;"></button>
					</form>
				</div>
			</div>
		</div>

		<nav>
			<div class="bottom_button">
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_02_Questions.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_home.png" alt="(質問一覧へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_03_MyTime.jsp" method="get">
					<button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_calender.png" alt="(マイ時間割へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_04_User.jsp" method="get">
                    <button class="pageButton toUserinfo" type="submit">
						<img src="<%= request.getContextPath() %>/web_system/images/icon_gear.png" alt="(ユーザ情報だよ！)" class="icon_toUserinfo">
						<img src="<%= request.getContextPath() %>/web_system/images/icon_gear_hukidashi.png" alt="(ユーザ情報だよ！)" class="icon_toUserinfo_hukidashi">
					</button>
                </form>
            </div>
		</nav>
    </body>
</html>
