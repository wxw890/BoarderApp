<%@page import="mybean.BoardDao"%>
<%@page import="mybean.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="dao" class="mybean.BoardDao" />

<%
int b_num = Integer.parseInt(request.getParameter("b_num"));
BoardDao d_dao = new BoardDao();
BoardDto d_dto = d_dao.getBoard(b_num);
String pass = d_dto.getB_pass();
String userInputPass = request.getParameter("pass");


%>
<html>
<head><title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
		if (document.form.pass.value == "") {
			 alert("������ ���� �н����带 �Է��ϼ���.");
		     form.pass.focus();
			 return false;
			}
		if(userInputPass.equals(d_dto.getB_pass())){
					
					<%
					d_dao.deleteBoard(b_num);
					response.sendRedirect("List.jsp");
					%>
				
				
			}else{
				
				alert("������ �Ϸ�Ǿ����ϴ�.");
				history.back();
			
			}
				document.form.submit();
			
	}
</script>
</head>
<body>
<center>
<br><br>
<table width=50% cellspacing=0 cellpadding=3>
 <tr>
  <td bgcolor=#dddddd height=21 align=center>
      ������� ��й�ȣ�� �Է��� �ּ���.</td>
 </tr>
</table>
<table width=70% cellspacing=0 cellpadding=2>
<form name=form method=post action="Delete.jsp" >
 <tr>
  <td align=center>
   <table align=center border=0 width=91%>
    <tr> 
     <td align=center>  
	  <input type=password name="pass" size=17 maxlength=15>
	 </td> 
    </tr>
    <tr>
     <td><hr size=1 color=#eeeeee></td>
    </tr>
    <tr>
     <td align=center>
	  <input type=button value="�����Ϸ�" onClick="check()"> 
      <input type=reset value="�ٽþ���"> 
      <input type=button value="�ڷ�" onClick="history.back()">
	 </td>
    </tr> 
   </table>
  </td>
 </tr>
</form> 
</table>
</center>
</body>
</html>
