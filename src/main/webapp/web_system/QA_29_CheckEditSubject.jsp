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
    		String subId = request.getParameter("subjectId");
    		String rawWeekday = request.getParameter("weekday");
    		String rawTime = request.getParameter("time");
    		String cls = request.getParameter("classneme");
    		String tea = request.getParameter("teacher");
    		String room = request.getParameter("roomname");
		%>
        <header><jsp:include page="header.jsp" /></header>
		<div class="request_list">
			<br>
    		授業名：<%= cls %><br><br>
    		教員名：<%= tea %><br><br>
    		教室名：<%= room %><br><br>
    		
    		<div class="bottom_buttons">
    			<form class="form" action="${pageContext.request.contextPath}/web_system/QA_28_EditSubject.jsp" method="post">
    				<input type="hidden" name="actionType" value="correction"> 
    				<input type="hidden" name="subjectId" value="<%= subId %>">
    				<input type="hidden" name="weekday" value="<%= rawWeekday %>">
    				<input type="hidden" name="time" value="<%= rawTime %>">
    				<input type="hidden" name="classneme" value="<%= cls %>">
    				<input type="hidden" name="teacher" value="<%= tea %>">
    				<input type="hidden" name="roomname" value="<%= room %>">
    				<button class="correctButton" type="submit">訂正</button>
				</form>
    			
    			<form class="form" action="${pageContext.request.contextPath}/subjects/update" method="post">
    				<input type="hidden" name="subjectId" value="<%= subId %>">
    				<input type="hidden" name="classneme" value="<%= cls %>">
    				<input type="hidden" name="teacher" value="<%= tea %>">
    				<input type="hidden" name="roomname" value="<%= room %>">
    				<button class="registerButton" type="submit">登録</button>
				</form>
    		</div>
    	
    	</div>
    
    </body>
</html>