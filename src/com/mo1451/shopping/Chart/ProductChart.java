package com.mo1451.shopping.Chart;

import java.awt.Font;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.general.PieDataset;

import com.mo1451.shopping.util.DB;

/**
 * Servlet implementation class ProductChart
 */
@WebServlet("/ProductChart")
public class ProductChart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductChart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	private CategoryDataset getDataSet() { 
        DefaultCategoryDataset dataset = new DefaultCategoryDataset(); 
        Connection conn = DB.getConnection();
        Statement stmt = DB.createStatement(conn);
        String sql = "select p.name,sum(pcount) from product p join salesitem si on (si.productid = p.id) group by p.id";
        ResultSet rs = DB.exceuteQurey(stmt, sql);
        try {
        	while(rs.next()) {
        		dataset.addValue(rs.getInt(2), "", rs.getString(1));
        	} 
        }catch (SQLException e) {
    		e.printStackTrace();
    	} finally {
    		DB.close(rs);
    		DB.close(stmt);
    		DB.close(conn);
    	}
        
        return dataset; 
    } 
	
	public void createProductCategoryChart(HttpServletRequest request) {
		CategoryDataset dataset = getDataSet(); 
	      //创建主题样式  
      StandardChartTheme standardChartTheme=new StandardChartTheme("CN");  
      //设置标题字体  
     
      standardChartTheme.setExtraLargeFont(new Font("隶书",Font.BOLD,20));  
      //设置图例的字体  
      standardChartTheme.setRegularFont(new Font("宋书",Font.PLAIN,15));  
      //设置轴向的字体  
      standardChartTheme.setLargeFont(new Font("宋书",Font.BOLD,15));  
      //应用主题样式  
      ChartFactory.setChartTheme(standardChartTheme);  
      JFreeChart chart = ChartFactory.createBarChart3D( 
                         "产品销量柱状图", // 图表标题
                         "产品", // 目录轴的显示标签
                         "销量", // 数值轴的显示标签
                          dataset, // 数据集
                          PlotOrientation.VERTICAL, // 图表方向：水平、垂直
                          true,  // 是否显示图例(对于简单的柱状图必须是 false)
                          false, // 是否生成工具
                          false  // 是否生成 URL 链接
                          ); 
	                           
      FileOutputStream fos_jpg = null; 
      try { 
          fos_jpg = new FileOutputStream(request.getServletContext().getRealPath("/") + 
					"images/chart/"  + "productsales_category.jpg"); 
          ChartUtilities.writeChartAsJPEG(fos_jpg,1,chart,400,300,null); 
      } catch(IOException e1) {
    	   e1.printStackTrace();
      } finally {
          try { 
              fos_jpg.close(); 
          } catch (Exception e) {} 
      } 
	}
	
	private DefaultPieDataset getPieDataSet() { 
        DefaultPieDataset dataset = new DefaultPieDataset(); 
        Connection conn = DB.getConnection();
        Statement stmt = DB.createStatement(conn);
        String sql = "select p.name,sum(pcount) from product p join salesitem si on (si.productid = p.id) group by p.id";
        ResultSet rs = DB.exceuteQurey(stmt, sql);
        try {
        	while(rs.next()) {
        		dataset.setValue(rs.getString(1), rs.getInt(2));
        	} 
        }catch (SQLException e) {
    		e.printStackTrace();
    	} finally {
    		DB.close(rs);
    		DB.close(stmt);
    		DB.close(conn);
    	}
        
        return dataset; 
    } 
	
	public void createProductPieChart(HttpServletRequest request) {
		PieDataset dataset = getPieDataSet(); 
	      //创建主题样式  
      StandardChartTheme standardChartTheme=new StandardChartTheme("CN");  
      //设置标题字体  
     
      standardChartTheme.setExtraLargeFont(new Font("隶书",Font.BOLD,20));  
      //设置图例的字体  
      standardChartTheme.setRegularFont(new Font("宋书",Font.PLAIN,15));  
      //设置轴向的字体  
      standardChartTheme.setLargeFont(new Font("宋书",Font.BOLD,15));  
      //应用主题样式  
      ChartFactory.setChartTheme(standardChartTheme);  
      JFreeChart chart = ChartFactory.createPieChart3D("产品销量饼图", dataset, true, false, false);
	                           
      FileOutputStream fos_jpg = null; 
      try { 
          fos_jpg = new FileOutputStream(request.getServletContext().getRealPath("/") + 
					"images/chart/"  + "productsales_pie.jpg"); 
          ChartUtilities.writeChartAsJPEG(fos_jpg,1,chart,400,300,null); 
      } catch(IOException e1) {
    	   e1.printStackTrace();
      } finally {
          try { 
              fos_jpg.close(); 
          } catch (Exception e) {} 
      } 
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
