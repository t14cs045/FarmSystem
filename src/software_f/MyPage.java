package software_f;

import software_f.PMF;
import java.io.IOException;
import javax.jdo.PersistenceManager;
import javax.servlet.http.*;

public class MyPage extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
    	
        resp.sendRedirect("/MyPage.jsp");
    }
}
