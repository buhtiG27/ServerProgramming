<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ page
import="java.net.URLEncoder" %> <% request.setCharacterEncoding("UTF-8"); // ---
エラーメッセージ --- String errorMessage = ""; // フォームの値 String cls =
request.getParameter("classneme"); String con = request.getParameter("content");
String lim = request.getParameter("limmit"); String output =
request.getParameter("output"); String detail =
request.getParameter("detailcontent"); // 訂正ボタンからのリクエスト判定用
String actionType = request.getParameter("actionType"); // --- POST
のときだけチェック --- if ("POST".equalsIgnoreCase(request.getMethod())) { if
("correction".equals(actionType)) { } else { //
通常の「確認」ボタン押下の場合のみ、入力チェックを行う if (cls == null ||
cls.isEmpty()) { errorMessage = "授業名を入力してください。"; } else if (con ==
null || con.isEmpty()) { errorMessage = "内容を入力してください。"; } else if
(lim == null || lim.isEmpty()) { errorMessage = "期限を入力してください。"; }
else if (output == null || output.isEmpty()) { errorMessage =
"提出場所を入力してください。"; } else if (detail == null || detail.isEmpty()) {
errorMessage =
"補足説明を入力してください。ない場合、「特になし」と入力してください。"; } //
--- エラーなしなら次画面へ遷移 --- if (errorMessage.isEmpty()) { String
encodedCls = URLEncoder.encode(cls, "UTF-8"); String encodedCon =
URLEncoder.encode(con, "UTF-8"); String encodedLim = URLEncoder.encode(lim,
"UTF-8"); String encodedOut = URLEncoder.encode(output, "UTF-8"); String
encodedDetail = URLEncoder.encode(detail, "UTF-8"); String redirectUrl =
"QA_27_CheckEdiTask.jsp" + "?classneme=" + encodedCls + "&content=" + encodedCon
+ "&limmit=" + encodedLim + "&output=" + encodedOut + "&detailcontent=" +
encodedDetail; response.sendRedirect(redirectUrl); return; } } } %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>課題編集画面</title>
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_26_EditTask.css"
        />
    </head>
    <body>
        <%-- トップボタン --%>
        <header>
            <jsp:include
                page="header.jsp"
            /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
        </header>

        <!-- 戻るボタンとタイトル -->
        <div class="header_area">
            <form
                action="${pageContext.request.contextPath}/web_system/QA_13_ViewTask.jsp"
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
            <h1 class="page_title">課題編集</h1>
        </div>

        <br />
        <%-- 置き換え --%>
        <div class="view_list">
            <h2 class="task_title">課題名サンプル</h2>

            <% if (!errorMessage.isEmpty()) { %>
            <p style="color: red; font-weight: bold"><%= errorMessage %></p>
            <% } %>
            <div class="info_box">
                <form action="" method="post">
                    <label for="cls">授業名：</label><br />
                    <input
                        class="content_box"
                        type="text"
                        maxlength="50"
                        name="classneme"
                        value="<%= (cls != null ? cls : cls) %>"
                    />
                    <br /><br />
                    <label for="con">内容：</label><br />
                    <input
                        class="content_box"
                        type="text"
                        maxlength="200"
                        name="content"
                        value="<%= (con != null ? con : con) %>"
                    />
                    <br /><br />

                    <label for="lim">期限：</label><br />
                    <input
                        class="content_box"
                        type="text"
                        maxlength="30"
                        name="limmit"
                        value="<%= (lim != null ? lim : lim) %>"
                    />
                    <br /><br />

                    <label for="out">提出場所：</label><br />
                    <input
                        class="content_box"
                        type="text"
                        maxlength="100"
                        name="output"
                        value="<%= (output != null ? output : output) %>"
                    />
                    <br /><br />

                    <label for="detail">補足説明：</label><br />
                    <input
                        class="textarea_box"
                        type="text"
                        maxlength="400"
                        name="detailcontent"
                        value="<%= (detail != null ? detail : detail) %>"
                    />

                    <br /><br />

                    <button
                        class="regist_button"
                        type="submit"
                        name="register"
                        value="send"
                    >
                        確認
                    </button>
                </form>
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
