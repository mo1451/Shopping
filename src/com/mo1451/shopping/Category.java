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
 * @author Ĭ1451
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
	 * �������Ƿ��Ѵ���
	 * @param name �����
	 * @return true �Ѵ��ڣ�false δ����
	 */
	public boolean checkCategory(String name) {
		return new CategoryDAO().checkCategory(name);
	}
	
	/**
	 * �����ݿ���������
	 */
	public void addRootCategory() {
		this.setId(-1);
		this.setGrade(1);
		this.setIsleaf(true);
		new CategoryDAO().addToDatabase(this);
	}
	
	/**
	 * ���¡������������
	 */
	public void updateCategory() {
		CategoryDAO.updateCategory(this);
	}
	
	/**
	 * �����ݿ��еõ����
	 * @return List<���>
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
	 * ������״�ṹ��ʾtreeview����ݹ��HTML����
	 * @param categories List<Category>
	 * @param pid ��ID
	 * @return HTML����
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
          		"--<a href='categoryadd.jsp?id=" + cId +"'><span class='icon-edit'></span> �޸����</a>" +
          		"--<a href='categoryadd.jsp?pid=" + cPid + "'><span class='icon-edit'></span> �������</a>" +
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
	 * ͨ�������ID��PIDɾ���������
	 * @param id �����ID
	 * @param pid �����PID
	 */
	public static void delete(int id,int pid) {
		CategoryDAO.delete(id,pid);
	}
	
	/**
	 * ͨ�������IDɾ���������
	 * @param id �����ID
	 */
	public static void delete(int id) {
		Category c = CategoryDAO.getCategoryById(id);
		CategoryDAO.delete(c.getId(), c.getPid());
	}
}
