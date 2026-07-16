<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%if  session("yuzhiguo_admin")<>"" then%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>空间占用情况查看</title>
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<style type="text/css">
<!--
body  {
Font:normal 12px 宋体;
Background:#9EB6D8; font:Verdana 12px;
SCROLLBAR-FACE-COLOR: #799AE1;
SCROLLBAR-HIGHLIGHT-COLOR: #799AE1;
SCROLLBAR-SHADOW-COLOR: #799AE1;
SCROLLBAR-DARKSHADOW-COLOR: #799AE1;
SCROLLBAR-3DLIGHT-COLOR: #799AE1;
SCROLLBAR-ARROW-COLOR: #FFFFFF;
SCROLLBAR-TRACK-COLOR: #AABFEC;
margin: 0px;
padding: 0px;}
.tableall {
WIDTH: 97%;
BORDER-RIGHT: #183789 1px solid;
BORDER-TOP: #183789 1px solid;
BORDER-LEFT: #183789 1px solid;
BORDER-BOTTOM: #183789 1px solid;
BACKGROUND-COLOR: #ffffff}
.tabletd1 {

text-align: center;
text-valign: middle;
padding: 1px;
font-size: 14px;
color: #ffffff;
FONT-WEIGHT: bold;
BACKGROUND-IMAGE: url(Images/titlebg.gif);
BACKGROUND-COLOR: #799AE1}
.tabletd2 {

PADDING-RIGHT: 3px;
PADDING-LEFT: 3px;
BACKGROUND: #E4EDF9;
PADDING-BOTTOM: 3px;
PADDING-TOP: 3px}
.tabletd3 {

PADDING-RIGHT: 3px;
PADDING-LEFT: 3px;
BACKGROUND: #F1F3F5;
PADDING-BOTTOM: 3px;
PADDING-TOP: 3px}
table  {
border:0px; }
td  {
font:normal 12px 宋体;}
a:hover  {
color:#FF0000;
text-decoration:underline overline;}
a:visited {
text-decoration: none;}
-->
</style>
</head>
<body><br />
<%on error resume next%>
<%
Sub ShowSpaceInfo(drvpath)
dim fso,d,size,showsize
set fso=server.createobject("scripting.filesystemobject")
drvpath=server.mappath(drvpath)
set d=fso.getfolder(drvpath)
size=d.size
showsize=size & " Byte"
if size>1024 then
size=(size\1024)
showsize=size & " KB"
end if
if size>1024 then
size=(size/1024)
showsize=size & " MB"
end if
if size>1024 then
size=(size/1024)
showsize=size & " GB"
end if
response.write "<font face=verdana>" & showsize & "</font>"
End Sub

Sub Showspecialspaceinfo(method)
dim fso,d,fc,f1,size,showsize,drvpath
set fso=server.createobject("scripting.filesystemobject")
drvpath=server.mappath("pic")
drvpath=left(drvpath,(instrrev(drvpath,"\")-1))
set d=fso.getfolder(drvpath)

if method="All" then
size=d.size
elseif method="Program" then
set fc=d.Files
for each f1 in fc
size=size+f1.size
next
end if

showsize=size & " Byte"
if size>1024 then
size=(size\1024)
showsize=size & " KB"
end if
if size>1024 then
size=(size/1024)
showsize=size & " MB"
end if
if size>1024 then
size=(size/1024)
showsize=size & " GB"
end if
response.write "<font face=verdana>" & showsize & "</font>"
end sub

Function Drawbar(drvpath)
dim fso,drvpathroot,d,size,totalsize,barsize
set fso=server.createobject("scripting.filesystemobject")
drvpathroot=server.mappath("pic")
drvpathroot=left(drvpathroot,(instrrev(drvpathroot,"\")-1))
set d=fso.getfolder(drvpathroot)
totalsize=d.size

drvpath=server.mappath(drvpath)
set d=fso.getfolder(drvpath)
size=d.size

barsize=cint((size/totalsize)*400)
Drawbar=barsize
End Function

Function Drawspecialbar()
dim fso,drvpathroot,d,fc,f1,size,totalsize,barsize
set fso=server.createobject("scripting.filesystemobject")
drvpathroot=server.mappath("pic")
drvpathroot=left(drvpathroot,(instrrev(drvpathroot,"\")-1))
set d=fso.getfolder(drvpathroot)
totalsize=d.size

set fc=d.files
for each f1 in fc
size=size+f1.size
next

barsize=cint((size/totalsize)*400)
Drawspecialbar=barsize
End Function
%> <table border="0" ALIGN="CENTER" cellpadding=0 cellspacing=1 class="tableall">
<tr> <td WIDTH="100%" height=25 class="tabletd1">
系统空间占用情况</td>
</tr> <tr> <td WIDTH="100%" class="tabletd2" >
<blockquote class="tabletd2">
<%
fsorank=1
if fsorank=1 then
%> <br> <%Function GetPP
dim s
s=Request.ServerVariables("path_translated")
GetPP=left(s,instrrev(s,"\",len(s)))
End function
if sPP="" then sPP=GetPP
if right(sPP,1)<>"\" then sPP=sPP&"\"
set fso=server.createobject("scripting.filesystemobject")
Set f = fso.GetFolder(sPP)
Set fc = f.SubFolders
i=1
i2=1
For Each f in fc%> 目录<b><%=f.name%></b>占用空间： <img src="images/bar.gif" width=<%=drawbar(""&f.name&"")%> height=10> <%showSpaceinfo(""&f.name&"")%><br><br>
<%i=i+1
if i2<10 then
i2=i2+1
else
i2=1
end if
Next%> 其他文件占用空间： <img src="images/bar.gif" width=<%=drawspecialbar%> height=10> <%showSpecialSpaceinfo("Program")%><br><br>
系统占用空间总计： <img src="images/bar.gif" width=400 height=10> <%showspecialspaceinfo("All")%>
<%
else
response.write "<br><li>本功能已经被关闭"
end if
%> </blockquote></td></tr> </table>
<%
if err.number = 0 then
end if
%>
<%
else
response.Redirect("index.asp")
end if
%>
