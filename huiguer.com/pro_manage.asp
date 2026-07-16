<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="网站产品管理"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<!--#include file="../pub/godaddy.asp"-->
<!-- #INCLUDE file="../yuzhiguoeditor/fckeditor.asp" -->
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<%
dim filename,id,keywords,paixu,action,big_id,small_id
filename="pro_manage.asp"'页面名称
id=trim(request("id"))
keywords=trim(request("keywords"))

if trim(request("big_id"))<>"" then
big_id=CInt(trim(request("big_id")))
else
big_id=0
end if

if trim(request("small_id"))<>"" then
small_id=CInt(trim(request("small_id")))
else
small_id=0
end if

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
xu="desc"'默认升序排
end if
%>
<%dim count
set rs=server.createobject("adodb.recordset")
rs.open "select * from yuzhiguo_small_class order by sort ",conn,1,1%>
<script language = "JavaScript">
var onecount;
onecount=0;
subcat = new Array();
<%
count = 0
do while not rs.eof
%>
subcat[<%=count%>] = new Array("<%= trim(rs("name"))%>(<%= trim(rs("e_name"))%>)","<%= rs("big_id")%>","<%= rs("small_id")%>");
<%
count = count + 1
rs.movenext
loop
rs.close
%>

onecount=<%=count%>;

function changelocation(locationid)
{
document.myform.small_id.length = 0;


document.myform.small_id.options[0] = new Option("未选小类", "");
var locationid=locationid;
var i;
for (i=0;i < onecount; i++)
{
if (subcat[i][1] == locationid)
{
document.myform.small_id.options[document.myform.small_id.length] = new Option(subcat[i][0], subcat[i][2]);
}
}

}
</script>
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
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=id&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if paixu="id" then %>selected<% end if %>>按【默认】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=cpbh&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if paixu="cpbh" then %>selected<% end if %>>按【产品编号】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=e_cpmc&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if paixu="e_cpmc" then %>selected<% end if %>>按【产品英文名称】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=hits&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if paixu="hits" then %>selected<% end if %>>按【浏览次数】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=desc&amp;paixu=newpro&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if paixu="newpro" then %>selected<% end if %>>按【新品】排序</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=sort&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if paixu="sort" then %>selected<% end if %>>按【排序】排序</option>
</select>

        
<select name="jumpMenu_big_id" id="jumpMenu_big_id" onChange="location=this.options[this.selectedIndex].value" >
    <option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=0&amp;small_id=0&amp;keywords=<%=keywords%>" <%if big_id=0 then %>selected<%end if%>>全部大类</option>
<%
	set rs_big=server.CreateObject("adodb.recordset")
	rs_big.open "select * from yuzhiguo_big_class order by big_id",conn,1,1
	if rs_big.eof and rs_big.bof then
	else
	do while not rs_big.eof%>
    	<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=rs_big("big_id")%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <%if rs_big("big_id")=big_id then %>selected<%end if%>><%=rs_big("e_name")%></option>
    <% 
	rs_big.movenext
	loop
	rs_big.close
	set rs_big = nothing
	end if
	%>
        </select>
        
<select name="jumpMenu_small_id" id="jumpMenu_small_id" onChange="location=this.options[this.selectedIndex].value" >
<%
if big_id=0 then
%>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=0&amp;keywords=<%=keywords%>">全部小类</option>

<%	else

	set rs_small=server.CreateObject("adodb.recordset")
	rs_small.open "select * from yuzhiguo_small_class where big_id="&big_id&" order by big_id",conn,1,1
	if rs_small.eof and rs_small.bof then
	%>
    <option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=0&amp;keywords=<%=keywords%>">没有小类</option>
    <%
	else
	%>
    <option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=0&amp;keywords=<%=keywords%>">全部小类</option>
    <%
	do while not rs_small.eof%>
    
    	<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=rs_small("small_id")%>&amp;keywords=<%=keywords%>"  <%if rs_small("small_id")=small_id then %>selected<%end if%> ><%=rs_small("e_name")%></option>
    <% 
	rs_small.movenext
	loop
	rs_small.close
	set rs_small = nothing
	end if
	
	end if
	%>
        </select>

<select name="jumpMenu_xu" id="jumpMenu_xu" onChange="location=this.options[this.selectedIndex].value" >
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=asc&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if xu="asc" then %>selected<% end if %>>【升序】</option>
<option value="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=desc&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if xu="desc" then %>selected<% end if %>>【降序】</option>
</select>

<select name="jumpMenu_pagesize" id="jumpMenu_pagesize" onChange="location=this.options[this.selectedIndex].value" >
<option value="<%=filename%>?page=1&amp;pagesize=10&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if pagesize="10" then %>selected<% end if %>>每页【10】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=20&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if pagesize="20" then %>selected<% end if %>>每页【20】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=30&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if pagesize="30" then %>selected<% end if %>>每页【30】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=40&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if pagesize="40" then %>selected<% end if %>>每页【40】条记录</option>
<option value="<%=filename%>?page=1&amp;pagesize=50&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" <% if pagesize="50" then %>selected<% end if %>>每页【50】条记录</option>
</select>
</td>
</form>
</tr>
</table>


