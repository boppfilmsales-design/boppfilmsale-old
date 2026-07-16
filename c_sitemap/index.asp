<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<title><%=yuzhiguo_webname%> - 网站地图</title>
<meta name="keywords" content="<%=yuzhiguo_keywords%>" />
<meta name="description" content="<%=yuzhiguo_description%>" />
<meta name="author" content="慧谷设计,QQ:995226433" />
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
</style></head>

<body style="line-height:25px;">
<h1><%=yuzhiguo_webname%> - 网站地图</h1>

<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_other",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
<a href="../c_html_info/<%=rs("html_url")%>" target="_blank" ><%=rs("name")%></a> |
<%rs.movenext
loop
%>
<%
end if
rs.close
set rs=nothing
%>
<h1>产品分类</h1>
			<%
	  		set rs=server.createobject("adodb.recordset") 
      		sql="select * from yuzhiguo_big_class  ORDER BY sort asc "
  			rs.open sql,conn,1,1  
 		 	if rs.eof and rs.bof then 
    	 	response.write "<center>没有数据</center>" 
 		 	else 
     	 	do while not rs.eof
	  		big_id=rs("big_id")
	  		name=rs("name")
			html_url_cn=rs("html_url_cn")
			%>
            <div>●
<a href="../c_products/?big_id=<%=big_id%>" title="<%=name%>"><strong><%=name%></strong></a>

			<%
		    set rss=server.createobject("adodb.recordset") 
            sql="select * from yuzhiguo_small_class where big_id="&big_id&" order by sort asc"
			rss.open sql,conn,1,3
			if rss.eof then		
			%>
			<%
			else
			do while not rss.eof
			small_id=rss("small_id")
			name=rss("name")
			html_url_cn=rss("html_url_cn")
			%>
            <div>○
<a href="../c_products/?big_id=<%=big_id%>&?small_id=<%=small_id%>" title="<%=name%>" ><%=name%></a>
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
<h1>产品列表</h1>
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_products",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
<a href="../c_html_products/<%=rs("html_url_cn")%>" target="_blank" ><%=rs("cpmc")%> - <%=rs("cpbh")%></a> |
<%rs.movenext
loop
%>
<%
end if
rs.close
set rs=nothing
%>
<h1>新闻分类</h1>
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_news_class",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
<div>●<a href="../c_news/?class_id=<%=rs("class_id")%>" target="_blank" ><%=rs("name")%></a></div>
<%rs.movenext
loop
%>
<%
end if
rs.close
set rs=nothing
%>
<h1>新闻列表</h1>
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_news",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
<a href="../c_html_news/<%=rs("html_url")%>" target="_blank" ><%=rs("name")%></a> |
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
