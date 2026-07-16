<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%

'┌┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┐
'  小鱼儿外贸网站管理系统V3.8中英版

'  程序作者：小鱼儿

'  购买正版官方唯一QQ:195094303

'  未经授权使用必究法律责任，后果自负
'└┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┘

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<title><%=e_webname%> - SiteMap</title>
<meta name="keywords" content="<%=e_keywords%>" />
<meta name="description" content="<%=e_description%>" />
<meta name="author" content="Web Design：Shejifang QQ:195094303 E-mail:www@shejifang.org Website:http://www.shejifang.org" />
<style type="text/css">
<!--
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
a:active {
	text-decoration: none;
}
h1{font-size:16px;}
body,td,th {
	font-size: 12px;
	font-family: Arial,宋体;
}
-->
</style>
</head>

<body style="line-height:25px;">
<h1><%=e_webname%> - SiteMap</h1>

<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  xiaoyuer_e_menu  where show=false order by sort asc",conn,1,1
if rs.eof and rs.bof then
%>
<%else%>
<%do while not rs.eof%>
<a href="<%=webfolder%><%=rs("url")%>" title="<%=rs("name")%>"><%=rs("name")%></a> | 
<%
rs.movenext
loop
end if
rs.close
set rs=nothing
%>

<h1>Products Category</h1>
			<%
	  		set rs=server.createobject("adodb.recordset") 
      		sql="select * from xiaoyuer_big_class  ORDER BY sort asc "
  			rs.open sql,conn,1,1  
 		 	if rs.eof and rs.bof then 
    	 	response.write "<center>No Data</center>" 
 		 	else 
     	 	do while not rs.eof
	  		big_id=rs("big_id")
	  		e_name=rs("e_name")
			'html_url_en=rs("html_url_en")
			%>
            <div>●
<a href="../e_products/?big_id=<%=big_id%>" title="<%=e_name%>"><strong><%=e_name%></strong></a>

			<%
		    set rss=server.createobject("adodb.recordset") 
            sql="select * from xiaoyuer_small_class where big_id="&big_id&" order by sort asc"
			rss.open sql,conn,1,3
			if rss.eof then		
			%>
			<%
			else
			do while not rss.eof
			small_id=rss("small_id")
			e_name=rss("e_name")
			'html_url_en=rss("html_url_en")
			%>
            <div>○
<a href="../e_products/?big_id=<%=big_id%>&?small_id=<%=small_id%>" title="<%=e_name%>" ><%=e_name%></a>
			</div>
			<%
			rss.movenext
			loop
			end if
			rss.close
			set rss=nothing
			%>
            </div>
			<%
			rs.movenext
			loop
			end if
			rs.close
			set rs=nothing
			%>
<h1>Products List</h1>
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  xiaoyuer_products",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
<a href="../html_products/<%=rs("html_url_en")%>"  ><%=rs("e_cpmc")%> - <%=rs("cpbh")%></a> |
<%rs.movenext
loop
%>
<%
end if
rs.close
set rs=nothing
%>
<h1>News Category</h1>
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  xiaoyuer_e_news_class",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
<div>●<a href="../e_news/?class_id=<%=rs("class_id")%>"  ><%=rs("name")%></a></div>
<%rs.movenext
loop
%>
<%
end if
rs.close
set rs=nothing
%>
<h1>News List</h1>
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  xiaoyuer_e_news",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
<a href="../html_news/<%=rs("html_url")%>"  ><%=rs("name")%></a> |
<%rs.movenext
loop
%>
<%
end if
rs.close
set rs=nothing
%>
</body>
</html>
