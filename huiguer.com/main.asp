<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>网站后台管理主页</title>
<!--#include file="check.asp"-->
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
a:link {
	color: #FF0000;
}
-->
</style></head>

<body>
<table width="99%" border="0" align="center" cellpadding="3" cellspacing="1" class="a2">
<tr>
<td colspan="4" align="center" class="a1">服务器信息</td>
</tr>
<tr>
<td align="right" class="a3">服务器名：</td>
<td class="a3"><%=Request.ServerVariables("SERVER_NAME")%></td>
<td align="right" class="a3">服务器IP：</td>
<td class="a3"><%=Request.ServerVariables("LOCAL_ADDR")%> 端口：<%=Request.ServerVariables("SERVER_PORT")%></td>
</tr>
<tr>
<td align="right" class="a3">本文件绝对路径：</td>
<td colspan="3" class="a3"><%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%></td>
</tr>
<tr>
<td align="right" class="a3">服务器操作系统：</td>
<td class="a3"><%=Request.ServerVariables("OS")%></td>
<td align="right" class="a3">服务器时间：</td>
<td class="a3"><%=now%></td>
</tr>
<tr>
<td align="right" class="a3">脚本解释引擎：</td>
<td class="a3"><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
<td align="right" class="a3">脚本超时时间：</td>
<td class="a3"><%=Server.ScriptTimeout%> 秒</td>
</tr>
<tr>
<td align="right" class="a3">客户端IP：</td>
<td class="a3"><%=Request.ServerVariables("REMOTE_ADDR")%></td>
<td align="right" class="a3">CDO.Message邮箱组件：</td>
<td class="a3"><%If IsObjInstalled("CDO.Message") Then%>
<font color="#00CC00">支持√</font>
<%else%>
<font color="#FF0000">不支持×</font>
<%end if%></td>
</tr>
<tr>
<td align="right" class="a3">FSO组件：</td>
<td class="a3">
<%If IsObjInstalled("Scripting.FileSystemObject") then%>   <font color="#00CC00">支持√</font>
<%else%>    <font color="#FF0000">不支持×</font>
<%end if%>  </td>
<td align="right" class="a3">Jmail邮箱组件：</td>
<td class="a3"><%If IsObjInstalled("JMail.Message") Then%>
Jmail4.3邮箱组件 <font color="#00CC00">支持√</font>
<%elseIf IsObjInstalled("JMail.SMTPMail") then%>
Jmail4.2邮箱组件 <font color="#00CC00">支持√</font>
<%else%>
<font color="#FF0000">不支持×</font>
<%
set rs=server.CreateObject("adodb.recordset")
sql="select * from yuzhiguo_setup"
rs.open sql,conn,1,3
rs.update
rs("mail_jmail")=0
rs.update
rs.close
set rs=nothing
%>
<%end if%>  </td>
</tr>
<tr>
<td align="right" class="a3">adodb.stream组件：</td>
<td class="a3">
<%

on error resume next

dim objstream
set objstream = Server.CreateObject("adodb.stream")
objstream.Open

if err.number <> 0 then
err.Clear
%>
<font color="#FF0000">不支持×</font>
<%
else
%>    <font color="#00CC00">支持√</font>
<%
end if

%>  </td>
<td align="right" class="a3">Aspjpeg组件：</td>
<td class="a3">
<%
Set Jpeg = Server.CreateObject("Persits.Jpeg")
Response.Write "到期时间："&Jpeg.Expires

if -2147221005=Err  or Jpeg.Expires<now() then
%>
<font color="#FF0000">不支持×</font>
<%
set rs=server.CreateObject("adodb.recordset")
sql="select * from yuzhiguo_setup"
rs.open sql,conn,1,3
rs.update
rs("pic_aspjpeg")=0
rs("font_aspjpeg")=0
rs.update
rs.close
set rs=nothing
%>
<%
else
%>
<font color="#00CC00">支持√</font>
<%
end if
Set Jpeg = nothing
%>  </td>
</tr>
</table>
<br />
<table width="99%" cellpadding="3" cellspacing="1" border="0" align="center" class="a2">
<tr>
<td colspan="4" align="center" class="a1">系统信息</td>
</tr>
<tr>
<td align="right" class="a3" >产品总数：</td>
<td align="left" class="a3" ><font color="red"><%=Mydb("Select Count([ID]) From [yuzhiguo_products]",1)(0)%></font>个</td>
<td align="right" class="a3" >留言总数：</td>
<td align="left" class="a3" >英文<font color="red"><%=Mydb("Select Count([ID]) From [yuzhiguo_e_feedback]",1)(0)%></font>条</td>
</tr>
<tr>
  <td align="right" class="a3" >订单总数：</td>
  <td align="left" class="a3" >英文<font color="red"><%=Mydb("Select Count([ID]) From [yuzhiguo_e_order]",1)(0)%></font>个</td>
  <td align="right" class="a3" >链接总数：</td>
  <td align="left" class="a3" >英文<font color="red"><%=Mydb("Select Count([link_id]) From [yuzhiguo_e_link]",1)(0)%></font>个</td>
</tr>
<tr>
  <td align="right" class="a3" >新闻总数：</td>
  <td align="left" class="a3" >英文<font color="red"><%=Mydb("Select Count([ID]) From [yuzhiguo_e_news]",1)(0)%></font>个</td>
  <td align="right" class="a3" >&nbsp;</td>
  <td align="left" class="a3" >&nbsp;</td>
</tr>
</table>
<br />

<table width="99%" border="0" align="center" cellpadding="3" cellspacing="1" class="a2">
<tr>
<td colspan="4" align="center" class="a1">系统说明</td>
</tr>
<td width="26%"></tr>
<tr>
<td align="right" class="a3" >技术支持：</td>
<td width="24%" align="left" class="a3" ><font color="red"><a href="http://huigur.taobao.com" target="_blank">慧谷动力设计</a></font></td>
<td width="26%" align="right" class="a3" >地址：</td>
<td width="24%" align="left" class="a3" >贵州省铜仁市</td>
</tr>
<tr>
  <td align="right" class="a3" >E-mail：</td>
  <td align="left" class="a3" ><a href="mailto:mikl@163.com">mikl@163.com</a></td>
  <td align="right" class="a3" >脚本：</td>
  <td align="left" class="a3" >ASP VBSCRIPT</td>
</tr>
<tr>
  <td align="right" class="a3" >QQ：</td>
  <td align="left" class="a3" ><a target=blank href=tencent://message/?uin=995226433&Site=慧谷动力&Menu=yes><img border="0" SRC=http://wpa.qq.com/pa?p=1:995226433:5 alt="有事您找我!!"></a></td>
  <td align="right" class="a3" >&nbsp;</td>
  <td align="left" class="a3" >&nbsp;</td>
</tr>
</table>
</body>
</html>
