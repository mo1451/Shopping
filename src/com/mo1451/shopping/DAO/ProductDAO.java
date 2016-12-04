/**
 * 
 */
package com.mo1451.shopping.DAO;

import java.util.Date;
import java.util.List;

import com.mo1451.shopping.Product;

/**
 * @author 默1451
 *
 */
public interface ProductDAO {

	/**
	 * 获取“产品”
	 * @return “产品”
	 */
	public List<Product> getProducts();
	
	/**
	 * 检查“产品”是否存在
	 * @param p “产品”
	 * @return true：存在 false：不存在
	 */
	public boolean checkProudct(Product p);
	
	/**
	 * 获取某一页“产品”
	 * @param products "产品"List
	 * @param pageNo 页数
	 * @param pageSize 每页多少
	 * @return 共多少页
	 */
	public int getProducts(List<Product> products, int pageNo,int pageSize,boolean lazy);
	
	/**
	 * 添加产品
	 * @param p “产品”
	 * @return true：已添加，false：未添加
	 */
	public boolean add(Product p);
	
	/**
	 * 通过ID删除“产品”
	 * @param id “产品”ID
	 * @return true：已删除，false：未删除
	 */
	public boolean deleteById(int id);
	
	/**
	 * 更新“产品”
	 * @param p “产品”
	 * @return true：已更新，false：未更新
	 */
	public boolean updateProduct(Product p);
	
	/**
	 * 通过所传参数查询“产品”
	 * @param products “产品”列表
	 * @param ids “产品”ID
	 * @param keyword 关键词
	 * @param lowNormalPrice 市场价低价
	 * @param highNormalPrice 市场价高价
	 * @param lowMemberPrice 会员价低价
	 * @param highMemberPrice 会员价高价
	 * @param startDate 开始日期
	 * @param endDate 结束日期
	 * @param pageNo “产品”页数
	 * @param pageSize “产品”每页多少
	 * @return 共多少页
	 */
	public int  searchProductBy(List<Product> products,
								 int[] ids,
								  String keyword,
								  double lowNormalPrice,
								  double highNormalPrice,
								  double lowMemberPrice,
								  double highMemberPrice,
								  Date startDate,
								  Date endDate,
								  int pageNo,
								  int pageSize,
								  boolean lazy);

	/**通过“产品”ID获得“产品”
	 * @param id “产品”ID
	 */
	public Product getProductById(int id);

	/**
	 * @param products
	 * @param count
	 * @return
	 */
	public boolean getLatestProducts(List<Product> products, int count);
}
