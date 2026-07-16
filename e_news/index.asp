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
set rs_class=conn.execute("select * from yuzhiguo_e_news_class where class_id="&class_id&"")
if rs_class.eof and rs_class.bof then

else
class_name=rs_class("name")+","
class_name_weizhi="> "+rs_class("name")
end if
rs_class.close
set rs_class=nothing
end if
%>
<title><%=class_name%>News,<%=e_webname%></title>
<meta name="keywords" content="<%=e_keywords%>" />
<meta name="description" content="<%=e_description%>" />
<meta name="author" content="Web Design：Xiehui QQ:995226433@qq.com Website:http://huigur.taobao.com" />
<link href="../css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
</head>

<body>


  <!--#include file="../pub/e_top.asp"-->
<!--#include file="../pub/flash.asp"-->
<div class="main">
  <table width="1000" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
      <td width="230" valign="top">
      <!--#include file="../pub/e_left.asp"-->
      </td>
      <td width="10"></td>
      <td width="740" valign="top">
<div id="right_main">

<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td bgcolor="#E6F2EF"> <div class="iproducts">
	  <div class="products_ico"><div align="center"></div></div>
	  <div class="products_title"><span class="ztitle"><a href="/index_en.html" target="_self">Home</a> &gt; <a href="/e_news/" target="_parent">News Center</a> </span></div>
	  
    </div></td>
    </tr>
  <tr>
    <td valign="top">
    <div class="hangju">
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
    sql="select * from yuzhiguo_e_news order by sort desc,id desc"
	else
	sql ="select * from yuzhiguo_e_news where class_id="&class_id&" order by sort desc,id desc"
	end if
rs.open sql,conn,1,1
if rs.eof then
%>
<tr align="center" >
<td height="25"><center>No Data</center></td>
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
<tr onMouseOver="this.style.backgroundColor='#F7F7F7';return true;"     
  onmouseout="this.style.backgroundColor='#FFFFFF';return true;" >
  
  
  <td height="25">&nbsp;
<%
set rs_class=conn.execute("select * from yuzhiguo_e_news_class where class_id="&rs("class_id")&"")
if rs_class.eof and rs_class.bof then
else
%><div class="n_news_list">
<img src="../images/icon.gif" alt="" /> 
<a href="?class_id=<%=rs("class_id")%>">[<%=rs_class("name")%>]</a>
<%
end if
rs_class.close
%> <a href="../html_news/<%=rs("html_url")%>" target="_blank"> &nbsp;<%=rs("name")%></a> </div>
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
<span class="text">Total News: <b><%=rs.recordcount%></b></span> 
<span class="text">Page: <b><%=CurrentPage%></b> of <b><%=rs.pagecount%></b></span>
    <% if CurrentPage=1 then%>
    <span class="text">First</span>
 	<span class="text">←Previous</span>
    <% else %>
 	<a href="<%=filename%>?page=1&amp;class_id=<%=class_id%>" >First</a>
 	<a href="<%=filename%>?page=<%=currentpage-1%>&amp;class_id=<%=class_id%>" >←Previous</a>
    <% end if%>
    <% if CurrentPage<n then%>
    <a href="<%=filename%>?page=<%=currentpage+1%>&amp;class_id=<%=class_id%>">Next→</a>
 	<a href="<%=filename%>?page=<%=rs.pagecount%>&amp;class_id=<%=class_id%>" >End</a>
    <% else %>
    <span class="text">Next→</span>
 	<span class="text">End</span>
    <% end if%>
<select name="page" onChange="location=this.options[this.selectedIndex].value" >
<% for i=1 to rs.pagecount %>
<option value="<%=filename%>?page=<%=i%>&amp;class_id=<%=class_id%>" <% if i = CurrentPage then response.Write("selected='selected'")%> ><%=i%> page</option>
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

</div>
  <!--#include file="../pub/e_foot.asp"-->
</body>
</html>
