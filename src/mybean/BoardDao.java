package mybean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

public class BoardDao {
   private Connection con;//DB����
   private PreparedStatement stmt;//Statement���� �ݺ����� ������ ���� ���� ���ټ� �ִ� ��ü�̸� ����(SQL���)�� �����ϱ� ���ؼ� ����Ѵ�.
   private ResultSet rs;//DB����� �����ϱ� ���ؼ� ���
   private DataSource ds;//DriverManager�� ������ ���·μ� connection ��ü�� ȹ���ϱ� ���� ������ �Ѵܰ� �� �߻�ȭ�Ѵ٤�.
   
   //DB������ �����ڿ��� �Ѵ�.
   public BoardDao(){
      try{
         Context ctx=new InitialContext();//InitialContext()�� DB���� �ڿ� ������ ���ش�.pool�� �������ش�. context��  ���� ���α׷��� � ���������� �������ش�.
         ds=(DataSource)ctx.lookup("java:/comp/env/jdbc/testDB");//lookup()�� java:/comp/env/jdbc/testDB�� �̸��� ���� ��ü�� �����´�.
      }catch(Exception err){
         System.out.println("BoardDao : "+err);
      }
   }
   
   //DB ������ ���� ���� �޼���
   public void freeCon(){
		if(rs!=null){ try{ rs.close(); }catch(Exception err){} }
		if(stmt!=null){ try{ stmt.close(); }catch(Exception err){} }
		if(con!=null){ try{ con.close(); }catch(Exception err){} }
	}
	
	public List getBoardList(String keyField, String keyWord){
		String sql = null;
		if(keyWord == null || keyWord.equals("null") || keyWord.isEmpty()){
			System.out.println("1.ã��?");
			sql = "select * from tblboard order by pos";
		}
		else{
			System.out.println("2.ã��?");
			sql = "select * from tblboard where " + keyField +
				" like '%" + keyWord + "%' order by pos";
		}
		System.out.println("getBoardList ��, ����Ʈ ����!!!!!!!");
		Vector vec = new Vector();
		
		try{
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while(rs.next()){
				BoardDto dto = new BoardDto();
				dto.setB_content(rs.getString("b_content"));
				dto.setB_count(rs.getInt("b_count"));
				dto.setB_email(rs.getString("b_email"));
				dto.setB_homepage(rs.getString("b_homepage"));
				dto.setB_ip(rs.getString("b_ip"));
				dto.setB_name(rs.getString("b_name"));
				dto.setB_num(rs.getInt("b_num"));
				dto.setB_pass(rs.getString("b_pass"));
				dto.setB_regdate(rs.getString("b_regdate"));
				dto.setB_subject(rs.getString("b_subject"));
				dto.setDepth(rs.getInt("depth"));
				dto.setPos(rs.getInt("pos"));
				
				vec.add(dto);
			}
		}
		catch(Exception err){
			System.out.println("getBoardList() : " + err);
		}
		finally{
			freeCon();
		}
		return vec;
	}
	public void updatePos(Connection con){
		try{
			String sql = "update tblBoard set pos=pos+1";
			stmt = con.prepareStatement(sql);
			stmt.executeUpdate();
		}
		catch(Exception err)
		{
			System.out.println("updatePos() : " + err);
		}
	}
	public void insertBoard(BoardDto dto){
		String sql = "insert into tblboard(b_num, b_name, b_email, " +
			"b_homepage, b_subject, b_content, b_regdate, b_pass, " +
			"b_count, b_ip, pos, depth) " +
			"values(seq_b_num.nextVal, ?,?,?,?,?, sysdate,?,0,?,0,0)";
		try{
			con = ds.getConnection();
			updatePos(con);// �ԷµǱ� ���� ������Ʈ�� �ȴ�.
			stmt = con.prepareStatement(sql);
			stmt.setString(1, dto.getB_name());
			stmt.setString(2, dto.getB_email());
			stmt.setString(3, dto.getB_homepage());
			stmt.setString(4, dto.getB_subject());
			stmt.setString(5, dto.getB_content());
			stmt.setString(6, dto.getB_pass());
			stmt.setString(7, dto.getB_ip());
			
			stmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("insertBoard() : " + err);
		}
		finally{
			freeCon();
		}
		
	}
	
