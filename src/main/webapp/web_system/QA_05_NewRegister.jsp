<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %> 
<%
request.setCharacterEncoding("UTF-8");

String errorMessage = (String) request.getAttribute("error");

String email = (String) request.getAttribute("Address");
String pw = (String) request.getAttribute("Password");
String uname = (String) request.getAttribute("Username");
String grade = (String) request.getAttribute("Grade");
String cls = (String) request.getAttribute("Classification");
%>
<!DOCTYPE html>
<html lang="ja">
	<head>
	<meta charset="utf-8">
	<title>新規ログイン</title>
        <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
	<link rel="stylesheet" href="${page.Context.request.contextPath}/web_system/css/style_5_New.css">
</head>
	<body>

    <header>
            <jsp:include
                page="header.jsp"
            /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
        </header>
        <div class="header_area">
            <form
                action="${pageContext.request.contextPath}/timetable"
                method="get"
            >
                <button
                    class="back_button"
                    type="submit"
                    name="filterbyNew"
                    value="send"
                >
                    戻る
                </button>
            </form>
    </div>

    <div class="request_list">

        <% if (errorMessage != null) { %>
            <p style="color:red; font-weight:bold;"><%= errorMessage %></p>
        <% } %>

        <form action="${page.Context.request.contextPath}/register/check" method="post">

            <label for="email">メールアドレス（@ms.dendai.ac.jp）：</label><br>
            <input class="txt" type="text" size="256" name="Address" placeholder="s123456@ms.dendai.ac.jp"
                       value="<%= (email != null ? email : "") %>"/>
            <br><br>

            <label for="pw">パスワード（英数字を8文字以上含む）：</label><br>
            <input class="txt" type="password" size="32" name="Password"
                       value="<%= (pw != null ? pw : "") %>"/>
            <br><br>

            <label for="name">ユーザ名（表示名）：</label><br>
            <input class="txt" type="text" size="30" name="Username"
                       value="<%= (uname != null ? uname : "") %>"/>
            <br><br>

            <label for="grade">学年：</label><br>
            <input class="txt" type="text" size="10" name="Grade"
                       value="<%= (grade != null ? grade : "") %>"/>
            <br><br>

            <label for="class">区分：</label><br>
            <select class="txt" name="Classification">
                <option value="0" <%= ("0".equals(cls) || cls == null || cls.isEmpty()) ? "selected" : "" %>>選択してください</option>
                <option value="1" <%= "1".equals(cls) ? "selected" : "" %>>学生</option>
                <option value="2" <%= "2".equals(cls) ? "selected" : "" %>>副手</option>
                <option value="3" <%= "3".equals(cls) ? "selected" : "" %>>教員</option>
                <option value="4" <%= "4".equals(cls) ? "selected" : "" %>>管理者</option>
            </select>
            <br><br>

            <button class="button1" type="submit">確認</button>
        </form>
    </div>

	</body>
</html>