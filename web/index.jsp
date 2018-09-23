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
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
    <style>
      h1, table{
        text-align: center;
        margin: auto;
      }
      a, a:visited, a:hover, a:link{
        text-decoration: none; color: #1a1a1a;
      }
      td{
        white-space:nowrap;  text-overflow:ellipsis; overflow:hidden;
      }
      #pageNav{
        width: 80%;
        text-align: center;
        margin: auto;
      }
      #btn_write{
        width: 80%;
        text-align: right;
        margin: auto;
        padding-right: 10px;

      }
    </style>
    <title>리스트</title>
  </head>
  <body>
  <h1>리스트</h1>
    <table border="1" style="width: 80%; text-align: center; table-layout:fixed;">
    <tr>
      <th style="width: 10%;">번호</th><th style="width: 50%;">제목</th><th  style="width: 20%;">글쓴이</th><th  style="width: 20%;">등록일</th>
    </tr>

      <%
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int totalRows = 0; // 전체 글 수
        int pageRows = 10; // 한 페이지당 출력할 글의 개수

        String pageNumNowStr = request.getParameter("pageNumNow"); // 현재 페이지 번호
        if(pageNumNowStr==null){
            pageNumNowStr="1";
        }
        int pageNumNow = Integer.parseInt(pageNumNowStr); // 현재 페이지 번호

        int startNum = (pageNumNow-1) * pageRows; // 시작 글 번호

        int pageNavCnt = 0;
        int totalPageNavCnt = 0;
        int startNavNum = 0;
        int endNavNum = 0;
        boolean prevNav = false;
        boolean nextNav = false;

        try {
          Context context = new InitialContext();
          DataSource ds = (DataSource) context.lookup("java:/comp/env/jdbc/jspDS");
          con = ds.getConnection();

          String totalRowsSql = "SELECT IFNULL(COUNT(NUM),0) FROM testboard"; // 전체 글 수 구하기
          pstmt = con.prepareStatement(totalRowsSql);
          rs = pstmt.executeQuery();
          rs.next();
          totalRows = rs.getInt(1);
          rs.first();
          pstmt.clearParameters();


          String listSql = "SELECT num, title, writer, regdate FROM testboard ORDER BY num DESC LIMIT "+startNum+", "+pageRows; // 리스트 출력

          pstmt = con.prepareStatement(listSql);
          rs = pstmt.executeQuery();



          while(rs.next()){
              int num = rs.getInt("num");
              String title = rs.getString("title");
              String writer = rs.getString("writer");
              Date regdate = rs.getDate("regdate");

              String titleLink="<a href='detail.jsp?num="+num+"&pageNumNow="+pageNumNow+"'>"+title+"</a>";

              out.println("<tr><td>"+num+"</td><td>"+titleLink+"</td><td>"+writer+"</td><td>"+regdate+"</td></tr>");
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

  </table>
<div id="pageNav">
  <%

    pageNavCnt = 5; // 페이지 하단 네비 출력 개수
    totalPageNavCnt = (int)( Math.ceil( (totalRows / (double)pageRows) ) ); // 페이지 내비 전체 개수
    startNavNum = (int)( Math.floor( ( (pageNumNow-1) / pageNavCnt ) ) )*pageNavCnt+1; // 페이지 네비 시작 번호
    endNavNum = (startNavNum + pageNavCnt)-1; // 페이지 네비 끝 번호

    if(endNavNum> totalPageNavCnt){ // 페이지 네비 마지막 번호 처리
      endNavNum= totalPageNavCnt;
    }

    prevNav = (startNavNum != 1) ? true : false ; // 이전 페이지 이동 표시
    nextNav = endNavNum<totalPageNavCnt ? true : false; // 다음 페이지 이동 표시

    out.println("<br>");
    // 이전 페이지 네비 표시
    if(prevNav){
        int prev=startNavNum-pageNavCnt;
        out.println("<a href='index.jsp?pageNumNow="+prev+"'>"+"<<"+"</a>");
    }

    // 페이지 네비 번호 출력
    int idx = 0;
    for(idx=startNavNum; idx <=endNavNum; idx++){

        if(idx==pageNumNow){
          out.println("[<a href='index.jsp?pageNumNow="+idx+"'>"+idx+"</a>]");
        }else{
          out.println("<a href='index.jsp?pageNumNow="+idx+"'>"+idx+"</a>");
        }
    }

    // 다음 페이지 네비 표시
    if(nextNav){
      int next=startNavNum+pageNavCnt;
      if(next>totalPageNavCnt){
          next=totalPageNavCnt;
      }
      out.println("<a href='index.jsp?pageNumNow="+next+"'>"+">>"+"</a>");
    }

    out.println("<br>");
%>
</div>
<div id="btn_write">
<%
    out.println("<a href='write.jsp?pageNumNow="+pageNumNow+"' ><input type='button' value='글쓰기'></a>");

  %>
</div>

  </body>
</html>
