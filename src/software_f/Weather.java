package software_f;

import software_f.TenkiTable;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Weather extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html;charset=UTF-8");
		int error = 0;

		int tenki = 0;
		String Tenki = req.getParameter("tenki");
		if (Tenki == null || Tenki.length() == 0) {
			error += 1;
		} else {
			try {
				tenki = Integer.parseInt(Tenki);
			} catch (NumberFormatException e) {
			}
		}

		int ondo = 0;
		String Ondo = req.getParameter("ondo");
		if (Ondo == null || Ondo.length() == 0) {
			error += 4;
		} else {
			try {
				ondo = Integer.parseInt(Ondo);
			} catch (NumberFormatException e) {
				error += 8;
			}
		}

		HttpSession session = req.getSession(true);
		Long user = (Long) session.getAttribute("userID");

		if (error != 0) {
			resp.sendRedirect("./ondo.jsp?Error=" + String.valueOf(error));
			return;
		}

		Date today = Calendar.getInstance().getTime();
		String Today = new SimpleDateFormat("yyyyMMddHH").format(today);
		int date = Integer.parseInt(Today);

		TenkiTable tt = new TenkiTable(ondo, tenki, user, date);
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(tt);
		} finally {
			if (pm != null && !pm.isClosed())
			pm.close();
		}


		resp.sendRedirect("/nyuryoku.jsp");
	}
}
