<%@language=vbscript codepage=65001 %>
<!--#include file="pub/conn_index.asp"-->
<!--#include file="pub/function.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>小鱼儿网站地图</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%
' sitemap.asp
session("count")=0
'你的域名
session("server")="http://"&Request.ServerVariables("SERVER_NAME")&webfolder
'制作生成SiteMap.xml的目录,后面不要带"/",大小写敏感
vDir = "SiteMap.xml"
'设置你想要GOOGLE收录的文件文件名扩展名
Extensions = Array("html","htm","shtml","shtm")
'需要过滤的目录
PathExclusion=Array("\admin","\_vti_cnf","_vti_pvt","_vti_log","cgi-bin","aspnet_client","shejifangeditor","css","admin","guanli","pub","xiaoyuerdata","js","images")
set objfso = CreateObject("Scripting.FileSystemObject")
root = Server.MapPath(vDir)
'response.End 
'创建文件
objfso.createtextfile(server.mappath(vDir))
response.write "<p><strong style='font-family:arial,sans-serif;font-size=12'>创建"&vDir&"成功！</strong><I style='font-family:arial,sans-serif;font-size=12'> "&server.mappath(vDir)&" </I></p>"
response.write "<p><strong style='font-family:arial,sans-serif;font-size=12'>正在索引文件,请稍侯...</strong></p>"
Set openfileobj=objfso.opentextfile(server.mappath(vDir),8)
openfileobj.writeline"<?xml version='1.0' encoding='UTF-8'?>"
openfileobj.writeline"<urlset xmlns='http://www.google.com/schemas/sitemap/0.84'>"
'===
str=root
strLeft=split(str,vDir)(0)
'===
Set objFolder = objFSO.GetFolder(strLeft)
Set colFiles = objFolder.Files
For Each objFile In colFiles
     openfileobj.writeline getfilelink(objFile.Path,objfile.dateLastModified)
Next
ShowSubFolders(objFolder)
openfileobj.writeline "</urlset>"
response.write "<p><strong style='font-family:arial,sans-serif;font-size=12'>"&vDir&"生成完毕，共<span style=color:#FF0000> "&session("count")&" </span>个文件被索引</strong></p>"
set fso = nothing
Sub ShowSubFolders(objFolder)
     Set colFolders = objFolder.SubFolders
     For Each objSubFolder In colFolders
         if folderpermission(objSubFolder.Path) then
               openfileobj.writeline getfilelink(objSubFolder.Path,objSubFolder.dateLastModified)
               Set colFiles = objSubFolder.Files
               For Each objFile In colFiles
                   openfileobj.writeline getfilelink(objFile.Path,objFile.dateLastModified)
               Next
               ShowSubFolders(objSubFolder)
         end if
     Next
End Sub
Function getfilelink(file,datafile)
     file=replace(file,root,"")
     file=replace(file,"\","/")
     If FileExtensionIsBad(file) then Exit Function
     if month(datafile)<10 then filedatem="0"
     if day(datafile)<10 then filedated="0"
     filedate=year(datafile)&"-"&filedatem&month(datafile)&"-"&filedated&day(datafile)
strLeft=replace(strLeft,"\","/")
file=(split(LCASE(file),LCASE(strLeft)))(1)
     getfilelink = "<url>"&Chr("10")&"<loc>"&server.htmlencode(session("server")&"/"&file)&"</loc>"&Chr("10")&"<lastmod>"&filedate&"</lastmod>"&Chr("10")&"<changefreq>daily</changefreq>"&Chr("10")&"<priority>1.0</priority>"&Chr("10")&"</url>"
         session("count")=session("count")+"1"
         Response.Flush
End Function
Function Folderpermission(pathName)
     Folderpermission =True
     for each PathExcluded in PathExclusion
         if instr(ucase(pathName),ucase(PathExcluded))>0 then
               Folderpermission = False
               exit for
         end if
     next
End Function
Function FileExtensionIsBad(sFileName)
     Dim sFileExtension, bFileExtensionIsValid, sFileExt 
     if len(trim(sFileName)) = 0 then
         FileExtensionIsBad = true
         Exit Function
     end if
     sFileExtension = right(sFileName, len(sFileName) - instrrev(sFileName, "."))
     bFileExtensionIsValid = false
     for each sFileExt in extensions
         if ucase(sFileExt) = ucase(sFileExtension) then
               bFileExtensionIsValid = True
               exit for
         end if
     next
     FileExtensionIsBad = not bFileExtensionIsValid
End Function
%>
</body>
</html>
