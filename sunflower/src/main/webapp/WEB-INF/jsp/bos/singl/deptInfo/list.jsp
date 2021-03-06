<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<link rel="stylesheet" href="/static/jslibrary/jstree/themes/default/style.css" />

<style>
/* custom 추가 */
#tree .jstree-delete { text-decoration:line-through; color:red; }
</style>
<script src="/static/jslibrary/jstree/jstree.min.js"></script>
<script src="/static/jslibrary/jquery.form.min.js"></script>


<script>
function fnGetDeptDetail(id) {
	if (id > 0) {
		$.ajax({ url : "/bos/singl/deptInfo/listJson.json?cDeptId="+id, dataType : "json", async: false }).done(function (resdata) {
			for (key in resdata) {
				$('#'+key).val(resdata[key]);
			}

			$('input:radio[name=useAt]:input[value='+resdata.useAt+']').prop("checked", true);

			if (resdata.deptTelno!=null){
				var arrTelno = resdata.deptTelno.split("-");
				if (arrTelno.length>0)$("#telno1").val(arrTelno[0]);
				if (arrTelno.length>1)$("#telno2").val(arrTelno[1]);
				if (arrTelno.length>2)$("#telno3").val(arrTelno[2]);
			}

			if (resdata.deptFaxno!=null){
				var arrFaxno = resdata.deptFaxno.split("-");
				if (arrFaxno.length>0)$("#faxno1").val(arrFaxno[0]);
				if (arrFaxno.length>1)$("#faxno2").val(arrFaxno[1]);
				if (arrFaxno.length>2)$("#faxno3").val(arrFaxno[2]);
			}
		});
		$(".bdView").show();
		$(".btnSet").show();
		$("#rootDdView").hide();
	}
	else {
		//최상위 root 선택
		$(".bdView").hide();
		$(".btnSet").hide();
		$("#rootDdView").show();

		$('#deptId').val(id);
		$('#deptCd').val('');
		initlMenuList();
		$('#deptLevel').val(0);
		$('#subYn').val("N");
		$('input:radio[name=useAt]:input[value=Y]').prop("checked", true);
	}

}

function fnResetAnchor() {
	$(".jstree-anchor").each(function(n) {
		var node = $("#tree").jstree(true).get_node($(this));
		if (typeof node.data != "undefined" && node.data!=null && node.data.useAt != "undefined" && node.data.useAt == "N") {
			$(this).addClass("jstree-delete");
		}
	})
}

