<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"  trimDirectiveWhitespaces="true"%>
<script src="/static/axe/axe.ko.js"></script>
<script>
	var validationdata;
	axe.run({
			runOnly: {
				type: 'tag',
				// 적용할 지침
				// values: ['wcag2a']
				values: ['wcag2a','wcag2aa','section508']//,'best-practice'
			}
		}, )
		.then(results => {
			if (results.violations.length) {
				// if (confirm('접근성 오류가 발견 되었습니다. 확인 하시겠습니까?')) {
				// }
				//app.info = results
				validationdata = results
				window.name = "parentForm";
				// window.open('validation.html','validation','')
				window.open("/validation.html","validation", "top=0, left=0, width=1920, height=1080, resizable=1, scrollbars=1"); 
				throw new Error('접근성 오류가 발견 되었습니다.')
			}
		})
		.catch(err => {
			console.error('에러가 발생 하였습니다.:', err.message)
		})
</script>