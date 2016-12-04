/**
 * 
 */
package com.mo1451.shopping.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.mo1451.shopping.Category;
import com.mo1451.shopping.Product;
import com.mo1451.shopping.util.DB;

/**
 * @author Ĭ1451
 *
 */
public class ProductMySQLDAO implements ProductDAO{

	/**
	 * ��ȡ����Ʒ��
	 * @return ����Ʒ��
	 */
	public List<Product> getProducts() {
		List<Product> products = new ArrayList<Product>();
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "Select * from product";
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("category"));
				products.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return products;
	}
	
	/**
	 * ��ȡĳһҳ����Ʒ��
	 * @param products "��Ʒ"List
	 * @param pageNo ҳ��
	 * @param pageSize ÿҳ����
	 * @return ������ҳ
	 */
	public int getProducts(List<Product> products, int pageNo,int pageSize, boolean lazy) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "";
		if(lazy) {
			sql = "select * from product limit " + (pageNo-1)*pageSize + "," + pageSize;
		} else {
			sql = "select product.id,product.name,product.descr,product.normalprice,product.memberprice,product.pdate,product.category,"
					+ "category.id cid,category.name cname,category.descr cdescr,category.pid cpid,category.isleaf cisleaf,category.grade cgrade"
					+ " from product join category on (category.id = product.category) limit " + (pageNo-1)*pageSize + "," + pageSize;
		}
