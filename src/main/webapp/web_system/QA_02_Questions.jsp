<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="utf-8">
    <title>質問一覧 | 電大生のQ&A</title>
    <link rel="icon" href="${pageContext.request.contextPath}/web_system/images/icon_qa.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_2_Question.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

    <header>
        <jsp:include page="header.jsp" />
        <br>
        <div class="filters">
            <div class="searchbyKeyword">
                <form action="${pageContext.request.contextPath}/questions/search" method="get">
                    <input class="txt" type="text" name="searchbyKeyword" size="20" placeholder="質問を検索">
                    <button type="submit" style="background:none; border:none; padding:0;">
                        <span class="fa-solid fa-magnifying-glass"></span>
                    </button>
                </form>
            </div>
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/questions" class="filter-link">
                        <button class="filter" type="button" data-text="新着">新着</button>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/questions/filter?type=flagged" class="filter-link">
                        <button class="filter" type="button" data-text="フラグつき">フラグつき</button>
                    </a>
                </li>
            </ul>
        </div>
    </header>
    
    <main>
        <div class="post-list">
        <%
            // ページネーションとフィルタ情報の取得
            Object limitObj = request.getAttribute("limit");
            Object offsetObj = request.getAttribute("offset");
            int limit  = (limitObj instanceof Integer) ? (Integer) limitObj : 20;
            int offset = (offsetObj instanceof Integer) ? (Integer) offsetObj : 0;

            String type = (String) request.getAttribute("type"); 
            boolean isFilterMode = (request.getAttribute("isFilterMode") != null);
            
            List<Map<String, Object>> questions = (List<Map<String, Object>>) request.getAttribute("questions");

            if (questions == null || questions.isEmpty()) {
        %>
            <p style="color:gray; text-align:center; margin-top: 50px;">
                <%= "flagged".equals(type) ? "フラグ（保存）された質問はありません" : "投稿されている質問はありません" %>
            </p>
        <%
            } else {
                for (Map<String, Object> q : questions) {
                    pageContext.setAttribute("q", q);
        %>
            <div class="post">
                <div class="post_sideParts">
                    <button class="iconButton" type="button">
                        <img src="${pageContext.request.contextPath}/web_system/images/kari_image_Monozu.png" alt="User Icon">
                    </button>
                </div>
                
                <div class="post_upperParts">
                    <form action="${pageContext.request.contextPath}/questions/show" method="get" class="post_upperParts_form">
                        <input type="hidden" name="questionId" value="${q['id']}">
                        <button class="post_upperParts_atarihantei" type="submit"></button>
                        <div class="creatorName">${q['creator']['display_name']}</div>
                        <div class="created_at">${q['created_at_fmt']}</div>
                    </form>
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
                    <%-- いいねボタン --%>
                    <form action="${pageContext.request.contextPath}/questions/like" method="post" class="post_bottomParts_form">
                        <input type="hidden" name="questionId" value="${q['id']}">
                        <input type="hidden" name="offset" value="<%= offset %>">
                        <input type="hidden" name="type" value="<%= type != null ? type : "" %>">
                        <button class="goodButton" type="submit">
                        <%
                        	Object isLikedObj = q.get("is_liked");
                        	boolean isLiked = (isLikedObj != null && isLikedObj.toString().equals("true"));
                        	String goodIcon = isLiked ? "icon_good_active.png" : "icon_good_button.png";
                        %>
                        <img src="${pageContext.request.contextPath}/web_system/images/<%= goodIcon %>" 
                        	 alt="Good" width="auto" height="90%" style="margin-top:10%;">
                        </button>
                        <span class="count-text"><%= q.get("like_count") != null ? q.get("like_count") : 0 %></span>
                    </form>

                    <%-- 返信（詳細）ボタン --%>
                    <form action="${pageContext.request.contextPath}/questions/show" method="get" class="post_bottomParts_form">
                        <input type="hidden" name="questionId" value="${q['id']}">
                        <button class="replyButton" type="submit">
                            <img src="${pageContext.request.contextPath}/web_system/images/icon_chat.png" alt="Reply" width="auto" height="90%" style="margin-top:5%;">
                        </button>
                    </form>

                    <%-- フラグ（お気に入り）ボタン --%>
                    <form action="${pageContext.request.contextPath}/questions/flag" method="post" class="post_bottomParts_form">
                        <input type="hidden" name="questionId" value="${q['id']}">
                        <input type="hidden" name="offset" value="<%= offset %>">
                        <input type="hidden" name="type" value="<%= type != null ? type : "" %>">
                        <button class="flagButton" type="submit">
                        <%
                        	Object isFlagObj = q.get("is_flag");
                        	boolean isFlag = (isFlagObj != null && isFlagObj.toString().equals("true"));
                        	String flagIcon = isFlag ? "icon_flag_active.png" : "icon_flag.png";
                        	String flagStyle = isFlag ? "filter: sepia(100%) saturate(500%) hue-rotate(0deg);" : "";
                        %>
                            <img src="${pageContext.request.contextPath}/web_system/images/${q['is_flag'] ? 'icon_flag_active.png' : 'icon_flag.png'}" 
                            	 alt="Flag" width="auto" height="90%"
                            	 style="margin-top:5%; ${q['is_flag'] ? 'filter: sepia(100%) saturate(500%) hue-rotate(0deg);' : ''}">
                            </button>
                    </form>
                </div>
            </div>
        <%
                }
            }
        %>

        <%-- ページネーション制御 --%>
        <%
            String baseUrl = isFilterMode ? "filter" : "";
            String typeParam = (type != null && !type.isEmpty()) ? "&type=" + type : "";
            int prev = Math.max(0, offset - limit);
            int next = offset + limit;
        %>
        <div class="pagination" style="text-align: center; margin: 20px 0;">
            <% if (offset > 0) { %>
                <a href="${pageContext.request.contextPath}/questions/<%= baseUrl %>?limit=<%= limit %>&offset=<%= prev %><%= typeParam %>" class="page-link">前へ</a>
            <% } %>
            
            <% if (questions != null && questions.size() >= limit) { %>
                <a href="${pageContext.request.contextPath}/questions/<%= baseUrl %>?limit=<%= limit %>&offset=<%= next %><%= typeParam %>" class="page-link">次へ</a>
            <% } %>
        </div>

        </div>
    </main>
    
    <%-- 質問作成フローティングボタン --%>
    <form action="${pageContext.request.contextPath}/questions/create" method="get">
        <button class="createbutton" type="submit">
            <img src="${pageContext.request.contextPath}/web_system/images/icon_create_new_question.png" alt="質問作成" style="display:block;margin:auto;">
        </button>
    </form>
    
    <%-- 下部ナビゲーション --%>
    <nav>
        <div class="bottom_button">
            <form class="form" action="${pageContext.request.contextPath}/questions" method="get">
                <button class="pageButton toQuestions" type="submit">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_home.png" alt="Home" class="icon_toQuestions">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_home_hukidashi.png" alt="Home Label" class="icon_toQuestions_hukidashi">
                </button>
            </form>
            <form class="form" action="${pageContext.request.contextPath}/timetable" method="get">
                <button class="pageButton" type="submit">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_calender.png" alt="Timetable">
                </button>
            </form>
            <form class="form" action="${pageContext.request.contextPath}/user" method="get">
                <button class="pageButton" type="submit">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_gear.png" alt="User Settings">
                </button>
            </form>
        </div>
    </nav>

</body>
</html>