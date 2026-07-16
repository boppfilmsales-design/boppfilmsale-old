<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<!--#include file="../pub/function.asp"-->
<% dim class_id
class_id=trim(request("class_id"))
if class_id<>"" then
set rs_class=conn.execute("select * from yuzhiguo_news_class where class_id="&class_id&"")
if rs_class.eof and rs_class.bof then

else
class_name=rs_class("name")+","
class_name_weizhi="> "+rs_class("name")
end if
rs_class.close
set rs_class=nothing
end if
%>
<title><%=class_name%>新闻动态,<%=yuzhiguo_webname%></title>
<meta name="keywords" content="<%=yuzhiguo_keywords%>" />
<meta name="description" content="<%=yuzhiguo_description%>" />
<meta name="author" content="慧谷设计,QQ:995226433"  />
<link href="../css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div align="center">
  <!--#include file="../pub/c_top.asp"-->
  <!--#include file="../pub/flash.asp"-->
  <table width="1000" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
      <td width="230" valign="top">
      <!--#include file="../pub/c_left.asp"-->
      </td>
      <td width="10"></td>
      <td width="740" valign="top">
<div id="right_main">
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td bgcolor="#E6F2EF" align="left">   <div class="iproducts">
	  <div class="products_ico"><div align="center"></div></div>
	  <div class="products_title"><span class="ztitle"><a href="/index_cn.html" target="_self">首页</a> &gt; <a href="/c_news/" target="_parent">新闻动态</a> </span></div>
	  
    </div></td>
    </tr>
  <tr>
    <td valign="top">
    <div class="hangju" align="left">
   <table width="100%"  border="0" align="center" cellpadding="5"  cellspacing="0">
<%
dim page
page=trim(request("page"))
if page="" and not isnumeric(page) then
page=1
end if
filename=""'当前页面文件名称
Set Rs=Server.CreateObject("ADODB.Recordset")

	if class_id="" then 
    sql="select * from yuzhiguo_news order by sort desc,id desc"
	else
	sql ="select * from yuzhiguo_news where class_id="&class_id&" order by sort desc,id desc"
	end if
rs.open sql,conn,1,1
if rs.eof then
%>
<tr align="center" >
<td height="25"><center>没有数据</center></td>
</tr>
<%
else
rs.pagesize=news_page '一页新闻数
currentpage=Clng(page)
if currentpage<1 then currentpage=1
if currentpage>rs.pagecount then currentpage=rs.pagecount
rs.absolutepage=currentpage
Do While Not rs.Eof
%>
<tr onmouseover="this.style.backgroundColor='#F7F7F7';return true;"     
  onmouseout="this.style.backgroundColor='#FFFFFF';return true;" >
<td height="25">&nbsp;
<%
set rs_class=conn.execute("select * from yuzhiguo_news_class where class_id="&rs("class_id")&"")
if rs_class.eof and rs_class.bof then
else
%><div class="n_news_list">
<img src="../images/icon.gif" alt="" /> 
<a href="?class_id=<%=rs("class_id")%>">[<%=rs_class("name")%>]</a>
<%
end if
rs_class.close
%> <a href="../c_html_news/<%=rs("html_url")%>" target="_blank"> &nbsp;<%=rs("name")%></a> </div>
<div class="n_news_time"><%=rs("date")%></div></td>
</tr>
<%
i=i+1
rs.MoveNext
If i>=rs.pagesize Then Exit Do
Loop
%>

<tr>
<td> 
<div id="page">
<span class="text">新闻数: <b><%=rs.recordcount%></b></span> 
<span class="text">页次: <b><%=CurrentPage%></b> / <b><%=rs.pagecount%></b></span>

    <% if CurrentPage=1 then%>
    <span class="text">首页</span>
 	<span class="text">←上一页</span>
    <% else %>
 	<a href="<%=filename%>?page=1&amp;class_id=<%=class_id%>" >首页</a>
 	<a href="<%=filename%>?page=<%=currentpage-1%>&amp;class_id=<%=class_id%>" >←上一页</a>
    <% end if%>
    <% if CurrentPage<n then%>
    <a href="<%=filename%>?page=<%=currentpage+1%>&amp;class_id=<%=class_id%>">下一页→</a>
 	<a href="<%=filename%>?page=<%=rs.pagecount%>&amp;class_id=<%=class_id%>" >末页</a>
    <% else %>
    <span class="text">下一页→</span>
 	<span class="text">末页</span>
    <% end if%>
<select name="page" onchange="location=this.options[this.selectedIndex].value" >
<% for i=1 to rs.pagecount %>
<option value="<%=filename%>?page=<%=i%>&amp;class_id=<%=class_id%>" <% if i = CurrentPage then response.Write("selected='selected'")%> ><%=i%> 页</option>
<% next %>
</select>
</div></td>
</tr>

<%
end if
rs.close
set rs=nothing
%>
</table></div></td>
    </tr>
</table>
</div>
</td>
    </tr>
  </table>
  <!--#include file="../pub/c_foot.asp"-->
</div>

</body>
</html>
