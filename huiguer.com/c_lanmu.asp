<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="中文单栏目管理"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<!--#include file="../pub/godaddy.asp"-->
<!-- #INCLUDE file="../yuzhiguoeditor/fckeditor.asp" -->
<meta name="author" content="Web Design：Yuzhiguo QQ:286313315 E-mail:vip@yuzhiguo.com Website:http://www.yuzhiguo.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<%
dim filename,id,keywords,paixu,action
filename="c_lanmu.asp"'页面名称
id=trim(request("id"))
keywords=trim(request("keywords"))

if trim(request("paixu"))<>"" then
paixu=trim(request("paixu"))
else
paixu="id"'默认按排序排序
end if

if trim(request("page"))<>"" then
page=trim(request("page"))
else
page=1
end if

if trim(request("pagesize"))<>"" then
pagesize=trim(request("pagesize"))
else
pagesize=10'默认一页显示数
end if

if trim(request("xu"))<>"" then
xu=trim(request("xu"))
else
xu="asc"'默认升序排
end if
%>
<%
if request("action") = "add" then
call add()
elseif request("action")="edit" then
call edit()
elseif request("action")="savenew" then
call savenew()
elseif request("action")="savedit" then
call savedit()
elseif request("action")="del" then
call del()
elseif request("action")="delAll" then
call delAll()
else
call List()
end if

sub List()
%>
<table width="99%" border="0" cellspacing="1" cellpadding="3"  align=center class="a2" style="margin-bottom:5px;">
<tr>
<form name="form1" method="get" action="<%=filename%>">
<td height="25" bgcolor="f7f7f7" class="a1">

搜索：
<input name="keywords" type="text" id="keywords" value="<%=keywords%>">
<input type="submit" name="Submit2" value="搜索">

<select name="jumpMenu_paixu" id="jumpMenu_paixu" onChange="location=this.options[this.selectedIndex].value" >
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=id&amp;keywords=<%=keywords%>" <% if paixu="id" then %>selected<% end if %>>按【默认】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=name&amp;keywords=<%=keywords%>" <% if paixu="name" then %>selected<% end if %>>按【栏目名称】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=id&amp;keywords=<%=keywords%>" <% if paixu="id" then %>selected<% end if %>>按【链接地址】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=sort&amp;keywords=<%=keywords%>" <% if paixu="sort" then %>selected<% end if %>>按【排序】排序</option>
</select>

<select name="jumpMenu_xu" id="jumpMenu_xu" onChange="location=this.options[this.selectedIndex].value" >
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=asc&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" <% if xu="asc" then %>selected<% end if %>>【升序】</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=desc&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" <% if xu="desc" then %>selected<% end if %>>【降序】</option>
</select>

<select name="jumpMenu_pagesize" id="jumpMenu_pagesize" onChange="location=this.options[this.selectedIndex].value" >
<option value="<%=filename%>?page=1&amp;pagesize=10&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" <% if pagesize="10" then %>selected<% end if %>>每页【10】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=20&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" <% if pagesize="20" then %>selected<% end if %>>每页【20】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=30&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" <% if pagesize="30" then %>selected<% end if %>>每页【30】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=40&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" <% if pagesize="40" then %>selected<% end if %>>每页【40】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=50&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" <% if pagesize="50" then %>selected<% end if %>>每页【50】条记录</option>
</select>
</td>
</form>
</tr>
</table>


<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" class="a2">
<form name="myform" method="POST" action="<%=filename%>?action=delAll">
<tr>
<td colspan="8" align=center class="a1">中文单栏目管理</td>
</tr>
<tr  style="font-weight:bold;">
<td height="30" align="center" class="a1">选择</td>
<td align="center" class="a1">ID</td>
<td height="30" align="center" class="a1">栏目名称</td>
<td align="center" class="a1">前台链接地址</td>
<td height="25" align="center" class="a1">排序</td>
<td align="center" class="a1">查看</td>
<td align="center" class="a1">静态</td>
<td height="25" align="center" class="a1">管理</td>
</tr>
<%
set rs=server.createobject("adodb.recordset")
sql ="select * from yuzhiguo_other where name like '%"&keywords&"%' or content like '%"&keywords&"%' order by "&paixu&" "&xu&""
Rs.Open Sql,Conn,1,1
page=request.QueryString("page")
if Isnumeric(page) then
page=cint(page)
if page<1 then page=1
else
page=1
end if
everypage=pagesize
rs.pagesize=everypage
if rs.bof and rs.eof then
%>
<tr >
  <td  colspan="8" align="center" class="red a3">没有数据</td>
  </tr>
