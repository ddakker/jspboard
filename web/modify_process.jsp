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
  Time: 오후 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String num = request.getParameter("num");
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
        DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/jspDS");
        con = ds.getConnection();

        content = content.replace("<","&lt");
        content = content.replace(">","&gt");

        String modifySql = "UPDATE testboard SET title=?, writer=?, content=?, pwd=?, regdate=now() WHERE num="+num;

        pstmt=con.prepareStatement(modifySql);
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
        out.println("<script>");
        out.println("alert(\"정상적으로 수정되었습니다.\");");
        out.println("document.location.href='index.jsp?pageNumNow="+pageNumNow+"';");
        out.println("</script>");
    }else{
        out.println("<script>");
        out.println("alert(\"오류가 발생하였습니다.\");");
        out.println("document.location.href='modify.jsp?num="+num+"&pageNumNow="+pageNumNow+"';");
        out.println("</script>");
    }
%>
</body>
</html>
