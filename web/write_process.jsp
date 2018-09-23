<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %>

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018-09-23
  Time: 오후 1:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String pageNumNow = request.getParameter("pageNumNow");
    String writer = request.getParameter("writer");
    String title = request.getParameter("title");
    String content  = request.getParameter("content");
    String pwd = request.getParameter("pwd");

    Connection con = null;
    PreparedStatement pstmt = null;
    int sqlCheck = 0;

    try {
        Context context = new InitialContext();
        DataSource ds = (DataSource)context.lookup("java:/comp/env/jdbc/jspDS");
        con = ds.getConnection();

        content = content.replace("<","&lt");
        content = content.replace(">","&gt");

        String insertSql = "INSERT INTO testboard (title, writer, content, pwd, regdate) VALUES(?, ?, ?, ?, now())";
        pstmt=con.prepareStatement(insertSql);
        pstmt.setString(1,title);
        pstmt.setString(2,writer);
        pstmt.setString(3,content);
        pstmt.setString(4,pwd);
        sqlCheck = pstmt.executeUpdate();
    } catch (NamingException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }

    if(sqlCheck>0){
%>
    <script>
        alert("정상적으로 등록되었습니다.");
        document.location.href="index.jsp";
    </script>
<%
    }else{
        out.println("<script>");
        out.println("alert(\"오류가 발생하였습니다.\");");
        out.println("document.location.href='write.jsp?pageNumNow="+pageNumNow+"';");
        out.println("</script>");
    }
%>
</body>
</html>
