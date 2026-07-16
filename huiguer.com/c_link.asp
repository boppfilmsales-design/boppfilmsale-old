<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="中文友情链接管理"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<meta name="author" content="Web Design：Yuzhiguo QQ:286313315 E-mail:vip@yuzhiguo.com Website:http://www.yuzhiguo.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<%
dim filename,id,keywords,paixu,action
filename="c_link.asp"'页面名称
id=trim(request("id"))
keywords=trim(request("keywords"))

if trim(request("paixu"))<>"" then
paixu=trim(request("paixu"))
else
paixu="sort"'默认按排序排序
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
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=link_id&amp;keywords=<%=keywords%>" <% if paixu="link_id" then %>selected<% end if %>>按【默认】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=name&amp;keywords=<%=keywords%>" <% if paixu="name" then %>selected<% end if %>>按【链接名称】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=url&amp;keywords=<%=keywords%>" <% if paixu="url" then %>selected<% end if %>>按【链接地址】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=class_id&amp;keywords=<%=keywords%>" <% if paixu="class_id" then %>selected<% end if %>>按【链接类型】排序</option>
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
<form action="<%=filename%>?action=delAll" method="POST" name="myform1" id="myform1">
<tr>
<td colspan="9" align=center class="a1">中文友情链接管理</td>
</tr>
<tr  style="font-weight:bold;">
<td height="30" align="center" class="a1">选择</td>
<td align="center" class="a1">ID</td>
<td height="30" align="center" class="a1">链接名称</td>
<td align="center" class="a1">链接地址</td>
<td align="center" class="a1">LOGO</td>
<td align="center" class="a1">类型</td>
<td align="center" class="a1">审核</td>
<td height="25" align="center" class="a1">排序</td>
<td height="25" align="center" class="a1">管理</td>
</tr>
<%
set rs=server.createobject("adodb.recordset")
sql ="select * from yuzhiguo_link where name like '%"&keywords&"%' or url like '%"&keywords&"%' order by "&paixu&" "&xu&""
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
  <td  colspan="9" align="center" class="red a3">没有数据</td>
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
<td align="CENTER"><input type="checkbox" value="<%=rs("link_id")%>" name="id" onClick="unselectall(this.form)" style="border:0;">
<input name="pl_id" type="hidden" id="pl_id" value="<%=rs("link_id")%>"></td>
<td align="center"><%=rs("link_id")%></td>
<td align="center">
<input name="name" type="text" id="name" value="<%=rs("name")%>" size="20" maxlength="255" /></td>
<td align="center"><input name="url" type="text" id="url" value="<%=rs("url")%>" size="35" maxlength="255"></td>
<td align="center"><%if rs("logo")<>"" then%>
<a href="<%=rs("logo")%>" target="_blank">
<img src="<%=rs("logo")%>" onload="javascript:if(this.width&gt;120) this.width=120;"  border="0"></a>
<%else%>
无图
<%end if%></td>
<td align="center"><select name="class_id" id="class_id">
  <option value="1" <%if rs("class_id")=1 then response.write"selected" end if%> style="color:#FF0000;">图片</option>
  <option value="0" <%if rs("class_id")=0 then response.write"selected" end if%>>文字</option>
</select></td>
<td align="center"><select name="show" id="show">
  <option value="1" <%if rs("show")=true then response.write"selected" end if%> style="color:#FF0000;">是</option>
  <option value="0" <%if rs("show")=false then response.write"selected" end if%>>否</option>
</select></td>
<td align="center"><input name="sort" type="text" id="sort" value="<%=rs("sort")%>" size="4" maxlength="10" onKeyDown="myKeyDown()"></td>
<td align="center"><a href="<%=filename%>?action=edit&id=<%=rs("link_id")%>&page=<%=page%>">编辑</a></td>
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
<td colspan="8">
<input name="Del" type="submit" id="Del"  onClick="JavaScript:return confirm('确定删除吗？')" value="批量删除">
<input name="Del" type="submit" id="Del" value="批量修改">
<!--<input name="Del" type="submit" id="Del" value="添加">-->
<span class="hui">（提醒：友情链接只在<strong>首页底部显示</strong>，如果不想前台显示友情链接，请删除所有链接）</span></td>
</tr>
<tr><td colspan="9" align="left">
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
'end sub