	public void increaseCount(int b_num){
		try{
			con = ds.getConnection();
			String sql = "update tblboard set b_count=b_count+1 where b_num=?";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, b_num);
			stmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("increaseCount() : " + err);
		}
		finally{freeCon();}
	}
	
	public BoardDto getBoard(int b_num){
		String sql;
		BoardDto result = new BoardDto();
		
		try{
			System.out.println("getBoard ��, �б� ����!!!!!!!");
			con = ds.getConnection();
			
			sql = "select * from tblboard where b_num=?";
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, b_num);
			rs = stmt.executeQuery();
			
			if(rs.next()){
				result.setB_content(rs.getString("b_content"));
				result.setB_count(rs.getInt("b_count"));
				result.setB_email(rs.getString("b_email"));
				result.setB_homepage(rs.getString("b_homepage"));
				result.setB_ip(rs.getString("b_ip"));
				result.setB_name(rs.getString("b_name"));
				result.setB_num(rs.getInt("b_num"));
				result.setB_pass(rs.getString("b_pass"));
				result.setB_regdate(rs.getString("b_regdate"));
				result.setB_subject(rs.getString("b_subject"));
				result.setDepth(rs.getInt("depth"));
				result.setPos(rs.getInt("pos"));
			}
		}
		catch(Exception err){
			System.out.println("getBoard() : " + err);
		}
		finally{
			freeCon();
		}
		
		return result;
	}
	
	public void updateBoard(BoardDto dto){
		String sql = "update tblboard set b_name=?, b_email=?, " +
			"b_subject=?, b_content=? where b_num=?";
		
		try{
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, dto.getB_name());
			stmt.setString(2, dto.getB_email());
			stmt.setString(3, dto.getB_subject());
			stmt.setString(4, dto.getB_content());
			stmt.setInt(5, dto.getB_num());
			
			stmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("updateBoard() : " + err);
		}
		finally{ freeCon(); }
	}
	
	public void deleteBoard(int b_num){
		String sql = "delete from tblboard where b_num=?";
			
		try{
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, b_num);
			stmt.executeUpdate();
		}
		catch(Exception err){
			System.out.println("deleteBoard() : " + err);
		}
		finally{ freeCon(); }
	}
	public void replyUpdatePos(BoardDto dto){//�θ�
		String sql = "update tblBoard set pos=pos+1 where pos>?";
		try{
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, dto.getPos());
			stmt.executeUpdate();
			
		}
		catch(Exception err){
			System.out.println("deleteBoard() : " + err);
		}
		finally{ freeCon(); }
	}
	
	public void replyBoard(BoardDto dto){//BoardDto dto �θ���� �Ѱܹ޾ƾ��Ѵ�.
		String sql = "insert into tblboard(b_num, b_name, b_email, " +
				"b_homepage, b_subject, b_content, b_regdate, b_pass, " +
				"b_count, b_ip, pos, depth) " +
				"values(seq_b_num.nextVal, ?,?,?,?,?, sysdate,?,0,?,?,?)";
			try{
				con = ds.getConnection();
				stmt = con.prepareStatement(sql);
				stmt.setString(1, dto.getB_name());
				stmt.setString(2, dto.getB_email());
				stmt.setString(3, dto.getB_homepage());
				stmt.setString(4, dto.getB_subject());
				stmt.setString(5, dto.getB_content());
				stmt.setString(6, dto.getB_pass());
				stmt.setString(7, dto.getB_ip());
				stmt.setInt(8, dto.getPos()+1);
				stmt.setInt(9, dto.getDepth()+1);
				
				stmt.executeUpdate();
			}
			catch(Exception err){
				System.out.println("replyBoard() : " + err);
			}
			finally{
				freeCon();
			}
			
	}
	
	public String useDepth(int depth){
		String result = "";
		for(int i=0; i<depth*3; i++){
			result +="&nbsp;";
		}
		return result;
	}
		
}