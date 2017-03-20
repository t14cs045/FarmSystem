<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.TimeZone"%>
<%@ page import="javax.jdo.PersistenceManager"%>
<%@ page import="javax.jdo.Query"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="software_f.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
	// ログインをしているかの判定
	boolean flag_login = true;
	if (session.getAttribute("access") == null) {
		flag_login = false;
		response.sendRedirect("./Error.jsp");
	}
	if(flag_login){
		
		//ログインしているアカウントのuserIDを取得
		Long userID_ = (Long) session.getAttribute("userID");
		
		String gmake = null;
		
		PersistenceManager pm = null;
		try {
			//栽培している野菜を取得
			pm = PMF.get().getPersistenceManager();
			Query k_query = pm.newQuery(Kozinjouhou.class);
			k_query.setFilter("userID == userid");
			k_query.declareParameters("Long userid");
			List<Kozinjouhou> kozin = (List<Kozinjouhou>) k_query.execute(userID_);
			for (Kozinjouhou kz : kozin) {
				if (kz.getSakumotu() != null)
					gmake = kz.getSakumotu();
			}
		} finally {
			if (pm != null && !pm.isClosed())
				pm.close();
		}
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>天気入力</title>
</head>
<body>
	<!--******** ヘッダー ********-->
	<div id="headerArea">
	<br>
		<table border="1" cellpadding="5" cellspacing="0"
			bordercolor="#000000" align="center">
			<tr>
				<td>
					<form action="/MyPage.jsp" method="post">
						<input type="submit" value="マイページ"
							style="WIDTH: 120px; HEIGHT: 50px" />
					</form>
				</td>
				<td>
					<form action="/green.jsp" method="post">
						<input type="submit" value="作物情報の登録"
							style="WIDTH: 120px; HEIGHT: 50px" />
					</form>
				</td>
				<td>
					<form action="/ondo.jsp" method="post">
						<input type="submit" value="天気の入力"
							style="WIDTH: 120px; HEIGHT: 50px" />
					</form>
				</td>
				<%
					if (gmake == null) {
				%>
				<td>
					<form action="/ondonyuuryoku.jsp" method="post">
						<input type="submit" value="室内温度の入力"
							style="WIDTH: 120px; HEIGHT: 50px" disabled/>
					</form>
				</td>
				<td>
					<form action="/Growth.jsp" method="post">
						<input type="submit" value="成長記録の入力"
							style="WIDTH: 120px; HEIGHT: 50px" disabled/>
					</form>
				</td>
				<%
					} else {
				%>
				<td>
					<form action="/ondonyuuryoku.jsp" method="post">
						<input type="submit" value="室内温度の入力"
							style="WIDTH: 120px; HEIGHT: 50px" />
					</form>
				</td>
				<td>
					<form action="/Growth.jsp" method="post">
						<input type="submit" value="成長記録の入力"
							style="WIDTH: 120px; HEIGHT: 50px" />
					</form>
				</td>
				<%
					}
				%>
				<td>
					<form action="/noukaall.jsp" method="post">
						<input type="submit" value="農家の一覧"
							style="WIDTH: 120px; HEIGHT: 50px" />
					</form>
				</td>
				<td>
					<form action="/logout">
						<input type="submit" value="ログアウト"
							style="WIDTH: 120px; HEIGHT: 50px" />
					</form>
				</td>
			</tr>
		</table>
	</div>
	<!--******** ヘッダー終わり ********-->
	<center>
		<h2>天気入力</h2>
	
		<form action="/weather" method="post">
			<table border=1>
	
				<tr>
					<td><label>今日の天気</label></td>
					<td><Label>晴れ</label><input type="radio" name="tenki" value="0">
				        <Label>曇り</label><input type="radio" name="tenki" value="1">
					     <Label>雨</label><input type="radio" name="tenki" value="2">
					     <Label>雪</label><input type="radio" name="tenki" value="3"></td>
	             		
				</tr>
				
				<tr>
					<td><label>外部温度</label></td>
					<td><input type="text" name="ondo"><label>℃</label></td>
				</tr>		
						

			</table>

			<p>
				<input class="bsize" type="submit" value="登録する">
			</p>

		</form>
		    <form action="/MyPage.jsp">
				<input class="top" type="submit" value="マイページ" />
			</form>
	</center>
</body>
<%} %>
</html>