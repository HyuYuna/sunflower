<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>
<%@ page import="site.unp.cms.service.siteManage.impl.SiteInfoServiceImpl" %>

<%
org.springframework.context.ApplicationContext context =
org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());

SiteInfoService siteMngService = context.getBean("siteInfoService", SiteInfoService.class);
ZValue site = siteMngService.getSiteBySiteName(SiteInfoService.BOS_SITE_ID);
pageContext.setAttribute("siteVO", site);
%>

<link rel="stylesheet" href="/static/jslibrary/jstree/themes/default/style.css" />
<script src="/static/jslibrary/jstree/jstree.min.js"></script>

<script>
var	_selectedNodeId = "0"; // 기본은 최상위
// 서비스로 도움맟 찾기
<c:if test="${not empty param.pSrvcId}">
	_selectedNodeId = '${empty result.hpcmNo ? "1" : result.hpcmNo}';
</c:if>
//도움말번호로 찾기
<c:if test="${not empty param.pHpcmNo}">
_selectedNodeId = '${param.pHpcmNo}';
</c:if>

function fnSiteHpcmDetail(id) {

	var tempId = _selectedNodeId;
	if (_selectedNodeId!=""){	//관리자 특정 메뉴에서 도움말 클릭으로 해당 도움말을 보여줌..
		//$('#tree').deselect_all(true);
		$('#tree').jstree("deselect_node","#"+id);
		id=_selectedNodeId;
		_selectedNodeId="";
		$('#tree').jstree("select_node","#"+tempId);
		return;
	}

	$.ajax({ url : "/bos/siteManage/siteHpcm/listJson.json?useAt=Y&cHpcmNo="+id, dataType : "json", async: false }).done(function (resdata) {
		// h2:도움말 내용
		var strHtml = "";
		var hpcmCn = "";
		if (resdata.hpcmCn!=undefined){
			hpcmCn = resdata.hpcmCn.replace('<p>&nbsp;</p>null','');
			hpcmCn = resdata.hpcmCn.replace('<p>&nbsp;</p>','');
		}
		//alert(hpcmCn)
		//alert(hpcmCn.replace(" ","").length)
		if (resdata.hpcmCn!="" && resdata.hpcmCn!=undefined){
			//alert(resdata.hpcmCn)
			strHtml += "<h2>" + resdata.hpcmNm + "</h2>"+resdata.hpcmCn.replace('<p>&nbsp;</p>null','');
			$('#divSiteHpcmDetail').html(strHtml);
		} else {
			$('#divSiteHpcmDetail').html("");
		}

		//h2:세부 도움말 목록
		var subHtml ="";
		if (resdata.subList.length>0){
			for(var i=0;i<resdata.subList.length;i++){
				subHtml += "<li><a href='/bos/siteManage/siteHpcm/view.do?pHpcmNo=" + resdata.subList[i].hpcmNo + "&viewType=BODY'>" + resdata.subList[i].hpcmNm + "</a></li>"
			}
			if (resdata.hpcmNo==undefined){
				$('#divSiteHpcmCntnt').html("<h3 class='bu3'>도움말 목록</h3><ul class='list'>" + subHtml + "</ul>");
			} else {
				$('#divSiteHpcmCntnt').html("<h3 class='bu3'>세부 도움말 목록</h3><ul class='list'>" + subHtml + "</ul>");
			}
		} else {
			$('#divSiteHpcmCntnt').html("");
		}
	});

}


