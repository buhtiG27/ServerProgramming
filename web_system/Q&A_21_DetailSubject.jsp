<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<title>科目詳細画面</title>
<link rel="stylesheet" href="css/style_21_DetailSubject.css">
</head>
<body>
<%--　ロゴに置き換える --%>
<div class="top_button_area">
	<form action="Q&A_2_Question.jsp" method="get">
		<button class="top_button" type="submit" name="back" value="send">TDU</button>
	</form>
</div>

<!-- 戻るボタンとタイトル -->
<div class="header_area">
	<form action="Q&A_19_AllMyTime.jsp" method="get">
		<button class="back_button" type="submit" name="back" value="send">戻る</button>
	</form>
	<h1 class="page_title">科目詳細</h1>
</div>

<div class="view_list">
	<h2 class="task_title">
	科目「プログラミング応用Ⅰ」の表示
		<%--
			//授業のリクエスト表示
		 	out.print("科目「" + classname + "」の詳細<br />");
		--%>
	</h2>
	<div class="edit_create">
		<form action="Q&A_28_EditSubject.jsp" method="get">
			<button class="edit_button" type="submit" name="edit" value="send">編集</button>
		</form>
	</div>
	<div class="info_box">
		<label>授業名：</label>
		<div class="content_box">プログラミング応用Ⅰ
		<%--
			//授業のリクエスト表示
		 	out.print(classname);
		--%>
		</div>

		<label>教員名：</label>
		<div class="content_box">サンプル
		<%--
			//授業のリクエスト表示
		 	out.print(teacher);
		--%>
		</div>

		<label>教室：</label>
		<div class="content_box">サンプル
		<%--
			//授業のリクエスト表示
		 	out.print(roomname);
		--%>
		</div>
	</div>
	<label>課題：
		<div class="new_create">
		<form action="Q&A_23_NewCreateTask.jsp" method="get">
			<button class="new_create_button" type="submit" name="edit" value="send">新規作成</button>
		</form>
		</div>
		</label>
		<div class="textarea_box">
		<ul>
       		<%--
            List<Task> tasks = (List<Task>)request.getAttribute("taskList");
            if (tasks != null) {
                for (Task t : tasks) {
        	--%>
            <div class="task_item">
        		<form action="Q&A_13_ViewTask.jsp"> 
        			<input type="hidden" name="source" value="DetailSubject" /> <%--  隠しフィールド --%>
        			<button class="task_link">課題１</button>
    			</form>
    		</div>
    		<div class="task_item">
        		<form action="Q&A_13_ViewTask.jsp"> 
            		<input type="hidden" name="source" value="DetailSubject" /> <%--  隠しフィールド --%>
            		<button class="task_link">課題２</button>
        		</form>
    		</div>
        	<%--
                }
            }
       		--%>
    	</ul>
		</div>
</div>
<div class="bottom_buttons">
		<form class="form" action="" method="get">
			<button class="pageButton" type="submit" name="toQuestion">質問一覧</button>
		</form>
		<form class="form" action="Q&A_3_MyTime.jsp" method="get">
			<button class="pageButton" action="Sample_MyTime.jsp" type="submit" name="toTimetable">マイ時間割</button>
		</form>
		<form class="form" action="Q&A_4_User.jsp" method="get">
			<button class="pageButton" action="Sample_Uses.jsp" type="submit" name="toUserInformation">ユーザ画面</button>
		</form>
	</div>
</body>
</html>