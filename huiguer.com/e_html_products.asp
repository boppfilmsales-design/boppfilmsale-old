<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="check.asp"-->
<title>产品生成静态</title>
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%
if request("action") = "html_id" then
call html_id()
else
call html_all()
end if
%>

<%
sub html_all()
'全部生成html
set rs=server.CreateObject("adodb.recordset")
Sql = "Select * from yuzhiguo_products order by id"
rs.open sql,conn,1,1
totalPut=rs.recordcount
%>
总共有：<font color="#FF0000"><%=totalPut%></font>页需要生成！<br />
<%
do while not rs.eof
on error resume next 
host="e_products_show/?id="+Cstr(rs("id"))'前台动态地址
folder="../html_products/"'文件夹
html_url_name=rs("html_url_en")
Fso_info host,folder,html_url_name
rs.movenext
loop
rs.close
set rs=nothing
response.write"全部生成HTML完成.<br />"
end sub
%>

<%
sub html_id()
'单个产品生成
Set rs=Server.CreateObject("ADODB.Recordset")
Sql="Select * From yuzhiguo_products where id="&trim(request("id"))
rs.Open Sql,Conn,1,1

host="e_products_show/?id="+Cstr(rs("id"))'前台动态地址
folder="../html_products/"'文件夹
html_url_name=rs("html_url_en")'生成静态文件名
Fso_info host,folder,html_url_name
rs.close
set rs=nothing
Call Alert ("生成完成！",-1)
end sub
%>
<!--#include file="foot.asp"-->
</body>
</html>
