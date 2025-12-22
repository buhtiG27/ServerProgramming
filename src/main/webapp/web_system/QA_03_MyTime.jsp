<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>マイ時間割 | 電大生のQ&A</title>
        <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_3_MyTime.css"
        />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
        <!-- cssでスマホ用のデザインをするために書く -->
    </head>
    <body>
        <header><jsp:include page="header.jsp" /><!-- ヘッダ --></header>

        <div class="top_area">
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
                action="${pageContext.request.contextPath}/tasks"
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
        
        <!-- 時間割部分 -->
        <%-- 元のtime-list --%>
        <div class="time-list">
            <% String message = request.getParameter("message"); if (message !=
            null && !message.isEmpty()) { %>
            <p style="color: green; font-weight: bold"><%= message %></p>
            <% } %>
            <table border="1">
    <tr>
        <th></th>
        <th>月</th><th>火</th><th>水</th><th>木</th><th>金</th>
    </tr>

	<%
    Map<String, Map<String, Object>> timetable = (Map<String, Map<String, Object>>) request.getAttribute("timetable");
	if (timetable == null) {
	%>
	    <p style="color:red;">時間割データが取得できませんでした</p>
	<%
	    return;
	}
	%>

	<%
for (int p = 1; p <= 8; p++) {
%>
<tr>
    <th><%= p %>限</th>
    <%
    for (int d = 0; d < 5; d++) {
        String key = p + ":" + d;
        Map<String,Object> sub = timetable.get(key);

        Long subId = null;
        String displayName = "＋"; // 空セルのデフォルト表示
        String actionUrl = request.getContextPath() + "/subjects"; // デフォルトは一覧

        if (sub != null) {
            Object idObj = sub.get("id");
            subId = Long.valueOf(idObj.toString());
            
            
            displayName = sub.get("subject_name") != null ? sub.get("subject_name").toString() : "名称未設定";
            actionUrl = request.getContextPath() + "/subjects/detail";
        }

    %>
    <td style="text-align: center;">
    <form action="<%= actionUrl %>" method="get" style="margin:0;">
        <input type="hidden" name="subjectId" value="<%= subId %>">
        <input type="hidden" name="weekday" value="<%= d %>">
        <input type="hidden" name="time" value="<%= p %>">
        
        <button type="submit" class="timetable-btn">
            <%= displayName %>
        </button>
    </form>
	</td>
    <%
        }
    %>
</tr>
<%
}
%>

	</table>
        </div>
        <br />
        <br />

		<nav>
			<div class="bottom_button">
                <form class="form" action="${pageContext.request.contextPath}/questions" method="get">
                    <button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_home.png" alt="(質問一覧へ)"></button>
                </form>
                <form class="form" action="${pageContext.request.contextPath}/timetable" method="get">
                    <button class="pageButton toMytime" type="submit">
						<img src="${pageContext.request.contextPath}/web_system/images/icon_calender.png" alt="(マイ時間割だよ！)" class="icon_toMytime">
						<img src="${pageContext.request.contextPath}/web_system/images/icon_calender_hukidashi.png" alt="(マイ時間割だよ！)" class="icon_toMytime_hukidashi">
					</button>
                </form>
                <form class="form" action="${pageContext.request.contextPath}/user" method="get">
                    <button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_gear.png" alt="(ユーザ情報へ)"></button>
                </form>
            </div>
		</nav>
    </body>
</html>
