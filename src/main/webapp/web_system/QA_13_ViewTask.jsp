<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>課題詳細画面</title>
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_13_ViewTask.css"
        />
    </head>
    <body>
        <%-- トップボタン --%>
        <div class="top_button_area">
            <form
                action="${page.Context.request.contextPath}/questions"
                method="get"
            >
                <button
                    class="top_button"
                    type="submit"
                    name="back"
                    value="send"
                >
                    TDU
                </button>
            </form>
        </div>

        <div class="header_area">
            <form
                action="${page.Context.request.contextPath}/web_system/QA_21_DetailSubject.jsp"
                method="get"
            >
                <button
                    class="back_button"
                    type="submit"
                    name="back"
                    value="send"
                >
                    戻る
                </button>
            </form>
            <h1 class="page_title">課題詳細</h1>
        </div>

        <div class="filter_buttons">
            <button
                class="button"
                type="submit"
                name="filterbyNew"
                value="send"
            >
                課題詳細
            </button>
            <button
                class="button"
                type="submit"
                name="filterbySameGrade"
                value="send"
            >
                人気
            </button>
            <button
                class="button"
                type="submit"
                name="filterbyFlag"
                value="send"
            >
                新着
            </button>
        </div>

        <br />
        <%-- 置き換え --%>
        <div class="view_list">
            <h2 class="task_title">課題名サンプル</h2>
            <div class="edit">
                <form
                    action="${pageContext.request.contextPath}/web_system/QA_26_EditTask.jsp"
                    method="get"
                >
                    <button
                        class="edit_button"
                        type="submit"
                        name="edit"
                        value="send"
                    >
                        編集
                    </button>
                </form>
            </div>

            <div class="info_box">
                <label>授業名：</label>
                <div class="content_box">プログラミング応用Ⅰ</div>

                <label>内容：</label>
                <div class="content_box">
                    第5回レポート提出（Javaのクラス構成について）
                </div>

                <label>期限：</label>
                <div class="content_box">2025年11月10日（月）23:59</div>

                <label>提出場所：</label>
                <div class="content_box">LMS提出フォーム</div>

                <label>補足説明：</label>
                <div class="textarea_box">
                    提出形式はPDFで統一してください。ファイル名は「学籍番号_氏名.pdf」とすること。
                    内容が長い場合でも自動で折り返して表示されます。
                </div>
            </div>
        </div>
        
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
