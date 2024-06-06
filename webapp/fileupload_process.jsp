<%@page import="java.io.*" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>File Upload</title>
</head>

<body>
	
	<%
		MultipartRequest multi = new MultipartRequest(request, "C:\\Upload", 7 * 1024 * 1024, "utf-8", new DefaultFileRenamePolicy());
	
		String name1 = multi.getParameter("postName");
		String subject1 = multi.getParameter("postContent");
		
		Enumeration files = multi.getFileNames();
		
		String file1 = (String) files.nextElement();
		String filename1 = multi.getFilesystemName(file1);

	%>
	
	<table border="1">
		<tr>
			<th width="100">이름</th>
			<th width="100">제목 </th>
			<th width="100">파일</th>
		</tr>
		<%
			out.print("<tr><td>" + name1 + " </td>" );
			out.print("<td>" + subject1 + " </td>" );		
			out.print("<td>" + filename1 + " </td></tr>\n" );
		
		%>
		</table>
</body>
</html>
