<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<!--#include file="../pub/function.asp"-->
<% 
	if trim(request("id"))<>"" then
	id=Cint(trim(request("id")))
	else
	id=2'首页显示ID
	end if
	set rs=Server.CreateObject("ADODB.RecordSet")
	sql="select * from yuzhiguo_e_other where id="&id&""
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then 
	response.write"<script>alert('您访问的数据不存在！');location.href='index.asp';</script>"
	else 
	id=rs("id")
	name=rs("name")
	content=rs("content")
	title=rs("title")
	keywords=rs("keywords")
	description=rs("description")
	rs.close 
	set rs=nothing
	end if
	%>
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
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
<div class="iproducts">   <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle"><%=title%></span></div>
	  <div class="cmore"></div></div></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto;">

  <tr>
    <td valign="top">
    <div class="hangju">
    <%=content%>    </div></td>
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
