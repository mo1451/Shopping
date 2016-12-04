/**
 * 
 */
package com.mo1451.shopping.DAO;

import java.util.List;

import com.mo1451.shopping.SalesItem;
import com.mo1451.shopping.SalesOrder;

/**
 * @author 默1451
 *
 */
public interface OrderDAO {
	public boolean addToDatabse(SalesOrder so);

	/**
	 * 获得某一页订单
	 * @param orders 所获订单
	 * @param pageNo 页数
	 * @param pageSize 每页显示多少个
	 * @return 一共多少页
	 */
	public int getOrders(List<SalesOrder> orders, int pageNo, int pageSize);

	/**
	 * 获得订单明细
	 * @param orderId 订单号
	 * @return 订单明细
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
