/**
 * 
 */
package com.mo1451.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.mo1451.shopping.util.DB;

/**
 * @author Ĭ1451
 *
 */
public class User {

	private int id;
	private String username;
	private String password;
	private String phone;
	private String addr;
	private Date rdate;
	
	public int getId() {
		return id;
	}
	public String getUserName() {
		return username;
	}
	public String getPassWord() {
		return password;
	}
	public String getPhone() {
		return phone;
	}
	public String getAddr() {
		return addr;
	}
	public Date getrDate() {
		return rdate;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setUserName(String username) {
		this.username = username;
	}
	public void setPassWord(String password) {
		this.password = password;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public void setrDate(Date rdate) {
		this.rdate = rdate;
	}
	
	/**
	 * �����ݿ�������û�
	 */
	public void addToDatabase() {
		Connection conn = DB.getConnection();
		String sql = "insert into user values (null,?,?,?,?,?)";
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			conn.setAutoCommit(false);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, phone);
			pstmt.setString(4, addr);
			pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			pstmt.execute();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * �����ݿ��еõ��û�
	 * @return List<�û�>
	 */
	public List<User> getUsers() {
		List<User> users = new ArrayList<User>();
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "Select * from user";
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUserName(rs.getString("username"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setrDate(rs.getTimestamp("rdate"));
				users.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return users;
	}
	
	/**
	 * ͨ��ID�õ�һ���û�
	 * @param id �û���ID��
	 * @return һ���û�
	 */
	public User getUserById(int id) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "Select * from user where id = " + id;
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		User u = new User();
		try {
			while(rs.next()) {
				u.setId(rs.getInt("id"));
				u.setUserName(rs.getString("username"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setrDate(rs.getTimestamp("rdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return u;
	}
	
	/**
	 * ɾ��һ���û�
	 * @param id �û�id
	 */
	public void delete(int id) {
		Connection conn = DB.getConnection();
		String sql = "delete from user where id = " + id;
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * ����Ƿ��и��û��������Ƿ���ȷ
	 * @param username �û���
	 * @param password ����
	 * @return 0�����û������ڣ�1��������ȷ��-1�����벻��ȷ
	 */
	public int checkUser(String username,String password) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from user where username = '" + username + "'";
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			if(rs.next()) {
				if(password.equals(rs.getString("password"))) {	
					this.setId(rs.getInt("id"));
					this.setUserName(rs.getString("username"));
					this.setPassWord(rs.getString("password"));
					this.setPhone(rs.getString("phone"));
					this.setAddr(rs.getString("addr"));
					this.setrDate(rs.getTimestamp("rdate"));
					return 1;
				}
			} else {
				return 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return -1;
	}
	
	/**
	 * ����û����Ƿ��Ѵ���
	 * @param username
	 * @return
	 */
	public boolean checkUser(String username) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from user where username = '" + username + "'";
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			if(rs.next()) {				
					return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return false;
	}
	
	/**
	 * �����û��绰�͵�ַ
	 */
	public void update() {
		Connection conn = DB.getConnection();
		String sql = "update user set phone = ?,addr = ? where id = " + this.getId();
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			conn.setAutoCommit(false);
			pstmt.setString(1, phone);
			pstmt.setString(2, addr);
			pstmt.execute();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * ��������
	 * @param password ����
	 */
	public void changPassword(String password) {
		Connection conn = DB.getConnection();
		String sql = "update user set password = ? where id = " + this.getId();
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			conn.setAutoCommit(false);
			pstmt.setString(1, password);
			pstmt.execute();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	/**
	 * ��ȡĳһҳ���û���
	 * @param users "�û�"List
	 * @param pageNo ҳ��
	 * @param pageSize ÿҳ����
	 * @return ������ҳ
	 */
	public int getUsers(List<User> users, int pageNo,int pageSize) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from user limit " + (pageNo-1)*pageSize + "," + pageSize;
//System.out.println(sql);
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		int pageCount = 0;
		Statement stmtCount = DB.createStatement(conn);
		ResultSet rsCount = DB.exceuteQurey(stmtCount, "select count(*) from user");
		try {
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize -1) / pageSize;
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUserName(rs.getString("username"));
				u.setPhone(rs.getString("phone"));
				u.setAddr(rs.getString("addr"));
				u.setrDate(rs.getTimestamp("rdate"));
				users.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(rsCount);
			DB.close(stmtCount);
			DB.close(conn);
		}
		return pageCount;
	}
	
	/**
	 * �����ʷ����
	 * @param orders ����List
	 * @param userId �û�ID
	 * @param pageNo ҳ��
	 * @param pageSize ÿҳ��ʾ���ٸ�
	 * @return ����ҳ
	 */
	public int getHistoryOrders(List<SalesOrder> orders,int userId, int pageNo,int pageSize) {
		return OrderMgr.getInstance().getHistoryOrders(orders, userId, pageNo, pageSize);
	}
}
