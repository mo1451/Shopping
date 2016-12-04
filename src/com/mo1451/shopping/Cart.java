/**
 * 
 */
package com.mo1451.shopping;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Ĭ1451
 *
 */
public class Cart {
	private List<CartItem> items = new ArrayList<CartItem>();
	private boolean login;

	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	} 
	
	public void add(CartItem item) {
		for(int i=0;i<items.size();i++) {
			if(items.get(i).getProductId() == item.getProductId()) {
				items.get(i).setProductNo(items.get(i).getProductNo() + 1);
				return;
			}
		}
		items.add(item);
	}
	
	public void delete(int productId) {
		for(int i=0;i<items.size();i++) {
			CartItem ci = items.get(i);
			if(ci.getProductId() == productId) {
				items.remove(i);
			}
		}
	}
	
	public double getTotalPrice(boolean login) {
		double totalPrice = 0.0;
			for(int i=0;i<items.size();i++) {
				totalPrice += items.get(i).getTotalPrice(login);
			}		
		return totalPrice;
	}

	public boolean isLogin() {
		return login;
	}

	public void setLogin(boolean login) {
		this.login = login;
	}
}
