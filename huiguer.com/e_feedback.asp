<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="英文留言管理"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<%
dim filename,id,keywords,paixu,action
filename="e_feedback.asp"'页面名称
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
xu="desc"'默认升序排
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
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=name&amp;keywords=<%=keywords%>" <% if paixu="name" then %>selected<% end if %>>按【留言人】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=date&amp;keywords=<%=keywords%>" <% if paixu="date" then %>selected<% end if %>>按【留言时间】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=IP&amp;keywords=<%=keywords%>" <% if paixu="sort" then %>selected<% end if %>>按【IP】排序</option>
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
<td colspan="9" align=center class="a1">英文留言管理</td>
</tr>
<tr  style="font-weight:bold;">
<td height="30" align="center" class="a1">选择</td>
<td align="center" class="a1">ID</td>
<td height="30" align="center" class="a1">留言人</td>
<td align="center" class="a1">电话</td>
<td align="center" class="a1">E-mail</td>
<td align="center" class="a1">IP</td>
<td align="center" class="a1">留言时间</td>
<td align="center" class="a1">审核</td>
<td height="30" align="center" class="a1">管理</td>
</tr>
<%
set rs=server.createobject("adodb.recordset")
sql ="select * from yuzhiguo_e_feedback where name like '%"&keywords&"%' or content like '%"&keywords&"%' order by "&paixu&" "&xu&""
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
<td align="CENTER"><input type="checkbox" value="<%=rs("id")%>" name="id" onClick="unselectall(this.form)" style="border:0;">
<input name="pl_id" type="hidden" id="pl_id" value="<%=rs("id")%>"></td>
<td align="center"><%=rs("id")%></td>
<td align="center">
<%=rs("name")%></td>
<td align="center"><%=rs("tel")%></td>
<td align="center"><%=rs("email")%></td>
<td align="center"><a href="http://www.ip138.com/ips138.asp?ip=<%=rs("ip")%>" target="_blank"><%=rs("ip")%></a></td>
<td align="center"><%=rs("date")%></td>
<td align="center"><%if rs("show")=true then %><font color="#FF0000">是</font><%else%>否<%end if%>
</td>
<td align="center"><a href="<%=filename%>?action=edit&id=<%=rs("id")%>&page=<%=page%>">回复</a></td>
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
<input name="Del" type="submit" id="Del"  onClick="JavaScript:return confirm('确定删除吗？')" value="批量删除"></td>
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
%><br />


<%
end sub

sub edit()
id=request("id")
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_e_feedback where id="& id &""
rs.open sql,conn,1,1
%>
<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savedit" name="myform" method=post>
<tr>
<td colspan="3" align=center class="a1">回复英文留言</td>
</tr>
<tr>
<td width="20%" align="center" class="a3"><span class="a3">姓名</span></td>
<td width="80%" colspan="2" class="a3"><input name="name" type="text" id="name" value="<%=rs("name")%>" size="50" maxlength="50"></td>
</tr>

<tr>
<td align="center" class="a3">公司名称</td>
<td colspan="2" class="a3"><input name="company_name" type="text" id="company_name" value="<%=rs("company_name")%>" size="60" maxlength="255" /></td>
</tr>

<tr>
  <td align="center" class="a3">地址</td>
  <td colspan="2" class="a3"><input name="add" type="text" id="add" value="<%=rs("add")%>" size="80" maxlength="255" /></td>
</tr>
<tr>
  <td align="center" class="a3">电话</td>
  <td colspan="2" class="a3"><input name="tel" type="text" id="tel" value="<%=rs("tel")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">传真</td>
  <td colspan="2" class="a3"><input name="fax" type="text" id="fax" value="<%=rs("fax")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">E-mail</td>
  <td colspan="2" class="a3"><input name="email" type="text" id="email" value="<%=rs("email")%>" size="60" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">Website</td>
  <td colspan="2" class="a3"><input name="website" type="text" id="website" value="<%=rs("website")%>" size="60" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">QQ</td>
  <td colspan="2" class="a3"><input name="qq" type="text" id="qq" value="<%=rs("qq")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">MSN</td>
  <td colspan="2" class="a3"><input name="msn" type="text" id="msn" value="<%=rs("msn")%>" size="60" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">IP地址</td>
  <td colspan="2" class="a3"><a href="http://www.ip138.com/ips138.asp?ip=<%=rs("ip")%>" target="_blank"><%=rs("ip")%>[点击查询IP位置]</a> </td>
</tr>
<tr>
  <td align="center" class="a3">留言时间</td>
  <td colspan="2" class="a3"><%=rs("date")%></td>
</tr>
<tr>
  <td align="center" class="a3">留言内容</td>
  <td colspan="2" class="a3"><textarea name="content" cols="80" rows="5" id="content"><%=rs("content")%></textarea></td>
</tr>
<tr>
  <td align="center" class="a3">回复内容</td>
  <td colspan="2" class="a3"><textarea name="reply" cols="80" rows="5" id="reply"><%=rs("reply")%></textarea></td>
</tr>

<tr>
  <td align="center" class="a3">审核</td>
  <td colspan="2" class="a3"><input name="show" type="checkbox" id="show" value="1" <%if rs("show")=true  then%>checked<%end if%>/></td>
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
company_name=trim(request.form("company_name"))
add=trim(request.form("add"))
tel=trim(request.form("tel"))
fax=trim(request.form("fax"))
email=trim(request.form("email"))
website=trim(request.form("website"))
qq=trim(request.form("qq"))
msn=trim(request.form("msn"))
content=trim(request.form("content"))
reply=trim(request.form("reply"))
show=trim(request.form("show"))

if name="" or content="" then
Call Alert ("请填写完整！","-1")
end if
If sort="" Then sort=0
If show="" Then 
show=false
else
show=true
end if
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_e_feedback where id="&id&""
rs.open sql,conn,1,3
if not(rs.eof and rs.bof) then

rs("name")=name
rs("company_name")=company_name
rs("add")=add
rs("tel")=tel
rs("fax")=fax
rs("email")=email
rs("website")=website
rs("qq")=qq
rs("msn")=msn
rs("content")=content
rs("reply")=reply
rs("show")=show

rs.update
Call Alert ("修改成功！",""&filename&"?page="&page&"")
else
Call Alert ("修改错误！",-2)
end if
rs.close
set rs=nothing
end sub

Sub delAll
If id="" Then
Call Alert ("请选择记录!","-1")
ElseIf Request("Del")="批量删除" Then
set rs=conn.execute("delete from yuzhiguo_e_feedback where id In(" & id & ")")
Call Alert ("批量删除成功",""&filename&"")
End If
End Sub
%>
<!--#include file="foot.asp"-->
</body>
</html>
