<%@ page import="mybean.BoardDto"%>
<%@ page import="mybean.BoardDao"%>
<%@ page contentType="text/html; charset=utf-8"%>

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
   alert("수정되었습니다.");
   alert("글목록으로 이동합니다.");
   location.href="List.jsp";
   </script>


<%       
   }
   else{
%>

      <script>
         alert("패스워드가 틀렸는데요?");
         history.back();
      </script>

<%      
   }
%>