/**
 * 
 */
package com.mo1451.shopping;

import java.util.List;

import com.mo1451.shopping.DAO.OrderDAO;
import com.mo1451.shopping.DAO.OrderMySQLDAO;

/**
 * @author Ĭ1451
 *
 */
public class OrderMgr {

	private static OrderMgr om = null;
	static {
		if(om == null) {
			om = new OrderMgr();
			om.setOdao(new OrderMySQLDAO());
		}
	}
	
	private OrderMgr() {}
	
	OrderDAO odao = null;
	
	public static OrderMgr getInstance() {
		return om;
	}

	public OrderDAO getOdao() {
		return odao;
	}

	public void setOdao(OrderDAO odao) {
		this.odao = odao;
	}
	
	public boolean addToDatabase(SalesOrder so) {
		return odao.addToDatabse(so);
	}
	
	public int getOrders(List<SalesOrder> orders, int pageNo,int pageSize) {
		return odao.getOrders(orders, pageNo, pageSize);
	}
	
	public int getHistoryOrders(List<SalesOrder> orders,int userId, int pageNo,int pageSize) {
		return odao.getHistoryOrders(orders,userId, pageNo, pageSize);
	}
	
	public List<SalesItem> getItems(int orderId) {
		return odao.getItems(orderId);
	}
	
	public boolean updateStatus(SalesOrder so) {
		return odao.updateStatus(so);
	}
} 