<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" class="a2">
<form name="myform" method="POST" action="<%=filename%>?action=delAll">
<tr>
<td align=center class="a1"><input name="Del" type="submit" id="Del" value="添加"></td>
<td colspan="10" align=center class="a1">产品管理</td>
</tr>
<tr  style="font-weight:bold;">
<td height="30" align="center" class="a1">选择</td>
<td align="center" class="a1">ID</td>
<td align="center" class="a1">产品编号</td>
<td align="center" class="a1">产品英文名称</td>
<td align="center" class="a1">所属大类</td>
<td align="center" class="a1">浏览次数</td>
<td align="center" class="a1">缩略图</td>
<td align="center" class="a1">首页显示</td>
<td height="30" align="center" class="a1">排序</td>
<td align="center" class="a1">静态</td>
<td height="30" align="center" class="a1">管理</td>
</tr>
<%
set rs=server.createobject("adodb.recordset")
if big_id>0 and small_id=0 then
sql ="select * from yuzhiguo_products where (e_cpmc like '%"&keywords&"%' or cpmc like '%"&keywords&"%'  or cpbh like '%"&keywords&"%' or id like '%"&keywords&"%' )  and big_id="&big_id&" order by "&paixu&" "&xu&""
elseif big_id>0 and small_id>0 then
sql ="select * from yuzhiguo_products where (e_cpmc like '%"&keywords&"%' or cpmc like '%"&keywords&"%'  or cpbh like '%"&keywords&"%' or id like '%"&keywords&"%' ) and big_id="&big_id&" and small_id="&small_id&" order by "&paixu&" "&xu&""
else
sql ="select * from yuzhiguo_products where e_cpmc like '%"&keywords&"%'  or cpmc like '%"&keywords&"%'  or cpbh like '%"&keywords&"%' or id like '%"&keywords&"%' order by "&paixu&" "&xu&",id desc"
end if
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
  <td  colspan="11" align="center" class="red a3">没有数据</td>
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
<td align="center"><input name="cpbh" type="text" id="cpbh" value="<%=rs("cpbh")%>" size="15" maxlength="50" /></td>
<td align="center"><input name="e_cpmc" type="text" id="e_cpmc" value="<%=rs("e_cpmc")%>" size="15" maxlength="255"></td>
<td align="center"><%
set rs_class=conn.execute("select * from yuzhiguo_big_class where big_id="&rs("big_id")&"")
if rs_class.eof and rs_class.bof then
response.Write("未知分类")
else
%>
<%=rs_class("e_name")%>
<%
end if
rs_class.close
%></td>
<td align="center"><%=rs("hits")%></td>
<td align="center"><a href="../e_products_show/?id=<%=rs("id")%>" target="_blank"><img <% if pic_aspjpeg=1 then %>src="<%=get_pic(rs("pic"),2)%>" <% else %> src="<%=rs("pic")%>" width="100" height="100" <% end if %> alt="点击预览" /></a></td>
<td align="center">

<select name="newpro" id="newpro">
  <option value="1" <%if rs("newpro")=1 then response.write"selected" end if%> style="color:#FF0000;">是</option>
  <option value="0" <%if rs("newpro")=0 then response.write"selected" end if%>>否</option>
</select></td>
<td align="center"><input name="sort" type="text" id="sort" value="<%=rs("sort")%>" size="4" maxlength="10" onKeyDown="myKeyDown()"></td>
<td align="center"><a href="e_html_products.asp?action=html_id&amp;id=<%=rs("id")%>">生成</a></td>
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
<td colspan="10">
<input name="Del" type="submit" id="Del"  onClick="JavaScript:return confirm('确定删除吗？')" value="批量删除">
<input name="Del" type="submit" id="Del" value="批量修改">
<input name="Del" type="submit" id="Del" value="添加"></td>
</tr>
<tr><td colspan="11" align="left">
<div class="page">
<span class="text">共<strong><%=rs.recordcount%></strong>条记录</span>
<span class="text"><strong><%=page%></strong>/<%=page_count%>页</span>
<%if page=1 then%>
<span class="disabled">首页</span><span class="disabled">上一页</span>
<%else%>
<a href="<%=filename%>?page=1&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" >首页</a>
<a href="<%=filename%>?page=<%=page-1%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" >上一页</a>
<%end if%>
<%for j=page-3 to page-1%>
<%if j>0 then%>
<a href="<%=filename%>?page=<%=j%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>"><%=j%></a>
<%end if%>
<%next%>
<%for j=page to page+3%>
<% if j<=page_count then%>
<%if j=page then%>
<span class="current"><%=j%></span>
<%else%>
<a href="<%=filename%>?page=<%=j%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>"><%=j%></a>
<%end if%>
<%end if%>
<% next%>
<%if page<page_count then%>
<a href="<%=filename%>?page=<%=page+1%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" >下一页</a>
<a href="<%=filename%>?page=<%=page_count%>&amp;pagesize=<%=pagesize%>&amp;xu=<%=xu%>&amp;paixu=<%=paixu%>&amp;big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;keywords=<%=keywords%>" >末页</a>
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
	<% 
	set rs=Server.CreateObject("ADODB.RecordSet")
	sql="select top 1 * from yuzhiguo_products order by id desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then 
	pro_big_id=0
	pro_small_id=0
	pro_cpmc=""
	pro_e_cpmc=""
	pro_cpbh=""
	else 
	pro_big_id=int(rs("big_id"))
	pro_small_id=int(rs("small_id"))
	pro_cpmc=rs("cpmc")
	pro_e_cpmc=rs("e_cpmc")
	pro_cpbh=rs("cpbh")
    rs.close 
	set rs=nothing
	end if
	%>
