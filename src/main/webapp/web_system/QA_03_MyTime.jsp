<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8" />
        <title>マイ時間割 | 電大生のQ&A</title>
        <link
            rel="icon"
            href="${page.Context.request.contextPath}/web_system/images/icon_qa.png"
        />
        <!-- ファビコン -->
        <link
            rel="stylesheet"
            href="${page.Context.request.contextPath}/web_system/css/style_3_MyTime.css"
        />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"> <!-- Font Awesome を追加 -->
        <!-- cssでスマホ用のデザインをするために書く -->
    </head>
    <body>
        <header><jsp:include page="header.jsp" /><!-- ヘッダ --></header>

        <div class="top_area">
            <form action="QA_18_DeleteMyTime.jsp" method="get">
                <button
                    class="delete_button"
                    type="submit"
                    name="filterbyNew"
                    value="send"
                >
                    科目削除
                </button>
            </form>
            <h2>マイ時間割</h2>
            <form
                action="${page.Context.request.contextPath}/tasks"
                method="get"
            >
                <button
                    class="task_button"
                    type="submit"
                    name="filterbySameGrade"
                    value="send"
                >
                    課題一覧
                </button>
            </form>
        </div>
        
        <!-- 時間割部分 -->
		<div class="time-list">
			<table border="1">
				<tr>
					<th></th>
					<th>月</th>
					<th>火</th>
					<th>水</th>
					<th>木</th>
					<th>金</th>
					<th>土</th>
				</tr>
			    <!-- 1限〜8限 -->
				<!-- 1限 -->
				<tr>
					<th>1限</th>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button>数理最適化</button></td>
					<td><button></button></td>
					<td><button></button></td>
				</tr>
				
				<!-- 2限 -->
				<tr>
					<th>2限</th>
					<td><button>応用信号処理</button></td>
					<td><button></button></td>
					<td><button>クラウドコンピューティング</button></td>
					<td><button>ソフトウェア設計</button></td>
					<td><button>生体情報とVR</button></td>
					<td><button></button></td>
				</tr>

				<!-- 3限 -->
				<tr>
					<th>3限</th>
					<td><button>機械学習および演習</button></td>
					<td><button>サーバプログラミング演習</button></td>
					<td><button></button></td>
					<td><button>CGレンダリングおよび演習</button></td>
					<td><button>情報メディア総合演習</button></td>
					<td><button></button></td>
				</tr>

				<!-- 4限 -->
				<tr>
					<th>4限</th>
					<td><button>コンピュータアーキテクチャ</button></td>
					<td><button>サーバプログラミングおよび演習</button></td>
					<td><button></button></td>
					<td><button>CGレンダリングおよび演習</button></td>
					<td><button></button></td>
					<td><button></button></td>
				</tr>

				<!-- 5限 -->
				<tr>
					<th>5限</th>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
				</tr>

				<!-- 6限 -->
				<tr>
					<th>6限</th>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
				</tr>

				<!-- 7限 -->
				<tr>
					<th>7限</th>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
				</tr>

				<!-- 8限 -->
				<tr>
					<th>8限</th>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
					<td><button></button></td>
				</tr>
			</table>
		</div>
        <%-- 元のtime-list --%>
        <!-- 
        <div class="time-list">
            <% String message = request.getParameter("message"); if (message !=
            null && !message.isEmpty()) { %>
            <p style="color: green; font-weight: bold"><%= message %></p>
            <% } %>
            <table>
                <tr>
                    <%String[] days = {" ","月","火","水","木","金","土"};%> <%
                    for (int d = 0; d < 7; d++) { %>
                    <th><%= days[d] %></th>
                    <% } %>
                </tr>
                <% for(int i = 1; i < 9; i++){ %>
                <tr>
                    <th><%= i%>限</th>
                    <% for(int j = 0; j < 6; j++){ %>
                    <td>
                        <form
                            action="${page.Context.request.contextPath}/timetable/search"
                            method="get"
                        >
                            <input type="hidden" name="searchSubject" />
                            <input type="hidden" name="showRegisteredSubject" />
                            <button class="displayButton" type="submit">
                                <%= "登録/表示" %>
                            </button>
                        </form>
                    </td>
                    <% } %>
                </tr>
                <% } %>
            </table>
        </div>
        -->
        <br />
        <br />

		<nav>
			<div class="bottom_button">
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_02_Questions.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_home.png" alt="(質問一覧へ)"></button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_03_MyTime.jsp" method="get">
                    <button class="pageButton toMytime" type="submit">
						<img src="<%= request.getContextPath() %>/web_system/images/icon_calender.png" alt="(マイ時間割だよ！)" class="icon_toMytime">
						<img src="<%= request.getContextPath() %>/web_system/images/icon_calender_hukidashi.png" alt="(マイ時間割だよ！)" class="icon_toMytime_hukidashi">
					</button>
                </form>
                <form class="form" action="<%= request.getContextPath() %>/web_system/QA_04_User.jsp" method="get">
                    <button class="pageButton" type="submit"><img src="<%= request.getContextPath() %>/web_system/images/icon_gear.png" alt="(ユーザ情報へ)"></button>
                </form>
            </div>
		</nav>
    </body>
</html>
