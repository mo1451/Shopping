/**
 * 
 */
package com.mo1451.shopping;

/**
 * @author Ĭ1451
 *
 */
public class CartItem {
	private int productId;
	private String productName;
	private double productNormalPrice;
	private double productMemberPrice;
	private int productNo;
	public int getProductId() {
		return productId;
	}
	public String getProductName() {
		return productName;
	}
	public double getProductNormalPrice() {
		return productNormalPrice;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public void setProductNormalPrice(double productNormalPrice) {
		this.productNormalPrice = productNormalPrice;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public double getTotalPrice(boolean login) {
		return (login ? this.productMemberPrice : this.productNormalPrice)*productNo;
	}
	public double getProductMemberPrice() {
		return productMemberPrice;
	}
	public void setProductMemberPrice(double productMemberPrice) {
		this.productMemberPrice = productMemberPrice;
	}
	public double getUnitPrice(boolean login) {
		return login?this.productMemberPrice:this.productNormalPrice;
	}
}
