<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="产品小类管理"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<%
dim filename,id,paixu,action
filename="pro_small_class.asp"'页面名称
id=trim(request("id"))

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

if trim(request("big_id"))<>"" then
big_id=CInt(trim(request("big_id")))
else
big_id=0
end if
name=trim(request("name"))
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

<select name="jumpMenu_paixu" id="jumpMenu_paixu" onChange="location=this.options[this.selectedIndex].value" >
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=small_id&amp;big_id=<%=big_id%>" <% if paixu="small_id" then %>selected<% end if %>>按【默认】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=e_name&amp;big_id=<%=big_id%>" <% if paixu="e_name" then %>selected<% end if %>>按【英文小类名称】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=sort&amp;big_id=<%=big_id%>" <% if paixu="sort" then %>selected<% end if %>>按【排序】排序</option>
</select>

<select name="jumpMenu_xu" id="jumpMenu_xu" onChange="location=this.options[this.selectedIndex].value" >
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=asc&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" <% if xu="asc" then %>selected<% end if %>>【升序】</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=desc&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" <% if xu="desc" then %>selected<% end if %>>【降序】</option>
</select>

<select name="jumpMenu_pagesize" id="jumpMenu_pagesize" onChange="location=this.options[this.selectedIndex].value" >
<option value="<%=filename%>?page=1&amp;pagesize=10&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" <% if pagesize="10" then %>selected<% end if %>>每页【10】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=20&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" <% if pagesize="20" then %>selected<% end if %>>每页【20】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=30&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" <% if pagesize="30" then %>selected<% end if %>>每页【30】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=40&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" <% if pagesize="40" then %>selected<% end if %>>每页【40】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=50&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" <% if pagesize="50" then %>selected<% end if %>>每页【50】条记录</option>
</select>
</td>
</form>
</tr>
</table>


<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" class="a2">
<form name="myform" method="POST" action="<%=filename%>?action=delAll">
<tr>
<td colspan="7" align=center class="a1">产品小类管理</td>
</tr>
<tr  style="font-weight:bold;">
  <td height="30" colspan="7" align="left" class="a1">所属大类：<select name="select"  onChange="var jmpURL=this.options[this.selectedIndex].value ; if(jmpURL!='') {window.location=jmpURL;} else {this.selectedIndex=0 ;}"  style="color:#FF0000;">
<option value="<%=filename%>">选择产品大类</option>
<%set rs=server.createobject("adodb.recordset")
rs.Open "select * from yuzhiguo_big_class order by sort asc",conn,1,1
do while not rs.eof %>
<option value="<%=filename%>?big_id=<%=rs("big_id")%>&name=<%=rs("e_name")%>" <%if rs("big_id")=cint(request.QueryString("big_id")) then %>selected<%end if%>><%=trim(rs("name"))%>(<%=trim(rs("e_name"))%>)</option>
<%rs.movenext
loop
rs.close
set rs=nothing
%>
</select>
<%
if big_id=0 then
response.Write " <font color='#CCFFCC'>▲请选择产品大类</font>"
else
%></td>
  </tr>
<tr  style="font-weight:bold;">
<td height="30" align="center" class="a1">选择</td>
<td align="center" class="a1">ID</td>
<td align="center" class="a1">中文小类名称</td>
<td align="center" class="a1">英文小类名称</td>
<td align="center" class="a1">产品数量</td>
<td height="30" align="center" class="a1">排序</td>
<td height="30" align="center" class="a1">管理</td>
</tr>

