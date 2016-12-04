/**
 * 
 */
package com.mo1451.shopping;

import java.util.Date;
import java.util.List;

import com.mo1451.shopping.DAO.ProductDAO;
import com.mo1451.shopping.DAO.ProductMySQLDAO;
/**
 * @author Ĭ1451
 *
 */
public class ProductMgr {

	private static ProductMgr pm = null;
	static {
		if(pm == null) {
			pm = new ProductMgr();
			pm.setPdao(new ProductMySQLDAO());
		}
	}
	
	private ProductMgr() {}
	
	ProductDAO pdao = null;
	
	public static ProductMgr getInstance() {
		return pm;
	}
	
	public List<Product> getProducts() {
		return pdao.getProducts();
	}
	
	public int getProducts(List<Product> products, int pageNo,int pageSize,boolean lazy) {
		return pdao.getProducts(products, pageNo, pageSize,lazy);
	}
	
	public boolean add(Product p) {
		if(pdao.add(p)) {
			return true;
		}
		return false;
	}
	
	public boolean deleteById(int id) {
		return false;
	}
	
	public boolean updateProduct(Product p) {
		return pdao.updateProduct(p);
	}
	
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
		return pdao.searchProductBy(products, ids, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, startDate, endDate, pageNo, pageSize,lazy);
	}

	public ProductDAO getPdao() {
		return pdao;
	}

	public void setPdao(ProductDAO pdao) {
		this.pdao = pdao;
	}
	
	public Product getProductById(int id) {
		return pdao.getProductById(id);
	}
	
	public boolean getLatestProducts(List<Product> products,int count) {
		return pdao.getLatestProducts(products,count);
	}
}
