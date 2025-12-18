<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %> 
<%
    request.setCharacterEncoding("UTF-8");

    // --- エラーメッセージ ---
    String errorMessage = "";

    // フォームの値
    String cls = request.getParameter("classneme");
    String tea = request.getParameter("teacher");
    String room = request.getParameter("roomname");
    //List<Task> tasks = (List<Task>)request.getAttribute("taskList");
    
    // 訂正ボタンからのリクエスト判定用
    String actionType = request.getParameter("actionType"); 

    // --- POST のときだけチェック ---
    if ("POST".equalsIgnoreCase(request.getMethod())) {

                if ("correction".equals(actionType)) {
                    } else {
            // 通常の「確認」ボタン押下の場合のみ、入力チェックを行う
            if (cls == null || cls.isEmpty()) {
                errorMessage = "授業名を入力してください。";
            } else if (tea == null || tea.isEmpty()) {
                errorMessage = "内容を入力してください。";
            } else if (room == null || room.isEmpty()) {
                errorMessage = "期限を入力してください。";
            } 

            // --- エラーなしなら次画面へ遷移 ---
            if (errorMessage.isEmpty()) {

            	String encodedCls = URLEncoder.encode(cls, "UTF-8");
                String encodedTea = URLEncoder.encode(tea, "UTF-8");
                String encodedRoom = URLEncoder.encode(room, "UTF-8");
                //List<Task> encodedTasks = URLEncoder.encode(tasks, "UTF-8");

                String redirectUrl = "QA_29_CheckEditSubject.jsp"
                        + "?classneme=" + encodedCls
                        + "&teacher=" + encodedTea
                        + "&roomname=" + encodedRoom;
                        //+ "&taskList=" + encodedOutl;

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
		<title>科目編集画面</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_28_EditSubject.css">
	</head>
	<body>
		<%-- トップボタン --%>
		<header>
			<jsp:include page="header.jsp" /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
		</header>
		
		<!-- 戻るボタンとタイトル -->
		<div class="header_area">
			<form action="${pageContext.request.contextPath}/web_system/QA_21_DetailSubject.jsp" method="get">
				<button class="back_button" type="submit" name="back" value="send">戻る</button>
			</form>
			<h1 class="page_title">科目編集</h1>
		</div>
		<% if (!errorMessage.isEmpty()) { %>
			<p style="color:red; font-weight:bold;"><%= errorMessage %></p>
		<% } %>
		
		<!-- フィルターボタン3つ -->
		<div class="filter_buttons">
			<button class="button" type="submit" name="filterbyNew" value="send">課題詳細</button>
			<button class="button" type="submit" name="filterbySameGrade" value="send">人気</button>
			<button class="button" type="submit" name="filterbyFlag" value="send">新着</button>
		</div>
		
		<br>
		
		<%-- 置き換え --%>
		<div class="view_list">
			<form action="" method="post">
				<div class="info_box">
					<label>授業名：</label>
					<input class="content_box" type="text" maxlength="50" name="classneme"
					value="<%= cls %>"/>
					
					<label>教室名：</label>
					<input class="content_box" type="text" maxlength="50" name="teacher"
					   value="<%= tea %>"  />

					<label>教室：</label>
					<input class="content_box" type="text" maxlength="50" name="roomname"
					value="<%= room %>"  />
					
					<label>課題：</label>
					<div class="textarea_box">
						<ul>
							<%--
							List<Task> tasks = (List<Task>)request.getAttribute("taskList");
							if (tasks != null) {
								for (Task t : tasks) {
							--%>
							<div class="task_item">
								<form action="">
									<button class="task_link">課題１</button>
								</form>
							</div>
							
							<div class="task_item">
								<form action="">
									<button class="task_link">課題２</button>
								</form>
							</div>
							<%--
								}
							}
							--%>
						</ul>
					</div>
					
					<button class="save_button" type="submit" name="save" value="send">保存</button>
				</div>
			</form>
			
			<br>
		</div>
		
		<nav>
			<jsp:include page="navigation.jsp" />
		</nav>
		
	</body>
</html>