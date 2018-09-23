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
  Date: 2018-09-21
  Time: 오전 2:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        #wrap{
            width: 50%;
            margin: auto;
        }
        h1{
            text-align: center;
            margin: auto;
        }
        input[type="text"], input[type="password"], textarea{
            width: 100%;
            margin: 0px auto 20px auto;
        }
        input[type="button"], input[type="submit"]{
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
    <title>암호 확인</title>
    <script>
        window.onload=function () {
            document.getElementById("inputPwd").focus();
        }
        function enterKey(){
            if(window.event.keyCode==13){
                document.getElementById("pwdForm").submit();
            }
        }
    </script>

</head>
<body>
<%
    String num = request.getParameter("num");
    String pageNumNow = request.getParameter("pageNumNow");
    String cmd = request.getParameter("cmd");

    if(cmd.equals("mod")){
        out.println("<h1>글 수정 비밀번호 확인</h1>");
    }else if(cmd.equals("del")){
        out.println("<h1>글 삭제 비밀번호 확인</h1>");
    }
%>
    <div id="wrap">
    <%
        out.println("<form  id=\"pwdForm\" name=\"pwdForm\" action=\"pwd_process.jsp?num="+num+"&pageNumNow="+pageNumNow+"&cmd="+cmd+"\" method=\"post\">");
    %>
        <input type="password" id="inputPwd" name="inputPwd" maxlength="8" onkeyup="enterKey();">
        <br>

        <div id="btn_footer">
            <%
                out.print("<a href='detail.jsp?num="+num+"&pageNumNow="+pageNumNow+"'><input type=\"button\" value=\"취소\"></a>");
                out.print("<input type=\"submit\" value=\"확인\">");
                out.print("<a href='index.jsp?pageNumNow="+pageNumNow+"'><input type=\"button\" value=\"목록\"></a>");
            %>
        </div>
        </form>
    </div>
</body>
</html>
