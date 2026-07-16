<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<!--#include file="../pub/function.asp"-->
<%
Set news=Server.CreateObject("ADODB.Recordset")
Sql="Select * From yuzhiguo_e_news where id="&trim(request("id"))
news.Open Sql,Conn,1,1
if news.bof and news.eof then
response.write"<script>alert('No Data');location.href='../e_news/';</script>"
else
%>
<title><%=news("title")%></title>
<meta name="keywords" content="<%=news("keywords")%>" />
<meta name="description" content="<%=news("description")%>" />
<meta name="author" content="Web Design：Xiehui QQ:995226433@qq.com Website:http://huigur.taobao.com" />
<link href="../css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
<script language="javascript"  type="text/javascript" src="../pub/e_hits.asp?action=news_hits&amp;id=<%=trim(request("id"))%>"></script>
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
<div class="icompany">
	  <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">News Center</span></div>
	  <div class="cmore"></div>
	  </div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td align="center" bgcolor="#E6F2EF"><h1 class="weizhi"><%=news("name")%></h1></td>
    </tr>
  <tr>
    <td align="right" class="grey">Author : <%=news("author")%> Date : <%=news("date")%></td>
    </tr>
  
  <tr>
    <td><div class="hangju"> <%=news("content")%> </div></td>
  </tr>
</table>
</div>
</td>
    </tr>
  </table>
  <%
end if
news.close
set news=nothing
%>

</div>
  <!--#include file="../pub/e_foot.asp"-->
</body>
</html>