<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savenew" name="myform" method=post>
<tr>
<td align=center class="a1"><input name="Submit" type="submit" value="添 加"></td>
<td colspan="3" align=center class="a1">添加产品</td>
</tr>
<tr>
  <td align="center" class="a3">产品所属类别</td>
  <td colspan="3" class="a3">
  <%
  set rs_big=server.createobject("adodb.recordset")
rs_big.open "select * from yuzhiguo_big_class order by sort",conn,1,1
if rs_big.eof and rs_big.bof then
response.write "请先添加分类"
response.end
else
%>
<select name="big_id"  size="1" id="big_id" onChange="changelocation(document.myform.big_id.options[document.myform.big_id.selectedIndex].value)">
<option value="0">未选大类</option>
<%
do while not rs_big.eof
%>

<option value="<%=rs_big("big_id")%>" <%if pro_big_id=rs_big("big_id") then%>selected<%end if%>><%=trim(rs_big("name"))%>(<%=trim(rs_big("e_name"))%>)</option>
<%
rs_big.movenext
loop
end if
rs_big.close
%>
</select>

<select name="small_id">

<option value="0">未选小类</option>
<%
if pro_small_id=0 then
%>
<%
else
set rss=server.CreateObject("adodb.recordset")
rss.open "select * from yuzhiguo_small_class where big_id="&int(pro_big_id)&"",conn,1,1
%>

<%
do while not rss.eof
name=rss("name")
e_name=rss("e_name")
%>
<option value="<%=rss("small_id")%>" <%if rss("small_id")=pro_small_id then response.Write("selected") %>><%=name%>(<%=e_name%>)</option>
<%
rss.movenext
loop
%>
<%
rss.close
end if%>
</select></td>
  </tr>
<tr>
<td align="center" class="a3">产品中文名称</td>
<td class="a3"><input name="cpmc" type="text" id="cpmc" value="<%=pro_cpmc%>" size="50" maxlength="255" /></td>
<td class="a3">产品英文名称</td>
<td class="a3"><input name="e_cpmc" type="text" id="e_cpmc" value="<%=pro_e_cpmc%>" size="50" maxlength="255" /></td>
</tr>

<tr>
<td align="center" class="a3">产品编号</td>
<td colspan="3" class="a3"><input name="cpbh" type="text" id="cpbh" value="<%=pro_cpbh%>" size="50" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">中文静态文件名</td>
  <td class="a3">    <input name="html_url_cn" type="text" id="html_url_cn" size="50" maxlength="255" />
    .html <br />
    <span class="hui">（提醒：如不填写则以产品名称命名，一经设置不可更改）</span></td>
  <td class="a3">英文静态文件名</td>
  <td class="a3"><input name="html_url_en" type="text" id="html_url_en" size="50" maxlength="255" />
.html </td>
</tr>
<tr>
  <td align="center" class="a3">产品中文价格</td>
  <td class="a3"><input name="price" type="text" id="price" size="50" maxlength="50" /></td>
  <td class="a3">产品英文价格</td>
  <td class="a3"><input name="e_price" type="text" id="e_price" size="50" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">产品主图</td>
  <td colspan="3" class="a3"><input name="pic" type="text" id="pic" size="80" maxlength="255" />
    <input type="button" name="submit1"  id="submit1" value="上传主图" onClick="window.open('pro_upload_flash.asp?formname=myform&editname=pic&uppath=../pic/big&filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')">
    <br />
    （必传，产品图片建议尺寸为550*550像素，最大宽度不超过700像素，图片大小不超过500KB）</td>
</tr>
<tr>
  <td align="center" class="a3">产品角度1</td>
  <td colspan="3" class="a3"><input name="pic1" type="text" id="pic1" size="80" maxlength="255" />
    <input type="button" name="submit2"  id="submit2" value="上传角度1" onclick="window.open('pro_upload_flash.asp?formname=myform&amp;editname=pic1&amp;uppath=../pic/big&amp;filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" /></td>
