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
<jsp:useBean id="dto" class="mybean.BoardDto" /><!-- dto ���� �Է��� ���� ������ �������ִ�. -->
<jsp:useBean id="dao" class="mybean.BoardDao" />
<jsp:setProperty property="*" name="dto"/>
<%
	BoardDto parent = dao.getBoard(dto.getB_num());//�θ�ۿ� ���� ������ �������ִ�.
	dao.replyUpdatePos(parent);//�θ��
	dto.setPos(parent.getPos());
	dto.setDepth(parent.getDepth());
	dao.replyBoard(dto);//������ �亯��
	response.sendRedirect("List.jsp");
%>
	
	<h2>��� ������ �� �߰��Ǿ����ϴ�.</h2>
	<a href="Reply.jsp">�亯ȭ������</a><br/>
	<a href="index.jsp">����ȭ������</a>

</body>
</html>