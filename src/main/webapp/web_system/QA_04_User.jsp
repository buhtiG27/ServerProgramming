<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>ユーザ情報 | 電大生のQ&A</title>
        <link rel="icon" href="${pageContext.request.contextPath}/web_system/images/icon_qa.png" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_4_User.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    </head>
    <body>
        <main>
            <%-- プロフィール上部セクション --%>
            <div class="top_button">
                <form action="${pageContext.request.contextPath}/logout" method="get" class="logout-area">
                    <button type="submit" class="logout-button">ログアウト</button>
                </form>
                
                <img src="${pageContext.request.contextPath}/web_system/images/kari_image_sky.jpeg" class="background_image" />
                <img src="${pageContext.request.contextPath}/web_system/images/kari_image_User.png" class="icon_image" />
                
                <div class="button">
                    <%-- プロフィール編集画面へ --%>
                    <form action="${pageContext.request.contextPath}/web_system/QA_09_Edit.jsp" method="get">
                        <button class="edit_button" type="submit">編集</button>
                    </form>
                </div>

                <b class="username">${name}</b>
                <p class="intro_text">${description}</p>
            </div>

            <%-- アクティビティリスト（自分の質問・回答一覧） --%>
            <div class="post-list">
                <h2 style="padding: 15px 20px; font-size: 1.2em; border-bottom: 1px solid #eee; text-align: left;">自分のアクティビティ</h2>
        
                <%
                    List<Map<String, Object>> questions = (List<Map<String, Object>>) request.getAttribute("questions");
                    if (questions == null || questions.isEmpty()) {
                %>
                    <p style="color:gray; padding: 40px;">まだ投稿した質問や回答はありません。</p>
                <%
                    } else {
                        for (Map<String, Object> q : questions) {
                            pageContext.setAttribute("q", q);
                            // 親投稿(parent)があれば「回答」、なければ「質問」
                            boolean isReply = (q.get("parent") != null);
                %>
                    <div class="post <%= isReply ? "is-reply" : "" %>">
                        
                        <%-- 回答の場合のみ表示：どの質問に対するものか --%>
                        <% if (isReply) { 
                            Map<String, Object> parent = (Map<String, Object>) q.get("parent");
                        %>
                            <div class="reply-context">
                                <i class="fa-solid fa-reply"></i> 
                                <%= (parent.get("creator_name") != null) ? parent.get("creator_name") : "誰か" %> さんの
                                「<%= parent.get("contents_text") %>」への回答
                            </div>
                        <% } %>

                        <div class="post_sideParts">
                            <div class="iconButton">
                                <img src="${pageContext.request.contextPath}/web_system/images/kari_image_User.png" alt="icon">
                            </div>
                        </div>
                        
                        <div class="post_upperParts">
                            <div class="creatorName">${name}</div> <%-- 自分の名前を表示 --%>
                            <div class="created_at">${q['created_at_fmt']}</div> <%-- 投稿時刻 --%>
                        </div>
                        
                        <div class="post_mainParts">
                            <form action="${pageContext.request.contextPath}/questions/show" method="get" class="post_mainParts_form">
                                <input type="hidden" name="questionId" value="${q['id']}">
                                <button class="post_mainParts_atarihantei" type="submit">
                                    <div class="contents_text">${q['contents_text']}</div>
                                </button>
                            </form>
                        </div>

                        <div class="post_bottomParts">
                            <div class="post_bottomParts_form">
                                <button class="goodButton"><img src="${pageContext.request.contextPath}/web_system/images/icon_good_button.png" alt="good"></button>
                            </div>
                            <div class="post_bottomParts_form">
                                <form action="${pageContext.request.contextPath}/questions/show" method="get">
                                    <input type="hidden" name="questionId" value="${q['id']}">
                                    <button class="replyButton"><img src="${pageContext.request.contextPath}/web_system/images/icon_chat.png" alt="reply"></button>
                                </form>
                            </div>
                            <div class="post_bottomParts_form">
                                <button class="flagButton"><img src="${pageContext.request.contextPath}/web_system/images/icon_flag.png" alt="flag"></button>
                            </div>
                        </div>
                    </div>
                <%
                        }
                    }
                %>

                <%-- ページネーション --%>
                <%
                    Object limitObj = request.getAttribute("limit");
                    Object offsetObj = request.getAttribute("offset");
                    int limit  = (limitObj instanceof Integer) ? (Integer) limitObj : 20;
                    int offset = (offsetObj instanceof Integer) ? (Integer) offsetObj : 0;
                    int prev = Math.max(0, offset - limit);
                    int next = offset + limit;
                %>
                <div class="pagination">
                    <a href="${pageContext.request.contextPath}/user?limit=<%= limit %>&offset=<%= prev %>">前へ</a>
                    <span style="margin: 0 15px;"></span>
                    <a href="${pageContext.request.contextPath}/user?limit=<%= limit %>&offset=<%= next %>">次へ</a>
                </div>

                <%-- シツモチくん（マスコット）ボタン：リストの最下部に配置 --%>
                <div class="motchy-container">
                    <button id="cycleButton" class="motchyButton">
                        <img id="Shitsumotchy" src="${pageContext.request.contextPath}/web_system/images/Shitsumotchy_1.png" alt="シツモチくん">
                    </button>
                </div>
            </div>
        </main>

        <%-- 下部ナビゲーションバー --%>
        <nav>
            <div class="bottom_button">
                <form class="form" action="${pageContext.request.contextPath}/questions" method="get">
                    <button class="pageButton" type="submit">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_home.png" alt="Home">
                    </button>
                </form>
                <form class="form" action="${pageContext.request.contextPath}/timetable" method="get">
                    <button class="pageButton" type="submit">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_calender.png" alt="TimeTable">
                    </button>
                </form>
                <form class="form" action="${pageContext.request.contextPath}/user" method="get">
                    <button class="pageButton toUserinfo" type="submit">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_gear.png" alt="User" class="icon_toUserinfo">
                        <img src="${pageContext.request.contextPath}/web_system/images/icon_gear_hukidashi.png" alt="hint" class="icon_toUserinfo_hukidashi">
                    </button>
                </form>
            </div>
        </nav>

        <%-- JavaScript: シツモチくんのアニメーション --%>
        <script>
            const button = document.getElementById("cycleButton");
            const img = document.getElementById("Shitsumotchy");
            let isVisible = true; 
            
            button.addEventListener("click", () => {
                if (!isVisible) return;
                img.classList.add("flip");
                requestAnimationFrame(() => {
                    img.classList.add("fade-out");
                });
                isVisible = false;
            });
        </script>
    </body>
</html>