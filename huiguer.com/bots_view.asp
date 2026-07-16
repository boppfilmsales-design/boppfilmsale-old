<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="蜘蛛来访情况"
%>
<!--#include file="check.asp"-->
<title>余志国搜索引擎蜘蛛来访统计系统V2.0</title>
<meta name="author" content="Web Design：Yuzhiguo QQ:286313315 E-mail:vip@yuzhiguo.com Website:http://www.yuzhiguo.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<%
dim filename,id,keywords,paixu,action
filename="bots_view.asp"'页面名称
id=trim(request("id"))
keywords=trim(request("keywords"))
paixu=trim(request("paixu"))
if paixu="" then
paixu="lastdate"'默认排序
end if

action=trim(request("action"))
select case action
case "del_all"
call del_all()
case "del"
call del()
case else
call main()
end select
sub main()
%>
<table width="99%" border="0" align="center" cellpadding="3" cellspacing="1" class="a2">
<form action="<%=filename%>" method="post" name="search" id="search">
<tr>
<td class="a1">搜索：
<input name="keywords" class="form" id="keywords" value="<%=keywords%>" size="30" maxlength="50" />
<input name="submit" type="submit" value="搜索" />
<select name="jumpMenu" id="jumpMenu" onChange="location=this.options[this.selectedIndex].value" >

<option value="<%=filename%>?page=1&amp;paixu=botname&amp;keywords=<%=keywords%>" <% if paixu="botname" then %>selected<% end if %>>按【蜘蛛名称】排序</option>
<option value="<%=filename%>?page=1&amp;paixu=ip&amp;keywords=<%=keywords%>" <% if paixu="ip" then %>selected<% end if %>>按【IP】排序</option>
<option value="<%=filename%>?page=1&amp;paixu=lastdate&amp;keywords=<%=keywords%>" <% if paixu="lastdate" then %>selected<% end if %>>按【最近时间】排序</option>
<option value="<%=filename%>?page=1&amp;paixu=hits_day&amp;keywords=<%=keywords%>" <% if paixu="hits_day" then %>selected<% end if %>>按【最近一天次数】排序</option>
<option value="<%=filename%>?page=1&amp;paixu=hits_year&amp;keywords=<%=keywords%>" <% if paixu="hits_year" then %>selected<% end if %>>按【总次数】排序</option>
</select></td>
</tr>
</form>
</table>
<table width="99%" border="0" align="center"  cellpadding="3"  cellspacing="1" class="a2" >
<tr>
<td colspan="7" align="center" class="a1"  ><font color="#FFFFFF">余志国搜索引擎蜘蛛来访记录系统V2.0</font></td>
</tr>
<tr>
<td align="center" class="a1">蜘蛛名称</td>
<td align="center" class="a1">最近来访IP</td>
<td align="center" class="a1">最近来访时间</td>
<td align="center" class="a1">最近一天来访次数</td>
<td align="center" class="a1">总来访次数</td>
<td align="center" class="a1">最近访问页面地址</td>
<td align="center" class="a1">管理</td>
</tr>
<%
set rs=server.createobject("adodb.recordset")
sql ="select * from  yuzhiguo_bots  where botname like '%"&keywords&"%' order by "&paixu&" desc"
Rs.Open Sql,Conn,1,1
page=request.QueryString("page")
if IsNumeric(page) then
page=cint(page)
if page<1 then page=1
else
page=1
end if
everypage=20
rs.pagesize=everypage
if rs.bof and rs.eof then
%>
<tr>
<td align="center" colspan="7"><span class="red">还没有蜘蛛来访本站。。。</span></td>
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
<tr class="a3" onMouseOver="this.style.backgroundColor='#EAFCD5';return true;"
onmouseout="this.style.backgroundColor='#F8FAFC';return true;">
<td align="left"><strong><font color="#0066CC"><%=Rs("botname")%></font></strong></td>
<td align="center"><a href="http://www.yuzhiguo.com/tool/ip/?ip=<%=rs("IP")%>" target="_blank"><%=rs("IP")%></a></td>
<td align="center"><%if Month(Rs("lastdate"))=Month(Date) And Day(Rs("lastdate"))=Day(Date) then %>
<%=Rs("lastdate")%><font color="red" size="1">New</font>
<%else%>
<%=Rs("lastdate")%>
<%end if%></td>
<td align="center"><%=Rs("hits_day")%></td>
<td align="center"><%=Rs("hits_year")%></td>
<td align="left"><a href="<%=rs("lasturl")%>" target="_blank" ><%=rs("lasturl")%></a></td>
<td align="center"><a href="<%=filename%>?action=del&id=<%=Rs("id")%>" onClick="return confirm('您确定进行删除操作吗？删除后将不可恢复！')">删除</a></td>
</tr>
<%if n mod 1=0 then%>
<%end if%>
<%
n=n+1
j=j+1
rs.movenext
loop
end if%>
<tr>
<td colspan="7" align="center"><div class="page"> <span class="text">共<strong><%=rs.recordcount%></strong>条记录</span><span class="text"><strong><%=page%></strong>/<%=page_count%>页</span>
<%
if page=1 then
%>
<span class="disabled">首页</span><span class="disabled">上一页</span>
<%
else
%>
<a href="<%=filename%>?page=1&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" >首页</a><a href="<%=filename%>?page=<%=page-1%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" >上一页</a>
<%
end if
%>
<%for j=page-3 to page-1%>
<%if j>0 then%>
<a href="<%=filename%>?page=<%=j%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>"><%=j%></a>
<%end if%>
<%next%>
<%
for j=page to page+3
%>
<% if j<=page_count then%>
<%if j=page then%>
<span class="current"><%=j%></span>
<%else%>
<a href="<%=filename%>?page=<%=j%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>"><%=j%></a>
<%end if%>
<%end if%>
<% next%>
<%if page<page_count then%>
<a href="<%=filename%>?page=<%=page+1%>&amp;paixu=<%=paixu%>&amp;keywords=<%=keywords%>" >下一页</a><a href="<%=filename%>?page=<%=page_count%>&amp;keywords=<%=keywords%>" >末页</a>
<%else%>
<span class="disabled">下一页</span><span class="disabled">末页</span>
<%end if%>
</div></td>
</tr>
<%
rs.close
set rs=nothing
%>



<tr>
<td align="center" colspan="7"><a href="<%=filename%>?action=del_all" onClick="return confirm('您确定进行清空数据操作吗？清空后将不可恢复！')">【清空数据】</a>【<a href="http://www.yuzhiguo.com/articleview.asp?id=438" target="_blank">点此升级</a>】</td>
</tr>
</table>
<%
end sub
Sub del_all()
set rs=server.CreateObject("adodb.recordset")
sql="delete * from yuzhiguo_bots "
rs.open sql,Conn,1,3
Call alert ("清空所有来访数据成功!",""&filename&"")
End sub

Sub del()
set rs=server.CreateObject("adodb.recordset")
sql="delete * from yuzhiguo_bots where id="&id
rs.open sql,Conn,1,3
Call alert ("删除单条记录成功!",""&filename&"")
End sub
%>
<!--#include file="foot.asp"-->
</body>
</html>
