<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ip = request.getRemoteAddr();
	request.setAttribute("myIp", ip);
%>
<c:if test="${'127.0.0.1' eq myIp or '192.168.0.152' eq myIp or '0:0:0:0:0:0:0:1' eq myIp or '192.168.0.1' eq myIp}">
<script src="/static/jslibrary/clipboard.min.js"></script>
<div class="posr" style="position: relative;">
<%-- 	<button class="btn soucecopy" aria-label="copyed!" data-clipboard-text="*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}">
		*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}
	</button>
	<button class="btn soucecopy" aria-label="copyed!" data-clipboard-text="WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}">
		WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}
	</button> --%>
	<script>
		$('.soucecopy').on('focusout mouseleave',  function(event) {
			$(this).removeClass('tooltipped tooltipped-n')
		});
		var clipboard = new Clipboard('.soucecopy');
		clipboard.on('success', function(e) {
			$(e.trigger).addClass('tooltipped tooltipped-n')
			e.clearSelection();
		});
		clipboard.on('error', function(e) {
			$(e.trigger).attr('aria-label','복사실패');
			$(e.trigger).addClass('tooltipped tooltipped-n')
		});
	</script>
</div>
</c:if>