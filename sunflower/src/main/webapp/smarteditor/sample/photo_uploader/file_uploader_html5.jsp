<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@page import="site.unp.core.util.WebUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.OutputStream" %>
<%@page import="java.io.FileOutputStream" %>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>

<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%--
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
--%>
<%
String sFileInfo = "";
//파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴
String name = request.getHeader("file-name");
String ext = name.substring(name.lastIndexOf(".")+1);

long fileSize = new Long(request.getContentLength());

//System.out.println("ext::" + ext.toLowerCase());
//[보안취약점]-2019-01-25 수정-start
if (!"jpg".equals(ext.toLowerCase()) && !"gif".equals(ext.toLowerCase()) && !"png".equals(ext.toLowerCase()) && !"bmp".equals(ext.toLowerCase())){
	out.println("NOTALLOW_" + name);
	//System.out.println("등록하실 수 없는 확장자입니다.");
	return;
}
//3MB 보다 큰지 체크
else if (fileSize > 3000000) {
	out.println("LIMITFILESIZE_" + "3MB");
	return;
}
//[보안취약점]-2019-01-25 수정-end

//파일 기본경로
String defaultPath = request.getServletContext().getRealPath("/");
//파일 기본경로 _ 상세경로
String path = defaultPath + "editorUpload" + File.separator;

path = WebUtil.filePathBlackList(path);
File file = new File(path);
if(!file.exists()) {
	if (!file.mkdirs()){
		System.out.println(file + " :: Unable to create path!!");
	}
}
String realname = UUID.randomUUID().toString() + "." + ext;
InputStream is = request.getInputStream();
OutputStream os=new FileOutputStream(WebUtil.filePathBlackList(path + realname));

try{
	int numRead;
	//파일쓰기
	byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
	while((numRead = is.read(b,0,b.length)) != -1){
	  os.write(b,0,numRead);
	}
	if(is != null) {
	  is.close();
	}
	os.flush();
	os.close();
	sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/editorUpload/"+realname;
	out.println(sFileInfo);
	//System.out.println(sFileInfo);
} catch (Exception e){
	System.out.println(e.toString());
} finally {
	if (is!=null){ try { is.close();} catch (Exception e) {	e.printStackTrace();}}
	if (os!=null){ try { os.flush(); os.close();} catch (Exception e) {	e.printStackTrace();}}
}
%>
<%--
</body>
</html>
--%>