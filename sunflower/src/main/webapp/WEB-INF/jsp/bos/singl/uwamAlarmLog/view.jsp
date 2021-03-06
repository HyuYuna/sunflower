<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<div class="view">
	<dl>
		<dt>제목</dt>
		<dd>${result.alarmSj}</dd>
	</dl>
	<dl>
		<dt>경보 링크주소</dt>
		<dd>${result.alarmUrlad}</dd>
	</dl>
	<dl>
		<dt>HTTP응답코드</dt>
		<dd>${result.httpRspnsCd}</dd>
	</dl>
	<dl>
		<dt>응답성공여부</dt>
		<dd>${result.rspnsSuccesAt}</dd>
	</dl>
	<dl>
		<dt>경보내용</dt>
		<dd>${result.rspnsErrorMssage}</dd>
	</dl>
	<dl>
		<dt>사용자명</dt>
		<dd>${result.userNm}</dd>
	</dl>
	<dl>
		<dt>등록일시</dt>
		<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm" /></dd>
	</dl>
</div>

<div class="btnSet fr">
	<a class="b-list" href="/bos/singl/uwamAlarmLog/list.do?menuNo=${param.menuNo }"><span>목록</span></a>
</div>
