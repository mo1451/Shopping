/**
 * 
 */
package com.mo1451.shopping.DAO;

import java.util.Date;
import java.util.List;

import com.mo1451.shopping.Product;

/**
 * @author Ĭ1451
 *
 */
public interface ProductDAO {

	/**
	 * ��ȡ����Ʒ��
	 * @return ����Ʒ��
	 */
	public List<Product> getProducts();
	
	/**
	 * ��顰��Ʒ���Ƿ����
	 * @param p ����Ʒ��
	 * @return true������ false��������
	 */
	public boolean checkProudct(Product p);
	
	/**
	 * ��ȡĳһҳ����Ʒ��
	 * @param products "��Ʒ"List
	 * @param pageNo ҳ��
	 * @param pageSize ÿҳ����
	 * @return ������ҳ
	 */
	public int getProducts(List<Product> products, int pageNo,int pageSize,boolean lazy);
	
	/**
	 * ��Ӳ�Ʒ
	 * @param p ����Ʒ��
	 * @return true������ӣ�false��δ���
	 */
	public boolean add(Product p);
	
	/**
	 * ͨ��IDɾ������Ʒ��
	 * @param id ����Ʒ��ID
	 * @return true����ɾ����false��δɾ��
	 */
	public boolean deleteById(int id);
	
	/**
	 * ���¡���Ʒ��
	 * @param p ����Ʒ��
	 * @return true���Ѹ��£�false��δ����
	 */
	public boolean updateProduct(Product p);
	
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

	/**ͨ������Ʒ��ID��á���Ʒ��
	 * @param id ����Ʒ��ID
	 */
	public Product getProductById(int id);

	/**
	 * @param products
	 * @param count
	 * @return
	 */
	public boolean getLatestProducts(List<Product> products, int count);
}
