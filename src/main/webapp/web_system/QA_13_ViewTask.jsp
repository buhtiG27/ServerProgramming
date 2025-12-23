<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Task" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>課題詳細画面</title>
                <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_13_ViewTask.css" />
    </head>
    <body>
        <header>
            <jsp:include
                page="header.jsp"
            /><!-- ヘッダ部分は1つの.jspにまとめた→こう書くだけで使いまわせる -->
        </header>

        <div class="header_area">
            <%-- 戻るボタン：DetailSubjectサーブレット経由で科目詳細に戻る --%>
            <form action="${pageContext.request.contextPath}/subjects/detail" method="get">
                <input type="hidden" name="subjectId" value="${task.subjectId}">
                <input type="hidden" name="weekday" value="${weekday}">
                <input type="hidden" name="time" value="${time}">
                <button class="back_button" type="submit">戻る</button>
            </form>
        </div>

        <%-- エラー表示用 --%>
        <c:if test="${not empty error}">
            <p style="color:red; text-align:center;">${error}</p>
        </c:if>

        <br />
        <div class="view_list">
            <h2 class="task_title">${task.content}</h2>
            
            <div class="edit">
                <form action="${pageContext.request.contextPath}/web_system/QA_26_EditTask.jsp" method="get">
                    <input type="hidden" name="taskId" value="${task.id}">
                    <button class="edit_button" type="submit">編集</button>
                </form>
            </div>

            <div class="info_box">
                <label>授業名：</label>
                <div class="content_box">${classname != null ? classname : "科目名不明"}</div>

                <label>内容：</label>
                <div class="content_box">${task.content}</div>

                <label>期限：</label>
                <div class="content_box">${task.limmit}</div>

                <label>提出場所：</label>
                <div class="content_box">${task.output}</div>

                <label>補足説明：</label>
                <div class="textarea_box">${task.detail}</div>
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
