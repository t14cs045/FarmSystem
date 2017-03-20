package software_f;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import java.util.List;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import software_f.*;

public class green extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		String yasai_del = req.getParameter("yasaid"); // 削除する野菜の取得
		String yasai_act = req.getParameter("yasaia"); // 追加する野菜の取得
		String botton = req.getParameter("ボタン");// 削除か追加かを判断

		HttpSession session = req.getSession(false);
		// ログインしているアカウントのuserIDを取得
		Long userID_ = (Long) session.getAttribute("userID");

		// 両方に値がセットされていない場合は、登録しない
		if (yasai_del != null || yasai_act != null) {
			PersistenceManager pm = PMF.get().getPersistenceManager();

			try {
				Query query = pm.newQuery(Kozinjouhou.class);
				query.setFilter("userID == userid");
				query.declareParameters("Long userid");
				List<Kozinjouhou> kozin = (List<Kozinjouhou>) query.execute(userID_);

				//追加処理
				if (botton.equals("追加")) {
					for (Kozinjouhou act : kozin)
						if (act.getSakumotu() == null) // 個人情報に作物が登録されていない場合のみ追加する
							act.setSakumotu(yasai_act);
				} 
				
				//削除処理
				else if (botton.equals("削除")) {
					for (Kozinjouhou del : kozin)
						if (del.getSakumotu() != null)// 個人情報に野菜が登録されていた場合削除する
							del.setSakumotu(null);
				}
			} finally {
				if (pm != null && !pm.isClosed())
					pm.close();
			}
		}

		resp.sendRedirect("/green.jsp");
	}
}
