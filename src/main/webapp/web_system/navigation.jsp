<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/web_system/css/navigation.css"
/><!-- navigation.cssを適用 -->
<div class="bottom_button">
    <form
        class="form"
        action="${pageContext.request.contextPath}/questions"
        method="get"
    >
        <button class="pageButton" type="submit">質問一覧</button>
    </form>
    <form
        class="form"
        action="${pageContext.request.contextPath}/timetable"
        method="get"
    >
        <button class="pageButton" type="submit">マイ時間割</button>
    </form>
    <form
        class="form"
        action="${pageContext.request.contextPath}/user"
        method="get"
    >
        <button class="pageButton" type="submit">ユーザ画面</button>
    </form>
</div>
