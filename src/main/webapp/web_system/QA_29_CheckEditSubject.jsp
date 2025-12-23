<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>科目編集確認画面</title>
		        <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_29_CheckEditSubject.css">
	</head>
	<body>
		<%
		request.setCharacterEncoding("UTF-8");
		
		// リクエスト・パラメータ取得 
		String cls = request.getParameter("classneme");
		String tea = request.getParameter("teacher");
		String room = request.getParameter("roomname");
		//List<Task> tasks = (List<Task>)request.getAttribute("taskList");
		%>
		
		<div class="top_button">
			<h1>TDU</h1>
			<br>
			<a>科目編集確認</a>
		</div>
		
		<div class="request_list">
			<br>
    		授業名：<%= cls %><br><br>
    		教員名：<%= tea %><br><br>
    		教室名：<%= room %><br><br>
    		
    		<div class="bottom_buttons">
    			<form class="form" action="${pageContext.request.contextPath}/web_system/QA_28_EditSubject.jsp" method="post">
    				<input type="hidden" name="actionType" value="correction"> 
    				<input type="hidden" name="classname" value="<%= cls %>">
    				<input type="hidden" name="teacher" value="<%= tea %>">
    				<input type="hidden" name="roomname" value="<%= room %>">
    				<button class="correctButton" type="submit">訂正</button>
    			</form>
    			
    			<form class="form" action="${pageContext.request.contextPath}/web_system/QA_21_DetailSubject.jsp" method="post">
    				<input type="hidden" name="classname" value="<%= cls %>">
    				<input type="hidden" name="teacher" value="<%= tea %>">
    				<input type="hidden" name="roomname" value="<%= room %>">
    				<input type="hidden" name="message" value="編集が完了しました。">
    				<button class="registerButton" type="submit">登録</button>
    			</form>
    		</div>
    	
    	</div>
    
    </body>
</html>