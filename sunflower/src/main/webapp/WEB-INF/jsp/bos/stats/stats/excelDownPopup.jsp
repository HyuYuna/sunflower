<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<script src="/static/bos/js/common.js"></script>

<script language="javascript">
    function fn_submit() {
        if($("#downloadMemo").val() == ""){
            alert("다운로드 사유를 입력하세요.");
            return;
        }
        $.ajax({
            type:"post",
            url:"/bos/stats/stats/insertDownloadHistory.json",
            data: {
            	downloadMemo :$("#downloadMemo").val(),
                shDataNm : "${param.shDataNm}"
            },
            dataType: "json",
        });
        window.open('','_self').close(); 
        window.opener.fn_export();
    }
</script>
<form id="frm" name="frm" method="post">
    <h1>다운로드 사유</h1>
    <div class="bdView" style="width: 450px; margin: 10px 0px;">

        <table class="table03">
            <caption>다운로드 사유</caption>
            <colgroup>
                <col width="30%" />
                <col width="" />
            </colgroup>
            <tbody>
            <!-- 
                <tr>
                    <td>다운로드 자료명 : </td>
                </tr>
                <tr>
                    <td>다운로드 실행자 : </td>
                </tr>
                <tr>
                    <td>다운로드 사유</td>
                </tr>
                 -->
                <tr>
                    <td>
                        <span>개인정보의 안정성 확보조치 기준에 따라 사유기입 필수</span>
                        <textarea name="downloadMemo" id="downloadMemo" style="height:80px; width:100%;">업무상 필요로 다운로드(기본값)</textarea>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

</form>

<div class="btnSet">
    <a class="btn btn-primary" href="javascript:fn_submit()">다운로드</a> 
    <a class="btn btn-primary" href="javascript:close();" style="background-color: #8C8C8C; border-color: #8C8C8C;" id="closeBtn"><span>닫기</span> </a>
</div>

<script>

$("#closeBtn").click(function() {
    self.close();
});


</script>