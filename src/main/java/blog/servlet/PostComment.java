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

/**
 * FindUsers is the primary entry point into the application.
 * 
 * Note the logic for doGet() and doPost() are almost identical. However, there
 * is a difference: doGet() handles the http GET request. This method is called
 * when you put in the /findusers URL in the browser. doPost() handles the http
 * POST request. This method is called after you click the submit button.
 * 
 * To run: 1. Run the SQL script to recreate your database schema:
 * http://goo.gl/86a11H. 2. Insert test data. You can do this by running
 * blog.tools.Inserter (right click, Run As > JavaApplication. Notice that this
 * is similar to Runner.java in our JDBC example. 3. Run the Tomcat server at
 * localhost. 4. Point your browser to
 * http://localhost:8080/BlogApplication/findusers.
 */
@SuppressWarnings("serial")
@WebServlet("/post_comment")
public class PostComment extends HttpServlet {

	protected PostsDao postsDao;
	protected PostCommentsDao postCommentsDao;

	@Override
	public void init() throws ServletException {
		postsDao = PostsDao.getInstance();
		postCommentsDao = PostCommentsDao.getInstance();
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

		String jspPage = req.getParameter("jspPage");
		
		// implement deleting comments
		
		String postIdStr = req.getParameter("postId");
		if (postIdStr == null || postIdStr.trim().isEmpty()) {
			System.out.println("empty");

			messages.put("error", "No postId was given.");
			req.getRequestDispatcher("/WEB-INF/jsp/UserPosts.jsp").forward(req, resp);

//			req.getRequestDispatcher("/WEB-INF/jsp/" + jspPage).forward(req, resp);
			return;
		}
		
		System.out.println("hh");

		Posts post = null;
		List<PostComments> comments = new ArrayList<>();
		List<Products> proudcts = new ArrayList<Products>();

		// Retrieve BlogUsers, and store as a message.
		int postId = Integer.parseInt(postIdStr);

//		try {
//			post = postsDao.getPostFromPostId(postId);
//			comments = postCommentsDao.getCommentsFromPostId(postId);
//			proudcts = productsDao.getSimilarProductsToPost(postId);
//		} catch (SQLException e) {
//			e.printStackTrace();
//			messages.put("error", "Error retrieving the post or similar products");
//			req.getRequestDispatcher("/WEB-INF/jsp/UserPosts.jsp").forward(req, resp);
////			req.getRequestDispatcher("/WEB-INF/jsp/" + jspPage).forward(req, resp);
//
//			return;
//		}
//		
//		messages.put("success", "Displaying results for " + postId);
//		messages.put("postId", postIdStr);
//
//		req.setAttribute("post", post);
//		req.setAttribute("comments", comments);
//		req.setAttribute("similarProducts", proudcts);

		req.getRequestDispatcher("/WEB-INF/jsp/SinglePost.jsp").forward(req, resp);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = SessionUtil.getUsername(req, resp);

		if (username == null) {
			return;
		}
		
		// Map for storing messages.
		Map<String, String> messages = new HashMap<String, String>();
		req.setAttribute("messages", messages);
		
		String postIdStr = req.getParameter("postId");
		if (postIdStr == null || postIdStr.trim().isEmpty()) {
			messages.put("error", "There was an error retrieving the post.");
			resp.sendRedirect(req.getContextPath() + "/all_posts");
			return;
		}
		
		int postId = -1;
		
		try {
		    postId = Integer.parseInt(postIdStr);
		} catch (NumberFormatException e) {
			messages.put("error", "You provided an invalid post id");
			resp.sendRedirect(req.getContextPath() + "/all_posts");
			return;
		}

		String comment = req.getParameter("commentContent");
		if (comment == null || comment.trim().isEmpty()) {
			messages.put("error", "The comment had no content was given.");
			resp.sendRedirect(req.getContextPath() + "/view_post?postId=" + postIdStr);
			return;
		}
				
		try {
			postCommentsDao.create(new PostComments(comment, username, postId));
		} catch (SQLException e) {
			e.printStackTrace();
			messages.put("error", "Comment could not be added to the post. Try again.");
		}
		
		resp.sendRedirect(req.getContextPath() + "/view_post?postId=" + postIdStr);
	}
}
