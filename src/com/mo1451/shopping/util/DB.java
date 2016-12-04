/**
 * 
 */
package com.mo1451.shopping.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author 默1451
 *连接数据库
 *辅助类DB
 */
public class DB {
	
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/shopping?user=root&password=root&useSSL=false");
		}catch (SQLException e1) {
			e1.printStackTrace();
		}
		return conn;
	}
	
	public static Statement createStatement(Connection conn) {
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return stmt;
	}
	
	public static int executeUpdate(Connection conn,String sql) {
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			return stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public static PreparedStatement preparedStatement(Connection conn,String sql) {
		PreparedStatement pStmt = null;
		try {
			pStmt = conn.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pStmt;
	}
	
	public static PreparedStatement preparedStatement(Connection conn,String sql,boolean generatedKey) {
		PreparedStatement pStmt = null;
		try {
			if(generatedKey) {
				pStmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			} else {
				pStmt = conn.prepareStatement(sql);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pStmt;
	}
	
	public static ResultSet exceuteQurey(Statement stmt, String sql) {
		ResultSet rs = null;
		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public static void close(Connection conn) {
		try {
			if(conn != null) {
				conn.close();
				conn = null;
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(Statement stmt) {
		try {
			if(stmt != null) {
				stmt.close();
				stmt = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(PreparedStatement pstmt) {
		try {
			if(pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(ResultSet rs) {
		try {
			if(rs != null) {
				rs.close();
				rs = null;
			}
		} catch (SQLException e ) {
			e.printStackTrace();
		}
	}
}
