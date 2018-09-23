<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018-09-21
  Time: 오전 2:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        input[type="text"], input[type="password"], textarea{
            width: 100%;
            margin: 0px auto 20px auto;
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
    <title>글쓰기</title>
    <script>
        window.onload=function(){
            document.getElementById("writer").focus();
        }
        // 글쓰기 작성 폼 유효성 검사
        function validCheck(){
            var writer = document.getElementById("writer");
            var title = document.getElementById("title");
            var content = document.getElementById("content");
            var pwd = document.getElementById("pwd");

            if(writer.value.length<1 || writer.value.length>50){
                writer.focus();
                alert("글쓴이는 50자 이내로 작성해주세요.");
                return false;
            }

            if(title.value.length<1 || title.value.length>200){
                title.focus();
                alert("제목은 200자 이내로 작성해주세요.");
                return false;
            }

            if(content.value.length<1 || content.value.length>200){
                content.focus();
                alert("본문은 200자 이내로 작성해주세요.");
                return false;
            }

            if(pwd.value.length<4 || pwd.value.length>10){
                pwd.focus();
                alert("비밀번호는 4~8자 이내로 작성해주세요.");
                return false;
            }

        }
    </script>
</head>
<body>
    <h1>글쓰기</h1>
    <div id="wrap">
        <%
            String pageNumNow = request.getParameter("pageNumNow");
            out.println("<form  id=\"writeForm\" name=\"writeForm\" onsubmit=\"return validCheck();\" action=\"write_process.jsp?pageNumNow="+pageNumNow+"\" method=\"post\">");
        %>

            글쓴이<br>
            <input type="text" id="writer" name="writer" maxlength="50"><br>
            제목<br>
            <input type="text" id="title" name="title" maxlength="200"><br>
            내용<br>
            <textarea rows="5" cols="50" id="content" name="content" ></textarea><br>
            비밀번호<br>
            <input type="password" id="pwd" name="pwd" maxlength="8"><br>

            <div id="btn_footer">
                <%
                    out.print("<a href='index.jsp?pageNumNow="+pageNumNow+"'><input type=\"button\" value=\"취소\"></a>");
                %>

                <input type="submit" value="등록">
            </div>
        </form>
    </div>
</body>
</html>