<%
set rs=server.createobject("adodb.recordset")
sql ="select * from yuzhiguo_small_class where  big_id="&big_id&" order by "&paixu&" "&xu&""
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
  <td  colspan="7" align="center" class="red a3">没有数据</td>
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
<td align="CENTER"><input type="checkbox" value="<%=rs("small_id")%>" name="id" onClick="unselectall(this.form)" style="border:0;">
<input name="pl_id" type="hidden" id="pl_id" value="<%=rs("small_id")%>"></td>
<td align="center"><%=rs("small_id")%></td>
<td align="center"><input name="name" type="text" id="name" value="<%=rs("name")%>" size="30" maxlength="255" /></td>
<td align="center"><input name="e_name" type="text" id="e_name" value="<%=rs("e_name")%>" size="30" maxlength="255"></td>
<td align="center"><a href="pro_manage.asp?big_id=<%=rs("big_id")%>&amp;small_id=<%=rs("small_id")%>&amp;paixu=id">[ <%=Mydb("Select Count([id]) From [yuzhiguo_products] where [small_id]="&rs("small_id")&"",1)(0)%> ]</a></td>
<td align="center"><input name="sort" type="text" id="sort" value="<%=rs("sort")%>" size="4" maxlength="10" onKeyDown="myKeyDown()"></td>
<td align="center"><a href="<%=filename%>?action=edit&id=<%=rs("small_id")%>&page=<%=page%>">编辑</a></td>
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
<td colspan="6">
<input name="Del" type="submit" id="Del"  onClick="JavaScript:return confirm('确定删除吗？')" value="批量删除">
<input name="Del" type="submit" id="Del" value="批量修改"><input name="big_id" type="hidden" id="big_id" value="<%=big_id%>"></td>
</tr>
<tr><td colspan="7" align="left">
<div class="page">
<span class="text">共<strong><%=rs.recordcount%></strong>条记录</span>
<span class="text"><strong><%=page%></strong>/<%=page_count%>页</span>
<%if page=1 then%>
<span class="disabled">首页</span><span class="disabled">上一页</span>
<%else%>
<a href="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" >首页</a>
<a href="<%=filename%>?page=<%=page-1%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" >上一页</a>
<%end if%>
<%for j=page-3 to page-1%>
<%if j>0 then%>
<a href="<%=filename%>?page=<%=j%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>"><%=j%></a>
<%end if%>
<%next%>
<%for j=page to page+3%>
<% if j<=page_count then%>
<%if j=page then%>
<span class="current"><%=j%></span>
<%else%>
<a href="<%=filename%>?page=<%=j%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>"><%=j%></a>
<%end if%>
<%end if%>
<% next%>
<%if page<page_count then%>
<a href="<%=filename%>?page=<%=page+1%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" >下一页</a>
<a href="<%=filename%>?page=<%=page_count%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>" >末页</a>
<%else%>
<span class="disabled">下一页</span><span class="disabled">末页</span>
<%end if%>
</div>
</td>
</tr>
</form>
</table>

<br />

<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savenew" name="myform" method=post>
<tr>
<td colspan="4" align=center class="a1">添加产品小类</td>
</tr>
<tr>
  <td align="center" class="a3">所属产品大类</td>
  <td colspan="3" class="a3">
  <%
  set rs_big=server.createobject("adodb.recordset")
rs_big.open "select * from yuzhiguo_big_class order by sort",conn,1,1
if rs_big.eof and rs_big.bof then
response.write "请先添加产品大类"
response.end
else
%>
    <select name="big_id" id="select"><%
do while not rs_big.eof
%>
      <option value="<%=rs_big("big_id")%>" <%if rs_big("big_id")=big_id then%>selected<%end if%>><%=trim(rs_big("name"))%>(<%=trim(rs_big("e_name"))%>)</option>
      
      
<%
rs_big.movenext
loop
end if
rs_big.close
%>
    </select></td>
</tr>


<tr>
<td align="center" class="a3">中文分类名称</td>
<td class="a3"><input name="name" type="text" id="name" size="50" maxlength="255" /></td>
<td class="a3">英文分类名称</td>
<td class="a3"><input name="e_name" type="text" id="e_name" size="50" maxlength="255" /></td>
</tr>

<tr>
<td align="center" class="a3">排序</td>
<td colspan="3" class="a3"><input name="sort" type="text" id="sort" value="<%=n%>" size="4" maxlength="10" /></td>
</tr>
<tr>
<td align="center" class="a3"></td>
<td colspan="3" class="a3"><input name="Submit" type="submit" value="添 加"></td>
</tr>
</form>
</table>
<%
rs.close
set rs=nothing
end if
%>
<%
end sub

sub savenew()
name=trim(request.form("name"))
e_name=trim(request.form("e_name"))
sort=trim(request.form("sort"))

if  name="" or e_name="" then
Call Alert ("请填写完整再提交！","-1")
end if
If sort="" Then sort=1
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_small_class "
rs.open sql,conn,1,3
rs.AddNew
rs("big_id")=big_id
rs("name")=name
rs("e_name")=e_name
rs("sort")=sort
rs.update

rs.close
set rs=nothing
Call Alert ("添加成功！",""&filename&"?big_id="&big_id&"")
end sub

