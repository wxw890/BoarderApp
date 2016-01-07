<%@page import="mybean.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="dto" class="mybean.BoardDto" /><!-- dto 내가 입력한 글의 정보를 가지고있다. -->
<jsp:useBean id="dao" class="mybean.BoardDao" />
<jsp:setProperty property="*" name="dto"/>
<%
	BoardDto parent = dao.getBoard(dto.getB_num());//부모글에 대한 정보를 가지고있다.
	dao.replyUpdatePos(parent);//부모글
	dto.setPos(parent.getPos());
	dto.setDepth(parent.getDepth());
	dao.replyBoard(dto);//본인의 답변글
	response.sendRedirect("List.jsp");
%>
	
	<h2>사원 정보가 잘 추가되었습니다.</h2>
	<a href="Reply.jsp">답변화면으로</a><br/>
	<a href="index.jsp">메인화면으로</a>

</body>
</html>