<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="software_f.PMF"%>
<%@ page import="software_f.Kozinjouhou"%>
<%@ page import="javax.jdo.PersistenceManager"%>
<%@ page import="javax.jdo.Query"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%
	// ログインをしているかの判定
	boolean flag_login = true;
	if (session.getAttribute("access") == null) {
		flag_login = false;
		response.sendRedirect("./Error.jsp");
	}
	if (flag_login) {
		Long id = null;
		id = (Long) session.getAttribute("userID");

		String gmake = null;

		PersistenceManager pm = null;
		try {
			//栽培している野菜を取得
			pm = PMF.get().getPersistenceManager();
			Query k_query = pm.newQuery(Kozinjouhou.class);
			k_query.setFilter("userID == userid");
			k_query.declareParameters("Long userid");
			List<Kozinjouhou> kozin = (List<Kozinjouhou>) k_query.execute(id);
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
<title>室内温度入力</title>

<style type='text/css'>
input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
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

	<!-- 見出し -->
	<div align="left" style="margin-left: 37%;">
		<h3>温度記録入力</h3>
	</div>

	<!-- ondodialog.jspにpostで送信する -->
	<form action="/ondodialog.jsp" method="post">

		<!-- 全体にマージン -->
		<div align="left" style="margin-left: 37%;">

			<!-- 日付入力 -->
			<div style="display: inline-block; height: 20%;">
				<input type="date" name="date" style="height: 40px;">
			</div>

			<!-- 午前午後選択 -->
			<div
				style="display: inline-block; margin-left: 5%; vertical-align: middle;">
				<select name="ampm" size="2" style="height: 45px; width: 50px;">
					<option value="am" label="午前"></option>
					<option value="pm" label="午後"></option>
				</select>
			</div>

			<!-- 時間入力 -->
			<div style="display: inline-block; margin-left: 1%; width: 5%">
				<input type="number" name="hour" min="0" max="12"
					style="height: 40px; width: 100%">
			</div>
			<div style="display: inline-block;">
				<p style="font-size: 25px;">:</p>
			</div>
			<div style="display: inline-block; margin-left: 0%; width: 5%">
				<input type="number" name="minute" min="0" max="60"
					style="height: 40px; width: 100%">
			</div>
		</div>


		<!--区画数把握  -->
		<%
			pm = null;
				int kukakusuu = 0;
				try {

					pm = PMF.get().getPersistenceManager();
					Query query = pm.newQuery(Kozinjouhou.class);
					query.setFilter("userID == idparam");
					query.declareParameters("Long idparam");
					List<Kozinjouhou> results = (List<Kozinjouhou>) query.execute(id);

					kukakusuu = 0;
					if (results != null) {
						for (Kozinjouhou data : results) {
							kukakusuu += data.getKukakusuu();
						}
					}
				} finally {
					if (pm != null && !pm.isClosed())
						pm.close();
				}
		%>

		<input type="hidden" name="kukakusuu" value="<%=kukakusuu%>">

		<!-- スクロールバーの部分 -->
		<div
			style="overflow-y: scroll; width: 40%; height: 500px; margin-left: 37%;">

			<!-- tableでレイアウト -->
			<table>

				<!-- 区画数行分ループ -->
				<%
					for (int i = 1; i <= kukakusuu; i++) {
				%>
				<tr>
					<td width="150" align="center">区画<%=i%>
					</td>
					<td width="300"><input type="number" name="kukaku<%=i%>"
						size="20"></input></td>
				</tr>
				<%
					}
				%>

			</table>

		</div>

		<div style="margin-left: 70%; width: 5%;">
			<input type="submit" value="保存" style="width: 100%;"></input>
		</div>

	</form>
</body>
<%
	}
%>
</html>
