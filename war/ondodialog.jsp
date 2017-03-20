<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="software_f.PMF"%>
<%@ page import="software_f.OndoTable"%>
<%@ page import="javax.jdo.PersistenceManager"%>
<%@ page import="javax.jdo.Query"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
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
		Long userid = (Long) session.getAttribute("userID");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>確認画面</title>
</head>
<body>
	<!-- 日時が一致しなかったら無条件でondonyuuryokuに送信 -->
	<script>
			//飛ばすURL,getのためparamを定義
			var redirectPass = "/ondonyuuryoku?<%="date=" + request.getParameter("date") + "&ampm=" + request.getParameter("ampm") + "&hour="
						+ request.getParameter("hour") + "&minute=" + request.getParameter("minute") + "&kukakusuu="
						+ request.getParameter("kukakusuu")%>";
			<%int kukakusuu = Integer.parseInt(request.getParameter("kukakusuu"));
				for (int i = 1; i <= kukakusuu; i++) {%>
			redirectPass += "&kukaku<%=i + "=" + request.getParameter("kukaku" + i)%>";
	<%}%>
		//日時が一致するかどうか調べる
	<%PersistenceManager pmm = null;
				try {
					pmm = PMF.get().getPersistenceManager();
					Query query = pmm.newQuery(OndoTable.class);
					List<OndoTable> results = (List<OndoTable>) query.execute();

					if (results != null) {
						//新規の日を取得
						String datestr = request.getParameter("date");
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						Date date = null;
						try {
							date = format.parse(datestr);
						} catch (ParseException e) {
							System.out.println("error");
							// TODO 自動生成された catch ブロック
							e.printStackTrace();
						}

						//新規の時間を取得
						String ampm = request.getParameter("ampm");

						int jikoku = 0;
						if (ampm == "pm")
							jikoku += 1200;
						int hour = Integer.parseInt(request.getParameter("hour"));
						int minute = Integer.parseInt(request.getParameter("minute"));
						jikoku += hour * 100 + minute;

						//一致するかどうか
						boolean flag = false;
						for (OndoTable data : results) {
							//日のずれを計算
							int diff = date.compareTo(data.getHiduke());
							if (diff == 0 && jikoku == data.getJikoku() && userid.equals(data.getUserID())) {
								flag = true;
								break;
							}
						}
						%>
						var flag = <%=flag%> 
		//一致するものがないとき
		if (flag == false){
			location.href = redirectPass;
		}
	<%}
				} finally {
					if (pmm != null && !pmm.isClosed())
						pmm.close();
				}%>
		
	</script>

	<div align="center">

		<p>
			<font size="5">日付，時刻が同じですが記録してもよろしいですか？</font>
		<p>
		<form action="/ondonyuuryoku" method="post">
			<input type="hidden" value=<%=request.getParameter("date")%>
				name="date"> <input type="hidden"
				value=<%=request.getParameter("ampm")%> name="ampm"> <input
				type="hidden" value=<%=request.getParameter("hour")%> name="hour">
			<input type="hidden" value=<%=request.getParameter("minute")%>
				name="minute"> <input type="hidden"
				value=<%=request.getParameter("kukakusuu")%> name="kukakusuu">
			<%
				kukakusuu = Integer.parseInt(request.getParameter("kukakusuu"));
					for (int i = 1; i <= kukakusuu; i++) {
			%>
			<input type="hidden" value=<%=request.getParameter("kukaku" + i)%>
				name=<%="kukaku" + i%>>
			<%
				}
			%>

			<input type="submit" value="はい"
				style="width: 280px; height: 40px; font-size: 20px;" /> <br>
		</form>
		<p>
		<form action="ondonyuuryoku.jsp" method="post">
			<input type="submit" value="いいえ"
				style="width: 280px; height: 40px; font-size: 20px;" />
		</form>
	</div>
</body>
<%
	}
%>
</html>