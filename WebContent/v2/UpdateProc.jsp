<%@ page import="mybean.BoardDto"%>
<%@ page import="mybean.BoardDao"%>
<%@ page contentType="text/html; charset=EUC-KR"%>

<%
   request.setCharacterEncoding("euc-kr");
   int b_num = Integer.parseInt(request.getParameter("b_num"));
   String userInputPass = request.getParameter("pass");
   
   BoardDao dao = new BoardDao();
   BoardDto db_dto = dao.getBoard(b_num);
   
   if(userInputPass.equals(db_dto.getB_pass())){
       BoardDto dto = new BoardDto();
       dto.setB_name(request.getParameter("name"));
       dto.setB_email(request.getParameter("email"));
       dto.setB_subject(request.getParameter("subject"));
       dto.setB_content(request.getParameter("content"));
       dto.setB_num(b_num);
       
       dao.updateBoard(dto);
%>
   <script>
   alert("�����Ǿ����ϴ�.");
   alert("�۸������ �̵��մϴ�.");
   location.href="List.jsp";
   </script>


<%       
   }
   else{
%>

      <script>
         alert("�н����尡 Ʋ�ȴµ���?");
         history.back();
      </script>

<%      
   }
%>