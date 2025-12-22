<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>管理者・質問削除画面</title>
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_30_DeleteQuestion.css"
        />
    </head>
    <body>
        <%--　ロゴに置き換える --%>
        <div class="top_button">
            <h1>TDU</h1>
            <form action="" method="get">
                検索：
                <input
                    class="txt"
                    type="text"
                    size="20"
                    value=""
                    name="searchbyKeyword"
                />
            </form>
            <button
                class="button"
                type="submit"
                name="filterbyNew"
                value="send"
            >
                新着
            </button>
            <button
                class="button"
                type="submit"
                name="filterbySameGrade"
                value="send"
            >
                学科
            </button>
            <button
                class="button"
                type="submit"
                name="filterbyFlag"
                value="send"
            >
                フラグ付き
            </button>
        </div>
        <br />
        <%-- 置き換え --%>
        <div class="post-list">
            <div class="post">
                <form action="" method="get">
                    <button
                        class="show_button"
                        type="submit"
                        name="filterbyNew"
                        value="send"
                    >
                        投稿１
                    </button>
                </form>

                <!-- ★ 右上削除ボタン -->
                <!-- action="DeleteQuestionServlet" -->
                <form
                    action="${pageContext.request.contextPath}/DeleteQuestionServlet"
                    method="post"
                >
                    <button
                        class="delete_button"
                        type="submit"
                        name="deleteId"
                        value="1"
                    >
                        削除
                    </button>
                </form>
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
                <form
                    action="${pageContext.request.contextPath}/DeleteQuestionServlet"
                    method="post"
                >
                    <button
                        class="delete_button"
                        type="submit"
                        name="deleteId"
                        value="1"
                    >
                        削除
                    </button>
                </form>
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
                <form
                    action="${pageContext.request.contextPath}/DeleteQuestionServlet"
                    method="post"
                >
                    <button
                        class="delete_button"
                        type="submit"
                        name="deleteId"
                        value="1"
                    >
                        削除
                    </button>
                </form>
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
                <form
                    action="${pageContext.request.contextPath}/DeleteQuestionServlet"
                    method="post"
                >
                    <button
                        class="delete_button"
                        type="submit"
                        name="deleteId"
                        value="1"
                    >
                        削除
                    </button>
                </form>
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
        <br />
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
