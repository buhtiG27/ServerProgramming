<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %> 
<%
    request.setCharacterEncoding("UTF-8");

    // --- エラーメッセージ ---
    String errorMessage = "";

    // フォームの値
    String email = request.getParameter("EmailAddress");
    String pw = request.getParameter("Password");
    String uname = request.getParameter("Username");
    String grade = request.getParameter("GradeAndDepartment");
    String cls = request.getParameter("Classification");
    
    // 訂正ボタンからのリクエスト判定用
    String actionType = request.getParameter("actionType"); 

    // --- POST のときだけチェック ---
    if ("POST".equalsIgnoreCase(request.getMethod())) {

                if ("correction".equals(actionType)) {
                    } else {
            // 通常の「確認」ボタン押下の場合のみ、入力チェックを行う
            if (email == null || email.isEmpty()) {
                errorMessage = "メールアドレスを入力してください。";
            } else if (pw == null || pw.isEmpty()) {
                errorMessage = "パスワードを入力してください。";
            } else if (uname == null || uname.isEmpty()) {
                errorMessage = "ユーザ名を入力してください。";
            } else if (grade == null || grade.isEmpty()) {
                errorMessage = "学年・学科を入力してください。";
            } else if (cls == null || cls.isEmpty()) {
                errorMessage = "区分を入力してください。";
            }

            // --- エラーなしなら次画面へ遷移 ---
            if (errorMessage.isEmpty()) {

                String encodedEmail = URLEncoder.encode(email, "UTF-8");
                String encodedPw = URLEncoder.encode(pw, "UTF-8");
                String encodedUname = URLEncoder.encode(uname, "UTF-8");
                String encodedGrade = URLEncoder.encode(grade, "UTF-8");
                String encodedCls = URLEncoder.encode(cls, "UTF-8");

                String redirectUrl = "QA_06_NewCheck.jsp"
                                   + "?EmailAddress=" + encodedEmail
                                   + "&Password=" + encodedPw
                                   + "&Username=" + encodedUname
                                   + "&GradeAndDepartment=" + encodedGrade
                                   + "&Classification=" + encodedCls;

                response.sendRedirect(redirectUrl);
                return;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>新規ログイン</title>
		<link rel="stylesheet" href="css/style_5_New.css">
	</head>
	<body>

    	<div class="top_button">
        	<h1>TDU</h1>
        	<form action="QA_01_Login.jsp" method="get">
            	<button class="button" type="submit" name="back" value="send">戻る</button>
        	</form>
        	<br>
       　	<a>新規ログイン</a>
        	<br>
    	</div>

    	<div class="request_list">

        	<% if (!errorMessage.isEmpty()) { %>
            	<p style="color:red; font-weight:bold;"><%= errorMessage %></p>
        	<% } %>

        	<form action="QA_05_NewRegister.jsp" method="post">

            	<label for="email">メールアドレス：</label><br>
            	<input class="txt" type="text" size="20" name="EmailAddress"
                       	value="<%= (email != null ? email : "") %>"/>
            	<br><br>

            	<label for="pw">パスワード：</label><br>
            	<input class="txt" type="password" size="32" name="Password"
                       value="<%= (pw != null ? pw : "") %>"/>
            	<br><br>

            	<label for="name">ユーザ名：</label><br>
            	<input class="txt" type="text" size="20" name="Username"
                       value="<%= (uname != null ? uname : "") %>"/>
            	<br><br>

            	<label for="grade">学年・学科：</label><br>
            	<input class="txt" type="text" size="20" name="GradeAndDepartment"
                       value="<%= (grade != null ? grade : "") %>"/>
            	<br><br>
			
            	<label for="class">区分：</label><br>
            	<input class="txt" type="text" size="20" name="Classification"
                       value="<%= (cls != null ? cls : "") %>"/>
            	<br><br>
			
            	<button class="button1" type="submit" name="Login" value="send">確認</button>
        	</form>
    	</div>
		
	</body>
</html>