'sub add()
%><br />

<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savenew" name="myform" method=post>
<tr>
<td colspan="3" align=center class="a1">添加中文友情链接</td>
</tr>
<tr>
<td width="20%" align="center" class="a3">链接名称</td>
<td width="80%" colspan="2" class="a3"><input name="name" type="text" id="name" size="50" maxlength="255"></td>
</tr>

<tr>
<td align="center" class="a3">链接地址</td>
<td colspan="2" class="a3"><input name="url" type="text" id="url" value="http://" size="50" maxlength="255" />
  （网址必须http://开头）</td>
</tr>
<tr>
  <td align="center" class="a3">链接类型</td>
  <td colspan="2" class="a3"><select name="class_id" id="class_id">
  <option value="1" style="color:#FF0000;">图片</option>
  <option value="0" selected="selected" >文字</option>
  </select></td>
</tr>
<tr>
  <td align="center" class="a3">LOGO</td>
  <td colspan="2" class="a3"><input name="logo" type="text" id="logo" size="50" maxlength="255" /> <input type="button" name="submit1"  id="submit" value="上传logo" onClick="window.open('pic_upload_flash.asp?formname=myform&editname=logo&uppath=../pic/link&filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')"></td>
</tr>
<tr>
  <td align="center" class="a3">是否审核</td>
  <td colspan="2" class="a3"><select name="show" id="show">
  <option value="1" selected="selected" style="color:#FF0000;">是</option>
  <option value="0" >否</option>
  </select>
    （选“是”才会在前台显示）</td>
</tr>
<tr>
<td align="center" class="a3">排序</td>
<td colspan="2" class="a3"><input name="sort" type="text" id="sort" value="<%=n%>" size="4" maxlength="10" /></td>
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
url=trim(request.form("url"))
class_id=trim(request.form("class_id"))
logo=trim(request.form("logo"))
show=trim(request.form("show"))
sort=trim(request.form("sort"))

if name="" or url="" then
Call Alert ("请填写完整再提交！","-1")
end if
If sort="" Then sort=1
set rs = server.CreateObject ("adodb.recordset")
'sql="select * from yuzhiguo_link Where name='"&name&"'"
sql="select * from yuzhiguo_link "
rs.open sql,conn,1,3
'if rs.eof and rs.bof then
rs.AddNew
rs("name")=name
rs("url")=url
rs("class_id")=class_id
rs("logo")=logo
rs("show")=show
rs("sort")=sort
rs.update
Call Alert ("添加成功！",""&filename&"")
'Else
'Call Alert ("该记录已经存在！",-1)
'End if
rs.close
set rs=nothing
end sub

sub edit()
id=request("id")
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_link where link_id="& id &""
rs.open sql,conn,1,1
%>
<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savedit" name="myform" method=post>
<tr>
<td colspan="3" align=center class="a1">修改中文友情链接</td>
</tr>
<tr>
<td width="20%" align="center" class="a3"><span class="a3">链接名称</span></td>
<td width="80%" colspan="2" class="a3"><input name="name" type="text" id="name" value="<%=rs("name")%>" size="50" maxlength="255"></td>
</tr>

<tr>
<td align="center" class="a3">链接地址</td>
<td colspan="2" class="a3"><input name="url" type="text" id="url" value="<%=rs("url")%>" size="50" maxlength="255" />
  （网址必须http://开头）</td>