</tr>
<tr>
  <td align="center" class="a3">产品角度2</td>
  <td colspan="3" class="a3"><input name="pic2" type="text" id="pic2" size="80" maxlength="255" />
    <input type="button" name="submit3"  id="submit3" value="上传角度2" onclick="window.open('pro_upload_flash.asp?formname=myform&amp;editname=pic2&amp;uppath=../pic/big&amp;filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" /></td>
</tr>
<tr>
  <td align="center" class="a3">产品角度3</td>
  <td colspan="3" class="a3"><input name="pic3" type="text" id="pic3" size="80" maxlength="255" />
    <input type="button" name="submit4"  id="submit4" value="上传角度3" onclick="window.open('pro_upload_flash.asp?formname=myform&amp;editname=pic3&amp;uppath=../pic/big&amp;filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" /></td>
</tr>

<tr>
  <td align="center" class="a3">产品中文介绍</td>
  <td colspan="3" class="a3"><%
Dim sBasePath
sBasePath = Request.ServerVariables("PATH_INFO")
sBasePath = Left( sBasePath, InStrRev( sBasePath, "/_samples" ) )

Dim oFCKeditor
Set oFCKeditor = New FCKeditor
oFCKeditor.BasePath	= sBasePath
oFCKeditor.Value	= ""
oFCKeditor.Create "intro"
%></td>
</tr>
<tr>
  <td align="center" class="a3">产品英文介绍</td>
  <td colspan="3" class="a3"><%
Dim e_sBasePath
e_sBasePath = Request.ServerVariables("PATH_INFO")
e_sBasePath = Left( e_sBasePath, InStrRev( e_sBasePath, "/_samples" ) )

Dim e_oFCKeditor
Set e_oFCKeditor = New FCKeditor
e_oFCKeditor.BasePath	= e_sBasePath
e_oFCKeditor.Value	= ""
e_oFCKeditor.Create "e_intro"
%></td>
</tr>
<tr>
  <td align="center" class="a3">保存远程图片到本站</td>
  <td colspan="3" class="a3"><input name="sSaveFileSelect" type="checkbox"  id="sSaveFileSelect" value="True"></td>
</tr>
<tr>
  <td align="center" class="a3">首页显示</td>
  <td colspan="3" class="a3"><input name="newpro" type="checkbox" id="newpro" value="1" /></td>
  </tr>
<tr>
  <td align="center" class="a3">浏览次数</td>
  <td colspan="3" class="a3"><input name="hits" type="text" id="hits" value="0" size="10" maxlength="10" /></td>
</tr>
<tr>
<td align="center" class="a3">排序</td>
<td colspan="3" class="a3"><input name="sort" type="text" id="sort" value="0" size="4" maxlength="10" /></td>
</tr>
<tr>
  <td align="center" class="a3">中文title</td>
  <td class="a3"><input name="title" type="text" id="title" size="50" maxlength="255" /></td>
  <td class="a3">英文title</td>
  <td class="a3"><input name="e_title" type="text" id="e_title" size="50" maxlength="255" /></td>
</tr>
<tr>
  <td align="center" class="a3">中文keywords</td>
  <td class="a3"><span class="hui">
    <textarea name="keywords" cols="50" rows="3" id="keywords"></textarea>
    <br />
    （提醒：不要超过255个字符）</span></td>
  <td class="a3">英文keywords</td>
  <td class="a3"><textarea name="e_keywords" cols="50" rows="3" id="e_keywords"></textarea></td>
</tr>
<tr>
  <td align="center" class="a3">中文description</td>
  <td class="a3"><span class="hui">
    <textarea name="description" cols="50" rows="3" id="description"></textarea>
    <br />
    （提醒：不要超过255个字符）</span></td>
  <td class="a3">英文description</td>
  <td class="a3"><textarea name="e_description" cols="50" rows="3" id="e_description"></textarea></td>
</tr>
<tr>
<td align="center" class="a3"></td>
<td colspan="3" class="a3"><input name="Submit" type="submit" value="添 加"></td>
</tr>
</form>
</table>
<%
end sub

sub savenew()
if trim(request.form("big_id"))="" or trim(request.form("pic"))="" then
Call Alert ("请填写完整再提交！","-1")
end if

set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_products "
rs.open sql,conn,1,3
rs.AddNew
rs("cpmc")=trim(request("cpmc"))
rs("e_cpmc")=trim(request("e_cpmc"))
rs("big_id")=trim(request("big_id"))

If trim(request.form("small_id"))="" Then 
rs("small_id")=0
else
rs("small_id")=trim(request.form("small_id"))
end if

