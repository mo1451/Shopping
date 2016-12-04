/**
 * 
 */
package com.mo1451.shopping;
import java.awt.Font;
import java.io.FileOutputStream;
import java.io.IOException;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
/**
 * @author Ĭ1451
 *
 */
public class TestJFreeChart {
	public static void main(String[] args) throws IOException{ 
        CategoryDataset dataset = getDataSet2(); 
      //����������ʽ  
        StandardChartTheme standardChartTheme=new StandardChartTheme("CN");  
        //���ñ�������  
       
        standardChartTheme.setExtraLargeFont(new Font("����",Font.BOLD,20));  
        //����ͼ��������  
        standardChartTheme.setRegularFont(new Font("����",Font.PLAIN,15));  
        //�������������  
        standardChartTheme.setLargeFont(new Font("����",Font.PLAIN,15));  
        //Ӧ��������ʽ  
        ChartFactory.setChartTheme(standardChartTheme);  
        JFreeChart chart = ChartFactory.createBarChart3D( 
                           "ˮ������ͼ", // ͼ�����
                           "ˮ��", // Ŀ¼�����ʾ��ǩ
                           "����", // ��ֵ�����ʾ��ǩ
                            dataset, // ���ݼ�
                            PlotOrientation.VERTICAL, // ͼ����ˮƽ����ֱ
                            true,  // �Ƿ���ʾͼ��(���ڼ򵥵���״ͼ������ false)
                            false, // �Ƿ����ɹ���
                            false  // �Ƿ����� URL ����
                            ); 
                           
        FileOutputStream fos_jpg = null; 
        try { 
            fos_jpg = new FileOutputStream("D:\\fruit.jpg"); 
           // ChartUtilities.writeChartAsJPEG(fos_jpg,100,chart,400,300); 
            ChartUtilities.writeChartAsJPEG(fos_jpg,1,chart,400,300,null); 
           // ChartUtilities.writeChartAsJPEG(fos_jpg, chart, 400, 300);
            //ChartUtilities.writeChartAsPNG(fos,chart,400,300); 
        } finally { 
            try { 
                fos_jpg.close(); 
            } catch (Exception e) {} 
        } 
    } 
    /** 
    * ��ȡһ����ʾ�õļ����ݼ�����
    * @return 
    */ 
    private static CategoryDataset getDataSet() { 
        DefaultCategoryDataset dataset = new DefaultCategoryDataset(); 
        dataset.addValue(100, null, "ƻ��"); 
        dataset.addValue(200, null, "����"); 
        dataset.addValue(300, null, "����"); 
        dataset.addValue(400, null, "�㽶"); 
        dataset.addValue(500, null, "��֦"); 
        return dataset; 
    } 
    /** 
    * ��ȡһ����ʾ�õ�������ݼ�����
    * @return 
    */ 
    private static CategoryDataset getDataSet2() { 
        DefaultCategoryDataset dataset = new DefaultCategoryDataset(); 
        dataset.addValue(100, "����", "ƻ��"); 
        dataset.addValue(100, "�Ϻ�", "ƻ��"); 
        dataset.addValue(100, "����", "ƻ��"); 
        dataset.addValue(200, "����", "����"); 
        dataset.addValue(200, "�Ϻ�", "����"); 
        dataset.addValue(200, "����", "����"); 
        dataset.addValue(300, "����", "����"); 
        dataset.addValue(300, "�Ϻ�", "����"); 
        dataset.addValue(300, "����", "����"); 
        dataset.addValue(400, "����", "�㽶"); 
        dataset.addValue(400, "�Ϻ�", "�㽶"); 
        dataset.addValue(400, "����", "�㽶"); 
        dataset.addValue(500, "����", "��֦"); 
        dataset.addValue(500, "�Ϻ�", "��֦"); 
        dataset.addValue(500, "����", "��֦"); 
        return dataset; 
    } 
}