</tr>
<tr>
  <td align="center" class="a3">链接类型</td>
  <td colspan="2" class="a3"><select name="class_id" id="class_id">
  <option value="1" <%if rs("class_id")=1 then response.write"selected" end if%> style="color:#FF0000;">图片</option>
  <option value="0" <%if rs("class_id")=0 then response.write"selected" end if%>>文字</option>
</select></td>
</tr>
<tr>
  <td align="center" class="a3">LOGO</td>
  <td colspan="2" class="a3"><input name="logo" type="text" id="logo" value="<%=rs("logo")%>" size="50" maxlength="255" /> <input type="button" name="submit1"  id="submit" value="上传logo" onClick="window.open('pic_upload_flash.asp?formname=myform&editname=logo&uppath=../pic/link&filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')"></td>
</tr>
<tr>
  <td align="center" class="a3">是否审核</td>
  <td colspan="2" class="a3"><select name="show" id="show">
  <option value="1" <%if rs("show")=true then response.write"selected" end if%> style="color:#FF0000;">是</option>
  <option value="0" <%if rs("show")=false then response.write"selected" end if%>>否</option>
</select>
    （选“是”才会在前台显示）</td>
</tr>
<tr>
<td align="center" class="a3">排序</td>
<td colspan="2" class="a3"><input name="sort" type="text" id="sort" value="<%=rs("sort")%>" size="4" maxlength="10" /></td>
</tr>
<tr>
<td width="20%" align="center" class="a3"><input name="id" type="hidden" id="id" value="<%=rs("link_id")%>">
<input name="page" type="hidden" id="page" value="<%=page%>"></td>
<td colspan="2" class="a3"><input name="Submit" type="submit" value="修 改"></td>
</tr>
</form>
</table>
<%
end sub

sub savedit()
name=trim(request.form("name"))
url=trim(request.form("url"))
class_id=trim(request.form("class_id"))
logo=trim(request.form("logo"))
show=trim(request.form("show"))
sort=trim(request.form("sort"))

if name="" or url="" then
Call Alert ("请填写完整！","-1")
end if
If sort="" Then sort=0
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_link where link_id="&id&""
rs.open sql,conn,1,3
if not(rs.eof and rs.bof) then

rs("name")=name
rs("url")=url
rs("class_id")=class_id
rs("logo")=logo
rs("show")=show
rs("sort")=sort

rs.update
Call Alert ("修改成功！",""&filename&"?page="&page&"")
else
Call Alert ("修改错误！",-2)
end if
rs.close
set rs=nothing
end sub

Sub delAll
'If id="" And Request("Del")<>"批量修改" And Request("Del")<>"添加" Then
If id="" And Request("Del")<>"批量修改"  Then
Call Alert ("请选择记录!","-1")
ElseIf Request("Del")="批量删除" Then
set rs=conn.execute("delete from yuzhiguo_link where link_id In(" & id & ")")
Call Alert ("批量删除成功",""&filename&"")
ElseIf Request("Del")="批量修改" Then
Server.ScriptTimeout=99999999
Dim pl_id,name,url,sort
For i=1 to request.form("pl_id").count
pl_id=replace(request.form("pl_id")(i),"'","")
name=replace(request.form("name")(i),"'","")
url=replace(request.form("url")(i),"'","")
class_id=replace(request.form("class_id")(i),"'","")
show=replace(request.form("show")(i),"'","")
sort=replace(request.form("sort")(i),"'","")
If replace(request.form("sort")(i),"'","")="" Then sort=0
set rs=conn.Execute("select * from yuzhiguo_link where link_id="&pl_id)
conn.Execute("update yuzhiguo_link set name='"&name&"',url='"&url&"',class_id="&class_id&",show="&show&",sort="&sort&" where link_id="&pl_id)
next
Call Alert ("批量修改成功",""&filename&"")
'ElseIf Request("Del")="添加" Then
'response.redirect""&filename&"?action=add"
'response.end
End If
End Sub
%>
<!--#include file="foot.asp"-->
</body>
</html>