rs("cpbh")=trim(request("cpbh"))
rs("price")=trim(request("price"))
rs("e_price")=trim(request("e_price"))
rs("pic")=trim(request("pic"))
rs("pic1")=trim(request("pic1"))
rs("pic2")=trim(request("pic2"))
rs("pic3")=trim(request("pic3"))
sSaveFileSelect =request.Form("sSaveFileSelect")
intro=replace(trim(request("intro")),zimulu,"")
e_intro=replace(trim(request("e_intro")),zimulu,"")
	If sSaveFileSelect="True" Then
	rs("intro")=ReplaceRemoteUrl(intro,"/pic/other/",sFileExt)
	rs("e_intro")=ReplaceRemoteUrl(e_intro,"/pic/other/",sFileExt)
	Else
	rs("intro")=intro
	rs("e_intro")=e_intro
	End If

If trim(request.form("newpro"))="" Then 
rs("newpro")=0
else
rs("newpro")=trim(request.form("newpro"))
end if

If trim(request.form("hits"))="" Then 
rs("hits")=0
else
rs("hits")=trim(request.form("hits"))
end if

if trim(request("title"))="" then
rs("title")=trim(request("cpmc"))
else
rs("title")=trim(request("title"))
end if

if trim(request("keywords"))="" then
rs("keywords")=trim(request("cpmc"))
else
rs("keywords")=left(trim(request("keywords")),255)
end if

if trim(request("description"))="" then
rs("description")=trim(request("cpmc"))
else
rs("description")=left(trim(request("description")),255)
end if

if trim(request("e_title"))="" then
rs("e_title")=trim(request("e_cpmc"))
else
rs("e_title")=trim(request("e_title"))
end if

if trim(request("e_keywords"))="" then
rs("e_keywords")=trim(request("e_cpmc"))
else
rs("e_keywords")=left(trim(request("e_keywords")),255)
end if

if trim(request("e_description"))="" then
rs("e_description")=trim(request("e_cpmc"))
else
rs("e_description")=left(trim(request("e_description")),255)
end if

If trim(request.form("sort"))="" Then 
rs("sort")=0
else
rs("sort")=trim(request.form("sort"))
end if

rs.update

id=rs("id")
pic=rs("pic")
pic_small=replace(rs("pic"),"big","small")
pic1=rs("pic1")
pic1_small=replace(rs("pic1"),"big","small")
pic2=rs("pic2")
pic2_small=replace(rs("pic2"),"big","small")
pic3=rs("pic3")
pic3_small=replace(rs("pic3"),"big","small")

folder_big="../pic/big/"+cstr(id)
folder_small="../pic/small/"+cstr(id)

if pic<>"" then
pic_new=folder_big+"_0"+right(pic,4)
pic_small_new=folder_small+"_0"+right(pic_small,4)
rs("pic")=pic_new
file_rename pic,pic_new
if pic_aspjpeg = 1 then
file_rename pic_small,pic_small_new
end if
end if

if pic1<>"" then
pic1_new=folder_big+"_1"+right(pic1,4)
pic1_small_new=folder_small+"_1"+right(pic1_small,4)
rs("pic1")=pic1_new
file_rename pic1,pic1_new
if pic_aspjpeg = 1 then
file_rename pic1_small,pic1_small_new
end if
end if

if pic2<>"" then
pic2_new=folder_big+"_2"+right(pic2,4)
pic2_small_new=folder_small+"_2"+right(pic2_small,4)
rs("pic2")=pic2_new
file_rename pic2,pic2_new
if pic_aspjpeg = 1 then
file_rename pic2_small,pic2_small_new
end if
end if

if pic3<>"" then
pic3_new=folder_big+"_3"+right(pic3,4)
pic3_small_new=folder_small+"_3"+right(pic3_small,4)
rs("pic3")=pic3_new
file_rename pic3,pic3_new
if pic_aspjpeg = 1 then
file_rename pic3_small,pic3_small_new
end if
end if

html_url_cn=trim(request.form("html_url_cn"))
html_url_en=trim(request.form("html_url_en"))

if html_url_cn<>"" then
rs("html_url_cn")=cn2en(html_url_cn)+"-"+Cstr(rs("id"))+".html"
else
rs("html_url_cn")=cn2en(rs("cpmc"))+"-"+Cstr(rs("id"))+".html"
end if

if html_url_en<>"" then
rs("html_url_en")=get_html_name(html_url_en)+"-"+Cstr(rs("id"))+".html"
else
rs("html_url_en")=get_html_name(rs("e_cpmc"))+"-"+Cstr(rs("id"))+".html"
end if
id=rs("id")

rs.update
rs.close
set rs=nothing

set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_products where id="&id&""
rs.open sql,conn,1,1
host="c_products_show/?id="+Cstr(rs("id"))'前台动态地址
folder="../c_html_products/"'文件夹
html_url_name=rs("html_url_cn")
Fso_info host,folder,html_url_name

host="e_products_show/?id="+Cstr(rs("id"))'前台动态地址
folder="../html_products/"'文件夹
html_url_name=rs("html_url_en")
Fso_info host,folder,html_url_name
rs.close
set rs=nothing

Call Alert ("添加成功！",""&filename&"")

