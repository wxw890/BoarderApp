<%@page import="mybean.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="dao" class="mybean.BoardDao" />
<%
int b_num = Integer.parseInt(request.getParameter("b_num"));//�۹�ȣ b_num�� �θ��
BoardDto dto = dao.getBoard(b_num);
String b_subject = dto.getB_subject();
String b_content = dto.getB_content();




%>
<html>
<head><title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<center>
<br><br>
<table width=80% cellspacing=0 cellpadding=3>
 <tr>
  <td bgcolor=84F399 height=25 align=center>�亯����</td>
 </tr>
</table>
<br>
<table width=80% cellspacing=0 cellpadding=3 align=center>
<form name=post method=post action="ReplyProc.jsp" >
	<input type="hidden" name = "b_ip" value="<%=request.getRemoteAddr() %>"/>
	<input type="hidden" name = "b_num" value="<%=b_num%>"/>
 <tr>
  <td align=center>
   <table border=0 width=100% align=center>
    <tr>
     <td width=10%>�� ��</td>
     <td width=90%><input type=text name="b_name" size=10 maxlength=8></td>
    </tr>
    <tr>
	 <td width=10%>E-Mail</td>
	 <td width=90%><input type=text name="b_email" size=30 maxlength=30></td>
    </tr>
    <tr>
     <td width=10%>Ȩ������</td>
     <td width=90%><input type=text name="b_homepage" size=40 maxlength=30></td>
    </tr>
    <tr>
     <td width=10%>�� ��</td>
     <td width=90%><input type=text name="b_subject" size=50 maxlength=30 value="�亯 : <%=b_subject%>"></td>
    </tr>
    <tr>
     <td width=10%>�� ��</td>
     <td width=90%><textarea name="b_content" rows=10 cols=50 ><%=b_content%></textarea></td>
    </tr>
    <tr>
     <td width=10%>��� ��ȣ</td> 
     <td width=90% ><input type=password name="b_pass" size=15 maxlength=15></td>
    </tr>
    <tr>
     <td colspan=2><hr size=1></td>
    </tr>
    <tr>
     <td><input type=submit value="���" >&nbsp;&nbsp;
         <input type=reset value="�ٽþ���">&nbsp;&nbsp;
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