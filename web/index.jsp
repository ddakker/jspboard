<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018-09-20
  Time: 오후 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <h1>리스트</h1>
  <table border="1">
    <tr>
      <th>번호</th><th>제목</th><th>글쓴이</th><th>등록일</th>
    </tr>
    <tr>
      <%
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
          Context context = new InitialContext();
          DataSource ds = (DataSource) context.lookup("java/comp/env/jdbc/jspDS");
          con = ds.getConnection();

          pstmt = con.prepareStatement("select num,title,writer,regdate from testboard");
          rs = pstmt.executeQuery();

          while(rs.next()){
              int num = rs.getInt("num");
              String title = rs.getString("title");
              String writer = rs.getString("writer");
              Date regdate = rs.getDate("regdate");

              out.println("<td>"+num+"</td><td>"+title+"</td><td>"+writer+"</td><td>"+regdate+"</td>");
          }

        } catch (NamingException e) {
          e.printStackTrace();
        } catch (SQLException e) {
          e.printStackTrace();
        } finally {
          try {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(con != null) con.close();
          } catch (SQLException e) {
            e.printStackTrace();
          }
        }
      %>
    </tr>
  </table>
  <a href="write.jsp">글쓰기</a>
  </body>
</html>
