<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="check.asp"-->
<title>网站中文首页生成静态</title>
<meta name="author" content="Web Design：Yuzhiguo QQ:286313315 E-mail:vip@yuzhiguo.com Website:http://www.yuzhiguo.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%
host="index_cn.asp"'前台动态地址
folder="../"'文件夹
filename="index_cn.html"'生成静态文件名
Fso_info host,folder,filename
rs.close
set rs=nothing
response.write"生成网站中文首页静态HTML完成.<br />"
%>
<!--#include file="foot.asp"-->
</body>
</html>