<%
else
page_count=rs.pagecount
rs.AbsolutePage=page
j=0
n=1
%>
<% do while not rs.eof and j<rs.pagesize
%>
<tr class="a3"  onmouseover="this.style.backgroundColor='#EAFCD5';return true;"
onmouseout="this.style.backgroundColor='';return true;">
<td align="CENTER"><input type="checkbox" value="<%=rs("id")%>" name="id" onClick="unselectall(this.form)" style="border:0;" <% if rs("bixuan")=true then %>disabled<%end if%>>
<input name="pl_id" type="hidden" id="pl_id" value="<%=rs("id")%>"></td>
<td align="center"><%=rs("id")%></td>
<td align="center">
<input name="name" type="text" id="name" value="<%=rs("name")%>" size="20" maxlength="50" /></td>
<td align="center"><input name="html_url" type="text" disabled="disabled" id="html_url" value="c_html_info/<%=rs("html_url")%>" size="50" maxlength="255" />
  <a href="c_menu.asp?lanmuname=<%=Server.UrlEncode(rs("name"))%>&amp;lanmuurl=c_html_info/<%=rs("html_url")%>">加入中文导航</a></td>
<td align="center"><input name="sort" type="text" id="sort" value="<%=rs("sort")%>" size="4" maxlength="10" onKeyDown="myKeyDown()"></td>
<td align="center"><a href="../c_info/?id=<%=rs("id")%>" target="_blank">查看</a></td>
<td align="center"><a href="c_html_info.asp?action=html_id&amp;id=<%=rs("id")%>">生成</a></td>
<td align="center"><a href="<%=filename%>?action=edit&id=<%=rs("id")%>&page=<%=page%>">编辑</a></td>
</tr>
<%if n mod 1=0 then%>
<%end if%>
<%
n=n+1
j=j+1
rs.movenext
loop
end if%>
<tr class="a3"  onMouseOver="this.style.backgroundColor='#EAFCD5';this.style.color='red'" onMouseOut="this.style.backgroundColor='';this.style.color=''">
<td align="center"><input name="Action" type="hidden"  value="Del">
<input name="chkAll" type="checkbox" id="chkAll" onClick=CheckAll(this.form) value="checkbox" style="border:0"></td>
<td colspan="7">
<input name="Del" type="submit" id="Del"  onClick="JavaScript:return confirm('确定删除吗？')" value="批量删除">
<input name="Del" type="submit" id="Del" value="批量修改">
<input name="Del" type="submit" id="Del" value="添加">
<span class="hui">（提醒：栏目添加了不会自动显示在前台，需要“加入导航”才可以显示在前台）</span></td>
</tr>
<tr><td colspan="8" align="left">
<div class="page">
<span class="text">共<strong><%=rs.recordcount%></strong>条记录</span>
<span class="text"><strong><%=page%></strong>/<%=page_count%>页</span>
<%if page=1 then%>
<span class="disabled">首页</span><span class="disabled">上一页</span>
<%else%>
<a href="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" >首页</a>
<a href="<%=filename%>?page=<%=page-1%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" >上一页</a>
<%end if%>
<%for j=page-3 to page-1%>
<%if j>0 then%>
<a href="<%=filename%>?page=<%=j%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>"><%=j%></a>
<%end if%>
<%next%>
<%for j=page to page+3%>
<% if j<=page_count then%>
<%if j=page then%>
<span class="current"><%=j%></span>
<%else%>
<a href="<%=filename%>?page=<%=j%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>"><%=j%></a>
<%end if%>
<%end if%>
<% next%>
<%if page<page_count then%>
<a href="<%=filename%>?page=<%=page+1%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" >下一页</a>
<a href="<%=filename%>?page=<%=page_count%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" >末页</a>
<%else%>
<span class="disabled">下一页</span><span class="disabled">末页</span>
<%end if%>
</div>
</td>
</tr>
</form>
</table>

<%
rs.close
set rs=nothing
end sub

sub add()
%>
<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savenew" name="myform" method=post>
<tr>
<td colspan="3" align=center class="a1">添加中文单栏目</td>
</tr>
<tr>
<td width="20%" align="center" class="a3">栏目名称</td>
<td width="80%" colspan="2" class="a3"><input name="name" type="text" id="name" size="50" maxlength="50"></td>
</tr>

<tr>
  <td align="center" class="a3">静态文件名</td>
  <td colspan="2" class="a3"><input name="html_url" type="text" id="html_url" size="60" maxlength="255" />
    .html （提醒：如不填写则以栏目名称命名，一经设置不可更改，中文文字自动转化为拼音）</td>