//System.out.println(sql);
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		int pageCount = 0;
		Statement stmtCount = DB.createStatement(conn);
		ResultSet rsCount = DB.exceuteQurey(stmtCount, "select count(*) from product");
		try {
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize -1) / pageSize;
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("category"));
				if(!lazy) {
					Category c = new Category();
					c.setId(rs.getInt("cid"));
					c.setName(rs.getString("cname"));
					c.setDescr(rs.getString("cdescr"));
					c.setPid(rs.getInt("cpid"));
					c.setIsleaf(rs.getInt("cisleaf")==1? true : false);
					c.setGrade(rs.getInt("cgrade"));
					p.setCategory(c);
				}
				products.add(p);
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
	 * ��Ӳ�Ʒ
	 * @param p ����Ʒ��
	 * @return true������ӣ�false��δ���
	 */
	public boolean add(Product p) {
		if(this.checkProudct(p)) {
			return false;
		}
		boolean flag = false;
		Connection conn = DB.getConnection();
		String sql = "";
		if(p.getId() == -1) {
			sql = "insert into product values (null,?,?,?,?,?,?)";
		} else {
			sql = "insert into product values (" + p.getId() + ",?,?,?,?,?,?)";
		}
		
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			conn.setAutoCommit(false);
			
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setTimestamp(5, p.getPdate());
			pstmt.setInt(6, p.getCategoryId());
			pstmt.execute();
			conn.commit();
			conn.setAutoCommit(true);
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
		return flag;
	}
	
	/**
	 * ��顰��Ʒ���Ƿ����
	 * @param p ����Ʒ��
	 * @return true������ false��������
	 */
	public boolean checkProudct(Product p) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from product where name = '" + p.getName() + "'";
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
	 * ͨ��IDɾ������Ʒ��
	 * @param id ����Ʒ��ID
	 * @return true����ɾ����false��δɾ��
	 */
	public boolean deleteById(int id) {
		Connection conn = DB.getConnection();
		String sql = "delete from product where id = " + id;
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
		return true;
	}
	
	/**
	 * ���¡���Ʒ��
	 * @param p ����Ʒ��
	 * @return true���Ѹ��£�false��δ����
	 */
	public boolean updateProduct(Product p) {
		Connection conn = DB.getConnection();
		String sql = "update product set name = ?,descr = ?,normalprice=?,memberprice=?,category=? where id = " + p.getId();
		PreparedStatement pstmt = DB.preparedStatement(conn, sql);
		try {
			conn.setAutoCommit(false);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setInt(5, p.getCategoryId());
			pstmt.execute();
			conn.commit();
			conn.setAutoCommit(true);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
		return false;
	}
	
	/**
	 * ͨ������������ѯ����Ʒ��
	 * @param products ����Ʒ���б�
	 * @param ids ����Ʒ��ID
	 * @param keyword �ؼ���
	 * @param lowNormalPrice �г��۵ͼ�
	 * @param highNormalPrice �г��۸߼�
	 * @param lowMemberPrice ��Ա�۵ͼ�
	 * @param highMemberPrice ��Ա�۸߼�
	 * @param startDate ��ʼ����
	 * @param endDate ��������
	 * @param pageNo ����Ʒ��ҳ��
	 * @param pageSize ����Ʒ��ÿҳ����
	 * @return ������ҳ
	 */
	public int searchProductBy(List<Product> products,int[] ids,
								  String keyword,
								  double lowNormalPrice,
								  double highNormalPrice,
								  double lowMemberPrice,
								  double highMemberPrice,
								  Date startDate,
								  Date endDate,
								  int pageNo,
								  int pageSize,
								  boolean lazy) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		
		String sql = "select product.id,product.name,product.descr,product.normalprice,product.memberprice,product.pdate,product.category,"
					+ "category.id cid,category.name cname,category.descr cdescr,category.pid cpid,category.isleaf cisleaf,category.grade cgrade"
					+ " from product join category on (category.id = product.category) where 1=1";
		if(lazy) {
			sql = "select * from product where 1=1";
		} else {
			sql = "select product.id,product.name,product.descr,product.normalprice,product.memberprice,product.pdate,product.category,"
					+ "category.id cid,category.name cname,category.descr cdescr,category.pid cpid,category.isleaf cisleaf,category.grade cgrade"
					+ " from product join category on (category.id = product.category) where 1=1";
		}
		String str = "";
		if(ids != null) {
			if(ids.length>0) {
				str += " and product.category in (";
				for(int i=0;i<ids.length;i++) {
					if(i<ids.length-1) {
						str += ids[i] + ",";
					} else {
						str += ids[i];
					}
				}
				str += ")";
			}
		}
		if(keyword != null && !keyword.trim().equals("")) {
			str += " and product.name like '%" + keyword + "%' or product.descr like '%" + keyword + "%'";
		}
		if(lowNormalPrice != -100) {
			str += " and product.normalprice >= " + lowNormalPrice;
		}
		if(highNormalPrice != -100) {
			str += " and product.normalprice <= " + highNormalPrice;
		}
		if(lowMemberPrice != -100) {
			str += " and product.memberprice >= " + lowMemberPrice;
		}
		if(highMemberPrice != -100) {
			str += " and product.memberprice <= " + highMemberPrice;
		}
		if(startDate != null) {
			str += " and product.pdate <= '" + new SimpleDateFormat("yyyy-MM-dd").format(startDate) + "'";
		}
		if(endDate != null) {
			str += " and product.pdate <= '" + new SimpleDateFormat("yyyy-MM-dd").format(endDate) + "'";
		}
		sql += str + " limit " + (pageNo-1)*pageSize + "," + pageSize;
//System.out.println(sql);
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		int pageCount = 0;
		Statement stmtCount = DB.createStatement(conn);
		ResultSet rsCount = DB.exceuteQurey(stmtCount, "select count(*) from product where 1=1" + str);
		try {
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize -1) / pageSize;
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("category"));
				if(!lazy) {
					Category c = new Category();
					c.setId(rs.getInt("cid"));
					c.setName(rs.getString("cname"));
					c.setDescr(rs.getString("cdescr"));
					c.setPid(rs.getInt("cpid"));
					c.setIsleaf(rs.getInt("cisleaf")==1? true : false);
					c.setGrade(rs.getInt("cgrade"));
					p.setCategory(c);
				}
				products.add(p);
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

	public Product getProductById(int id) {
		Product p = new Product();
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "select * from product where id = " + id;
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		try {
			while(rs.next()) {
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("category"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return p;
	}

	
	public boolean getLatestProducts(List<Product> products, int count) {
		Connection conn = DB.getConnection();
		Statement stmt = DB.createStatement(conn);
		String sql = "Select * from product order by pdate desc limit 0," + count;
		ResultSet rs = DB.exceuteQurey(stmt, sql);
		boolean flag = false;
		try {
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("category"));
				products.add(p);
			}
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
			DB.close(conn);
		}
		return flag;
	}
}
