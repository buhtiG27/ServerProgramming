<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // サーブレットが受け取った「数値」をそのまま取得しておく
    String rawWeekday = request.getParameter("weekday");
    String rawTime = request.getParameter("time");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="utf-8">
    <title>科目詳細画面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_21_DetailSubject.css">
</head>
<body>
    <div class="top_button_area">
        <form action="${pageContext.request.contextPath}/questions" method="get">
            <button class="top_button" type="submit">TDU</button>
        </form>
    </div>
    
    <div class="header_area">
        <form action="${pageContext.request.contextPath}/subjects" method="get">
                    <input type="hidden" name="weekday" value="<%= rawWeekday %>">
    				<input type="hidden" name="time" value="<%= rawTime %>">
            <button class="back_button" type="submit">戻る</button>
        </form>
        <h1 class="page_title">科目詳細</h1>
    </div>
    
    <%-- サーブレットから渡された 'subject' マップを取得 --%>
    <% Map<String, Object> subject = (Map<String, Object>) request.getAttribute("subject"); 
    	if (subject == null) {
        	out.println("<p style='color:red;'>Debug: サーブレットからデータが届いていません (subject is null)</p>");
    	} else {
    	    pageContext.setAttribute("subject", subject);
    	}
    %>

    <div class="view_list">
    <%-- 取得できたキー名に合わせて表示 --%>
    <h2 class="task_title">${subject['subject_name']}</h2>
    
    <div class="edit_create">
        <form action="${pageContext.request.contextPath}/web_system/QA_28_EditSubject.jsp" method="get">
            <input type="hidden" name="subjectId" value="${subject['ID']}">
            <button class="edit_button" type="submit">編集</button>
        </form>
    </div>
    <div class="info_box">
    	<label>授業名：</label>
    	<div class="content_box">${subject['subject_name']}</div>

    	<label>教員名：</label>
    	<div class="content_box">${subject['teacher']}</div>
    
    	<label>教室：</label>
    	<div class="content_box">${subject['class_room']}</div>
    	
    	<label>曜日・時限：</label>
        <div class="content_box">${subject['weekday']}曜 ${subject['time']}限</div>

        <label>期間：</label>
        <div class="content_box">${subject['period']}</div>
	</div>

        <label>課題：
            <div class="new_create">
                <form action="${pageContext.request.contextPath}/web_system/QA_23_NewCreateTask.jsp" method="get">
                    <input type="hidden" name="subjectId" value="${subject['ID']}">
                    <input type="hidden" name="weekday" value="<%= rawWeekday %>">
    				<input type="hidden" name="time" value="<%= rawTime %>">
    				<input type="hidden" name="classname" value="${subject['subject_name']}">
                    <button class="new_create_button" type="submit">新規作成</button>
                </form>
            </div>
        </label>

        <div class="textarea_box">
    <ul>
    <%
        // request.getAttribute("practices") が List<Object> として届く
        Object practicesObj = request.getAttribute("practices");
        List<Map<String, Object>> tasks = (List<Map<String, Object>>) practicesObj;
        
        if (tasks == null || tasks.isEmpty()) {
    %>
        <p style="color:gray;">登録されている課題はありません</p>
    <%
        } else {
            for (Map<String, Object> t : tasks) {
                // デバッグ用にキーを確認する場合（任意）: System.out.println("Keys: " + t.keySet());
                
                // キー名が 'practice_name' か 'PracticeName' か 'subject_id' になっていないか確認
                String pName = (t.get("practice_name") != null) ? t.get("practice_name").toString() 
                             : (t.get("PracticeName") != null) ? t.get("PracticeName").toString() : "名称未設定";
                Object pId = (t.get("ID") != null) ? t.get("ID") : t.get("id");
    %>
        <div class="task_item">
            <form action="${pageContext.request.contextPath}/tasks/view" method="get"> 
                <input type="hidden" name="taskId" value="<%= pId %>" />
                <button class="task_link" type="submit"><%= pName %></button>
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
			<div class="bottom_button">
                <form class="form" action="${pageContext.request.contextPath}/questions" method="get">
                    <button class="pageButton toQuestions" type="submit">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_home.png" alt="(質問一覧だよ！)" class="icon_toQuestions">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_home_hukidashi.png" alt="(質問一覧だよ！)" class="icon_toQuestions_hukidashi">
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