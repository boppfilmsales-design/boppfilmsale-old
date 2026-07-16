<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="防注入管理"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<%
dim filename,id,keywords,paixu,action
filename="sql.asp"'页面名称
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
elseif request("action")="savenew" then
call savenew()
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
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=SqlIn_IP&amp;keywords=<%=keywords%>" <% if paixu="SqlIn_IP" then %>selected<% end if %>>按【IP】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=SqlIn_WEB&amp;keywords=<%=keywords%>" <% if paixu="SqlIn_WEB" then %>selected<% end if %>>按【操作页面】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=SqlIn_TIME&amp;keywords=<%=keywords%>" <% if paixu="SqlIn_TIME" then %>selected<% end if %>>按【操作时间】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=Kill_ip&amp;keywords=<%=keywords%>" <% if paixu="Kill_ip" then %>selected<% end if %>>按【是否锁定】排序</option>
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
<td colspan="10" align=center class="a1">防注入管理</td>
</tr>
<tr  style="font-weight:bold;">
<td height="30" align="center" class="a1">选择</td>
<td align="center" class="a1">ID</td>
<td height="30" align="center" class="a1">操作IP</td>
<td align="center" class="a1">查询IP位置</td>
<td align="center" class="a1">操作页面</td>
<td align="center" class="a1">操作时间</td>
<td align="center" class="a1">提交方式</td>
<td align="center" class="a1">提交参数</td>
<td align="center" class="a1">提交数据</td>
<td align="center" class="a1">是否锁定</td>
</tr>
<%
set rs=server.createobject("adodb.recordset")
sql ="select * from yuzhiguo_sql where SqlIn_IP like '%"&keywords&"%' or SqlIn_WEB like '%"&keywords&"%' order by "&paixu&" "&xu&""
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
  <td  colspan="10" align="center" class="red a3">没有数据</td>
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
<input name="SqlIn_IP" type="text" id="SqlIn_IP" value="<%=rs("SqlIn_IP")%>" size="20" maxlength="255" /></td>
<td align="center"><a href="http://yxshejitao.taobao.com/tool/ip/?ip=<%=rs("SqlIn_IP")%>" target="_blank">查询</a></td>
<td align="center"><%=rs("SqlIn_WEB")%></td>
<td align="center"><%=rs("SqlIn_TIME")%></td>
<td align="center"><%=rs("SqlIn_FS")%></td>
<td align="center"><%=rs("SqlIn_CS")%></td>
<td align="center"><%=rs("SqlIn_SJ")%></td>
<td align="center"><select name="Kill_ip" id="Kill_ip">
  <option value="1" <%if rs("Kill_ip")=true then response.write"selected" end if%> style="color:#FF0000;">是</option>
  <option value="0" <%if rs("Kill_ip")=false then response.write"selected" end if%>>否</option>
</select></td>
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
<td colspan="9">
<input name="Del" type="submit" id="Del"  onClick="JavaScript:return confirm('确定删除吗？')" value="批量删除">
<input name="Del" type="submit" id="Del" value="批量修改"> <input name="Del" type="submit" id="Del" onClick="JavaScript:return confirm('确定清空数据吗？')" value="清空数据"></td>
</tr>
<tr><td colspan="10" align="left">
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

<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savenew" name="myform" method=post>
<tr>
<td colspan="3" align=center class="a1">添加防注入</td>
</tr>
<tr>
<td width="20%" align="center" class="a3">操作IP</td>
<td width="80%" colspan="2" class="a3"><input name="SqlIn_IP" type="text" id="SqlIn_IP" size="50" maxlength="255">
  <span class="hui">（提醒：添加IP可以达到封锁此IP访问的目的）</span></td>
</tr>

<tr>
  <td align="center" class="a3">是否锁定</td>
  <td colspan="2" class="a3"><select name="Kill_ip" id="Kill_ip">
  <option value="true" selected="selected" style="color:#FF0000;">是</option>
  <option value="false" >否</option>
  </select></td>
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
SqlIn_IP=trim(request.form("SqlIn_IP"))
Kill_ip=trim(request.form("Kill_ip"))

if SqlIn_IP="" then
Call Alert ("请填写完整再提交！","-1")
end if
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_sql "
rs.open sql,conn,1,3
rs.AddNew
rs("SqlIn_IP")=SqlIn_IP
rs("Kill_ip")=Kill_ip
rs.update
Call Alert ("添加成功！",""&filename&"")
rs.close
set rs=nothing
end sub

Sub delAll
If id="" And Request("Del")<>"批量修改" And Request("Del")<>"清空数据"  Then
Call Alert ("请选择记录!","-1")
ElseIf Request("Del")="批量删除" Then
set rs=conn.execute("delete from yuzhiguo_sql where id In(" & id & ")")
Call Alert ("批量删除成功",""&filename&"")
ElseIf Request("Del")="清空数据" Then
set rs=conn.execute("delete from yuzhiguo_sql")
Call Alert ("清空数据成功",""&filename&"")
ElseIf Request("Del")="批量修改" Then
Server.ScriptTimeout=99999999
Dim pl_id,name,url,sort
For i=1 to request.form("pl_id").count
pl_id=replace(request.form("pl_id")(i),"'","")
SqlIn_IP=replace(request.form("SqlIn_IP")(i),"'","")
Kill_ip=replace(request.form("Kill_ip")(i),"'","")
set rs=conn.Execute("select * from yuzhiguo_sql where id="&pl_id)
conn.Execute("update yuzhiguo_sql set SqlIn_IP='"&SqlIn_IP&"',Kill_ip="&Kill_ip&" where id="&pl_id)
next
Call Alert ("批量修改成功",""&filename&"")
End If
End Sub
%>
<!--#include file="foot.asp"-->
</body>
</html>