sub edit()
id=request("id")
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_small_class where small_id="& id &""
rs.open sql,conn,1,1
%>
<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savedit" name="myform" method=post>
<tr>
<td colspan="4" align=center class="a1">修改产品小类</td>
</tr>
<tr>
  <td align="center" class="a3">所属产品大类</td>
  <td colspan="3" class="a3"><%
  set rs_big=server.createobject("adodb.recordset")
rs_big.open "select * from yuzhiguo_big_class order by sort",conn,1,1
if rs_big.eof and rs_big.bof then
response.write "请先添加产品大类"
response.end
else
%>
    <select name="big_id" id="select"  ><%
do while not rs_big.eof
%>
      <option value="<%=rs_big("big_id")%>" <%if rs_big("big_id")=rs("big_id") then%>selected<%end if%>><%=trim(rs_big("name"))%>(<%=trim(rs_big("e_name"))%>)</option>
      
      
<%
rs_big.movenext
loop
end if
rs_big.close
%>
    </select></td>
</tr>


<tr>
<td align="center" class="a3">英文分类名称</td>
<td class="a3"><input name="name" type="text" id="name" value="<%=rs("name")%>" size="50" maxlength="255" /></td>
<td class="a3">英文分类名称</td>
<td class="a3"><input name="e_name" type="text" id="e_name" value="<%=rs("e_name")%>" size="50" maxlength="255" /></td>
</tr>

<tr>
<td align="center" class="a3">排序</td>
<td colspan="3" class="a3"><input name="sort" type="text" id="sort" value="<%=rs("sort")%>" size="4" maxlength="10" /></td>
</tr>
<tr>
<td align="center" class="a3"><input name="id" type="hidden" id="id" value="<%=rs("small_id")%>">
<input name="page" type="hidden" id="page" value="<%=page%>"></td>
<td colspan="3" class="a3"><input name="Submit" type="submit" value="修 改"></td>
</tr>
</form>
</table>
<%
end sub

sub savedit()
big_id=trim(request.form("big_id"))
name=trim(request.form("name"))
e_name=trim(request.form("e_name"))
sort=trim(request.form("sort"))

if  name="" or e_name="" then
Call Alert ("请填写完整！","-1")
end if
If sort="" Then sort=0
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_small_class where small_id="&id&""
rs.open sql,conn,1,3
if not(rs.eof and rs.bof) then

rs("big_id")=big_id
rs("name")=name
rs("e_name")=e_name
rs("sort")=sort

rs.update
%>

<%
Call Alert ("修改成功！",""&filename&"?page="&page&"&big_id="&big_id&"")
else
Call Alert ("修改错误！",-2)
end if
rs.close
set rs=nothing
end sub

Sub delAll
If id="" And Request("Del")<>"批量修改"  Then
Call Alert ("请选择记录!","-1")
ElseIf Request("Del")="批量删除" Then
Server.ScriptTimeout=99999999
Dim del_id
For i=1 to request.form("id").count
del_id=replace(request.form("id")(i),"'","")

	set rs_del=Server.CreateObject("ADODB.RecordSet")
	sql="select * from yuzhiguo_products where small_id="&del_id&""
	rs_del.open sql,conn,1,1
	if rs_del.eof and rs_del.bof then 
	set rs=conn.execute("delete from yuzhiguo_small_class where small_id In(" & del_id & ")")
	set rs=conn.execute("delete from yuzhiguo_products where small_id In(" & del_id & ")")
	else 
	Call Alert ("该分类下还有产品，请先删除产品，再删除分类!","-1")
	rs_del.close 
	set rs_del=nothing
	end if
next
Call Alert ("批量删除成功",""&filename&"?big_id="&big_id&"")
ElseIf Request("Del")="批量修改" Then
Server.ScriptTimeout=99999999
Dim pl_id,name,e_name,sort
For i=1 to request.form("pl_id").count
pl_id=replace(request.form("pl_id")(i),"'","")
name=replace(request.form("name")(i),"'","")
e_name=replace(request.form("e_name")(i),"'","")
sort=replace(request.form("sort")(i),"'","")
If replace(request.form("sort")(i),"'","")="" Then sort=0
set rs=conn.Execute("select * from yuzhiguo_small_class where small_id="&pl_id)
conn.Execute("update yuzhiguo_small_class set name='"&name&"',e_name='"&e_name&"',sort="&sort&" where small_id="&pl_id)
next
Call Alert ("批量修改成功",""&filename&"?big_id="&big_id&"")
End If
End Sub
%>
<!--#include file="foot.asp"-->
</body>
</html>
