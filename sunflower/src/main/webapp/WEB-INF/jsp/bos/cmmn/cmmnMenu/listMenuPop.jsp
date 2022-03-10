<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>


<link rel="stylesheet" href="/static/jslibrary/jstree/themes/default/style.css" />
<style>
/* custom 추가 */
#tree .jstree-delete { text-decoration:line-through; color:red; }
</style>
<script src="/static/jslibrary/jstree/jstree.min.js"></script>
<script src="/static/jslibrary/jquery.form.min.js"></script>

<script>
function fnResetAnchor() {
/* 	$(".jstree-anchor").each(function(n) {
		var node = $("#tree").jstree(true).get_node($(this));
		if (typeof node.data != "undefined" && node.data.useAt == "N") {
			$(this).addClass("jstree-delete");
		}
	}) */
}

function selectMenu(node) {
	//console.debug($("input[name=pMenuNo]",opener.document));
	opener.fnSetMenuLink(node.id, node.text, node.data.allMenuCours, "${param.linkNo}");
	<c:if test="${param.pCloseAt ne 'N'}">
	self.close();
	</c:if>
}

function replaceX(str){
	str = str.replace("&amp;","&").replace(/&/gi,"&amp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/"/gi,"&quot;").replace(/'/gi,"&apos;");
	return str;
}


$(function() {
	$('#contentsPopBtn').hide();
	//localStorage.removeItem('jstree');
	$('#tree').jstree({
		'core' : {
			'data' : function (node, cb) {
				console.debug("node.id :: " + node.id);
				var t_url = node.id != "#" ? "/bos/singl/menu/listJson.json?upperMenuNo="+node.id+"&pSiteId=${param.pSiteId}" : "/bos/singl/menu/listJson.json?pSiteId=${param.pSiteId}";
				$.ajax({ url: t_url, dataType: "json"}).done(function (data) {
					var rootList = [];
					var jsonList = [];
					var root = {'id' : '0', 'text' : "Root",'icon' : "jstree-folder",'children':true, 'state' : { 'opened' : true, 'selected' : true },'data' : {'useAt' : "Y"}};
					$.each(data,function(key, value) {
						if (value.useAt == "Y") {
							var children = true;
							if (value.icon == "jstree-file") children = false;
								console.log("value::" + value);
							var item = {'id' : value.menuNo, 'text' : replaceX(value.menuNm), 'children' : children, 'icon' : value.icon};
							var addData = value;
							item.data = addData;
							jsonList.push(item);
						}
					});
					root.children = jsonList;
	            	rootList.push(root);
	            	if (node.id == "#") cb(rootList);
	            	else cb(jsonList);
				});
			},
			'check_callback' : function(o, n, p, i, m) {
				if (m && m.dnd && m.pos !== 'i') { return false; }
				if (o === "move_node" || o === "copy_node") {
					if (this.get_node(n).parent === this.get_node(p).id) { return false; }
				}
				return true;
			},
			'themes' : {
				'responsive' : false,
				'variant' : 'small',
				'stripes' : true
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
		"cookies" : {
			"save_selected" : false
		},
		'plugins' : ['state','types','unique']
	})
	.on('loaded.jstree', function(e, data) {
		//console.log(data)
		//fnResetAnchor();
	})
	.on('select_node.jstree', function (e, data) {
		var node = data.node;
		if (node.id == "0") return;
	})
	.on("click", ".jstree-anchor", function(e) {
	   var node = $("#tree").jstree(true).get_node($(this));
	   if (node.id == "0") return;
	   selectMenu(node); //node.data.allMenuCours
	})
	.on('open_node.jstree', function (e, data) {
		fnResetAnchor();
    })
    .on('changed.jstree', function (e, data) {
    	if (typeof data.node != "undefined") fnResetAnchor();
    	//$('#tree').jstree(true).get_node(data.id).data = {'useAt' : data..useAt}
    });
});

</script>

<h1>메뉴 목록</h1>
<div class="beforeDiv">
	<div id="tree">
	</div>
</div>
<p class="help">
	가이드메뉴에 연결할 메뉴를 선택하세요.
</p>