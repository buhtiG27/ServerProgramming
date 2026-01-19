<%-- バックエンド側の実装ができていない --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>課題編集確認画面</title>
                <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_27_CheckEditTask.css"
        />
    </head>
    <body>
        <%
    		request.setCharacterEncoding("UTF-8");

    		String taskId = request.getParameter("taskId");
    		String weekday = request.getParameter("weekday");
    		String time = request.getParameter("time");
    
    		String cls = request.getParameter("classneme"); 
    		String con = request.getParameter("content"); 
    		String lim = request.getParameter("limmit"); 
    		String output = request.getParameter("output"); 
    		String ditail = request.getParameter("detailcontent"); 
		%>

        <header><jsp:include page="header.jsp" /></header>
        <div class="request_list">
            <br />
            授業名：<%= cls %><br /><br />
            内容：<%= con %><br /><br />
            期限：<%= lim %><br /><br />
            提出場所：<%= output %><br /><br />
            補足説明：<%= ditail %><br /><br />

            <div class="bottom_buttons">
                <form class="form" action="${pageContext.request.contextPath}/web_system/QA_26_EditTask.jsp" method="post">
            		<input type="hidden" name="actionType" value="correction" />
            		<input type="hidden" name="taskId" value="<%= taskId %>" />
            		<input type="hidden" name="weekday" value="<%= weekday %>" />
            		<input type="hidden" name="time" value="<%= time %>" />
            		<input type="hidden" name="classneme" value="<%= cls %>" />
            		<input type="hidden" name="content" value="<%= con %>" />
            		<input type="hidden" name="limmit" value="<%= lim %>" />
            		<input type="hidden" name="output" value="<%= output %>" />
            		<input type="hidden" name="detailcontent" value="<%= ditail %>" />
            		<button class="correctButton" type="submit">訂正</button>
        		</form>

                <%-- form class="form" action="${pageContext.request.contextPath}/tasks/update" method="post" --%>
                <form class="form">
            		<input type="hidden" name="taskId" value="<%= taskId %>" />
            		<input type="hidden" name="weekday" value="<%= weekday %>" />
            		<input type="hidden" name="time" value="<%= time %>" />
            		<input type="hidden" name="classneme" value="<%= cls %>" />
            		<input type="hidden" name="content" value="<%= con %>" />
            		<input type="hidden" name="limmit" value="<%= lim %>" />
            		<input type="hidden" name="output" value="<%= output %>" />
            		<input type="hidden" name="detailcontent" value="<%= ditail %>" />
            		<button class="registerButton" type="submit">登録</button>
        		</form>
            </div>
        </div>
    </body>
</html>
