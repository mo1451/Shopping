/**
 * 
 */
package com.mo1451.shopping;

/**
 * @author Ĭ1451
 *
 */
public class SalesItem {

	private int id;
	private int productId;
	private double unitPrice;
	private int pcount;
	private int orderId;
	private String productName;
	public int getId() {
		return id;
	}
	public int getProductId() {
		return productId;
	}
	public double getUnitPrice() {
		return unitPrice;
	}
	public int getPcount() {
		return pcount;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
}
