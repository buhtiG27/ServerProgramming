<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>時間割一覧画面</title>
                <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_19_AllMyTime.css"
        />
    </head>
    <body>
        <header>
            <jsp:include
                page="header.jsp"
            /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
            
            <h2>時間割一覧</h2>
            
        </header>
        <div class="header_area">
            <form
                action="${pageContext.request.contextPath}/timetable"
                method="get"
            >
                <button
                    class="cancel_button"
                    type="submit"
                    name="filterbyNew"
                    value="send"
                >
                    キャンセル
                </button>
            </form>
		<form action="" method="get" class="search_form">
			<label>検索：</label>
			<input class="txt" type="text" size="20" value="" name="searchbyKeyword" />	
		</form>
		<form action="${pageContext.request.contextPath}/web_system/QA_20_CreateSubject.jsp">
    			<input type="hidden" name="weekday" value="<%= request.getParameter("weekday") %>">
    			<input type="hidden" name="time" value="<%= request.getParameter("time") %>">
    			<button class="new_button" type="submit">新規作成</button>
			</form>	
        </div>
        <br />
        <div class="body_area">
        
		<%
		List<Map<String, Object>> subjects = (List<Map<String, Object>>) request.getAttribute("subjects");			
		if (subjects == null || subjects.isEmpty()) {
	%>
		<p style="color:gray;">登録されている科目はありません</p>
	<%
		} else {
   			for (Map<String, Object> sub : subjects) {
   				pageContext.setAttribute("sub", sub);
	%>
		<div class="subject_area">
    	<h3>${sub['subject_name']}</h3>
        <p>教員: ${sub['teacher']}</p>

    	<form action="${pageContext.request.contextPath}/subjects/detail" method="get">
    		<input type="hidden" name="subjectId" value="${sub['ID']}">
    
    		<%-- 追加：GoのAPIを叩くために必要な情報を引き継ぐ --%>
    		<input type="hidden" name="weekday" value="<%= request.getParameter("weekday") %>">
    		<input type="hidden" name="time" value="<%= request.getParameter("time") %>">
    
    		<button class="show_button" type="submit">詳細</button>
		</form>

            <form action="${pageContext.request.contextPath}/timetable" method="post">
                <input type="hidden" name="subjectId" value="${sub['ID']}">
                <button class="register_button" type="submit">登録</button>
            </form>
        </div>
		<%
		    }
		}
		%>
	</div>
        <br />
        <br />
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
