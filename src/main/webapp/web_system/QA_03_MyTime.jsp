<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>マイ時間割 | 電大生のQ&A</title>
        <link
            rel="icon"
            href="${page.Context.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${page.Context.request.contextPath}/web_system/css/style_3_MyTime.css"
        />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"> <!-- Font Awesome を追加 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- cssでスマホ用のデザインをするために書く -->
    </head>
    <body>
        <header><jsp:include page="header.jsp" /><!-- ヘッダ --></header>

        <div class="header_area">
            <form action="QA_18_DeleteMyTime.jsp" method="get">
                <button
                    class="delete_button"
                    type="submit"
                    name="filterbyNew"
                    value="send"
                >
                    科目削除
                </button>
            </form>
            <h2>マイ時間割</h2>
            <form
                action="${page.Context.request.contextPath}/tasks"
                method="get"
            >
                <button
                    class="task_button"
                    type="submit"
                    name="filterbySameGrade"
                    value="send"
                >
                    課題一覧
                </button>
            </form>
        </div>
        <%-- 置き換え --%>
        <div class="time-list">
            <% String message = request.getParameter("message"); if (message !=
            null && !message.isEmpty()) { %>
            <p style="color: green; font-weight: bold"><%= message %></p>
            <% } %>
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
                        <form
                            action="${page.Context.request.contextPath}/timetable/search"
                            method="get"
                        >
                            <input type="hidden" name="searchSubject" />
                            <input type="hidden" name="showRegisteredSubject" />
                            <button class="displayButton" type="submit">
                                <%= "登録/表示" %>
                            </button>
                        </form>
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
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_02_Questions.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_home.png" alt="(質問一覧へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_03_MyTime.jsp" method="get">
                    <button class="pageButton toMytime" type="submit">
						<img src="<%= request.getContextPath() %>/web_system/images/icon_calender.png" alt="(マイ時間割だよ！)" class="icon_toMytime">
						<img src="<%= request.getContextPath() %>/web_system/images/icon_calender_hukidashi.png" alt="(マイ時間割だよ！)" class="icon_toMytime_hukidashi">
					</button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_04_User.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_gear.png" alt="(ユーザ情報へ)"></button>
                </form>
            </div>
		</nav>
    </body>
</html>
