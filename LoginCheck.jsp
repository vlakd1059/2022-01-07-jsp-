<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// login.html에서 입력된 id, pw값을 변수에 저장
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	// JDBC연결을 통해 로그인 기능 구현
	// JDBC연결과정 
	// 1. OracleDirver연결
	// 2. DB연결(Connection)
	// 3. SQL쿼리문 작성 & 실행
	// 4. DB연결종료

	// 1)
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "hr";
	String password = "hr";
	// 2)
	Connection conn = DriverManager.getConnection(url, user, password);

	/* if(conn==null){ 
		out.print("DB연결실패...");
	}else{
		out.print("DB연결성공...");
	} */
	// 3)
	String sql = "select * from s_member where m_id=? and m_pw=?";
	PreparedStatement psmt = conn.prepareStatement(sql);
	psmt.setString(1, id);
	psmt.setString(2, pw);

	ResultSet rs = psmt.executeQuery();
	if (rs.next()) {
		String nick = rs.getString("m_nick");
		
		// URL주소창에 한글데이터를 전달 할 때는
		// URLEncoder.encode(문자열데이터, 인코딩방식);
		response.sendRedirect("LoginTrue.jsp?nick=" + URLEncoder.encode(nick,"UTF-8"));
	} else {
		response.sendRedirect("LoginFalse.jsp");
	}

	//4)
	rs.close();
	psmt.close();
	conn.close();

	/* if (id.equals("smhrd") && pw.equals("1234")) {
		response.sendRedirect("LoginTrue.jsp?id="+id);
	} else {
		response.sendRedirect("LoginFalse.jsp");
	}  */
	%>
</body>
</html>