$(function() {
	$('#tree').jstree({
		'core' : {
			'data' : function (node, cb) {
				var t_url = node.id != "#" ? "/bos/siteManage/siteHpcm/listJson.json?useAt=Y&upperHpcmNo="+node.id : "/bos/siteManage/siteHpcm/listJson.json?useAt=Y";
				$.ajax({ url: t_url, dataType: "json"}).done(function (data) {
					var rootList = [];
					var jsonList = [];
					var root = {'id' : '0', 'text' : "도움말",'icon' : "jstree-folder",'children':true, 'state' : { 'opened' : true, 'selected' : true },'data' : {'useAt' : "Y"}};
					$.each(data,function(key, value) {
						var children = true;
						if (value.icon == "jstree-file") children = false;

						var item = {'id' : value.hpcmNo, 'text' : value.hpcmNm, 'children' : children, 'icon' : value.icon};
						var addData = value;
						item.data = addData;
						jsonList.push(item);
					});
					root.children = jsonList;
	            	rootList.push(root);
	            	if (node.id == "#") cb(rootList);
	            	else cb(jsonList);

				});
			},
			'check_callback' : function(o, n, p, i, m) {
				/*
				if (m && m.dnd && m.pos !== 'i') { return false; }
				if (o === "move_node" || o === "copy_node") {
					if (this.get_node(n).parent === this.get_node(p).id) { return false; }
				}
				*/
				return true;
			},
			'themes' : {
				'responsive' : false,
				'variant' : 'small'
				//,'stripes' : true
			}
		},
		'sort' : function(a, b) {
			return this.get_type(a) === this.get_type(b) ? (this.get_text(a) > this.get_text(b) ? 1 : -1) : (this.get_type(a) >= this.get_type(b) ? 1 : -1);
		},
		'types' : {
			'default' : { 'icon' : 'folder' },
			'file' : { 'valid_children' : [], 'icon' : 'file' }
		},
		'unique' : {
			'duplicate' : function (name, counter) {
				return name + ' ' + counter;
			}
		},
		/* "cookies" : {
			"save_selected" : false
		}, */
		'plugins' : ['state','types','unique','contextmenu',"search"]
		,"contextmenu" : {
			"items" : {
			"ccp" : null
			}
		}

	})
	.on('loaded.jstree', function(e, data) {
		//console.log(data)
		fnResetAnchor();
		$("#tree").jstree('open_all');
	})
	.on('ready.jstree', function(event) {
		/* Act on the event */
		$('#tree').jstree("select_node","#"+_selectedNodeId);
		// console.log('reday')
	})
	.on('select_node.jstree', function (e, data) {
		var node = data.node;
		//if (node.id == "0") return;
		//if (typeof node.id != "undefined")
		fnSiteHpcmDetail(node.id);
	})
	.on('open_node.jstree', function (e, data) {
		fnResetAnchor();
    })
    .on('changed.jstree', function (e, data) {
    	if (typeof data.node != "undefined") fnResetAnchor();
    	//$('#tree').jstree(true).get_node(data.id).data = {'useAt' : data..useAt}
    });
	var to = false;
	$('#demo_q').on('keyup',function () {
		if(to) { clearTimeout(to); }
		to = setTimeout(function () {
			var v = $('#demo_q').val();
			$('#tree').jstree(true).search(v);
		}, 250);
	});

	$('.pop-close').on('click',function () {
		self.close();
	});

});

function fnResetAnchor() {
	$(".jstree-anchor").each(function(n) {
		var node = $("#tree").jstree(true).get_node($(this));
		if (typeof node.data != "undefined" && node.data!=null && node.data.useAt != "undefined" && node.data.useAt == "N") {
			$(this).addClass("jstree-delete");
		}
	})
}



</script>

	<h1>${siteVO.siteNm} 도움말</h1>
	<div class="row">
		<div class="col-sm-4">
			<div class="sh mb0">
				<label>색인검색 <input type="text" id="demo_q"></label>
			</div>
			<div class="beforeDiv">
				<div id="tree">
				</div>
			</div>
		</div>
		<div class="col-sm-8">
			<div class="beforeDiv">
				<div class="ovy"  style="height:640px">
					<div id="divSiteHpcmDetail">
				 	</div>
				 	<div id="divSiteHpcmCntnt">
				 	</div>
				</div>
			</div>
		</div>
	</div>
</div>
<button type="button" class="pop-close" >닫기</button>