end sub

sub edit()
id=request("id")
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_products where id="& id &""
rs.open sql,conn,1,1
%>
<table width="99%" border="0"  align=center cellpadding="3" cellspacing="1" bgcolor="#FFFFFF" class="a2">
<form action="<%=filename%>?action=savedit" name="myform" method=post>
<tr>
<td colspan="4" align=center class="a1">修改产品</td>
</tr>
<tr>
  <td align="center" class="a3">产品所属类别</td>
  <td colspan="3" class="a3">
  <%
  set rs_big = server.CreateObject ("adodb.recordset")
rs_big.open "select * from yuzhiguo_big_class order by sort",conn,1,1
if rs_big.eof and rs_big.bof then
response.write "请先添加分类"
response.end
else
%>
<select name="big_id"  size="1" id="big_id" onChange="changelocation(document.myform.big_id.options[document.myform.big_id.selectedIndex].value)">
<%
do while not rs_big.eof
%>
<option value="<%=rs_big("big_id")%>" <%if rs("big_id")=rs_big("big_id") then%>selected<%end if%>><%=trim(rs_big("name"))%>(<%=trim(rs_big("e_name"))%>)</option>
<%
rs_big.movenext
loop
end if
rs_big.close
%>
</select>

<select name="small_id">


<%

set rss=server.CreateObject("adodb.recordset")
rss.open "select * from yuzhiguo_small_class where big_id="&rs("big_id")&"",conn,1,1
%>
<option value="0">未选小类</option>
<%
do while not rss.eof
name=rss("name")
e_name=rss("e_name")
%>
<option value="<%=rss("small_id")%>" <%if int(rss("small_id"))=rs("small_id") then response.Write("selected") %>><%=name%>(<%=e_name%>)</option>
<%
rss.movenext
loop
%>
<%
rss.close
%>
</select></td>
  </tr>
<tr>
<td align="center" class="a3">产品中文名称</td>
<td class="a3"><input name="cpmc" type="text" id="cpmc" value="<%=rs("cpmc")%>" size="50" maxlength="255" /></td>
<td class="a3">产品英文名称</td>
<td class="a3"><input name="e_cpmc" type="text" id="e_cpmc" value="<%=rs("e_cpmc")%>" size="50" maxlength="255" /></td>
</tr>

<tr>
<td align="center" class="a3">产品编号</td>
<td colspan="3" class="a3"><input name="cpbh" type="text" id="cpbh" value="<%=rs("cpbh")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">中文静态文件名</td>
  <td class="a3"><input name="html_url_cn" type="text" id="html_url_cn" value="<%=rs("html_url_cn")%>" size="50" maxlength="255" disabled="disabled"/></td>
  <td class="a3">英文静态文件名</td>
  <td class="a3"><input name="html_url_en" type="text" id="html_url_en" value="<%=rs("html_url_en")%>" size="50" maxlength="255" disabled="disabled"/></td>
</tr>
<tr>
  <td align="center" class="a3">产品中文价格</td>
  <td class="a3"><input name="price" type="text" id="price" value="<%=rs("price")%>" size="50" maxlength="50" /></td>
  <td class="a3">产品英文价格</td>
  <td class="a3"><input name="e_price" type="text" id="e_price" value="<%=rs("e_price")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
  <td align="center" class="a3">产品主图</td>
  <td colspan="3" class="a3"><input name="pic" type="text" id="pic" value="<%=rs("pic")%>" size="80" maxlength="255" />
    <input type="button" name="submit1"  id="submit1" value="上传主图" onClick="window.open('pro_upload_flash.asp?formname=myform&editname=pic&amp;uppath=../pic/big&amp;file_name=<%=rs("id")%>_0&amp;filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')">
    <br />
    （必传，产品图片建议尺寸为550*550像素，最大宽度不超过700像素，图片大小不超过500KB）</td>
</tr>
<tr>
  <td align="center" class="a3">产品角度1</td>
  <td colspan="3" class="a3"><input name="pic1" type="text" id="pic1" value="<%=rs("pic1")%>" size="80" maxlength="255" />
    <input type="button" name="submit2"  id="submit2" value="上传角度1" onclick="window.open('pro_upload_flash.asp?formname=myform&amp;editname=pic1&amp;uppath=../pic/big&amp;file_name=<%=rs("id")%>_1&amp;filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" /></td>
</tr>
<tr>
  <td align="center" class="a3">产品角度2</td>
  <td colspan="3" class="a3"><input name="pic2" type="text" id="pic2" value="<%=rs("pic2")%>" size="80" maxlength="255" />
    <input type="button" name="submit3"  id="submit3" value="上传角度2" onclick="window.open('pro_upload_flash.asp?formname=myform&amp;editname=pic2&amp;uppath=../pic/big&amp;file_name=<%=rs("id")%>_2&amp;filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" /></td>
