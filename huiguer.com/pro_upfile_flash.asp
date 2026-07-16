<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="pub/css.css" rel="stylesheet" type="text/css">
<!--#include file="conn.asp"-->
<!--#include file="pub/upload.inc"-->
<!--#include file="pub/build_small_pic.asp"-->
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
if fileext<>"gif" and fileext<>"jpg"  then
response.write "<script language=javascript>alert('只能上传jpg或gif格式的图片!');history.back()</script>"
response.end
end if
if file.filesize>(500*1024) then
response.write "<script language=javascript>alert('最大只能上传 500K 的图片文件!');history.back()</script>"
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

'当支持aspjpeg组件时，生成缩略图
if pic_aspjpeg = 1 then
'FileName=BuildSmallPic(FileName, filepath, 700, 1000)'产品大图宽度不超过700像素，高度不超过1000像素
filepath_small=replace(filepath,"big","small")
FileName_small=BuildSmallPic(FileName, filepath_small, pic_width, pic_height)'产品小图按后台填写大小生成
response.write "<div style='color:#CCFF66;' align='center'>产品小图生成成功,路径为："&FileName_small&"</div>"
end if

'当支持aspjpeg组件时，加水印
if font_aspjpeg = 1 then
Dim Jpeg
Set Jpeg = Server.CreateObject("Persits.Jpeg")
Jpeg.Open Server.MapPath(FileName)
Jpeg.Canvas.Font.Color = "&H"&""&font_color&""
Jpeg.Canvas.Font.Size = ""&font_size&""
Jpeg.Canvas.Font.Family = ""&font_family&""
Jpeg.Canvas.Font.ShadowColor = "&H"&""&font_bg_color&""
Jpeg.Canvas.Font.ShadowXoffset = 1
Jpeg.Canvas.Font.ShadowYoffset = 1
Jpeg.Canvas.Font.Quality = 4
Jpeg.Canvas.Font.Bold = false
Jpeg.Canvas.Print 10,10,""&font_text&""
'Jpeg.Canvas.Print jpeg.width-400,jpeg.Height-100,""&font_text&""
Jpeg.Quality=95
Jpeg.Save Server.MapPath(FileName)
Set Jpeg = Nothing
end if

response.write "<div style='color:#CCFF66;' align='center'>产品大图上传成功,路径为："&FileName&"</div>"

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
