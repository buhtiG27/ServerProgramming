<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%
request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>質問作成画面</title>
        <link
            rel="stylesheet"
            href="${page.Context.request.contextPath}/web_system/css/style_12_CreateQuestion.css"
        />
    </head>
    <body>
        <div class="header_area">
            <div class="button_left">
                <form
                    class="back_form"
                    action="${page.Context.request.contextPath}/questions"
                    method="get"
                >
                    <button class="back_button" type="submit">戻る</button>
                </form>
            </div>
        </div>
        <% String errorMessage = (String) request.getAttribute("error"); if
        (errorMessage != null) { %>
        <p style="color: red; font-weight: bold"><%= errorMessage %></p>
        <% } %>

        <form
            id="questionForm"
            action="${page.Context.request.contextPath}/questions/create"
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
        <nav>
            <jsp:include page="navigation.jsp" />
        </nav>
    </body>
</html>
