<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
	<head>
		<meta charset="utf-8">
		<title>課題一覧画面</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_17_AllTasks.css">
	</head>
	<body>
		<div class="top_button_area">
			<form action="" method="get">
				<button class="top_button" type="submit" name="back" value="send">TDU</button>
			</form>
		</div>
		<div class="header_area">
			<form action="${pageContext.request.contextPath}/timetable" method="get">
				<button class="back_button" type="submit" name="filterbyNew" value="send">戻る</button>
			</form>
			<h2>課題一覧</h2>
		</div>
		<br>
		<div class="body_area">
			<form action="" method="get" class="search_form">
				<label>検索：</label>
				<input class="txt" type="text" size="20" value="" name="searchbyKeyword" />		
			</form>
			<div class="subject_area">
				<form action="" method="get">
					<button class="show_button" type="submit" name="filterbyNew" value="send">課題1</button>
				</form>
				<p>サンプル表示</p>
			</div>	
			<div class="subject_area">
				<form action="" method="get">
					<button class="show_button" type="submit" name="filterbyNew" value="send">課題2</button>
				</form>
				<p>サンプル表示</p>	
		</div>	
		<br>
		<br>
		<nav>
			<jsp:include page="navigation.jsp" />
		</nav>

	</body>
</html>