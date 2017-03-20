package software_f;

import software_f.Kozinjouhou;
import software_f.PMF;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class login extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		resp.setContentType("text/html;charset=UTF-8");
		String mail = req.getParameter("mail");
		String password = (req.getParameter("password"));
		boolean flag = false;

		// 値が無ければreloginへ
		if ((mail.length() == 0) || (password.length() == 0))
			resp.sendRedirect("/relogin.jsp");

		PersistenceManager pm = PMF.get().getPersistenceManager();	
		try {
		Query query2 = pm.newQuery(Sakumotujyouhou.class);
		List<Sakumotujyouhou> SJ = (List<Sakumotujyouhou>) query2.execute();

			if (SJ.size() == 0) {
				Sakumotujyouhou s[];
				int N = 7;
				s = new Sakumotujyouhou[N];
				s[0] = new Sakumotujyouhou("なす", 27);
				s[1] = new Sakumotujyouhou("ピーマン", 27);
				s[2] = new Sakumotujyouhou("いも", 25);
				s[3] = new Sakumotujyouhou("トマト", 24);
				s[4] = new Sakumotujyouhou("きゅうり", 22);
				s[5] = new Sakumotujyouhou("にんじん", 22);
				s[6] = new Sakumotujyouhou("いちご", 18);
					for (int i = 0; i < N; i++)
						pm.makePersistent(s[i]);
			}
		} finally {
			if (pm != null && !pm.isClosed())
			pm.close();
		}

		// アカウント確認
		@SuppressWarnings("unchecked")
		List<Kozinjouhou> accounts = (List<Kozinjouhou>) pm.newQuery(Kozinjouhou.class).execute();

		HttpSession session = req.getSession(false);

		for (Kozinjouhou account : accounts) {

			// アカウントとパスワードが一致したならば
			if (mail.equals(account.getMailaddress())) {
				if (password.equals(account.getPassword())) {
					session = req.getSession(true);
					flag = true;
					session.setAttribute("access", String.valueOf(flag));
					session.setAttribute("mail", account.getMailaddress());
					session.setAttribute("userID", account.getUserID());
					session.setAttribute("password", account.getPassword());
				}
			}
		}

		// 正しい
		if (flag == true)
			resp.sendRedirect("/MyPage.jsp");

		// 間違い
		if (flag == false)
			resp.sendRedirect("/relogin.jsp");
	}
}