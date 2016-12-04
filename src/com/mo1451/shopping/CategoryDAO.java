/**
 * 
 */
package com.mo1451.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.mo1451.shopping.util.DB;

/**
 * @author Ĭ1451
 *
 */
public class CategoryDAO {

	/**
	 * �����ݿ�����ӡ����
	 * @param c �����
	 */
	public void addToDatabase(Category c) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		ResultSet rs = DB.exceuteQurey(stmt, "select * from category where id = " + c.getPid());
		String sql = "";
		if(c.getId() == -1) {
			sql = "insert into category values (null,?,?,?,?,?)";
		} else {
			sql = "insert into category values (" + c.getId() + ",?,?,?,?,?)";
		}
//System.out.println(sql);
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			conn.setAutoCommit(false);
			
			if(rs.next()) {
				c.setGrade(rs.getInt("grade") + 1);
				DB.executeUpdate(conn, "update category set isleaf = 0 where id = " + c.getPid());
			} else {
				c.setGrade(1);
			}
//System.out.println(c.getName());
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getDescr());
			pstmt.setInt(3, c.getPid());
			pstmt.setInt(4, c.isIsleaf()? 1 : 0);
			pstmt.setInt(5, c.getGrade());
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
	 * ��顰����Ƿ��Ѵ���
	 * @param name �������
	 * @return true �Ѵ��ڣ�false δ����
	 */
	public boolean checkCategory(String name) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from category where name = '" + name + "'";
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
	 * �����ݿ��еõ������
	 * @return List<���>
	 */
	public List<Category> getCategories(List<Category> categories,int id) {
		Connection conn = DB.getConnection();
		this.getCategories(conn,categories,id);
		DB.close(conn);
		return categories;
	}
	/**
	 * �����ݿ��еõ������
	 * @return List<���>
	 */
	public List<Category> getCategories(Connection conn,List<Category> categories,int id) {
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from category where pid = " + id;
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			while(rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getInt("isleaf")==1? true : false);
				c.setGrade(rs.getInt("grade"));
				categories.add(c);
				if(!c.isIsleaf()) {
					this.getCategories(conn,categories,c.getId());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
		}
		return categories;
	}
	
	public List<Category> getCategoriesByGrade(List<Category> categories,int pid) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from category where pid = " + pid;
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			while(rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getInt("isleaf")==1? true : false);
				c.setGrade(rs.getInt("grade"));
				categories.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
		}
		return categories;
	}
	/**
	 * ͨ���ݹ�ɾ���������
	 * @param id �����ID
	 * @param conn Connection
	 */
	public static void deleteTree(int id,Connection conn) {
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from category where pid = " + id;
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			while(rs.next()) {
				id = rs.getInt("id");
				deleteTree(id,conn);
			}
			stmt.executeUpdate("delete from category where id = " + id);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
		}
	}
	
	/**
	 * ɾ��������������ı���һ����Ҷ�ӽڵ�
	 * @param id �����ID
	 * @param pid �����PID
	 */
	public static void delete(int id,int pid) {
		Connection conn = DB.getConnection();
		Statement stmt = null;
		String sql = "select count(*) from category where pid =" + pid;
		ResultSet rs = null;
		int count = 0;
		try {
			conn.setAutoCommit(false);
			deleteTree(id,conn);		
			stmt = DB.createStatement(conn);
			rs = DB.exceuteQurey(stmt, sql);
			while(rs.next()) {
				count = rs.getInt(1);
			}
			if(count <= 0) {
				stmt.executeUpdate("update category set isleaf = 1 where id =" + pid);
			}
			sql = "delete from product where category = " + id;
			DB.executeUpdate(conn, sql);
			conn.commit();
			conn.setAutoCommit(true);
		}catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
	}
	
	/**
	 * �����ݿ���ͨ��ID�õ������
	 * @param id �����ID
	 * @return �á����
	 */
	public static Category getCategoryById(int id) {
		Category c = new Category();
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from category where id = " + id;
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			while(rs.next()) {
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setPid(rs.getInt("pid"));
				c.setIsleaf(rs.getInt("isleaf")==1? true : false);
				c.setGrade(rs.getInt("grade"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return c;
	}
	
	/**
	 * ���¡����Name��Descr
	 * @param c �����
	 */
	public static void updateCategory(Category c) {
		Connection conn = DB.getConnection();
		String sql = "update category set name = ?,descr = ? where id = " + c.getId();
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			conn.setAutoCommit(false);
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getDescr());
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
}