function replaceX(str){
	str = str.replace("&amp;","&").replace(/&/gi,"&amp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/"/gi,"&quot;").replace(/'/gi,"&apos;");
	return str;
}

$(function() {
	var chknodeSelect
	$('#contentsPopBtn').hide();
	//localStorage.removeItem('jstree');
	$('#tree').jstree({
		'core' : {
			'data' : function (node, cb) {
				var t_url = node.id != "#" ? "/bos/singl/deptInfo/listJson.json?upperDeptId="+node.id : "/bos/singl/deptInfo/listJson.json";
				$.ajax({ url: t_url, dataType: "json"}).done(function (data) {
					var rootList = [];
					var jsonList = [];
					var root = {'id' : '0', 'text' : "Root",'icon' : "jstree-folder",'children':true, 'state' : { 'opened' : true, 'selected' : true },'data' : {'useAt' : "Y"}};
					$.each(data,function(key, value) {
						var children = true;
						if (value.icon == "jstree-file") children = false;

						var item = {'id' : replaceX(value.deptId), 'text' : replaceX(value.deptKorNm), 'children' : children, 'icon' : value.icon};
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
		'plugins' : ['state','dnd','types','unique','contextmenu']
		,"contextmenu" : {
			"items" : {
			"create" : {
				"separator_before" : false, //api 참고
				"separator_after" : true, //api 참고
				"label" : "하위신규부서 추가", //node에서 마우스 오른쪽 클릭 시 text
				"action" : function (data) {
					var inst = $.jstree.reference(data.reference),
						obj = inst.get_node(data.reference);
						inst.create_node(obj, { type : "file" }, "last", function (new_node) {
							setTimeout(function () { inst.edit(new_node); },0);
							chknodeSelect = new_node
						});
				}
			},
			"rename" : {
				"separator_before" : false,
				"separator_after" : true,
				"label" : "부서명 변경",
				"action" : function (data) {
					var inst = $.jstree.reference(data.reference),
					obj = inst.get_node(data.reference);
					inst.edit(obj);
				}
			},
			"remove" : {
				"separator_before" : false,
				"separator_after" : true,
				"label" : "부서 삭제",
				"action" : function (data) {
					var inst = $.jstree.reference(data.reference),
					obj = inst.get_node(data.reference);
					if(inst.is_selected(obj)) {
						inst.delete_node(inst.get_selected());
					}
					else {
						inst.delete_node(obj);
					}
				}
			},
			"ccp" : null
			}
		}

	})
	.on('loaded.jstree', function(e, data) {
		//console.log(data)
		fnResetAnchor();

	})
	.on('select_node.jstree', function (e, data) {
		var node = data.node;
		//if (node.id == "0") return;
		//if (typeof node.id != "undefined") return;
		fnGetDeptDetail(node.id);
	})
	.on('delete_node.jstree', function (e, data) {
		if (data.node.id == "0") {
			alert("최상위 부서는 삭제할 수 없습니다.");
			data.instance.refresh();
			return;
		}
		if ($('#subYn').val() == "Y") {
			alert("하위부서가 존재합니다. 하위부서 삭제 후 가능합니다.");
			data.instance.refresh();
			return;
		}
		if (!confirm("삭제하시겠습니까?")) {
			data.instance.refresh();
		}
		else {
			var deptId = $('#deptId').val();
			$.ajax({ url : "/bos/singl/deptInfo/delete.json", data : { 'cDeptId' : deptId }, dataType : "json", async: false }).done(function (resdata) {
				//var node = $("#tree").jstree(true).get_node(menuNo);
				fnGetDeptDetail(data.node.parent);
				data.instance.refresh();
				//alert(resdata.msg);
			});
		}
	})
	.on('create_node.jstree', function (e, data) {
		$.ajax({ url : "/bos/singl/deptInfo/insert.json", data : {'deptId' : "0", 'deptKorNm' : escape(encodeURIComponent("신규부서")), 'upperDeptId' : data.node.parent, 'useAt' : "Y" }, dataType : "json", async: false }).done(function (resdata) {
			data.instance.set_id(data.node, resdata.cDeptId);
			data.instance.refresh();
		});
	})
	.on('rename_node.jstree', function (e, data) {
		var useAtVal = $('input:radio[name=useAt]:checked').val();
		$.ajax({ url : "/bos/singl/deptInfo/updateDeptInfoNm.json", data : { 'cDeptId' : data.node.id, 'deptKorNm' : data.node.text, 'upperDeptId' : data.node.parent, 'useAt' : useAtVal }, dataType : "json", async: false }).done(function (resdata) {
			//alert(resdata.cDeptId);
			data.instance.set_id(data.node, resdata.cDeptId);
			$('#tree').jstree(true).get_node(resdata.cDeptId).data = {'useAt' : resdata.useAt}
			fnGetDeptDetail(resdata.cDeptId);
			fnResetAnchor();
		});
	})
	.on("move_node.jstree", function(e, data) {
		if (!confirm((data.node.parents.length-1) + "depth "+  "["+data.node.text +"] 부서를 이동하시겠습니까?")) {
			data.instance.refresh();
			return false;
		}

		var deptId = data.node.id;
		if (deptId == "" || deptId == null) {
			return false;
		}

		var instance = $.jstree.reference('#tree'), selected = data.node.id, position = $('#'+selected).index();

		var deptData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			deptData.push(val);
		});

	    //alert("moving node id " + data.node.id);
	    //alert("moving old_parent " + data.old_parent);
	    //alert("new parent id " + data.parent);

		deptData = deptData.join(",");

		if (data.old_parent != data.parent) { //부모키가 틀릴경우
			$.ajax({ url : "/bos/singl/deptInfo/updateUpperDeptId.json", data : { 'cDeptId' : data.node.id, 'upperDeptId' : data.node.parent }, dataType : "json", async: false }).done(function (resdata) {
				fnGetDeptDetail(data.node.id);
				fnResetAnchor();
			});
		}
		else { // 부모 키가 같은 경우
			$.ajax({ url : "/bos/singl/deptInfo/updateMoveDeptId.json", data : { 'cDeptId' : data.node.id, 'upperDeptId' : data.node.parent, 'deptData' : deptData }, dataType : "json", async: false }).done(function (resdata) {
				fnGetDeptDetail(data.node.id);
				fnResetAnchor();
			});
		}


	})
	.on('refresh.jstree', function(event,d) {
		if (chknodeSelect!=undefined) {
			$('#tree').jstree(true).open_node(chknodeSelect.parent,function(){
				$('#'+chknodeSelect.id+'_anchor').trigger('click')
			})
		}
	})
	.on('open_node.jstree', function (e, data) {
		fnResetAnchor();
    })
    .on('changed.jstree', function (e, data) {
    	if (typeof data.node != "undefined") fnResetAnchor();
    	//$('#tree').jstree(true).get_node(data.id).data = {'useAt' : data..useAt}
    });

	$(".treeopen").on('click',function() {
		$("#tree").jstree('open_all');
	});
	$(".treeclose").on('click',function() {
		$("#tree").jstree('close_all');
	});

});


//초기화 함수
function initlMenuList() {
	$('#sortOrdr').val('');
	$('#deptKorNm').val('');
	//$('#deptEngNm').val('');
	$('#deptJobCn').val('');
	$('#telno1').val('');
	$('#telno2').val('');
	$('#telno3').val('');
	$('#faxno1').val('');
	$('#faxno2').val('');
	$('#faxno3').val('');
	$('input:radio[name=useAt]:input[value=N]').attr("checked", true);
}

function insertMenuList(gubun) {
	if (gubun == 'C') {
		if ($('#deptId').val() == "" || $('#deptId').val() == null) {
			alert('부서를 선택해주세요.');
			return;
		}
	}

	initlMenuList();

	if (gubun == 'C') {
		$('#upperDeptId').val($('#deptId').val());
		$('#deptKorNm').val('신규부서');
		$('#deptLevel').val(eval($('#deptLevel').val())+1);
	}
	else {
		$('#upperDeptId').val('0');
		$('#deptKorNm').val('신규부서');
		$('#deptLevel').val(1);
	}
	$('#deptCd').val('');
	$('#deptId').val('0');
	$('#sortOrdr').val('0');

    $.ajax({
        url: '/bos/singl/deptInfo/insert.json',
        type : "POST",
        dataType : 'json',
        data : $("#mainFrm").serialize(),
        success : function(result) {
    		fnGetDeptDetail(result.cDeptId);
    		$('#tree').jstree(true).refresh();
            alert(result.msg);
        }
    });
}

function deleteMenuList() {
	if ($('#deptId').val() == "" || $('#deptId').val() == null) {
		alert('부서를 선택해주세요.');
		return;
	}
	if ($('#subYn').val() == "Y") {
		alert("하위부서가 존재합니다. 하위부서 삭제 후 가능합니다.");
		return;
	}
	if ($('#deptId').val() == "0") {
		alert("최상위 부서는 삭제할 수 없습니다.");
		data.instance.refresh();
		return;
	}

	if(!confirm("삭제하시겠습니까?")) return;

	var deptId = $('#deptId').val();
	$.ajax({ url : "/bos/singl/deptInfo/delete.json", data : { 'cDeptId' : deptId }, dataType : "json", async: false }).done(function (resdata) {
		var node = $("#tree").jstree(true).get_node(deptId);
		fnGetDeptDetail(node.parent);
		$('#tree').jstree(true).refresh();
		//$('#tree').jstree(true)._open_to(node.parent).focus();
		alert(resdata.msg);
	});
}

function checkForm() {
	if ($('#deptId').val() == "0"){
		alert('Root는 수정하실 수 없습니다.');
		return;
	}
	if ($('#deptId').val() == "" || $('#deptId').val() == null) {
		alert('부서를 선택해주세요.');
		return;
	}

	var v = new MiyaValidator($("#mainFrm")[0]);

	v.add("deptId", {
		required : true
	});
	v.add("deptKorNm", {
		required : true
	});
	v.add("telno1", {
        required: false,
        span: 3,
        glue: "-",
        option: "phone"
    });
	v.add("faxno1", {
        required: false,
        span: 3,
        glue: "-",
        option: "phone"
    });
	v.add("sortOrdr", {
		required : true
	});
	v.add("useAt", {
		required : true
	});

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (!confirm('수정 하시겠습니까?')) {
		return;
	}
	else {

		var subDeptIds = [];
		$("#"+ $("#deptId").val()).find("li.jstree-node").each(function(n) {
			subDeptIds.push($(this).attr("id"));
		});
		$("#subDeptIdStr").val(subDeptIds.join());

        $.ajax({
            url: '/bos/singl/deptInfo/update.json',
            type : "POST",
            dataType : 'json',
            data : $("#mainFrm").serialize(),
            success : function(result) {
        		fnGetDeptDetail($('#deptId').val());
        		$('#tree').jstree(true).refresh();
                alert(result.msg);
            }
        });
	}
}

function initDept() {
	$("#deptId").val("");
	$("#userId").val("");
	$("#userNm").val("");
}

function check_num(value) {
	if (isNaN(value)) {
		alert("숫자로만 입력하셔야 합니다.");
		return "";
	}
	else {
		return value;
	}
}

function updateMoveDeptId(gubun) {
	var deptId = $('#deptId').val();
	if (deptId == "" || deptId == null) {
		alert('부서를 선택해주세요.');
		return;
	}

	var instance = $.jstree.reference('#tree'), selected = instance.get_selected(), position = $('#'+selected).index();
	var flag = "";
	var chgDeptId = "";

	var deptData = [];
	if (gubun == "U") {
		flag = instance.get_prev_dom(selected, true);
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {

			if (flag != false && flag.context.id == val) {
				deptData.push(deptId);
			}
			if (deptId != val) {
				deptData.push(val);
			}
		});
	}
	else if (gubun == "D") {
		flag = instance.get_next_dom(selected, true);
		var deptData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			if (deptId != val) {
				deptData.push(val);
			}
			if (flag != false && flag.context.id == val) {
				deptData.push(deptId);
			}
		});
	}
	else {
		var deptData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			if (deptId != val) deptData.push(val);
		});
		if (gubun == "T") deptData.splice(0, 0, deptId);
		else if (gubun == "B") deptData.push(deptId);
	}

	$("#deptData").val(deptData.join(","));

	if (flag) chgDeptId = flag.context.id;

	$.ajax({ url : "/bos/singl/deptInfo/updateMoveDeptId.json", data : { 'cDeptId' : deptId, 'sortOrdr' : $("#sortOrdr").val(), 'deptData' : $("#deptData").val(), 'chgDeptId' : chgDeptId, 'gubun' : gubun }, dataType : "json", async: false }).done(function (resdata) {
		//fnGetDeptDetail(node.parent);
		$('#tree').jstree(true).refresh();
	});
}

