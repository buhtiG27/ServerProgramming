<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>マイ時間割削除画面</title>
                <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${page.Context.request.contextPath}/web_system/css/style_18_DeleteMyTime.css"
        />
    </head>
    <body>
        <%--　ロゴに置き換える --%>
        <header>
            <jsp:include
                page="header.jsp"
            /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
        </header>
        <div class="header_area">
            <form
                action="${page.Context.request.contextPath}/web_system/QA_03_MyTime.jsp"
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
            <h2>科目削除</h2>
            <form
                action="${page.Context.request.contextPath}/web_system/QA_03_MyTime.jsp"
                method="get"
            >
                <button
                    class="save_button"
                    type="submit"
                    name="filterbySameGrade"
                    value="send"
                >
                    変更保存
                </button>
            </form>
        </div>
        <br />
        <%-- 置き換え --%>
        <div class="time-list">
            <table>
                <tr>
                    <%String[] days = {" ","月","火","水","木","金","土"};%> <%
                    for (int d = 0; d < 7; d++) { %>
                    <th><%= days[d] %></th>
                    <% } %>
                </tr>
                <% for(int i = 1; i < 9; i++){ %>
                <tr>
                    <th><%= i%>限</th>
                    <% for(int j = 0; j < 6; j++){ %>
                    <td>
                        <div class="cell-container">
                            <form class="delete-form" action="" method="post">
                                <input type="hidden" name="deleteSubject" />
                                <button class="deleteButton" type="submit">
                                    ×
                                </button>
                            </form>

                            <form action="" method="post">
                                <input type="hidden" name="searchSubject" />
                                <input
                                    type="hidden"
                                    name="showRegisteredSubject"
                                />
                                <button class="displayButton" type="submit">
                                    登録/表示
                                </button>
                            </form>
                        </div>
                    </td>
                    <% } %>
                </tr>
                <% } %>
            </table>
        </div>
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
