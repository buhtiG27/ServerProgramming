<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %> 
<%
    request.setCharacterEncoding("UTF-8");

    // --- エラーメッセージ ---
    String errorMessage = "";

    // フォームの値
    String cls = request.getParameter("classneme");
    String con = request.getParameter("content");
    String lim = request.getParameter("limmit");
    String output = request.getParameter("output");
    String detail = request.getParameter("detailcontent");
    
    // 訂正ボタンからのリクエスト判定用
    String actionType = request.getParameter("actionType"); 

    // --- POST のときだけチェック ---
    if ("POST".equalsIgnoreCase(request.getMethod())) {

                if ("correction".equals(actionType)) {
                    } else {
            // 通常の「確認」ボタン押下の場合のみ、入力チェックを行う
            if (cls == null || cls.isEmpty()) {
                errorMessage = "授業名を入力してください。";
            } else if (con == null || con.isEmpty()) {
                errorMessage = "内容を入力してください。";
            } else if (lim == null || lim.isEmpty()) {
                errorMessage = "期限を入力してください。";
            } else if (output == null || output.isEmpty()) {
                errorMessage = "提出場所を入力してください。";
            } else if (detail == null || detail.isEmpty()) {
                errorMessage = "補足説明を入力してください。ない場合、「特になし」と入力してください。";
            }

            // --- エラーなしなら次画面へ遷移 ---
            if (errorMessage.isEmpty()) {

            	String encodedCls = URLEncoder.encode(cls, "UTF-8");
                String encodedCon = URLEncoder.encode(con, "UTF-8");
                String encodedLim = URLEncoder.encode(lim, "UTF-8");
                String encodedOut = URLEncoder.encode(output, "UTF-8");
                String encodedDetail = URLEncoder.encode(detail, "UTF-8");

                String redirectUrl = "QA_24_CheckNewTask.jsp"
                        + "?classneme=" + encodedCls
                        + "&content=" + encodedCon
                        + "&limmit=" + encodedLim
                        + "&output=" + encodedOut
                        + "&detailcontent=" + encodedDetail;

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
		<title>課題新規作成画面</title>
		<link rel="stylesheet" href="css/style_23_NewCreateTask.css">
	</head>
	<body>
		<%--　ロゴに置き換える --%>
		<div class="top_button_area">
			<form action="QA_02_Questions.jsp" method="get">	
				<button class="top_button" type="submit" name="back" value="send">TDU</button>
			</form>
		</div>
		
		<!-- 戻るボタンとタイトル -->
		<div class="header_area">
			<form action="QA_21_DetailSubject.jsp" method="get">
				<button class="back_button" type="submit" name="back" value="send">戻る</button>
			</form>
			<h1 class="page_title">課題の新規作成</h1>
		</div>
		<br>
		<div class="view_list">
			<h2 class="task_title">課題の新規作成○○（授業名）</h2>
			<% if (!errorMessage.isEmpty()) { %>
				<p style="color:red; font-weight:bold;"><%= errorMessage %></p>
			<% } %>
			<div class="info_box">
				<form action="" method="post">
					<label for="cls">授業名：</label>
					<br>
					<input class="content_box" type="text" maxlength="50" name="classneme" 
					value="<%= (cls != null ? cls : "") %>"/>
					<br><br>
					<label for="con">内容：</label>
					<br>
					<input class="content_box" type="text" maxlength="200" name="content" 
					value="<%= (con != null ? con : "") %>"/>
					<br><br>
					<label for="lim">期限：</label>
					<br>
					<input class="content_box" type="text" maxlength="30" name="limmit" 
					value="<%= (lim != null ? lim : "") %>"/>
					<br><br>
					<label for="out">提出場所：</label>
					<br>
					<input class="content_box" type="text" maxlength="100" name="output"
					value="<%= (output != null ? output : "") %>"/>
					<br><br>
					<label for="detail">補足説明：</label><br>
					<input class="textarea_box" type="text" maxlength="400" name="detailcontent"
					value="<%= (detail != null ? detail : "") %>"/>
					<br><br>
					
					<button class="regist_button" type="submit" name="register" value="send">確認</button>
				</form>
			</div>
			<br>
		</div>
		<div class="bottom_buttons">
			<form class="form" action="" method="get">
				<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
			</form>
			<form class="form" action="QA_03_MyTime.jsp" method="get">
				<button class="pageButton" type="submit" name="toTimetable">マイ時間割</button>
			</form>
			<form class="form" action="QA_04_User.jsp" method="get">
				<button class="pageButton" type="submit" name="toUserInformation">ユーザ画面</button>
			</form>
		</div>
		
	</body>
</html>