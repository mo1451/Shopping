/**
 * 
 */
package com.mo1451.shopping.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mo1451.shopping.CartItem;
import com.mo1451.shopping.Category;
import com.mo1451.shopping.Product;
import com.mo1451.shopping.SalesItem;
import com.mo1451.shopping.SalesOrder;
import com.mo1451.shopping.util.DB;

/**
 * @author 默1451
 *
 */
public class OrderMySQLDAO implements OrderDAO {

	public boolean addToDatabse(SalesOrder so) {
		boolean flag = false;
		Connection conn = DB.getConnection();
		String sql = "insert into salesorder values (null,?,?,?,?)";
		PreparedStatement pstmt = DB.preparedStatement(conn, sql,true);
		ResultSet rs = null;
		List<CartItem> items = so.getCart().getItems();
		boolean login = so.getCart().isLogin();
		int key = -1;
		try {
			conn.setAutoCommit(false);
			
			pstmt.setInt(1, so.getUserid());
			pstmt.setString(2, so.getAddr());
			pstmt.setTimestamp(3, so.getOdate());
			pstmt.setInt(4, so.getStatus());
			pstmt.execute();
			rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				key = rs.getInt(1);
			}
			sql = "insert into salesitem values (null,?,?,?,?)";
			pstmt = DB.preparedStatement(conn, sql);
			for(int i=0;i<items.size();i++) {
				CartItem ci = items.get(i);
				pstmt.setInt(1, ci.getProductId());
				pstmt.setDouble(2, ci.getUnitPrice(login));
				pstmt.setInt(3, ci.getProductNo());
				pstmt.setInt(4, key);
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			conn.commit();
			conn.setAutoCommit(true);
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();
				conn.setAutoCommit(true);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return flag;
	}

	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "";
//System.out.println(sql);
		ResultSet rs = null;
		int pageCount = 0;
		Statement stmtCount = DB.createStatement(conn);
		ResultSet rsCount = DB.exceuteQurey(stmtCount, "select count(*) from salesorder");
		try {
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize -1) / pageSize;
			sql = "select * from salesorder order by odate desc limit " + (pageNo-1)*pageSize + "," + pageSize;;
			rs = DB.exceuteQurey(stmt, sql);
			while(rs.next()) {
				SalesOrder so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setUserid(rs.getInt("userid"));
				if(so.getUserid() == -1) {
					so.setUsername("游客");
				} else {
					ResultSet userRS = DB.exceuteQurey(stmtCount, "select username from user where id = " + so.getUserid());
					if(userRS.next()) {
						so.setUsername(userRS.getString("username"));
					}
					DB.close(userRS);
					
				}
				so.setStatus(rs.getInt("status"));
				so.setOdate(rs.getTimestamp("odate"));
				so.setAddr(rs.getString("addr"));
				orders.add(so);
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

	public List<SalesItem> getItems(int orderId) {
		List<SalesItem> items = new ArrayList<SalesItem>();
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "Select * from salesitem si where orderid = " + orderId;
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		int i = 1;
		try {
			while(rs.next()) {
				SalesItem si = new SalesItem();
				si.setId(i++);
				si.setOrderId(orderId);
				si.setProductId(rs.getInt("productid"));
				Statement pstmt = DB.createStatement(conn);
				ResultSet prs = DB.exceuteQurey(pstmt, "select name from product where id = " + si.getProductId());
				if(prs.next()) {
					si.setProductName(prs.getString(1));
				}
				DB.close(prs);
				DB.close(pstmt);
				si.setUnitPrice(rs.getDouble("unitprice"));
				si.setPcount(rs.getInt("pcount"));
				items.add(si);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return items;
	}

	public boolean updateStatus(SalesOrder so) {
		Connection conn = DB.getConnection();
		DB.executeUpdate(conn, "update salesorder set status = " + so.getStatus() + " where id = " + so.getId());
		DB.close(conn);
		return true;
	}

	/* (non-Javadoc)
	 * @see com.mo1451.shopping.DAO.OrderDAO#getHistoryOrders(java.util.List, int, int, int)
	 */
	@Override
	public int getHistoryOrders(List<SalesOrder> orders, int userId, int pageNo, int pageSize) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "";
//System.out.println(sql);
		ResultSet rs = null;
		int pageCount = 0;
		Statement stmtCount = DB.createStatement(conn);
		ResultSet rsCount = DB.exceuteQurey(stmtCount, "select count(*) from salesorder where userid = " + userId);
		try {
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize -1) / pageSize;
			sql = "select * from salesorder where userid = " + userId + " order by odate desc limit " + (pageNo-1)*pageSize + "," + pageSize;;
			rs = DB.exceuteQurey(stmt, sql);
			while(rs.next()) {
				SalesOrder so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setUserid(rs.getInt("userid"));
				if(so.getUserid() == -1) {
					so.setUsername("游客");
				} else {
					ResultSet userRS = DB.exceuteQurey(stmtCount, "select username from user where id = " + so.getUserid());
					if(userRS.next()) {
						so.setUsername(userRS.getString("username"));
					}
					DB.close(userRS);
					
				}
				so.setStatus(rs.getInt("status"));
				so.setOdate(rs.getTimestamp("odate"));
				so.setAddr(rs.getString("addr"));
				orders.add(so);
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
}
