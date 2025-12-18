<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>ユーザ画面</title>
        <link
            rel="stylesheet"
            href="${page.Context.request.contextPath}/web_system/css/style_4_User.css"
        />
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
            <jsp:include page="navigation.jsp" />
        </nav>
    </body>
</html>
