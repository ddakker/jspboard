<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018-09-23
  Time: 오후 6:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String num = request.getParameter("num");
    String pageNumNow = request.getParameter("pageNumNow");
    String cmd = request.getParameter("cmd");
    String inputPwd = request.getParameter("inputPwd"); // 사용자가 확인폼에 입력한 비번값
    String orgPwd = null; // DB에 입력된 비번값

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Context context = new InitialContext();
        DataSource ds = (DataSource)context.lookup("java:/comp/env/jdbc/jspDS");
        con = ds.getConnection();

        String pwdSql = "SELECT pwd FROM testboard where num="+num;
        pstmt = con.prepareStatement(pwdSql);
        rs = pstmt.executeQuery();

        if(rs.next()){
            orgPwd = rs.getString("pwd");

            // 비번 일치 확인
            if(inputPwd.equals(orgPwd) && cmd.equals("del")) { // 삭제
                pstmt.clearParameters();
                String delSql = "DELETE FROM testboard WHERE num="+num;
                pstmt = con.prepareStatement(delSql);
                int sqlCheck = pstmt.executeUpdate();

                if(sqlCheck>0){
                    out.println("<script>");
                    out.println("alert(\"정상적으로 삭제되었습니다.\");");
                    out.println("document.location.href='index.jsp?pageNumNow="+pageNumNow+"';");
                    out.println("</script>");
                }else{
                    out.println("<script>");
                    out.println("alert(\"오류가 발생하였습니다.\");");
                    out.println("document.location.href='detail.jsp?num="+num+"&pageNumNow="+pageNumNow+"';");
                    out.println("</script>");
                }

            }else if(inputPwd.equals(orgPwd) && cmd.equals("mod")) { // 수정
                out.println("<script>");
                out.println("document.location.href='modify.jsp?num="+num+"&pageNumNow="+pageNumNow+"';");
                out.println("</script>");

            }else{
                out.println("<script>");
                out.println("alert(\"비밀번호가 일치하지 않습니다.\");");
                out.println("document.location.href='detail.jsp?num="+num+"&pageNumNow="+pageNumNow+"';");
                out.println("</script>");
            }
        }
    } catch (NamingException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if( rs != null) rs.close();
        if( pstmt !=null ) pstmt.close();
        if( con != null) con.close();
    }

%>
</body>
</html>