</tr>
<tr>
  <td align="center" class="a3">产品角度3</td>
  <td colspan="3" class="a3"><input name="pic3" type="text" id="pic3" value="<%=rs("pic3")%>" size="80" maxlength="255" />
    <input type="button" name="submit4"  id="submit4" value="上传角度3" onclick="window.open('pro_upload_flash.asp?formname=myform&amp;editname=pic3&amp;uppath=../pic/big&amp;file_name=<%=rs("id")%>_3&amp;filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" /></td>
</tr>
<tr>
  <td align="center" class="a3">产品中文介绍</td>
  <td colspan="3" class="a3"><%
Dim sBasePath
sBasePath = Request.ServerVariables("PATH_INFO")
sBasePath = Left( sBasePath, InStrRev( sBasePath, "/_samples" ) )

Dim oFCKeditor
Set oFCKeditor = New FCKeditor
oFCKeditor.BasePath	= sBasePath
oFCKeditor.Value	= rs("intro")
oFCKeditor.Create "intro"
%></td>
</tr>
<tr>
  <td align="center" class="a3">产品英文介绍</td>
  <td colspan="3" class="a3"><%
Dim e_sBasePath
e_sBasePath = Request.ServerVariables("PATH_INFO")
e_sBasePath = Left( e_sBasePath, InStrRev( e_sBasePath, "/_samples" ) )

Dim e_oFCKeditor
Set e_oFCKeditor = New FCKeditor
e_oFCKeditor.BasePath	= e_sBasePath
e_oFCKeditor.Value	= rs("e_intro")
e_oFCKeditor.Create "e_intro"
%></td>
</tr>
<tr>
  <td align="center" class="a3">保存远程图片到本站</td>
  <td colspan="3" class="a3"><input name="sSaveFileSelect" type="checkbox"  id="sSaveFileSelect" value="True"></td>
</tr>
<tr>
  <td align="center" class="a3">首页显示</td>
  <td colspan="3" class="a3"><input name="newpro" type="checkbox" id="newpro" value="1" <%if rs("newpro")=1  then%>checked<%end if%>/></td>
  </tr>
<tr>
  <td align="center" class="a3">浏览次数</td>
  <td colspan="3" class="a3"><input name="hits" type="text" id="hits" value="<%=rs("hits")%>" size="10" maxlength="10" /></td>
</tr>
<tr>
<td align="center" class="a3">排序</td>
<td colspan="3" class="a3"><input name="sort" type="text" id="sort" value="<%=rs("sort")%>" size="4" maxlength="10" /></td>
</tr>
<tr>
  <td align="center" class="a3">中文title</td>
  <td class="a3"><input name="title" type="text" id="title" value="<%=rs("title")%>" size="50" maxlength="255" /></td>
  <td class="a3">英文title</td>
  <td class="a3"><input name="e_title" type="text" id="e_title" value="<%=rs("e_title")%>" size="50" maxlength="255" /></td>
</tr>
<tr>
  <td align="center" class="a3">中文keywords</td>
  <td class="a3"><textarea name="keywords" cols="50" rows="3" id="keywords"><%=rs("keywords")%></textarea>
    <br />
    <span class="hui">（提醒：不要超过255个字符）</span></td>
  <td class="a3">英文keywords</td>
  <td class="a3"><textarea name="e_keywords" cols="50" rows="3" id="e_keywords"><%=rs("e_keywords")%></textarea></td>
</tr>
<tr>
  <td align="center" class="a3">中文description</td>
  <td class="a3"><textarea name="description" cols="50" rows="3" id="description"><%=rs("description")%></textarea>
    <span class="hui"><br />
    （提醒：不要超过255个字符）</span></td>
  <td class="a3">英文description</td>
  <td class="a3"><textarea name="e_description" cols="50" rows="3" id="e_description"><%=rs("e_description")%></textarea></td>
</tr>
<tr>
<td align="center" class="a3"><input name="id" type="hidden" id="id" value="<%=rs("id")%>">
<input name="page" type="hidden" id="page" value="<%=page%>"></td>
<td colspan="3" class="a3"><input name="Submit" type="submit" value="修 改"></td>
</tr>
</form>
</table>

<%
end sub

sub savedit()

if trim(request("big_id"))="" or trim(request("pic"))="" then
Call Alert ("请填写完整！","-1")
end if
If sort="" Then sort=0
set rs = server.CreateObject ("adodb.recordset")
sql="select * from yuzhiguo_products where id="&id&""
rs.open sql,conn,1,3
if not(rs.eof and rs.bof) then

rs("cpmc")=trim(request("cpmc"))
rs("e_cpmc")=trim(request("e_cpmc"))
rs("big_id")=trim(request("big_id"))

If trim(request.form("small_id"))="" Then 
rs("small_id")=0
else
rs("small_id")=trim(request.form("small_id"))
end if

rs("cpbh")=trim(request("cpbh"))
rs("price")=trim(request("price"))
rs("e_price")=trim(request("e_price"))

