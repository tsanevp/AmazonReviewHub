package blog.servlet;

import blog.dal.*;
import blog.model.*;
import blog.util.SessionUtil;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/my_wishlist")
public class UserWishlist extends HttpServlet {

	protected UsersDao usersDao;
	protected WishlistDao wishlistDao;

	@Override
	public void init() throws ServletException {
		usersDao = UsersDao.getInstance();
		wishlistDao = WishlistDao.getInstance();
	}

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = SessionUtil.getUsername(req, resp);

		if (username == null) {
			return;
		}

		// Map for storing messages.
		Map<String, String> messages = new HashMap<String, String>();
		req.setAttribute("messages", messages);

		Users user = null;
		List<Wishlist> wishlistItems = new ArrayList<>();

		try {
			user = usersDao.getUserFromUserName(username);
			wishlistItems = wishlistDao.getWishlistFromUserName(username);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new IOException(e);
		}

		req.setAttribute("user", user);
		req.setAttribute("wishlistItems", wishlistItems);

		// Just render the JSP.
		req.getRequestDispatcher("/WEB-INF/jsp/WishList.jsp").forward(req, resp);
	}
}
