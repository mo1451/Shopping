/**
 * 
 */
package com.mo1451.shopping;

import java.sql.Timestamp;

/**
 * @author Ĭ1451
 *
 */
public class Product {

	private int id;
	private String name;
	private String descr;
	private double normalPrice;
	private double memberPrice;
	private Timestamp pdate;
	private int categoryId;
	
	private Category category;
	public int getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getDescr() {
		return descr;
	}
	public double getNormalPrice() {
		return normalPrice;
	}
	public double getMemberPrice() {
		return memberPrice;
	}
	public Timestamp getPdate() {
		return pdate;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public void setNormalPrice(double normalPrice) {
		this.normalPrice = normalPrice;
	}
	public void setMemberPrice(double memberPrice) {
		this.memberPrice = memberPrice;
	}
	public void setPdate(Timestamp pdate) {
		this.pdate = pdate;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	
}
