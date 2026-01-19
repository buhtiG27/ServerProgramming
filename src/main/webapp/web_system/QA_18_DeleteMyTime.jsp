<%-- バックエンド側が実装できていない --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>マイ時間割削除画面 | 電大生のQ&A</title>
        <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_18_DeleteMyTime.css"
        />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
        <!-- cssでスマホ用のデザインをするために書く -->
    </head>
    <body>
        <%--　ロゴに置き換える --%>
        <header><jsp:include page="header.jsp" /><!-- ヘッダ --></header>

        <div class="header_area">
            <form action="${pageContext.request.contextPath}/timetable" method="get">
                <button class="cancel_button" type="submit" name="cancel" value="send">キャンセル</button>
            </form>
            <h2>マイ時間割削除</h2>
            <form action="${pageContext.request.contextPath}/timetable" method="get">
                <button class="save_button" type="submit" name="filterbySameGrade" value="send">変更保存</button>
            </form>
        </div>
        <br />
        <%-- 置き換え --%>
        <div class="time-list">
    	<table border="1">
    	<tr>
        <th></th>
        <th>月</th><th>火</th><th>水</th><th>木</th><th>金</th>
    	</tr>

    	<%
    	// サーブレットから受け取ったtimetableを取得
    	Map<String, Map<String, Object>> timetable = (Map<String, Map<String, Object>>) request.getAttribute("timetable");
    
    	for (int p = 1; p <= 8; p++) {
    	%>
    	<tr>
        <th><%= p %>限</th>
        <%
        for (int d = 0; d < 5; d++) {
            String key = p + ":" + d;
            Map<String, Object> sub = (timetable != null) ? timetable.get(key) : null;
        %>
        <td style="text-align: center; vertical-align: middle; width: 100px; height: 70px;">
            <% if (sub != null) { %>
                <%-- 登録されている場合のみ表示 --%>
                <div class="cell-container">
                    <div style="font-size: 11px; font-weight: bold; margin-bottom: 5px;">
                        <%= sub.get("subject_name") %>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/timetable/delete" method="post" style="margin:0;">
                        <input type="hidden" name="subjectId" value="<%= sub.get("id") %>">
                        <button class="deleteButton" type="submit" 
                                style="background-color: #ff4d4d; color: white; border: none; border-radius: 50%; width: 22px; height: 22px; cursor: pointer;">
                            ×
                        </button>
                    </form>
                </div>
            <% } else { %>

            <% } %>
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
