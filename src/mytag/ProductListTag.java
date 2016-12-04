/**
 * 
 */
package mytag;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.mo1451.shopping.Product;
import com.mo1451.shopping.ProductMgr;
import com.mo1451.shopping.util.DB;

/**
 * @author Ĭ1451
 *
 */
public class ProductListTag extends SimpleTagSupport {

	public void doTag() throws JspException, IOException {
		this.getJspContext().getOut().write("helloworld");
		JspWriter out = this.getJspContext().getOut();
		List<Product> products = ProductMgr.getInstance().getProducts();
		for(int i=0;i<products.size();i++) {
			out.print(products.get(i).getName() + "<br>");
		}
		
	}

}
