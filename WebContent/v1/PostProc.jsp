<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="dto" class="mybean.BoardDto" />
<jsp:useBean id="dao" class="mybean.BoardDao" />
<jsp:setProperty property="*" name="dto"/>
<%
	dao.insertBoard(dto);
	response.sendRedirect("List.jsp");
%>
	
	<h2>��� ������ �� �߰��Ǿ����ϴ�.</h2>
	<a href="post.jsp">�Է�ȭ������</a><br/>
	<a href="index.jsp">����ȭ������</a>

</body>
</html>