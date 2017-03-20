package software_f;

//import software_f.Kozinjouhou;
import software_f.PMF;

import java.io.IOException;
import java.net.URL;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;
import java.util.TimeZone;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class FirstLogin extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html;charset=UTF-8");

		PersistenceManager pm = PMF.get().getPersistenceManager();
		PersistenceManager pm2 = PMF.get().getPersistenceManager();
		// Writer out = resp.getWriter();
		// エラー判定，アカウント作成判定
		int error = 0, judge = 1;
		// firstlogin.jsp からのデータを受け取る
		String name = req.getParameter("name");// 氏名
		String name2 = req.getParameter("name2");// 表示名
		String mail = req.getParameter("mail");
		String pass = req.getParameter("pass");
		String pass2 = req.getParameter("pass2");
		String number = req.getParameter("num");// 区画数
		String number2 =req.getParameter("num2");// 郵便番号(上3桁）
		String number3 = req.getParameter("num3");// 郵便番号(下4桁）
		String prefectures = req.getParameter("prefectures");
		String city = req.getParameter("city");// 市町村
		String city2 = req.getParameter("city2");// 番地など

		// error
		// 氏名
		if (name.equals("")) {
			error += 1;
		}
		// 氏名が適切かどうかの判定
		if (name.length() >= 50) {
			error += 2;
		}

		// 表示名
		if (name2.equals("")) {
			error += 4;
		}
		// 表示名が適切かどうかの判定
		if (name2.length() >= 20) {
			error += 8;
		}
		// メールアドレス
		if (mail.equals("")) {
			error += 16;
		}
		// メールアドレスが適切かどうかの判定
		else if (!mail.matches("[\\w\\.\\-]+@(?:[\\w\\-]+\\.)+[\\w\\-]+")) {
			error += 32;
		}
		try {
			//栽培している野菜を取得
			Query k_query = pm.newQuery(Kozinjouhou.class);
			k_query.setFilter("mailaddress == param");
			k_query.declareParameters("String param");
			List<Kozinjouhou> kozin = (List<Kozinjouhou>) k_query.execute(mail);
			for (Kozinjouhou kz : kozin) {
				if (mail.equals(kz.getMailaddress())){
					error += 131072*2;
				}
			}
		} finally {
			if (pm != null && !pm.isClosed())
				pm.close();
		}

		// パスワード
		if (pass.equals("")) {
			error += 64;
		}
		else if (pass2.equals("")) {
			error += 128;
		}
		else if (!pass.equals(pass2) && !pass.equals("") && !pass2.equals("")) {
			error += 256;
		}
		else if (pass.length() != 4 || pass2.length() != 4) {
			error += 512;
		}
		else if (!pass.matches("[\\d\\w]+") || !pass2.matches("[\\d\\w]+")) {
			error += 1024;
		}

		// 区画数
		if (number.equals("")) {
			error += 2048;
		}
		// 区画数が適切かどうかの判定
		else if (number.length() > 3 || !number.matches("[1,2,3,4,5,6,7,8,9]+[0+1+2+3+4+5+6+7+8+9]*")) {
			error += 4096;
		}
		
		// 郵便番号(上3桁)
		if (number2.equals("")) {
			error += 8192;
		}
		// 郵便番号(下4桁)
		else if (number3.equals("")) {
			error += 8192;
		}
		// 市町村
		if (city.equals("")) {
			error += 16384;
		}
		// 市町村が適切かどうかの判定
		else if (city.length() > 30) {
			error += 32768;
		}
		// 番地など
		if (city2.equals("")) {
			error += 65536;
		}
		// 番地などが適切かどうかの判定
		else if (city2.length() > 30) {
			error += 131072;
		}
		// エラーを見つければリダイレクトする
		if (error != 0) {
			resp.sendRedirect("./firstlogin.jsp?Error=" + String.valueOf(error));
			return;
		}
		
		
		try {
			String yuubin = number2 + number3;
			Kozinjouhou kj = new Kozinjouhou(name, name2, mail, pass, Integer.parseInt(number), yuubin, prefectures,
					city, city2, null);
			pm2.makePersistent(kj);

		} finally {
			if (pm != null && !pm.isClosed())
			pm2.close();
		}

		resp.sendRedirect("/toroku.jsp");
	}
}
