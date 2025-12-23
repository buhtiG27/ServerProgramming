<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>質問一覧 | 電大生のQ&A</title>
                <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_11_SearchQuestion.css"
        />
    </head>
    <body>
        <%--　ロゴに置き換える --%>
        <div class="top_button">
            <h1>TDU</h1>
            <%-- 検索でキーワードに当てはまる質問を表示 --%>
            <form action="" method="get" class="search_form">
                <label>検索：</label>
                <input
                    class="txt"
                    type="text"
                    size="20"
                    value=""
                    name="searchbyKeyword"
                />
                <button
                    class="cancel_button"
                    type="submit"
                    name="cancel"
                    value="send"
                >
                    キャンセル
                </button>
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
        </div>
        <br />
        <br />
        <form
            action="${page.Context.request.contextPath}/web_system/QA_12_CreateQuestion.jsp"
            method="get"
        >
            <button
                class="createbutton"
                type="submit"
                name="createQuestion"
                value="send"
            >
                質問作成
            </button>
        </form>
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
