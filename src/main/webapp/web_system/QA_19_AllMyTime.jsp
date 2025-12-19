<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>時間割一覧画面</title>
        <link
            rel="stylesheet"
            href="${page.Context.request.contextPath}/web_system/css/style_19_AllMyTime.css"
        />
    </head>
    <body>
        <header>
            <jsp:include
                page="header.jsp"
            /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
        </header>
        <div class="header_area">
            <form
                action="${page.Context.request.contextPath}/timetable"
                method="get"
            >
                <button
                    class="cancel_button"
                    type="submit"
                    name="filterbyNew"
                    value="send"
                >
                    キャンセル
                </button>
            </form>
            <h2>時間割一覧</h2>
            <form
                action="${page.Context.request.contextPath}/web_system/QA_20_CreateSubject.jsp"
            >
                <button
                    class="new_button"
                    type="submit"
                    name="filterbySameGrade"
                    value="send"
                >
                    新規作成
                </button>
            </form>
        </div>
        <br />
        <div class="body_area">
            <form action="" method="get" class="search_form">
                <label>検索：</label>
                <input
                    class="txt"
                    type="text"
                    size="20"
                    value=""
                    name="searchbyKeyword"
                />
            </form>
            <div class="subject_area">
                <form
                    action="${page.Context.request.contextPath}/web_system/QA_21_DetailSubject.jsp"
                    method="get"
                >
                    <button
                        class="show_button"
                        type="submit"
                        name="filterbyNew"
                        value="send"
                    >
                        科目1
                    </button>
                </form>
                <p>サンプル表示</p>
                <form
                    action="${page.Context.request.contextPath}/web_system/QA_03_MyTime.jsp"
                    method="post"
                >
                    <input
                        type="hidden"
                        name="message"
                        value="登録が完了しました。"
                    />
                    <button
                        class="register_button"
                        type="submit"
                        name="LikeButton"
                        value="send"
                    >
                        登録
                    </button>
                </form>
            </div>
            <div class="subject_area">
                <h3>科目1</h3>
                <p>サンプル表示</p>
                <form
                    action="${page.Context.request.contextPath}/web_system/QA_03_MyTime.jsp"
                    method="post"
                >
                    <input
                        type="hidden"
                        name="message"
                        value="登録が完了しました。"
                    />
                    <button
                        class="register_button"
                        type="submit"
                        name="LikeButton"
                        value="send"
                    >
                        登録
                    </button>
                </form>
            </div>
            <div class="subject_area">
                <h3>科目1</h3>
                <p>サンプル表示</p>
                <form
                    action="${page.Context.request.contextPath}/web_system/QA_03_MyTime.jsp"
                    method="post"
                >
                    <input
                        type="hidden"
                        name="message"
                        value="登録が完了しました。"
                    />
                    <button
                        class="register_button"
                        type="submit"
                        name="LikeButton"
                        value="send"
                    >
                        登録
                    </button>
                </form>
            </div>
        </div>
        <br />
        <br />
        <nav>
            <jsp:include page="navigation.jsp" />
        </nav>
    </body>
</html>
