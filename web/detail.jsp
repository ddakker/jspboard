<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018-09-23
  Time: 오후 2:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
    <style>
        #wrap{
            width: 50%;
            margin: auto;
        }
        h1{
            text-align: center;
            margin: auto;
        }
        input[type="text"], input[type="password"], input[type="date"], textarea{
            width: 100%;
            margin: 0px auto 20px auto;
        }
        input[type="button"]{
            margin-left: 10px;
            margin-right: 10px;
        }

        #btn_footer{
            width: 100%;
            text-align: center;
            margin: auto;

        }
        a, a:visited, a:hover, a:link{
            text-decoration: none; color: #1a1a1a;
        }

    </style>
    <title>글 상세정보</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String num = request.getParameter("num");
    String pageNumNow = request.getParameter("pageNumNow");

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String writer = null;
    String title = null;
    String content = null;
    Date regdate = null;
    try {
        Context context = new InitialContext();
        DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/jspDS");
        con = ds.getConnection();

        String detailSql = "SELECT writer, title, content, pwd, regdate FROM testboard WHERE num="+num;
        pstmt=con.prepareStatement(detailSql);
        rs=pstmt.executeQuery();

        if(rs.next()){
            writer = rs.getString("writer");
            title = rs.getString("title");
            content = rs.getString("content");
            regdate = rs.getDate("regdate");
        }
    } catch (NamingException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if(rs != null ) rs.close();
            if(pstmt != null ) pstmt.close();
            if(con != null ) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


%>

    <h1>글 상세보기</h1>
    <div id="wrap">
        글쓴이<br>
        <input type="text" id="writer" name="writer" maxlength="50"><br>
        <%
            out.println("<input type=\"text\" id=\"writer\" name=\"writer\" maxlength=\"50\" readonly=\"readonly\" value="+writer+"><br>");
        %>
        작성일<br>
        <%
            out.println("<input type=\"date\" id=\"regdate\" name=\"regdate\" readonly=\"readonly\" value="+regdate+"><br>");
        %>
        제목<br>
        <%
            out.println("<input type=\"text\" id=\"title\" name=\"title\" maxlength=\"200\" readonly=\"readonly\" value="+title+"><br>");
        %>
        내용<br>
        <%
            out.println("<textarea rows=\"5\" cols=\"50\" id=\"content\" name=\"content\" readonly=\"readonly\">"+content+"</textarea><br>");
        %>
        <div id="btn_footer">
        <%
            out.print("<a href='check_pwd.jsp?num="+num+"&pageNumNow="+pageNumNow+"&cmd=mod'><input type=\"button\" value=\"수정\"></a>");
            out.print("<a href='check_pwd.jsp?num="+num+"&pageNumNow="+pageNumNow+"&cmd=del'><input type=\"button\" value=\"삭제\"></a>");
            out.print("<a href='index.jsp?pageNumNow="+pageNumNow+"'><input type=\"button\" value=\"목록\"></a>");
        %>
        </div>
    </div>

</body>
</html>
