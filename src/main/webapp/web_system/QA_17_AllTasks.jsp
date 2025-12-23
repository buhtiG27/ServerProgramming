<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Task" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>課題一覧画面</title>
        <link
            rel="icon"
            href="${pageContext.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_17_AllTasks.css"
        />
    </head>
    <body>
        <div class="top_button_area">
            <form action="" method="get">
                <button
                    class="top_button"
                    type="submit"
                    name="back"
                    value="send"
                >
                    TDU
                </button>
            </form>
        </div>
        <div class="header_area">
            <form
                action="${pageContext.request.contextPath}/timetable"
                method="get"
            >
                <button
                    class="back_button"
                    type="submit"
                    name="filterbyNew"
                    value="send"
                >
                    戻る
                </button>
            </form>
            <h2>課題一覧</h2>
        </div>
        <br />
        <div class="body_area">
            <form action="" method="get" class="search_form">
                <label>検索：</label>
                <input
                    class="txt"
                    type="text"
                    size="20"
                    value=""
                    name="searchbyKeyword"
                />
            </form>
            <% List<Task> taskList = (List<Task>) request.getAttribute("tasks");
			for (Task task: taskList) { 
				pageContext.setAttribute("task", task);
			%>
            <div class="subject_area">
                <form action="${pageContext.request.contextPath}/tasks/view" method="get">
					<input type="hidden" name="taskId" value="${task.id}" />
					<input type="hidden" name="weekday" value="${task.subjectWeekdayNum}" />
					<input type="hidden" name="time" value="${task.subjectTime}" />
                    <button
                        class="show_button"
                        type="submit"
                        name="filterbyNew"
                        value="send"
                    >
					${task.content}
                    </button>
                </form>
                <p>期日：${task.limmit}</p>
            </div>
            <% } %>
        </div>
        <br />
        <br />

        <nav>
            <div class="bottom_button">
                <form
                    class="form"
                    action="${pageContext.request.contextPath}/questions"
                    method="get"
                >
                    <button class="pageButton toQuestions" type="submit">
                        <img
                            src="${pageContext.request.contextPath}/web_system/images/icon_home.png"
                            alt="(質問一覧だよ！)"
                            class="icon_toQuestions"
                        />
                        <img
                            src="${pageContext.request.contextPath}/web_system/images/icon_home_hukidashi.png"
                            alt="(質問一覧だよ！)"
                            class="icon_toQuestions_hukidashi"
                        />
                    </button>
                </form>
                <form
                    class="form"
                    action="${pageContext.request.contextPath}/timetable"
                    method="get"
                >
                    <button class="pageButton" type="submit">
                        <img
                            src="${pageContext.request.contextPath}/web_system/images/icon_calender.png"
                            alt="(マイ時間割へ)"
                        />
                    </button>
                </form>
                <form
                    class="form"
                    action="${pageContext.request.contextPath}/user"
                    method="get"
                >
                    <button class="pageButton" type="submit">
                        <img
                            src="${pageContext.request.contextPath}/web_system/images/icon_gear.png"
                            alt="(ユーザ情報へ)"
                        />
                    </button>
                </form>
            </div>
        </nav>
    </body>
</html>
