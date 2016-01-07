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
	
	<h2>사원 정보가 잘 추가되었습니다.</h2>
	<a href="post.jsp">입력화면으로</a><br/>
	<a href="index.jsp">메인화면으로</a>

</body>
</html>