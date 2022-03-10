<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
    <div class="btnGroup">
        <input type="submit" id="btnCasePrintView" class="pure-button btnPrint" value="미리보기">
        <input type="submit" id="btnCasePrintForm" class="pure-button btnPrint" value="수정" style="display:none;">
        <input type="submit" id="btnCasePrint" class="pure-button btnPrint" value="출력">
        <input type="submit" id="btnCaseCancel" class="pure-button btnCancel" value="취소">
    </div>

<script>
	$('#btnCasePrintView').click(function(){

        fn_print_page_action();

        $('#btnCasePrintView').hide();
        $('#btnCasePrintForm').show();

        $('#divPrintZone').show();

        $('#divPrintForm').hide();

    });
    $('#btnCasePrintForm').click(function(){

        $('#btnCasePrintView').show();
        $('#btnCasePrintForm').hide();

        $('#divPrintZone').hide();

        $('#divPrintForm').show();

    });

    $('#btnCasePrint').click(function(){
        fn_print_page_action();
        
        /*
        $('#divPrintZone').show().printThis({
            loacCSS:"./print_page.css",
            pageTitle:"해바라기센터 정보시스템"
        });
        */
        $('#divPrintZone').show()
        $('#divPrintForm').hide();
        $('.btnGroup').hide();
             
        window.print();
        
        
        //인쇄 취소 했을 경우 버튼 보이기
        $('.btnGroup').show();
    });

    $('#btnCaseCancel').click(function(){
        window.close();
        //var a = $('#divf1').val();
        //$('#diva1').html( a );

        //$('#diva1').html( $('#divf1').val() );
    });
</script>
