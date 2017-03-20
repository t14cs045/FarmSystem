package software_f;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ondonyuuryoku extends HttpServlet {

	int kukakusuu = 0;

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession(false);

		Long userid = (Long) session.getAttribute("userID");
		// 情報保存
		String datestr = req.getParameter("date");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = format.parse(datestr);
		} catch (ParseException e) {
			System.out.println("error");
			e.printStackTrace();
		}

		String ampm = req.getParameter("ampm");

		int jikoku = 0;
		if (ampm == "pm")
			jikoku += 1200;
		int hour = Integer.parseInt(req.getParameter("hour"));
		int minute = Integer.parseInt(req.getParameter("minute"));
		jikoku += hour * 100 + minute;

		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			kukakusuu = Integer.parseInt(req.getParameter("kukakusuu"));
			for (int i = 1; i <= kukakusuu; i++) {
				int ondo = Integer.parseInt(req.getParameter("kukaku" + i));
				OndoTable ot = new OndoTable(userid, date, jikoku, i, ondo);
				pm.makePersistent(ot);
			}
		} finally {
			pm.close();
		}

		resp.sendRedirect("/MyPage.jsp");
	}

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession(false);

		Long userid = (Long) session.getAttribute("userID");
		// 情報保存
		String datestr = req.getParameter("date");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = format.parse(datestr);
		} catch (ParseException e) {
			System.out.println("error");
			e.printStackTrace();
		}

		String ampm = req.getParameter("ampm");

		int jikoku = 0;
		if (ampm == "pm")
			jikoku += 1200;
		int hour = Integer.parseInt(req.getParameter("hour"));
		int minute = Integer.parseInt(req.getParameter("minute"));
		jikoku += hour * 100 + minute;

		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			kukakusuu = Integer.parseInt(req.getParameter("kukakusuu"));
			for (int i = 1; i <= kukakusuu; i++) {
				int ondo = Integer.parseInt(req.getParameter("kukaku" + i));
				OndoTable ot = new OndoTable(userid, date, jikoku, i, ondo);
				pm.makePersistent(ot);
			}
		} finally {
			pm.close();
		}

		resp.sendRedirect("/MyPage.jsp");

	}

}
