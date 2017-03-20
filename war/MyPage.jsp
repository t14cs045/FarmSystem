<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	boolean flag_login = true;
	if (session.getAttribute("access") == null) {
		flag_login = false;
		response.sendRedirect("./Error.jsp");
	}
	if (flag_login) {
		//ログインしているアカウントのメールアドレスを取得
		Long userID_ = (Long) session.getAttribute("userID");

		//変数の初期化
		String sakumotu_ = "";
		String hyouzimei = "";
		double saitekiondo = 0.0;
		session.setAttribute("flag_sakumotu", "false"); //作物情報を登録しているかどうかのフラグ

		String[] week_name = { "日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日" };
		Calendar calendar = Calendar.getInstance();
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DATE);
		int week = calendar.get(Calendar.DAY_OF_WEEK) - 1;

		Date today = Calendar.getInstance().getTime();
		String Today = new SimpleDateFormat("yyyyMMddHH").format(today);
		int date = Integer.parseInt(Today);
		// データベースからのデータ取得 
		PersistenceManager pm = null;
		try {
			if (flag_login) { //ログインしているときのみデータベースにクエリーを送る

				//まず,個人情報を抜き出す
				pm = PMF.get().getPersistenceManager();
				Query k_query = pm.newQuery(Kozinjouhou.class);
				k_query.setFilter("userID == id");
				k_query.declareParameters("Long id");
				List<Kozinjouhou> kozinjouhous = (List<Kozinjouhou>) k_query.execute(userID_);
				Kozinjouhou user = kozinjouhous.get(0);
				hyouzimei = user.getHyouzimei();

				sakumotu_ = user.getSakumotu();

				if (sakumotu_ != null) {
					session.setAttribute("flag_sakumotu", "true");
					//個人情報テーブルから抜き出された作物情報から,作物を抜き出す
					Query s_query = pm.newQuery(Sakumotujyouhou.class);
					s_query.setFilter("sakumotumei == yasai");
					s_query.declareParameters("String yasai");
					List<Sakumotujyouhou> sakumotujyouhous = (List<Sakumotujyouhou>) s_query.execute(sakumotu_);
					session.setAttribute("sakumotuID", sakumotujyouhous.get(0).getSakumotuID());

					saitekiondo = sakumotujyouhous.get(0).getSaitekiondo();

					Query t_query = pm.newQuery(TenkiTable.class);
					t_query.setFilter("userID == userid");
					t_query.declareParameters("Long userid");
					List<TenkiTable> tenkitables = (List<TenkiTable>) t_query.execute(userID_);

					if (tenkitables != null) {
						for (TenkiTable tt : tenkitables) {
							if (tt.getDate() == date) {
								int tenki = tt.getTenki();
								if (tenki == 0)
									saitekiondo -= 3;
								else if (tenki == 2 || tenki == 3) {
									saitekiondo += 3;
								}
								break;
							}
						}
					}
				}

			}
%>


<head>
<!-- スタイルシートの適用 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Style-Type" content="text/css">
<title>MyPage</title>
<link rel="stylesheet" type="text/css" href="/csslib/header.css"
	media="tv,screen,print">
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
					if ((String.valueOf(session.getAttribute("flag_sakumotu"))).equals("false")) {
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



	<div id="contentsArea" align="center">

		<!--******** 「○○さんマイページ」の表示 ********-->
		<table border="2" cellpadding="5" cellspacing="0"
			bordercolor="#a9a9a9">
			<tr>
				<td><span style="padding: 30pt"><%=hyouzimei%>さんのマイページ</span></td>
				<td><FONT size="1"><%=hyouzimei%>さんログイン中</FONT></td>
				<td>
					<form action="/firstlogin.jsp" method="post">
						<input type="submit" value="ユーザ情報の変更" disabled="disabled" />
					</form>
				</td>
			</tr>
		</table>
		<br>


		<!--******** 最適温度表示 ********-->


		<div
			style="border: 1px solid #000; padding: 10px; border-radius: 10px; width: 400px;">
			<%=month%>月
			<%=day%>日 (<%=week_name[week]%>) <br>

			<%
				if ((String.valueOf(session.getAttribute("flag_sakumotu"))).equals("false")) {
			%>
			作物情報の登録を行なってください。
			<%
				} else {
			%>

			今日の<%=sakumotu_%>の最適気温は
			<%=saitekiondo%>
			度です

			<%
				}
			%>
		</div>

		<!-- スクロールテスト用 -->
		<!-- Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> Contents<br> Contents<br> Contents<br>
		Contents<br> End -->
	</div>

	<%
		} finally {
				if (pm != null && !pm.isClosed())
					pm.close();
			}
	%>


</body>
<%
	}
%>
</html>