if trim(request("pic"))<>rs("pic") and rs("pic")<>"" then
file_delete rs("pic")
file_delete replace(rs("pic"),"big","small")
end if
rs("pic")=trim(request("pic"))

if trim(request("pic1"))<>rs("pic1") and rs("pic1")<>"" then
file_delete rs("pic1")
file_delete replace(rs("pic1"),"big","small")
end if
rs("pic1")=trim(request("pic1"))

if trim(request("pic2"))<>rs("pic2") and rs("pic2")<>"" then
file_delete rs("pic2")
file_delete replace(rs("pic2"),"big","small")
end if
rs("pic2")=trim(request("pic2"))

if trim(request("pic3"))<>rs("pic3") and rs("pic3")<>"" then
file_delete rs("pic3")
file_delete replace(rs("pic3"),"big","small")
end if
rs("pic3")=trim(request("pic3"))



sSaveFileSelect =request.Form("sSaveFileSelect")
intro=replace(trim(request("intro")),zimulu,"")
e_intro=replace(trim(request("e_intro")),zimulu,"")
	If sSaveFileSelect="True" Then
	rs("intro")=ReplaceRemoteUrl(intro,"/pic/other/",sFileExt)
	rs("e_intro")=ReplaceRemoteUrl(e_intro,"/pic/other/",sFileExt)
	Else
	rs("intro")=intro
	rs("e_intro")=e_intro
	End If

If trim(request.form("newpro"))="" Then 
rs("newpro")=0
else
rs("newpro")=trim(request.form("newpro"))
end if

If trim(request.form("hits"))="" Then 
rs("hits")=0
else
rs("hits")=trim(request.form("hits"))
end if

if trim(request("title"))="" then
rs("title")=trim(request("cpmc"))
else
rs("title")=trim(request("title"))
end if

if trim(request("keywords"))="" then
rs("keywords")=trim(request("cpmc"))
else
rs("keywords")=left(trim(request("keywords")),255)
end if

if trim(request("description"))="" then
rs("description")=trim(request("cpmc"))
else
rs("description")=left(trim(request("description")),255)
end if


if trim(request("e_title"))="" then
rs("e_title")=trim(request("e_cpmc"))
else
rs("e_title")=trim(request("e_title"))
end if

if trim(request("e_keywords"))="" then
rs("e_keywords")=trim(request("e_cpmc"))
else
rs("e_keywords")=left(trim(request("e_keywords")),255)
end if

if trim(request("e_description"))="" then
rs("e_description")=trim(request("e_cpmc"))
else
rs("e_description")=left(trim(request("e_description")),255)
end if

If trim(request.form("sort"))="" Then 
rs("sort")=0
else
rs("sort")=trim(request.form("sort"))
end if

rs.update

host="c_products_show/?id="+Cstr(rs("id"))'前台动态地址
folder="../c_html_products/"'文件夹
html_url_name=rs("html_url_cn")
Fso_info host,folder,html_url_name

host="e_products_show/?id="+Cstr(rs("id"))'前台动态地址
folder="../html_products/"'文件夹
html_url_name=rs("html_url_en")
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
rs_del.open "select * from [yuzhiguo_products]  where id="&del_id,conn,1,1

sql="delete from [yuzhiguo_products] where id="&del_id
pic=rs_del("pic")'定义要删除的图片
pic_small=get_pic(pic,2)
pic1=rs_del("pic1")
pic1_small=get_pic(pic1,2)
pic2=rs_del("pic2")
pic2_small=get_pic(pic2,2)
pic3=rs_del("pic3")
pic3_small=get_pic(pic3,2)
file_html_c="../c_html_products/"+rs_del("html_url_cn")'定义要删除的文件
file_html_e="../html_products/"+rs_del("html_url_en")'定义要删除的文件
conn.execute sql

file_delete pic
file_delete pic_small
file_delete pic1
file_delete pic1_small
file_delete pic2
file_delete pic2_small
file_delete pic3
file_delete pic3_small
file_delete file_html_c
file_delete file_html_e

next
Call Alert ("批量删除成功",""&filename&"")
ElseIf Request("Del")="批量修改" Then
Server.ScriptTimeout=99999999
Dim pl_id,cpbh,e_cpmc,newpro,sort
For i=1 to request.form("pl_id").count
pl_id=replace(request.form("pl_id")(i),"'","")
cpbh=replace(request.form("cpbh")(i),"'","")
e_cpmc=replace(request.form("e_cpmc")(i),"'","")
newpro=replace(request.form("newpro")(i),"'","")

If replace(request.form("sort")(i),"'","")="" Then 
sort=0
else
sort=replace(request.form("sort")(i),"'","")
end if

set rs=conn.Execute("select * from yuzhiguo_products where id="&pl_id)
conn.Execute("update yuzhiguo_products set cpbh='"&cpbh&"',e_cpmc='"&e_cpmc&"',newpro="&newpro&",sort="&sort&" where id="&pl_id)
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
