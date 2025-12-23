<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");

String errorMessage = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>科目作成画面</title>
                <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_20_CreateSubject.css"
        />
    </head>
    <body>
        <%--　ロゴに置き換える --%>
        <header>
            <jsp:include
                page="header.jsp"
            /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
        </header>

        <!-- 戻るボタンとタイトル -->
        <div class="header_area">
            <form
                action="${pageContext.request.contextPath}/subjects"
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
            <h1 class="page_title">科目作成</h1>
        </div>
        <div class="create_list">
    <% if (errorMessage != null) { %>
        <p style="color:red; font-weight:bold;"><%= errorMessage %></p>
    <% } %>
    
    <form action="${pageContext.request.contextPath}/subjects/register" method="post">
        <input type="hidden" name="weekday" value="<%= request.getParameter("weekday") %>">
        <input type="hidden" name="time" value="<%= request.getParameter("time") %>">

        <label>授業名：</label><br />
        <input class="txt" type="text" name="subjectName" required /><br /><br />

        <label>教員名：</label><br />
        <input class="txt" type="text" name="teacher" required /><br /><br />

        <label>教室：</label><br />
        <input class="txt" type="text" name="classRoom" required /><br /><br />

        <button class="regist_button" type="submit">登録</button>
    </form>
	</div>
        </div>
    </body>
</html>
