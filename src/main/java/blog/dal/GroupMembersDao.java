package blog.dal;

import blog.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

public class GroupMembersDao {
	protected ConnectionManager connectionManager;

	private static GroupMembersDao instance = null;

	protected GroupMembersDao() {
		connectionManager = new ConnectionManager();
	}

	public static GroupMembersDao getInstance() {
		if (instance == null) {
			instance = new GroupMembersDao();
		}
		return instance;
	}

	public GroupMembers create(GroupMembers groupMember) throws SQLException {
		String insertGroupMember = "INSERT INTO GroupMembers(GroupId,UserName,Role,JoinDate) VALUES(?,?,?,?);";
		Connection connection = null;
		PreparedStatement insertStmt = null;
		try {
			connection = connectionManager.getConnection();
			insertStmt = connection.prepareStatement(insertGroupMember);
			insertStmt.setInt(1, groupMember.getGroupId());
			insertStmt.setString(2, groupMember.getUserName());
			insertStmt.setString(3, groupMember.getRole().name());
			insertStmt.setTimestamp(3, new Timestamp(groupMember.getJoinDate().getTime()));

			insertStmt.executeUpdate();
			return groupMember;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (connection != null) {
				connection.close();
			}
			if (insertStmt != null) {
				insertStmt.close();
			}
		}
	}

	public GroupMembers getGroupMemberById(int groupId, String userName) throws SQLException {
		String selectGroupMember = "SELECT GroupId,UserName,Role,JoinDate FROM GroupMembers WHERE GroupId=? AND UserName=?;";
		Connection connection = null;
		PreparedStatement selectStmt = null;
		ResultSet results = null;
		try {
			connection = connectionManager.getConnection();
			selectStmt = connection.prepareStatement(selectGroupMember);
			selectStmt.setInt(1, groupId);
			selectStmt.setString(2, userName);
			results = selectStmt.executeQuery();
			if (results.next()) {
				int resultGroupId = results.getInt("GroupId");
				String resultUserName = results.getString("UserName");
				String role = results.getString("Role");
				Date joinDate = new Date(results.getTimestamp("JoinDate").getTime());
				
				return new GroupMembers(resultGroupId, resultUserName, GroupMembers.Roles.valueOf(role), joinDate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (connection != null) {
				connection.close();
			}
			if (selectStmt != null) {
				selectStmt.close();
			}
			if (results != null) {
				results.close();
			}
		}
		return null;
	}
	
	public GroupMembers updateRole(GroupMembers groupMember, String newRole) throws SQLException {
		String updateGroupMember = "UPDATE GroupMembers SET Role=? WHERE GroupId=? AND UserName=?;";
		Connection connection = null;
		PreparedStatement updateStmt = null;
		try {
			connection = connectionManager.getConnection();
			updateStmt = connection.prepareStatement(updateGroupMember);
			updateStmt.setString(1, newRole);
			updateStmt.setInt(2, groupMember.getGroupId());
			updateStmt.setString(3, groupMember.getUserName());

			updateStmt.executeUpdate();
			
			groupMember.setRole(GroupMembers.Roles.valueOf(newRole));
			return groupMember;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (connection != null) {
				connection.close();
			}
			if (updateStmt != null) {
				updateStmt.close();
			}
		}
	}

	public boolean delete(GroupMembers groupMember) throws SQLException {
		String deleteGroupMember = "DELETE FROM GroupMembers WHERE GroupId=? AND UserName=?;";
		Connection connection = null;
		PreparedStatement deleteStmt = null;
		try {
			connection = connectionManager.getConnection();
			deleteStmt = connection.prepareStatement(deleteGroupMember);
			deleteStmt.setInt(1, groupMember.getGroupId());
			deleteStmt.setString(2, groupMember.getUserName());

			int affectedRows = deleteStmt.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (connection != null) {
				connection.close();
			}
			if (deleteStmt != null) {
				deleteStmt.close();
			}
		}
	}
}