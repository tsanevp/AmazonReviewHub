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
@WebServlet("/my_posts")
public class UserPosts extends HttpServlet {

	protected UsersDao usersDao;
	protected PostsDao postsDao;

	@Override
	public void init() throws ServletException {
		usersDao = UsersDao.getInstance();
		postsDao = PostsDao.getInstance();
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
		List<Posts> posts = new ArrayList<>();

		try {
			user = usersDao.getUserFromUserName(username);
			posts = postsDao.getPostsFromUserName(username);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new IOException(e);
		}

		req.setAttribute("user", user);
		req.setAttribute("posts", posts);

		// Just render the JSP.
		req.getRequestDispatcher("/WEB-INF/jsp/UserPosts.jsp").forward(req, resp);
	}
}
