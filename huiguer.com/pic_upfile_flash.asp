<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="pub/css.css" rel="stylesheet" type="text/css">
<!--#include file="conn.asp"-->
<!--#include file="pub/upload.inc"-->
<%if  session("yuzhiguo_admin")<>"" then%>
<%

set upload=new upload_file
if upload.form("act")="uploadfile" then
file_name=trim(upload.form("file_name"))
filepath=trim(upload.form("filepath"))
filelx=trim(upload.form("filelx"))
filesize=trim(upload.form("filesize"))
i=0
for each formName in upload.File
set file=upload.File(formName)

fileExt=lcase(file.FileExt)	'得到的文件扩展名不含有.
if file.filesize<1 then
response.write "<script language=javascript>alert('请先选择你要上传的文件!');history.back()</script>"
response.end
end if
if fileext<>"gif" and fileext<>"jpg" and fileext<>"png" then
response.write "<script language=javascript>alert('只能上传jpg或gif格式的图片!');history.back()</script>"
response.end
end if
if file.filesize>(200*1024) then
response.write "<script language=javascript>alert('最大只能上传 200K 的图片文件!');history.back()</script>"
response.end
end if

randomize
ranNum=int(90000*rnd)+10000
if file_name="" then
filename=filepath&year(now)&"-"&month(now)&"-"&day(now)&"-"&hour(now)&"-"&minute(now)&"-"&second(now)&"."&fileExt
else
filename=filepath&file_name&"."&fileExt
end if
%>

<%
if file.FileSize>0 then'如果 FileSize > 0 说明有文件数据
file.SaveToFile Server.mappath(FileName)'保存文件

response.write "<div style='color:#CCFF66;' align='center'>图片上传成功,路径为："&FileName&"</div>"

if filelx="swf" then
response.write "<script>window.opener.document."&upload.form("FormName")&".size.value='"&int(file.FileSize/1024)&" K'</script>"
end if
response.write "<script>window.opener.document."&upload.form("FormName")&"."&upload.form("EditName")&".value='"&FileName&"'</script>"
%>

<%
end if
set file=nothing
next
set upload=nothing
end if
%>
<script language="javascript">
window.alert("文件上传成功!请不要修改生成的链接地址！");
window.close();
</script>
<%
else
response.Redirect("index.asp")
end if
%>