</tr>
<tr>
<td align="center" class="a3">title</td>
<td colspan="2" class="a3"><input name="title" type="text" id="title" size="80" maxlength="255" /></td>
</tr>
<tr>
  <td align="center" class="a3">keywords</td>
  <td colspan="2" class="a3"><textarea name="keywords" cols="80" rows="3" id="keywords"></textarea>
    <span class="hui">（提醒：不要超过255个字符）</span></td>
</tr>
<tr>
  <td align="center" class="a3">description</td>
  <td colspan="2" class="a3"><textarea name="description" cols="80" rows="3" id="description"></textarea>
    <span class="hui">（提醒：不要超过255个字符）</span></td>
</tr>
<tr>
  <td align="center" class="a3">栏目内容</td>
  <td colspan="2" class="a3"><%
Dim sBasePath
sBasePath = Request.ServerVariables("PATH_INFO")
sBasePath = Left( sBasePath, InStrRev( sBasePath, "/_samples" ) )

Dim oFCKeditor
Set oFCKeditor = New FCKeditor
oFCKeditor.BasePath	= sBasePath
oFCKeditor.Value	= ""
oFCKeditor.Create "content"
%><input name="sSaveFileSelect" type="checkbox"  id="sSaveFileSelect" value="True">
保存远程图片到本站</td>
</tr>

<tr>
<td align="center" class="a3">排序</td>
<td colspan="2" class="a3"><input name="sort" type="text" id="sort" value="0" size="4" maxlength="10" /></td>
</tr>
<tr>
<td width="20%" align="center" class="a3"></td>
<td colspan="2" class="a3"><input name="Submit" type="submit" value="添 加"></td>
</tr>
</form>
</table>
<%
end sub

sub savenew()
name=trim(request.form("name"))
html_url=trim(request.form("html_url"))
title=trim(request.form("title"))
keywords=left(trim(request.form("keywords")),255)
description=left(trim(request.form("description")),255)
content=replace(trim(request.form("content")),zimulu,"")
sort=trim(request.form("sort"))
sSaveFileSelect =request.Form("sSaveFileSelect")

if name="" then
Call Alert ("请填写完整再提交！","-1")
end if
If sort="" Then sort=0
set rs = server.CreateObject ("adodb.recordset")
'sql="select * from yuzhiguo_other Where name='"&name&"'"
sql="select * from yuzhiguo_other "
rs.open sql,conn,1,3
'if rs.eof and rs.bof then
rs.AddNew

rs("name")=name

if title="" then
rs("title")=name
else
rs("title")=title
end if

if keywords="" then
rs("keywords")=name
else
rs("keywords")=keywords
end if

if description="" then
rs("description")=name
else
rs("description")=description
end if

'rs("content")=content
	If sSaveFileSelect="True" Then
	rs("Content")=ReplaceRemoteUrl(Content,"/pic/other/",sFileExt)
	Else
	rs("Content")=Content
	End If
rs("sort")=sort

rs.update

if html_url<>"" then
rs("html_url")=cn2en(html_url)+"-"+Cstr(rs("id"))+".html"
else
rs("html_url")=cn2en(rs("name"))+"-"+Cstr(rs("id"))+".html"
end if
id=rs("id")
rs.update

'Else
'Call Alert ("该记录已经存在！",-1)
'End if
rs.close
set rs=nothing

set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_other where id="&id&""
rs.open sql,conn,1,1
host="c_info/?id="+Cstr(rs("id"))'前台动态地址
folder="../c_html_info/"'文件夹
html_url_name=rs("html_url")
Fso_info host,folder,html_url_name
rs.close
set rs=nothing

Call Alert ("添加成功！",""&filename&"")

end sub

sub edit()
id=request("id")
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_other where id="& id &""
rs.open sql,conn,1,1
%>
<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savedit" name="myform" method=post>
<tr>
<td colspan="3" align=center class="a1">修改中文单栏目</td>
</tr>
<tr>
<td width="20%" align="center" class="a3">栏目名称</td>
<td width="80%" colspan="2" class="a3"><input name="name" type="text" id="name" value="<%=rs("name")%>" size="50" maxlength="50"></td>
</tr>

<tr>
  <td align="center" class="a3">静态文件名</td>
  <td colspan="2" class="a3"><input name="html_url" type="text" id="html_url" value="<%=rs("html_url")%>" size="60" maxlength="255" disabled="disabled"/></td>
</tr>
<tr>
<td align="center" class="a3">title</td>
<td colspan="2" class="a3"><input name="title" type="text" id="title" value="<%=rs("title")%>" size="80" maxlength="255" /></td>
</tr>
<tr>
  <td align="center" class="a3">keywords</td>
  <td colspan="2" class="a3"><textarea name="keywords" cols="80" rows="3" id="keywords"><%=rs("keywords")%></textarea>
    <span class="hui">（提醒：不要超过255个字符）</span></td>
