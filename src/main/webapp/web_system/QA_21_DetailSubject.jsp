<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>科目詳細画面</title>
		<link rel="stylesheet" href="${page.Context.request.contextPath}/web_system/css/style_21_DetailSubject.css">
	</head>
	<body>
		<%--　ロゴに置き換える --%>
		<div class="top_button_area">
			<form action="${pageContext.request.contextPath}/questions" method="get">
			<button class="top_button" type="submit" name="back" value="send">TDU</button>
			</form>
		</div>
		
		<!-- 戻るボタンとタイトル -->
		<div class="header_area">
			<form action="${pageContext.request.contextPath}/subjects" method="get">
				<button class="back_button" type="submit" name="back" value="send">戻る</button>
			</form>
			<h1 class="page_title">科目詳細</h1>
		</div>
		
		<div class="view_list">
			<h2 class="task_title">
				${sub['subject_name']}
			</h2>
			<div class="edit_create">
				<form action="${pageContext.request.contextPath}/web_system/QA_28_EditSubject.jsp" method="get">
					<button class="edit_button" type="submit" name="edit" value="send">編集</button>
				</form>
			</div>
			<div class="info_box">
				<label>授業名：</label>
				<div class="content_box">${sub['subject_name']}
				</div>
		
				<label>教員名：</label>
				<div class="content_box">${sub['teacher']}
				</div>
				
				<label>教室：</label>
				<div class="content_box">${sub['class_room']}
				</div>
			</div>
			<label>課題：
				<div class="new_create">
					<form action="${pageContext.request.contextPath}/web_system/QA_23_NewCreateTask.jsp" method="get">
						<button class="new_create_button" type="submit" name="edit" value="send">新規作成</button>
					</form>
				</div>
			</label>
			<div class="textarea_box">
				<ul>
				<%
				List<Map<String, Object>> tasks = (List<Map<String, Object>>) request.getAttribute("practices");
				if (tasks != null) {
					for (Task t : tasks) {
				%>
				<%
				if (tasks == null || tasks.isEmpty()) {
			%>
    			<p style="color:gray;">投稿されている質問はありません</p>
			<%
				} else {
    				for (Map<String, Object> t : tasks) {
						pageContext.setAttribute("t", t);
			%>
				<div class="task_item">
					<form action="${pageContext.request.contextPath}/tasks/view"> 
						<input type="hidden" name="source" value="<%= q.get("id") %>}" /> <%--  隠しフィールド --%>
						<button class="task_link">${sub['practice_name']}</button>
					</form>
				</div>
				
    		    <%
    		    		}
 		           }
   		    	%>
   		    	</ul>	
			</div>
		</div>
		<nav>
			<jsp:include page="navigation.jsp" />
		</nav>
	</body>
</html>