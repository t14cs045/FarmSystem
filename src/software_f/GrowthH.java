package software_f;

import java.io.IOException;
import java.util.Date;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GrowthH extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		String userID = (req.getParameter("userID"));
		String sakumotuID = req.getParameter("sakumotuID");
		String date = (req.getParameter("date"));
		String seityouNum = (req.getParameter("sd"));
		String sagyouNum = (req.getParameter("sg"));
		String comment = req.getParameter("comment");

		// 両方に値がセットされていない場合は、登録しない
		if ((sagyouNum != null) && (seityouNum != null) && (userID != null) && !(sakumotuID.equals("null"))) {
			
			Seityoukiroku sc = new Seityoukiroku(Long.valueOf(userID), Long.valueOf(sakumotuID),
					(int) Integer.valueOf(seityouNum), (int) Integer.valueOf(sagyouNum), (int) Integer.valueOf(date),
					comment);

			PersistenceManager pm = PMF.get().getPersistenceManager();
			try {
				pm.makePersistent(sc);
			} finally {
				if (pm != null && !pm.isClosed())
				pm.close();
			}
		}

		resp.sendRedirect("/MyPage.jsp");
	}
}
