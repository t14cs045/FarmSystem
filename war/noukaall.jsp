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
	// ログインをしているかの判定
	boolean flag_login = true;
	if (session.getAttribute("access") == null) {
		flag_login = false;
		response.sendRedirect("./Error.jsp");
	}

	//ログインしているアカウントのuserIDを取得
	Long userID_ = (Long) session.getAttribute("userID");

	ArrayList<String> sakumotulist = new ArrayList<String>();//登録されている作物を格納するリスト
	String[] seityolist = { "芽が出た", "双葉が出た", "茎が総長10cmを越えた", "花が咲いた", "実が出来た", "実が熟した" };//生長段階を格納するリスト
	ArrayList<String> namelist = new ArrayList<String>();//利用者の名前を格納するためのリスト
	ArrayList<Long> seityoresult = new ArrayList<Long>();//生長IDを格納するためのリスト
	String gmake = null;//ヘッダーのif文で使う野菜を格納する

	PersistenceManager pm = null;
	try {
		pm = PMF.get().getPersistenceManager();
		Query query = pm.newQuery(Sakumotujyouhou.class);
		List<Sakumotujyouhou> sakumotu = (List<Sakumotujyouhou>) query.execute();

		for (Sakumotujyouhou pz : sakumotu) {
			sakumotulist.add(pz.getSakumotumei());//作物を取り出す
		}

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
<title>農家一覧</title>
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

	<form action="/noukaall.jsp" method="post">

		<h2>農家の検索</h2>

		<div
			style="background: #ffffff; padding: 10px 10px 10px 10px; border: 2px solid #000000; border-radius: 10px; width: 600px; margin-right: auto; margin-left: auto;">
			<table width=100%>


				<tr>
					<!-- 農作物のタブ -->
					<td align="left">農作物 <select name="yasai">
							<%
								for (int i = 0; i < sakumotulist.size(); i++) {
							%>
							<option value="<%=sakumotulist.get(i)%>"><%=sakumotulist.get(i)%></option>
							<%
								}
							%>
					</select>
					</td>
					<!-- 農作物終わり -->


					<!-- 成長過程のタブ -->
					<td align="center">成長過程 <select name="seityo">
							<%
								for (int i = 0; i < seityolist.length; i++) {
							%>
							<option value="<%=i%>"><%=seityolist[i]%></option>
							<%
								}
							%>
					</select>
					</td>
					<!-- 成長過程終わり -->


					<!-- 地域のタブ -->
					<td align="right">地域 <select name="tiiki">
							<option value="1">北海道</option>
							<option value="2">青森県</option>
							<option value="3">岩手県</option>
							<option value="4">宮城県</option>
							<option value="5">秋田県</option>
							<option value="6">山形県</option>
							<option value="7">福島県</option>
							<option value="8">茨城県</option>
							<option value="9">栃木県</option>
							<option value="10">群馬県</option>
							<option value="11">埼玉県</option>
							<option value="12">千葉県</option>
							<option value="13">東京都</option>
							<option value="14">神奈川県</option>
							<option value="15">新潟県</option>
							<option value="16">富山県</option>
							<option value="17">石川県</option>
							<option value="18">福井県</option>
							<option value="19">山梨県</option>
							<option value="20">長野県</option>
							<option value="21">岐阜県</option>
							<option value="22">静岡県</option>
							<option value="23">愛知県</option>
							<option value="24">三重県</option>
							<option value="25">滋賀県</option>
							<option value="26">京都府</option>
							<option value="27">大阪府</option>
							<option value="28">兵庫県</option>
							<option value="29">奈良県</option>
							<option value="30">和歌山県</option>
							<option value="31">鳥取県</option>
							<option value="32">島根県</option>
							<option value="33">岡山県</option>
							<option value="34">広島県</option>
							<option value="35">山口県</option>
							<option value="36">徳島県</option>
							<option value="37">香川県</option>
							<option value="38">愛媛県</option>
							<option value="39">高知県</option>
							<option value="40">福岡県</option>
							<option value="41">佐賀県</option>
							<option value="42">長崎県</option>
							<option value="43">熊本県</option>
							<option value="44">大分県</option>
							<option value="45">宮城県</option>
							<option value="46">鹿児島県</option>
							<option value="47">沖縄県</option>
					</select>
					</td>
					<!-- 地域終わり -->
				</tr>


				<!-- 検索ボタン -->
				<tr valign="bottom">
					<td colspan="4" align="center"><input type="submit"
						value="　検索する　"></td>
				</tr>

			</table>
		</div>
	</form>


	<%
		//ここから検索結果表示処理

		//すべてのセレクトを選択していなければ次の処理に進まない
		if ((request.getParameter("yasai") != null) && (request.getParameter("seityo") != null)
				&& (request.getParameter("tiiki") != null)) {

			int seityo = Integer.parseInt(request.getParameter("seityo"));//生長段階
			String green = request.getParameter("yasai"); //選択された農作物
			String ken = request.getParameter("tiiki");//都道府県
			Long greenID = null;//作物ID

			pm = null;

			//クエリーによるデータベースからの
			try {
				//選択された作物のIDを取り出す
				pm = PMF.get().getPersistenceManager();
				Query y_query = pm.newQuery(Sakumotujyouhou.class);
				y_query.setFilter("sakumotumei == yasainame");
				y_query.declareParameters("String yasainame");
				List<Sakumotujyouhou> sakumotu = (List<Sakumotujyouhou>) y_query.execute(green);
				for (Sakumotujyouhou gr : sakumotu) {
					greenID = gr.getSakumotuID();
				}

				//選択された都道府県と同じデータを取り出す
				Query t_query = pm.newQuery(Kozinjouhou.class);
				t_query.setFilter("todoufuken == tiiki");
				t_query.declareParameters("String tiiki");
				List<Kozinjouhou> kozin = (List<Kozinjouhou>) t_query.execute(ken);

				for (Kozinjouhou kz : kozin) {
					//取り出されたデータを基に作物ID,生長段階,ユーザーIDが同じデータを取り出す
					Query s_query = pm.newQuery(Seityoukiroku.class);
					s_query.setFilter("sakumotuID == yasai　&& seityoudankaibangou == seityo && userID == userid");
					s_query.declareParameters("Long yasai , int seityo , Long userid");
					List<Seityoukiroku> seityokiroku = (List<Seityoukiroku>) s_query.execute(greenID, seityo,
							kz.getUserID());

					for (Seityoukiroku st : seityokiroku) {
						namelist.add(kz.getHyouzimei());//検索結果から出た人の表示名を格納
						seityoresult.add(st.getSeityoukirokuId());//生長IDを格納
					}
				}
			} finally {
				if (pm != null && !pm.isClosed())
					pm.close();
			}
		}

		//ここで検索結果を表示し、その人の栽培データ表示ページに飛べるようにする
		for (int i = 0; i < namelist.size(); i++) {
	%>
	<br>
	<CENTER>
		<h2>
			<a href=<%="/nouka.jsp?id=" + seityoresult.get(i)%>><%=namelist.get(i)%></a>
		</h2>
	</CENTER>
	<br>
	<%
		}
	%>
	<!-- 検索処理終了 -->



</body>
</html>