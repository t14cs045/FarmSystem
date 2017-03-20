<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.DateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.jdo.PersistenceManager"%>
<%@ page import="javax.jdo.Query"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="software_f.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<%
	// ログインをしているかの判定
		// ログインをしているかの判定
	boolean flag_login = true;
	if (session.getAttribute("access") == null) {
		flag_login = false;
		response.sendRedirect("./Error.jsp");
	}

	if(flag_login){
	//ログインしているアカウントのメールアドレスを取得
	String mailaddress_ = String.valueOf(session.getAttribute("mail"));
	Long userID = (Long) session.getAttribute("userID");
	String gmake = null;

	//変数の初期化
	String sakumotu_ = "";
	Long sakumotuID = (Long) session.getAttribute("sakumotuID");
	boolean flag_sakumotu = false;
	
	PersistenceManager pm = null;
	try {
		//栽培している野菜を取得
		pm = PMF.get().getPersistenceManager();
		Query k_query = pm.newQuery(Kozinjouhou.class);
		k_query.setFilter("userID == userid");
		k_query.declareParameters("Long userid");
		List<Kozinjouhou> kozin = (List<Kozinjouhou>) k_query.execute(userID);
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
<title>成長記録入力画面</title>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<style>
#dragandrophandler {
	border: 2px dotted #0B85A1;
	width: 600px;
	height: 100px;
	color: #92AAB0;
	text-align: left;
	vertical-align: middle;
	padding: 10px 10px 10 10px;
	margin-bottom: 10px;
	font-size: 200%;
}

.progressBar {
	width: 200px;
	height: 22px;
	border: 1px solid #ddd;
	border-radius: 5px;
	overflow: hidden;
	display: inline-block;
	margin: 0px 10px 5px 5px;
	vertical-align: top;
}

.progressBar div {
	height: 100%;
	color: #fff;
	text-align: right;
	line-height: 22px;
	/* same as #progressBar height if we want text middle aligned */
	width: 0;
	background-color: #0ba1b5;
	border-radius: 3px;
}

.statusbar {
	border-top: 1px solid #A9CCD1;
	min-height: 25px;
	width: 700px;
	padding: 10px 10px 0px 10px;
	vertical-align: top;
}

.statusbar:nth-child(odd) {
	background: #EBEFF0;
}

.filename {
	display: inline-block;
	vertical-align: top;
	width: 250px;
}

.filesize {
	display: inline-block;
	vertical-align: top;
	color: #30693D;
	width: 100px;
	margin-left: 10px;
	margin-right: 5px;
}

.abort {
	background-color: #A8352F;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
	display: inline-block;
	color: #fff;
	font-family: arial;
	font-size: 13px;
	font-weight: normal;
	padding: 4px 15px;
	cursor: pointer;
	vertical-align: top
}
</style>

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



	<form action="growth_h" method="post">
		<%
			Calendar calendar = Calendar.getInstance();
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH) + 1;
			int day = calendar.get(Calendar.DATE);
			String strmonth = "" + month;
			if(month<10)
				strmonth = "0" + month;
			String strday = "" + day;
			if(day<10)
				strday = "0" + day;
			String date = "" + year + strmonth + strday;
		%>

		<input type="hidden" name="userID" value="<%=userID%>"> <input
			type="hidden" name="sakumotuID" value="<%=sakumotuID%>"> <input
			type="hidden" name="date" value="<%=date%>">


		<div align="center" style="font-size: 30pt;">
			<h3>成長記録入力</h3>
			<script type="text/javascript">
				var today = new Date();
				var year = today.getFullYear();
				var month = today.getMonth() + 1;
				var day = today.getDate();

				document.write(year + '/' + month + '/' + day);
			</script>

		</div>
		<HR>

		<div align="center">

			<table border="0">
				<tr>
					<td>
						<table border="1" id="grow">
							<caption>成長過程</caption>
							<tr>
								<td width="300"><input type="radio" name="sd" value="0">芽が出た</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sd" value="1">双葉が出た</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sd" value="2">茎が総長10cmを越えた</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sd" value="3">花が咲いた</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sd" value="4">実が出来た</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sd" value="5">実が熟した</td>
							</tr>
						</table>
					</td>

					<td>
						<table border="1">
							<caption>作業</caption>
							<tr>
								<td width="300"><input type="radio" name="sg" value="0">種まき</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sg" value="1">肥料をまく</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sg" value="2">わき芽かき</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sg" value="3">摘果</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sg" value="4">摘芯</td>
							</tr>
							<tr>
								<td width="300"><input type="radio" name="sg" value="5">収穫した</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>


			<script>
				function connecttext(textid, ischecked) {
					document.getElementById(textid).disabled = false;
				}
			</script>

			<textarea name="comment" rows="5" cols="60">備考欄</textarea>

			<p>
				<input type="submit" value="保存"
					style="width: 100px; height: 40px; font-size: 20px;" /> <br>
		</div>
	</form>


</body>
<%} %>
</html>