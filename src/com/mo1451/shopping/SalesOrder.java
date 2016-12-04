/**
 * 
 */
package com.mo1451.shopping;

import java.sql.Timestamp;

/**
 * @author Ĭ1451
 *
 */
public class SalesOrder {

	private int id;
	private int userid;
	private String username;
	private String addr;
	private Timestamp odate;
	private int status;
	private Cart cart;
	public int getId() {
		return id;
	}
	public int getUserid() {
		return userid;
	}
	public String getAddr() {
		return addr;
	}
	public Timestamp getOdate() {
		return odate;
	}
	public int getStatus() {
		return status;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public void setOdate(Timestamp odate) {
		this.odate = odate;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Cart getCart() {
		return cart;
	}
	public void setCart(Cart cart) {
		this.cart = cart;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	
}
