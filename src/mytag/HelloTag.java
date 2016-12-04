/**
 * 
 */
package mytag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * @author Ĭ1451
 *
 */
public class HelloTag extends SimpleTagSupport {

	public void doTag() throws JspException, IOException {
		this.getJspContext().getOut().write("helloworld");
	}

}
