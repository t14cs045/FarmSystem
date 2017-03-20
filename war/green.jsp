<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.jdo.PersistenceManager"%>
<%@ page import="javax.jdo.Query"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="software_f.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	//ログインをしているかの判定
	boolean flag = true;
	if (session.getAttribute("access") == null) {
		flag = false; //falseの時ログインなし
		response.sendRedirect("./Error.jsp");
	}

	String gmake = null;
	ArrayList<String> green = new ArrayList<String>();

	//ログインしているアカウントのuserIDを取得
	Long userID_ = (Long) session.getAttribute("userID");

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

		//野菜全体を取得
		Query g_query = pm.newQuery(Sakumotujyouhou.class);
		List<Sakumotujyouhou> sakumotu = (List<Sakumotujyouhou>) g_query.execute();
		for (Sakumotujyouhou sk : sakumotu) {
			if (sk.getSakumotumei() != null)
				green.add(sk.getSakumotumei());
		}
	} finally {
		if (pm != null && !pm.isClosed())
			pm.close();
	}
%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>野菜情報入力</title>
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


	<!-- 全体表示のテーブル -->
	<CENTER>
		<form action="/green" method="post">
			<table border="0">
				<tr>


					<!-- 栽培している野菜を表示するテーブル -->
					<td><div
							style="background: #ffffff; padding: 10px 10px 10px 10px; border: 2px solid #000000; border-radius: 10px; width: 500px; height: 450px; margin-right: auto; margin-left: auto;">
							<table>
								<tr>
									<CENTER>
										<h1>追加した作物</h1>
									</CENTER>
								</tr>

								<!-- 削除する野菜を選ぶラジオボタンを表示 -->
								<%
									if (gmake != null) { //gmakeの中身が空でなければ表示
								%>
								<tr>
									<p>
										<input type="radio" name="yasaid" value="<%=gmake%>"><%=gmake%></p>
								</tr>
								<%
									}
								%>

								<!-- 削除ボタンを表示 -->
								<tr valign="bottom">
									<CENTER>
										<input type="submit" name="ボタン" value="削除">
									</CENTER>
								</tr>
							</table>
						</div></td>
					<!-- 栽培している野菜を表示するテーブル終了 -->





					<!-- 野菜を追加するテーブル -->
					<td><div
							style="background: #ffffff; padding: 10px 10px 10px 10px; border: 2px solid #000000; border-radius: 10px; width: 500px; height: 450px; margin-right: auto; margin-left: auto;">
							<table>
								<tr>
									<CENTER>
										<h2>栽培する作物の種類を選択してください</h2>
									</CENTER>
								</tr>

								<!-- 追加する野菜を選ぶラジオボタンを表示 -->
								<%
									for (int i = 0; i < green.size(); i++) {
								%>
								<tr>
									<p>
										<input type="radio" name="yasaia" value="<%=green.get(i)%>"><%=green.get(i)%></p>
								</tr>
								<%
									}
								%>

								<!-- 追加ボタンと戻るボタンを表示 -->
								<!-- 追加ボタン -->
								<tr valign="bottom">
									<td width="250px" align="right"><input type="submit"
										name="ボタン" value="追加"></td>

									<!-- 削除ボタン -->
									<td width="250px">
										<form name="return" method="post" action="MyPage.jsp">
											<input type="submit" onclick="/MyPage.jsp" value="戻る">
										</form>
									</td>
								</tr>
							</table>
						</div></td>
					<!-- 野菜追加テーブル終了 -->


				</tr>
			</table>
		</form>
	</CENTER>

</body>
</html>