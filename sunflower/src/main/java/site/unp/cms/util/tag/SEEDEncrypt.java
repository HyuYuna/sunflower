package site.unp.cms.util.tag;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.StringUtils;

import site.unp.cms.util.Seed256Util;

@SuppressWarnings("serial")
public class SEEDEncrypt extends TagSupport {

	protected static final Log log = LogFactory.getLog(SEEDEncrypt.class);

	private String str;

	public String getStr() {
		return str;
	}

	public void setStr(String str) {
		this.str = str;
	}

	public int doStartTag() {
	    return SKIP_BODY;
	}

	public int doEndTag() throws JspTagException
    {
		try {

			String tempStr = str;
			if (StringUtils.hasText(str)) {
				tempStr = Seed256Util.Encrypt(str);
			}
			pageContext.getOut().write(tempStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return EVAL_PAGE;
    }
}
