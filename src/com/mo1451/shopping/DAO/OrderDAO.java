/**
 * 
 */
package com.mo1451.shopping.DAO;

import java.util.List;

import com.mo1451.shopping.SalesItem;
import com.mo1451.shopping.SalesOrder;

/**
 * @author Ĭ1451
 *
 */
public interface OrderDAO {
	public boolean addToDatabse(SalesOrder so);

	/**
	 * ���ĳһҳ����
	 * @param orders ���񶩵�
	 * @param pageNo ҳ��
	 * @param pageSize ÿҳ��ʾ���ٸ�
	 * @return һ������ҳ
	 */
	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize);

	/**
	 * ��ö�����ϸ
	 * @param orderId ������
	 * @return ������ϸ
	 */
	public List<SalesItem> getItems(int orderId);

	/**
	 * @param so
	 * @return
	 */
	public boolean updateStatus(SalesOrder so);

	/**
	 * @param orders
	 * @param userId
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public int getHistoryOrders(List<SalesOrder> orders, int userId, int pageNo, int pageSize);
}
