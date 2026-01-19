<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="utf-8" />
    <title>ユーザ編集画面 | 電大生のQ&A</title>
    <link rel="icon" href="${pageContext.request.contextPath}/web_system/images/icon_qa.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/web_system/css/style_9_Edit.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <%
        Map<String, Object> user = (Map<String, Object>) request.getAttribute("user");
        String displayName = (user != null && user.get("display_name") != null) ? user.get("display_name").toString() : "";
        String description = (user != null && user.get("description") != null) ? user.get("description").toString() : "";
        String iconPath = (user != null && user.get("icon_path") != null && !user.get("icon_path").toString().isEmpty()) 
                          ? user.get("icon_path").toString() : "kari_image_Monozu.png";
    %>

    <form action="${pageContext.request.contextPath}/user/edit" method="post">
        
        <div class="edit_list">
                <img src="${pageContext.request.contextPath}/web_system/images/kari_image_sky.jpeg" class="background_image" />
                <img src="${pageContext.request.contextPath}/web_system/images/kari_image_User.png" class="icon_image" />
                

            <div class="button_container">
                <div class="button_left">
                    <a href="${pageContext.request.contextPath}/user" class="cancel_button_link" 
                       style="text-decoration:none; padding:10px; border:1px solid #ccc; border-radius:5px;">
                        キャンセル
                    </a>
                </div>
                <div class="button_right">
                    <button class="save_button" type="submit">保存</button>
                </div>
            </div>

            <br /><br />
            
            <label for="userName">名前：</label><br />
            <input class="txt" type="text" size="20" name="userName" value="<%= displayName %>" />
            
            <br /><br />
            
            <label for="description">自己紹介：</label><br />
            <input class="txt" type="text" size="32" name="description" value="<%= description %>" />
            
            <br /><br />
            
            <label for="gradeAndDept">学年・学科：</label><br />
            <input class="txt" type="text" size="20" name="gradeAndDept" value="" />
        </div>
    </form>
    
    <nav>
        <div class="bottom_button">
            <form class="form" action="${pageContext.request.contextPath}/questions" method="get">
                <button class="pageButton toQuestions" type="submit">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_home.png" alt="Home" class="icon_toQuestions">
                    <img src="${pageContext.request.contextPath}/web_system/images/icon_home_hukidashi.png" alt="Home Label" class="icon_toQuestions_hukidashi">
                </button>
            </form>
            <form class="form" action="${pageContext.request.contextPath}/timetable" method="get">
                <button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_calender.png" alt="Timetable"></button>
            </form>
            <form class="form" action="${pageContext.request.contextPath}/user" method="get">
                <button class="pageButton" type="submit"><img src="${pageContext.request.contextPath}/web_system/images/icon_gear.png" alt="User Settings"></button>
            </form>
        </div>
    </nav>
</body>
</html>