</script>
<h2>부서목록</h2>
<div class="row">
	<div class="col-sm-6">
		<div class="treectrl">
			<div class="btn-group f">
				<button type="button" class="b-default btn-sm treeopen" >모두열기</button>
				<button type="button" class="b-default btn-sm treeclose" >모두닫기</button>
			</div>
			<div class="btn-group">
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveDeptId('T');"><i class="fa fa-angle-double-up"></i><span class="sr-only">선택된 부서 처음 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveDeptId('U');"><i class="fa fa-angle-up"></i><span class="sr-only">선택된 부서 이전 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveDeptId('D');"><i class="fa fa-angle-down"></i><span class="sr-only">선택된 부서 다음 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveDeptId('B');"><i class="fa fa-angle-double-down"></i><span class="sr-only">선택된 부서 마지막 순서로변경</span></button>
			</div>

		</div>
		<div class="beforeDiv">
			<div id="tree">
			</div>
		</div>
	</div>
	<div class="col-sm-6" style="margin-top:-40px">
		<div class="tar mt10 mb5">
			<a class="b-add" href="javascript:insertMenuList('T')"><span>최상위부서 추가</span></a>
			<a class="b-add" href="javascript:insertMenuList('C')"><span>하위신규부서 추가</span></a>
		</div>
		<div id="rootDdView" style="display:none;">
			<p class="help">부서를 선택하여 주십시요. Root는 수정/삭제가 불가능합니다.</p>
		</div>
		<div class="bdView afterDiv">
			<form id="mainFrm" name="mainFrm" action="#" method="post">
			<input type="hidden" name="csrfToken" value="${csrfToken}"/>
			<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
			<input type="hidden" name="pSiteId" value="${siteId}" />
			<input type="hidden" name="menuNo" value="${param.menuNo}" />
			<input type="hidden" name="sortOrdr" id="sortOrdr" />
			<input type="hidden" name="deptData" id="deptData" />
			<input type="hidden" name="subDeptIdStr" id="subDeptIdStr" />
			<table>
				<caption>부서정보</caption>
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
				<!-- 클라이언트 부서코드 사용시 사용 -->
