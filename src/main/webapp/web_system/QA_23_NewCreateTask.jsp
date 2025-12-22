<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%
    request.setCharacterEncoding("UTF-8");

    // --- エラーメッセージ (日本語部分に // を追加してコメント化) ---
    String errorMessage = "";

    // --- フォームの値 (subjectId を追加) ---
    String subId = request.getParameter("subjectId");
    String cls = request.getParameter("classname");
    String con = request.getParameter("content");
    String lim = request.getParameter("limmit");
    String output = request.getParameter("output");
    String detail = request.getParameter("detailcontent");
    String weekday = request.getParameter("weekday");   
    String time    = request.getParameter("time");

    // 訂正ボタンからのリクエスト判定用
    String actionType = request.getParameter("actionType");

    // --- POSTのときだけチェック (ここもコメント化) ---
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if ("correction".equals(actionType)) {
            // 訂正時は何もしない
        } else {
            // 通常の「確認」ボタン押下の場合のみ、入力チェックを行う
            if (cls == null || cls.isEmpty()) {
                errorMessage = "授業名を入力してください。";
            } else if (con == null || con.isEmpty()) {
                errorMessage = "内容を入力してください。";
            } else if (lim == null || lim.isEmpty()) {
                errorMessage = "期限を入力してください。";
            } else if (output == null || output.isEmpty()) {
                errorMessage = "提出場所を入力してください。";
            } else if (detail == null || detail.isEmpty()) {
                errorMessage = "補足説明を入力してください。ない場合、「特になし」と入力してください。";
            }

            // --- エラーなしなら次画面へ遷移 ---
            if (errorMessage.isEmpty()) {
                String encodedSubId = URLEncoder.encode(subId != null ? subId : "", "UTF-8");
                String encodedCls = URLEncoder.encode(cls, "UTF-8");
                String encodedCon = URLEncoder.encode(con, "UTF-8");
                String encodedLim = URLEncoder.encode(lim, "UTF-8");
                String encodedOut = URLEncoder.encode(output, "UTF-8");
                String encodedDetail = URLEncoder.encode(detail, "UTF-8");
                String encodedWeekday = URLEncoder.encode(weekday, "UTF-8");
                String encodedTime = URLEncoder.encode(time, "UTF-8");

                String redirectUrl = "QA_24_CheckNewTask.jsp"
                	    + "?subjectId=" + encodedSubId
                	    + "&weekday=" + encodedWeekday
                	    + "&time=" + encodedTime
                	    + "&classname=" + encodedCls
                	    + "&content=" + encodedCon
                	    + "&limmit=" + encodedLim
                	    + "&output=" + encodedOut
                	    + "&detailcontent=" + encodedDetail;
                
                response.sendRedirect(redirectUrl);
                return;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>課題新規作成画面</title>
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/web_system/css/style_23_NewCreateTask.css"
        />
    </head>
    <body>
        <div class="top_button_area">
            <form action="${pageContext.request.contextPath}/questions" method="get">
                <button class="top_button" type="submit">TDU</button>
            </form>
        </div>

        <div class="header_area">
            <%-- 戻るボタンのときも subjectId を送ることで詳細画面に戻れるようにする --%>
            <form action="${pageContext.request.contextPath}/subjects/detail" method="get">
                <input type="hidden" name="subjectId" value="<%= subId %>">
    			<input type="hidden" name="weekday" value="<%= weekday %>">
    			<input type="hidden" name="time" value="<%= time %>">
                <button class="back_button" type="submit">戻る</button>
            </form>
            <h1 class="page_title">課題の新規作成</h1>
        </div>
        <br />
        <div class="view_list">
            <h2 class="task_title">課題の新規作成：<%= (cls != null ? cls : "") %></h2>
            
            <% if (!errorMessage.isEmpty()) { %>
            <p style="color: red; font-weight: bold; text-align: center;"><%= errorMessage %></p>
            <% } %>

            <div class="info_box">
                <form action="" method="post">
                    <%-- 科目IDを隠しフィールドで保持 --%>
                    <input type="hidden" name="subjectId" value="<%= (subId != null ? subId : "") %>">
                    <input type="hidden" name="weekday" value="<%= weekday %>">
					<input type="hidden" name="time" value="<%= time %>">

                    <label for="cls">授業名：</label>
                    <br />
                    <input class="content_box" type="text" maxlength="50" name="classname" value="<%= cls %>" readonly/>
                    <br /><br />

                    <label for="con">内容：</label>
                    <br />
                    <input class="content_box" type="text" maxlength="200" name="content" value="<%= (con != null ? con : "") %>"/>
                    <br /><br />

                    <label for="lim">期限：</label>
                    <br />
                    <input class="content_box" type="text" maxlength="30" name="limmit" value="<%= (lim != null ? lim : "") %>"/>
                    <br /><br />

                    <label for="out">提出場所：</label>
                    <br />
                    <input class="content_box" type="text" maxlength="100" name="output" value="<%= (output != null ? output : "") %>"/>
                    <br /><br />

                    <label for="detail">補足説明：</label><br />
                    <input class="textarea_box" type="text" maxlength="400" name="detailcontent" value="<%= (detail != null ? detail : "") %>"/>
                    <br /><br />

                    <button class="regist_button" type="submit">確認</button>
                </form>
            </div>
            <br />
        </div>
        <nav>
            <jsp:include page="navigation.jsp" />
        </nav>
    </body>
</html>