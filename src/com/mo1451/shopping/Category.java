package com.mo1451.shopping;
/**
 * 
 */

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mo1451.shopping.util.DB;

/**
 * @author 默1451
 *
 */
public class Category {

	private int id;
	private String name;
	private String descr;
	private int pid;
	private boolean isleaf;
	private int grade;
	public int getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getDescr() {
		return descr;
	}
	public int getPid() {
		return pid;
	}
	public int getGrade() {
		return grade;
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
	public void setPid(int pid) {
		this.pid = pid;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public boolean isIsleaf() {
		return isleaf;
	}
	public void setIsleaf(boolean isleaf) {
		this.isleaf = isleaf;
	}
	
	/**
	 * 检查类别是否已存在
	 * @param name 类别名
	 * @return true 已存在；false 未存在
	 */
	public boolean checkCategory(String name) {
		return new CategoryDAO().checkCategory(name);
	}
	
	/**
	 * 向数据库中添加类别
	 */
	public void addRootCategory() {
		this.setId(-1);
		this.setGrade(1);
		this.setIsleaf(true);
		new CategoryDAO().addToDatabase(this);
	}
	
	/**
	 * 更新“类别”名，描述
	 */
	public void updateCategory() {
		CategoryDAO.updateCategory(this);
	}
	
	/**
	 * 从数据库中得到类别
	 * @return List<类别>
	 */
	public List<Category> getCategories() {
		List<Category> categories = new ArrayList<Category>();
		new CategoryDAO().getCategories(categories,0);
		return categories;
	}
	
	public List<Category> getCategories(int pid) {
		List<Category> categories = new ArrayList<Category>();
		return new CategoryDAO().getCategoriesByGrade(categories,pid);
	}
	/**
	 * 根据树状结构显示treeview插件递归出HTML代码
	 * @param categories List<Category>
	 * @param pid 父ID
	 * @return HTML代码
	 */
	public static String getTree(List<Category> categories,int pid) {
		String str = "";
		int cId = 0;
		String cName ="";
		int cPid = 0;
		for(int i=0;i<categories.size();i++) {
			Category c = categories.get(i);
			if(c.getPid() == pid) {
				cId = c.getId();
				cName = c.getName();
				cPid = c.getPid();
				str += "<li><span class='folder'>" + cName + "<div class='button-group'>" + 
          		"--<a href='categoryadd.jsp?id=" + cId +"'><span class='icon-edit'></span> 修改类别</a>" +
          		"--<a href='categoryadd.jsp?pid=" + cPid + "'><span class='icon-edit'></span> 添加子类</a>" +
          		"</div>" 
          		+ "</span>\n";
				//System.out.println(pid);
				//System.out.println(c.getId());
				if(!c.isIsleaf()) {
					str += "<ul>\n";
				//	System.out.println(c.getId());
					str += getTree(categories, cId);
					str += "</ul>\n";
				} else {
					//return str;
				}
				str +="</li>\n";
			}	
		}
		return str;
	}
	
	/**
	 * 通过“类别”ID和PID删除“类别”树
	 * @param id “类别”ID
	 * @param pid “类别”PID
	 */
	public static void delete(int id,int pid) {
		CategoryDAO.delete(id,pid);
	}
	
	/**
	 * 通过“类别”ID删除“类别”树
	 * @param id “类别”ID
	 */
	public static void delete(int id) {
		Category c = CategoryDAO.getCategoryById(id);
		CategoryDAO.delete(c.getId(), c.getPid());
	}
}