<!-- 				  <tr>
					<th scope="row"><label for="deptCd"><span class="req"><span>필수입력</span></span>부서코드</label></th>
					<td>
						<input type="text" name="deptCd" id="deptCd" size="30" value=""  maxlength="32" />
					</td>
				  </tr> -->
				  <tr>
					<th scope="row"><label for="deptKorNm"><span class="req"><span>필수입력</span></span>부서명</label></th>
					<td>
						<input type="hidden" name="deptId" id="deptId" size="10" value=""  maxlength="10" readonly="readonly"/>
						<input type="hidden" name="upperDeptId" id="upperDeptId" size="10" value=""  maxlength="10" readonly="readonly"/>
						<input type="hidden" name="deptLevel" id="deptLevel" size="10" value=""  maxlength="10" readonly="readonly"/>
						<input type="hidden" name="subYn" id="subYn" size="10" value=""  maxlength="50" readonly="readonly"/>
						<input name="deptKorNm" id="deptKorNm" type="text" size="10" value="" class="w50p" maxlength="50"/>
					</td>
				  </tr>
				  <!--
				  <tr>
					<th scope="row"><label for="deptEngNm">부서영문명</label></th>
					<td><input name="deptEngNm" id="deptEngNm" type="text" size="50" value="" class="w50p" maxlength="100"/>
					</td>
				  </tr>
				   -->
				  <tr>
					<th scope="row"><label for="deptJobCn">부서업무</label></th>
					<td>
						<textarea name="deptJobCn" id="deptJobCn" cols="30" rows="5" class="w95p board1" style="height:160px;" data-lensize="2000"></textarea>
					</td>
				  </tr>
				  <tr>
					<th scope="row"><label for="telno1">전화번호</label></th>
					<td>
						<select name="telno1" id="telno1" title="전화번호 연락처 앞 자리" >
							<option value="" selected>선택</option>
							<c:if test="${fn:length(telno1CdCodeList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(telno1CdCodeList)-1}" step="1">
							<option value="${telno1CdCodeList[x].cd}"  >${telno1CdCodeList[x].cdNm}</option>
							</c:forEach>
							</c:if>
						</select>
						-
						<input type="text" name="telno2" id="telno2" class="tel" title="전화번호 연락처 중간 3~4자리" maxlength="4" />
						-
						<input type="text" name="telno3" id="telno3" class="tel" title="전화번호 연락처 끝 4자리" maxlength="4" />
					</td>
				  </tr>
				  <tr>
					<th scope="row"><label for="faxno1">팩스번호</label></th>
					<td>
						<select name="faxno1" id="faxno1" title="팩스번호 앞 자리" >
							<option value="" selected>선택</option>
							<c:if test="${fn:length(telno1CdCodeList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(telno1CdCodeList)-1}" step="1">
							<option value="${telno1CdCodeList[x].cd}"  >${telno1CdCodeList[x].cdNm}</option>
							</c:forEach>
							</c:if>
						</select>
						-
						<input type="text" name="faxno2" id="faxno2" class="tel" title="팩스번호 중간 3~4자리" maxlength="4" />
						-
						<input type="text" name="faxno3" id="faxno3" class="tel" title="팩스번호 끝 4자리" maxlength="4" />
					</td>
				  </tr>
				  <tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>사용여부</th>
					<td>
						<label><input name="useAt" id="useAt1" type="radio" value="Y" /> 사용</label>
						<label><input name="useAt" id="useAt2" type="radio" value="N" />미사용</label>
					</td>
				  </tr>
			</table>
			</form>
		</div>
		<div class="btnSet clear" id="btnSet">
			<!-- <a class="b-reset" href="javascript:initlMenuList()"><span>초기화</span></a> -->
			<a class="b-edit" href="javascript:checkForm()"><span>수정</span></a>
			<a class="b-del"  href="javascript:deleteMenuList()"><span>삭제</span></a>
		</div>
	</div>
</div>

