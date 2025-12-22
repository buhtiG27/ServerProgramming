<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%
request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>質問一覧 | 電大生のQ&A</title>
        <link
            rel="icon"
            href="<%= request.getContextPath() %>/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        />
        <!-- Font Awesome を追加 -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- cssでスマホ用のデザインをするために書く -->
        <link
            rel="stylesheet"
            href="${page.Context.request.contextPath}/web_system/css/style_12_CreateQuestion.css"
        />
    </head>
    <body>
        <div class="top_area">
            <div class="back_container" id="backContainer">
                <button type="button" id="backButton" class="back_button">
                    戻る
                </button>
                <img
                    src="<%= request.getContextPath() %>/web_system/images/Anone_1.png"
                    id="anoneImage"
                    class="anone"
                    alt=""
                />
            </div>
            <h2>質問を作成</h2>
            <button
                class="save_button"
                type="submit"
                form="questionForm"
                name="save"
                value="send"
            >
                投稿
            </button>
        </div>

        <% String errorMessage = (String) request.getAttribute("error"); if
        (errorMessage != null) { %>
        <p style="color: red; font-weight: bold"><%= errorMessage %></p>
        <% } %>

        <form
            id="questionForm"
            action="<%= request.getContextPath() %>/questions/create"
            method="post"
        >
            <div class="create_list">
                <label> </label>
                <img
                    id="previewImage"
                    src="images/icon_image.png"
                    class="insert_Image"
                />
                <!-- <input
                    type="file"
                    id="imageInput"
                    name="InsertImage"
                    accept=".jpg, .png"
                    style="display: none"
                    onchange="const img = document.getElementById('previewImage');
                        if (this.files.length > 0) {
                            img.src = window.URL.createObjectURL(this.files[0]);
                        } else {
                            img.src = 'images/icon_image.png';
                        }"
                /> -->
                <br />
                <br />
                <textarea
                    class="txt"
                    name="questionBody"
                    placeholder="質問内容を入力してください"
                ></textarea>
            </div>
        </form>

        <nav>
            <div class="bottom_button">
                <form class="form" action="QA_02_Questions.html" method="get">
                    <button class="pageButton toQuestions" type="submit">
                        <img
                            src="images/icon_home.png"
                            alt="(質問一覧だよ！)"
                            class="icon_toQuestions"
                        />
                        <img
                            src="images/icon_home_hukidashi.png"
                            alt="(質問一覧だよ！)"
                            class="icon_toQuestions_hukidashi"
                        />
                    </button>
                </form>
                <form class="form" action="QA_03_MyTime.html" method="get">
                    <button class="pageButton" type="submit">
                        <img
                            src="images/icon_calender.png"
                            alt="(マイ時間割へ)"
                        />
                    </button>
                </form>
                <form class="form" action="QA_04_User.html" method="get">
                    <button class="pageButton" type="submit">
                        <img src="images/icon_gear.png" alt="(ユーザ情報へ)" />
                    </button>
                </form>
            </div>
        </nav>

        <script>
            const backBtn = document.getElementById("backButton");
            const container = document.getElementById("backContainer");

            let visible = true;

            backBtn.addEventListener("click", (e) => {
                e.stopPropagation();
                if (!visible) return;

                backBtn.classList.add("is-hidden");
                visible = false;
            });

            container.addEventListener("click", () => {
                if (visible) return;

                backBtn.classList.remove("is-hidden");
                visible = true;
            });
        </script>
    </body>
</html>
