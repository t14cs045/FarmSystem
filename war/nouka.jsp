<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.DateFormat"%>

<%@ page import="software_f.*"%>
<%@ page import="javax.jdo.PersistenceManager"%>
<%@ page import="javax.jdo.Query"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>成長記録</title>

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

<%
	// ログインをしているかの判定
	boolean flag_login = true;
	if (session.getAttribute("access") == null) {
		flag_login = false;
		response.sendRedirect("./Error.jsp");
	}
	if (flag_login) {
		Long seityouID = Long.parseLong(request.getParameter("id"));
		Long userID_ = (Long) session.getAttribute("userID");

		int date = 0;
		int seityoudankai = 0;
		int sagyoudankai = 0;
		String bikou = "";
		Long userid = null;
		String name = "";
		String gmake = null;

		PersistenceManager pm = null;
		PersistenceManager pmm = null;
		try {
			pmm = PMF.get().getPersistenceManager();
			Query query = pmm.newQuery(Seityoukiroku.class);
			query.setFilter("seityoukirokuId == idparam");
			query.declareParameters("Long idparam");
			List<Seityoukiroku> results = (List<Seityoukiroku>) query.execute(seityouID);

			if (results != null) {
				for (Seityoukiroku sk : results) {
					date = sk.getDate();
					seityoudankai = sk.getSeityoudankaibangou();
					sagyoudankai = sk.getSagyoubangou();
					bikou = sk.getComment();
					userid = sk.getUserID();
				}
			}
			pm = PMF.get().getPersistenceManager();
			Query query1 = pmm.newQuery(Kozinjouhou.class);
			query.setFilter("userID == idparam");
			query.declareParameters("Long idparam");
			List<Kozinjouhou> results1 = (List<Kozinjouhou>) query1.execute(userid);

			if (results1 != null) {
				for (Kozinjouhou kj : results1) {
					if (userid.equals(kj.getUserID()))
						name = kj.getHyouzimei();
				}
			}
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
			if (pmm != null && !pmm.isClosed())
				pmm.close();
		}

		if (date == 0) {
			response.sendRedirect("./noukaError.jsp");
		}

		int year = date / 10000;
		int month = (date % 10000) / 100;
		int day = date % 100;
%>

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
							style="WIDTH: 120px; HEIGHT: 50px" disabled />
					</form>
				</td>
				<td>
					<form action="/Growth.jsp" method="post">
						<input type="submit" value="成長記録の入力"
							style="WIDTH: 120px; HEIGHT: 50px" disabled />
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

	<div align="center" style="font-size: 30pt;">
		<h3>成長記録</h3>
		<%=year%>/<%=month%>/<%=day%>
		<br>
		<%=name%>さんの記録
	</div>
	<HR>
	<%
		System.out.println(name);
	%>
	<div align="center">

		<table border="0">
			<tr>
				<td>
					<table border="1" id="grow">
						<caption>成長過程</caption>
						<tr>
							<td width="300"><input type="radio" name="riyu" value="0"
								disabled <%if (seityoudankai == 0) {%> checked <%}%>>芽が出た</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="riyu" value="1"
								disabled <%if (seityoudankai == 1) {%> checked <%}%>>双葉が出た</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="riyu" value="2"
								disabled <%if (seityoudankai == 2) {%> checked <%}%>>茎が総長10cmを越えた</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="riyu" value="3"
								disabled <%if (seityoudankai == 3) {%> checked <%}%>>花が咲いた</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="riyu" value="4"
								disabled <%if (seityoudankai == 4) {%> checked <%}%>>実が出来た</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="riyu" value="5"
								disabled <%if (seityoudankai == 5) {%> checked <%}%>>実が熟した</td>
						</tr>
					</table>
				</td>

				<td>
					<table border="1">
						<caption>作業</caption>
						<tr>
							<td width="300"><input type="radio" name="sg" value="0"
								disabled <%if (sagyoudankai == 0) {%> checked <%}%>>種まき</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="sg" value="1"
								disabled <%if (sagyoudankai == 1) {%> checked <%}%>>肥料をまく</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="sg" value="2"
								disabled <%if (sagyoudankai == 2) {%> checked <%}%>>わき芽かき</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="sg" value="3"
								disabled <%if (sagyoudankai == 3) {%> checked <%}%>>摘果</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="sg" value="4"
								disabled <%if (sagyoudankai == 4) {%> checked <%}%>>摘芯</td>
						</tr>
						<tr>
							<td width="300"><input type="radio" name="sg" value="5"
								disabled <%if (sagyoudankai == 5) {%> checked <%}%>>収穫した</td>
						</tr>
					</table>
				</td>
			</tr>

		</table>

		<textarea name="comment" rows="5" cols="60" readonly><%=bikou%></textarea>

	</div>

	<p>
</body>
<%
	}
%>
</html>