<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>質問作成画面</title>
        <link
            rel="stylesheet"
            href="<%= request.getContextPath() %>/web_system/css/style_12_CreateQuestion.css"
        />
    </head>
    <body>
        <div class="header_area">
		<div class="button_left">
			<form class="back_form" action="<%= request.getContextPath() %>/questions" method="get"> 
				<button class="back_button" type="submit">戻る</button>
			</form>
		</div>

        
	</div>
	<% String errorMessage = (String)
            request.getAttribute("error"); if (errorMessage != null) { %>
            <p style="color: red; font-weight: bold"><%= errorMessage %></p>
            <% } %>

        <form
            id="questionForm"
            action="<%= request.getContextPath() %>/questions/create"
            method="post"
            enctype="multipart/form-data"
        >
            <div class="create_list">
                <div class="txtarea">
                    <label>
                        <img id="previewImage" src="" class="insert_Image" />
                        <input
                            type="file"
                            id="imageInput"
                            name="InsertImage"
                            accept=".jpg, .png"
                            style="display: none"
                            onchange="document.getElementById('previewImage').src = window.URL.createObjectURL(this.files[0])"
                        />
                    </label>
                    <br />
                    <br />
                    <textarea
                        class="txt"
                        name="questionBody"
                        placeholder="質問内容を入力してください"
                    ></textarea>
                </div>
            </div>
            <div class="header_right">

            <button
                    class="save_button"
                    type="submit"
                    form="questionForm"
                    name="save"
                    value="send"
                >
                    保存
                </button>
        </div>
        </form>

        <div class="bottom_buttons">
            <form class="form" action="" method="get">
                <button class="pageButton" type="submit" name="toQuestion">
                    質問一覧
                </button>
            </form>
            <form
                class="form"
                action="<%= request.getContextPath() %>/web_system/QA_03_MyTime.jsp"
                method="get"
            >
                <button class="pageButton" type="submit" name="toTimetable">
                    マイ時間割
                </button>
            </form>
            <form
                class="form"
                action="<%= request.getContextPath() %>/web_system/QA_04_UserInfo.jsp"
                method="get"
            >
                <button
                    class="pageButton"
                    type="submit"
                    name="toUserInformation"
                >
                    ユーザ画面
                </button>
            </form>
        </div>
    </body>
</html>
