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
            <img src="" class="background_image" />
            <img src="" class="icon_image" />
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
            <h2>${name}</h2>
            <p class="intro_text">${description}</p>
        </div>
        <br />
        <%-- 置き換え --%>
        <div class="post-list">
            <div class="post">
                <h3>投稿１</h3>
                <p>サンプル投稿を表示</p>
                <div class="button-post">
                    <button
                        class="like_button"
                        type="submit"
                        name="LikeButton"
                        value="send"
                    >
                        いいね
                    </button>
                    <button
                        class="like_button"
                        type="submit"
                        name="FlagButton"
                        value="send"
                    >
                        フラグ
                    </button>
                </div>
            </div>
            <div class="post">
                <h3>投稿2</h3>
                <p>サンプル投稿を表示</p>
                <div class="button-post">
                    <button
                        class="like_button"
                        type="submit"
                        name="LikeButton"
                        value="send"
                    >
                        いいね
                    </button>
                    <button
                        class="like_button"
                        type="submit"
                        name="FlagButton"
                        value="send"
                    >
                        フラグ
                    </button>
                </div>
            </div>
            <div class="post">
                <h3>投稿3</h3>
                <p>サンプル投稿を表示</p>
                <div class="button-post">
                    <button
                        class="like_button"
                        type="submit"
                        name="LikeButton"
                        value="send"
                    >
                        いいね
                    </button>
                    <button
                        class="like_button"
                        type="submit"
                        name="FlagButton"
                        value="send"
                    >
                        フラグ
                    </button>
                </div>
            </div>
            <div class="post">
                <h3>投稿4</h3>
                <p>サンプル投稿を表示</p>
                <div class="button-post">
                    <button
                        class="button3"
                        type="submit"
                        name="LikeButton"
                        value="send"
                    >
                        いいね
                    </button>
                    <button
                        class="button3"
                        type="submit"
                        name="FlagButton"
                        value="send"
                    >
                        フラグ
                    </button>
                </div>
            </div>
        </div>
        <br />
        <br />

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