</tr>
<tr>
  <td align="center" class="a3">description</td>
  <td colspan="2" class="a3"><textarea name="description" cols="80" rows="3" id="description"><%=rs("description")%></textarea>
    <span class="hui">（提醒：不要超过255个字符）</span></td>
</tr>
<tr>
  <td align="center" class="a3">栏目内容</td>
  <td colspan="2" class="a3"><%
Dim sBasePath
sBasePath = Request.ServerVariables("PATH_INFO")
sBasePath = Left( sBasePath, InStrRev( sBasePath, "/_samples" ) )

Dim oFCKeditor
Set oFCKeditor = New FCKeditor
oFCKeditor.BasePath	= sBasePath
oFCKeditor.Value	= rs("content")
oFCKeditor.Create "content"
%><input name="sSaveFileSelect" type="checkbox"  id="sSaveFileSelect" value="True">
保存远程图片到本站</td>
</tr>

<tr>
<td align="center" class="a3">排序</td>
<td colspan="2" class="a3"><input name="sort" type="text" id="sort" value="<%=rs("sort")%>" size="4" maxlength="10" /></td>
</tr>
<tr>
<td width="20%" align="center" class="a3"><input name="id" type="hidden" id="id" value="<%=rs("id")%>">
<input name="page" type="hidden" id="page" value="<%=page%>"></td>
<td colspan="2" class="a3"><input name="Submit" type="submit" value="修 改"></td>
</tr>
</form>
</table>
<%
end sub

sub savedit()
name=trim(request.form("name"))
title=trim(request.form("title"))
keywords=left(trim(request.form("keywords")),255)
description=left(trim(request.form("description")),255)
content=replace(trim(request.form("content")),zimulu,"")
sort=trim(request.form("sort"))
sSaveFileSelect =request.Form("sSaveFileSelect")

if name="" then
Call Alert ("请填写完整！","-1")
end if
If sort="" Then sort=0
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_other where id="&id&""
rs.open sql,conn,1,3
if not(rs.eof and rs.bof) then

rs("name")=name

if title="" then
rs("title")=name
else
rs("title")=title
end if

if keywords="" then
rs("keywords")=name
else
rs("keywords")=keywords
end if

if description="" then
rs("description")=name
else
rs("description")=description
end if

'rs("content")=content
	If sSaveFileSelect="True" Then
	rs("Content")=ReplaceRemoteUrl(Content,"/pic/other/",sFileExt)
	Else
	rs("Content")=Content
	End If
rs("sort")=sort

rs.update

host="c_info/?id="+Cstr(rs("id"))'前台动态地址
folder="../c_html_info/"'文件夹
html_url_name=rs("html_url")
Fso_info host,folder,html_url_name

Call Alert ("修改成功！",""&filename&"?page="&page&"")
else
Call Alert ("修改错误！",-2)
end if
rs.close
set rs=nothing
end sub

Sub delAll
If id="" And Request("Del")<>"批量修改" And Request("Del")<>"添加" Then
Call Alert ("请选择记录!","-1")
ElseIf Request("Del")="批量删除" Then
Server.ScriptTimeout=99999999

Dim del_id
For i=1 to request.form("id").count
del_id=replace(request.form("id")(i),"'","")
set rs_del = server.CreateObject ("adodb.recordset")
rs_del.open "select * from [yuzhiguo_other]  where id="&del_id,conn,1,1

sql="delete from [yuzhiguo_other] where id="&del_id
file_html="../c_html_info/"+rs_del("html_url")'定义要删除的文件
conn.execute sql

file_delete file_html

file_url=replace(file_html,"../","")'删除栏目同时删除导航链接
set rs=conn.execute("delete from yuzhiguo_menu where url='"&file_url&"'")

next
Call Alert ("批量删除成功",""&filename&"")
ElseIf Request("Del")="批量修改" Then
Server.ScriptTimeout=99999999
Dim pl_id,name,url,sort
For i=1 to request.form("pl_id").count
pl_id=replace(request.form("pl_id")(i),"'","")
name=replace(request.form("name")(i),"'","")
sort=replace(request.form("sort")(i),"'","")
If replace(request.form("sort")(i),"'","")="" Then sort=0
set rs=conn.Execute("select * from yuzhiguo_other where id="&pl_id)
conn.Execute("update yuzhiguo_other set name='"&name&"',sort="&sort&" where id="&pl_id)
next
Call Alert ("批量修改成功",""&filename&"")
ElseIf Request("Del")="添加" Then
response.redirect""&filename&"?action=add"
response.end
End If
End Sub
%>
<!--#include file="foot.asp"-->
</body>
</html>
