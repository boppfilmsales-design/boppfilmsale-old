<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="上传图片管理"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<%
'系统变量
Dim c_UploadDirg,c_PicType
Dim c_filelb,c_cook,con_MaxPerPage,con_Page,con_picwidth,con_picheight
dim c_strFileName,Action,totalPut,CurrentPage,TotalPages,upforder2
dim UploadDir,TruePath,fso,theFolder,theFile,thisfile,FileCount,TotalSize,TotalSize_Page
dim strFileType,sqlup,rsup,strFiles,iij,strDirName,strFileName
dim forder,upforder,action_cook,c_MaxPerPage,cook_MaxPerPage,cook_MaxPerPage01
dim c_Page,cook_Page,cook_Page01,c_picwidth,cook_picwidth,cook_picwidth01
dim c_picheight,cook_picheight,cook_picheight01

'============参数设置（等号“=”前后不要留空）===================

c_UploadDirg="../pic"   '图片所在文件夹
c_PicType="jpg|gif|png|bmp" '图片类型 (可使用|将图片格式分开)
c_filelb=""   '左则是否显示当前目录下文件。（是：显示，否则不显示）
c_cook="是"   '是否显示并允许使用自定义功能。（是：可用，否则不可用）
con_MaxPerPage=12     '每页显示图片数
con_Page=4      '每行显示图片数
con_picwidth=130    '图片缩图宽度
con_picheight=130    '图片缩图高度

'=============================================================

UploadDir =c_UploadDirg
c_filelb = Replace(c_filelb,"是","YES")
c_cook = Replace(c_cook,"是","YES")
If UploadDir = "" Then   UploadDir="./"
if right(UploadDir,1)<>"/" or right(UploadDir,1)<>"\" then
UploadDir=UploadDir & "/"
End if

forder=request("forder")
If instr(forder,"../")>0 Or instr(forder,"./")>0 Then
Response.write "<script language='javascript'>alert('路径有误！');history.go(-1);</script>"
Response.End
End if
if forder<>"" then
if right(forder,1)<>"/" then
forder=forder & "/"
End If
UploadDir=UploadDir&forder
end If

if instr(forder,"/")>0 then
upforder=left(forder,instrrev(forder,"/")-1)    'upforder当前目录去末尾的/
end If
if instr(upforder,"/")>0 then
upforder2=left(upforder,instrrev(upforder,"/")-1) 'upforder2上一层目录
end If

TruePath=Server.MapPath(UploadDir)
if upforder2<>"" then
TruePath2=Server.MapPath(upforder2)
end If

c_strFileName=Request.ServerVariables("script_name")
If forder = "" Then
strFileName = c_strFileName
c_strFileName = c_strFileName
Else
strFileName = c_strFileName
c_strFileName = c_strFileName &"?forder="&forder&"&"
End If

Action=trim(Request("Action"))

if trim(request("page"))<>"" then
currentPage=cint(request("page"))
else
currentPage=1
end if

'自定义每页图片数、行数、宽度、高度
If c_cook   =  "YES" then
action_cook = request("action_cook")

Select Case action_cook
Case "cookies"
cook_MaxPerPage = trim(replace(request("cook_MaxPerPage")," ",""))
cook_Page       = trim(replace(request("cook_Page")," ",""))
cook_picwidth   = trim(replace(request("cook_picwidth")," ",""))
cook_picheight  = trim(replace(request("cook_picheight")," ",""))

if  not(IsNumeric(cook_MaxPerPage)) then
Response.write "<script language='javascript'>alert('第页图片数：你输入的不是纯数字，请输入1-30之间的数字！');history.go(-1);</script>"
Response.end
elseif   cook_MaxPerPage<1  or cook_MaxPerPage>30 then
Response.write "<script language='javascript'>alert('第页图片数：请输入1-30之间的数字！');history.go(-1);</script>"
Response.end
end if
if  not(IsNumeric(cook_Page)) then
Response.write "<script language='javascript'>alert('每行图片数：你输入的不是纯数字，请输入正确数字！');history.go(-1);</script>"
Response.end
elseif   cook_Page<1  or cook_Page>10 then
Response.write "<script language='javascript'>alert('每行图片数：请输入1-10之间的数字！');history.go(-1);</script>"
Response.end
end if
if  not(IsNumeric(cook_picwidth)) then
Response.write "<script language='javascript'>alert('图片宽度：你输入的不是纯数字，请输入正确数字！');history.go(-1);</script>"
Response.end
elseif   cook_picwidth<20  or cook_Page>800 then
Response.write "<script language='javascript'>alert('图片宽度：请输入20-800之间的数字！');history.go(-1);</script>"
Response.end
end if
if  not(IsNumeric(cook_picheight)) then
Response.write "<script language='javascript'>alert('图片高度：你输入的不是纯数字，请输入正确数字！');history.go(-1);</script>"
Response.end
elseif   cook_picheight<20  or cook_picheight>800 then
Response.write "<script language='javascript'>alert('图片高度：请输入20-800之间的数字！');history.go(-1);</script>"
Response.end
end If

Response.cookies("cycpic")("cook_MaxPerPage") = cook_MaxPerPage
Response.cookies("cycpic")("cook_Page")       = cook_Page
Response.cookies("cycpic")("cook_picwidth")   = cook_picwidth
Response.cookies("cycpic")("cook_picheight")  = cook_picheight

if cook_MaxPerPage<>"" and cook_Page<>"" and cook_picwidth<>"" and cook_picheight<>"" then
Select Case Request.Form("CookieTime")
Case 1
Response.cookies("cycpic").Expires=Date+1
Case 2
Response.cookies("cycpic").Expires=Date+7
Case 3
Response.cookies("cycpic").Expires=Date+31
Case 4
Response.cookies("cycpic").Expires=Date+365
End Select
end If

Case "con"
Response.cookies("cycpic")("cook_MaxPerPage") = con_MaxPerPage
Response.cookies("cycpic")("cook_Page")       = con_Page
Response.cookies("cycpic")("cook_picwidth")   = con_picwidth
Response.cookies("cycpic")("cook_picheight")  = con_picheight
End Select
End If
'---------------------------------
cook_MaxPerPage = Request.cookies("cycpic")("cook_MaxPerPage")
cook_Page       = Request.cookies("cycpic")("cook_Page")
cook_picwidth   = Request.cookies("cycpic")("cook_picwidth")
cook_picheight  = Request.cookies("cycpic")("cook_picheight")
if cook_MaxPerPage="" then c_MaxPerPage = con_MaxPerPage  else c_MaxPerPage = cook_MaxPerPage
if cook_Page="" then       c_Page       = con_Page        else c_Page       = cook_Page
if cook_picwidth="" then   c_picwidth   = con_picwidth    else c_picwidth   = cook_picwidth
if cook_picheight="" then  c_picheight  = con_picheight   else c_picheight  = cook_picheight


'------------------------------------------------
'上一页、下一页链接
sub showpage(sfilename,totalnumber,c_MaxPerPage)
dim n, i,strTemp
c_MaxPerPage=CInt(c_MaxPerPage)
if totalnumber mod c_MaxPerPage=0 then
n= totalnumber \ c_MaxPerPage
else
n= totalnumber \ c_MaxPerPage+1
end If
If totalnumber=0 Then
Exit Sub
End if
strTemp= "<table align='center'><form name='showpages' method='Post' action='" & sfilename & "'><tr><td>"
strTemp=strTemp & "当前目录下共 <b>" & totalnumber & "</b> 个文件，占用 <b>" & TotalSize\1024 & "</b> K "
sfilename=JoinChar(sfilename)
if CurrentPage<2 then
strTemp=strTemp & "首页 上一页 "
else
strTemp=strTemp & "<a  title='首页' href='" & sfilename & "page=1'>首页</a> "
strTemp=strTemp & "<a  title='上一页' href='" & sfilename & "page=" & (CurrentPage-1) & "'>上一页</a> "
end if

if n-currentpage<1 then
strTemp=strTemp & "下一页 尾页"
else
strTemp=strTemp & "<a  title='下一页' href='" & sfilename & "page=" & (CurrentPage+1) & "'>下一页</a> "
strTemp=strTemp & "<a  title='尾页' href='" & sfilename & "page=" & n & "'>尾页</a>"
end if
strTemp=strTemp & " 页次：<strong><font color=red>" & CurrentPage & "</font>/" & n & "</strong>页 "
strTemp=strTemp & " <b>" & c_MaxPerPage & "</b>" & "个文件/页"
strTemp=strTemp & " 转到：<select name='page' size='1' onchange='javascript:submit()'>"
for iij = 1 to n
strTemp=strTemp & "<option value='" & iij & "'"
if cint(CurrentPage)=cint(iij) then strTemp=strTemp & " selected "
strTemp=strTemp & ">第" & iij & "页</option>"
next
strTemp=strTemp & "</select>"
strTemp=strTemp & "</td></tr></form></table>"
response.write strTemp
end sub
'------------------------------------------------
Sub ShowObjectInstalled(strObjName)
If IsObjInstalled(strObjName) Then
Response.Write "<b>√</b>"
Else
Response.Write "<font color='red'><b>×</b>(无)</font>"
End If
End Sub
'------------------------------------------------
'函数名：IsObjInstalled 检查组件是否已经安装（参  数：strClassString ----组件名）
'返回值：True  ----已经安装  False ----没有安装
Function IsObjInstalled(strClassString)
On Error Resume Next
IsObjInstalled = False
Err = 0
Dim xTestObj
Set xTestObj = Server.CreateObject(strClassString)
If 0 = Err Then IsObjInstalled = True
Set xTestObj = Nothing
Err = 0
End Function

'------------------------------------------------
'函数名：JoinChar
'作  用：向地址中加入 ? 或 &
'参  数：strUrl  ----网址
'返回值：加了 ? 或 & 的网址
function JoinChar(strUrl)
if strUrl="" then
JoinChar=""
exit function
end if
if InStr(strUrl,"?")<len(strUrl) then
if InStr(strUrl,"?")>1 then
if InStr(strUrl,"&")<len(strUrl) then
JoinChar=strUrl & "&"
else
JoinChar=strUrl
end if
else
JoinChar=strUrl & "?"
end if
else
JoinChar=strUrl
end if
end Function
'目录存在时显示此目录下的所有子目录
Function ShowFolderList(folderspec)
On Error Resume Next
Dim f, f1, fc, s ,fs,jj,Filenames,FileSize,Filetype,i
set fs=CreateObject("Scripting.FileSystemObject")
Set f = fs.GetFolder(folderspec)
s = s &"<br /><B>当前目录下文件夹：</B><br />"
Set fc = f.SubFolders
jj=1
For Each f1 in fc
s = s & "<a title='"&f1.name&"' href='?forder="&forder&f1.name&"'><img  border='0' src='images/folder.gif' width='16' height='16'> "
s = s &""&jj&" . "& f1.name&"</a><br /><br />"
jj=jj+1
Next
If jj-1=0 then s = s &"(无)<br />"
If c_filelb  =  "YES"  then
s = s &"<br /><B>当前目录下文件：</B>"
'读取该文件夹下所有文件
Set  fc2  =  f.Files
i=1
For  Each  f1  in  fc2
Filenames=  f1.name
FileSize=  f1.Size
'Filetype=Right(Trim(Filenames),3)
If Len(Filenames)>20 Then  Filenames=Left(Filenames,20)&".."
If instr(LCase(c_PicType),LCase(Filetype))>0 Then
s = s &"<br /><a href='" & UploadDir & f1.name & "' target='_blank'  alt='[文件]"&f1.name &Chr(10)&"[大小]"&round(FileSize\1024)&"K'>"
s = s &"<img  border='0' src='images/file.gif' width='16' height='16'>"
s = s &i&"."&Filenames&"</a>"
else
i=i-1
End If
i=i+1
Next
If i-1=0 then s = s &"<br />(无)"
End if
ShowFolderList = s
End Function
%>
<SCRIPT language=javascript>
<!--
function unselectall()
{
if(document.myform.chkAll.checked){
document.myform.chkAll.checked = document.myform.chkAll.checked&0;
}
}

function CheckAll(form)
{
for (var i=0;i<form.elements.length;i++)
{
var e = form.elements[i];
if (e.Name != "chkAll")
e.checked = form.chkAll.checked;
}
}
//----------------------
//图片等比例缩图
flag=false
function DrawImage(ImgD)
{
var image=new Image();
image.src=ImgD.src;
if(image.width>0 && image.height>0){
flag=true;
if(image.width/image.height>= <%=c_picwidth%>/<%=c_picheight%>){
if(image.width><%=c_picwidth%>){
ImgD.width=<%=c_picwidth%>;
ImgD.height=(image.height*<%=c_picwidth%>)/image.width;
}else{
ImgD.width=image.width;
ImgD.height=image.height;
}
//ImgD.alt="规格："+image.width+"x"+image.height+" [点击图片在新窗口打开查看]";
}else{
if(image.height><%=c_picheight%>){
ImgD.height=<%=c_picheight%>;
ImgD.width=(image.width*<%=c_picheight%>)/image.height;
}else{
ImgD.width=image.width;
ImgD.height=image.height;
}
//ImgD.alt="规格："+image.width+"x"+image.height+" [点击图片在新窗口打开查看]";
}
}
}
//-------------------------
//鼠标悬停在图片上时提示框（注：样式未加入）
var pltsPop=null;
var pltsoffsetX = 10;   // 弹出窗口位于鼠标左侧或者右侧的距离；3-12 合适
var pltsoffsetY = 15;  // 弹出窗口位于鼠标下方的距离；3-12 合适
var pltsPopbg="#FFFFEE"; //背景色
var pltsPopfg="#111111"; //前景色
var pltsTitle="";
document.write('<div id=pltsTipLayer style="display: none;position: absolute; z-index:10001"></div>');
function pltsinits()
{
document.onmouseover   = plts;
document.onmousemove = moveToMouseLoc;
}
function plts()
{  var o=event.srcElement;
if(o.alt!=null && o.alt!=""){o.dypop=o.alt;o.alt=""};
if(o.title!=null && o.title!=""){o.dypop=o.title;o.title=""};
pltsPop=o.dypop;
if(pltsPop!=null&&pltsPop!=""&&typeof(pltsPop)!="undefined")
{
pltsTipLayer.style.left=-1000;
pltsTipLayer.style.display='';
var Msg=pltsPop.replace(/\n/g,"<br />");
Msg=Msg.replace(/\0x13/g,"<br />");
var re=/\{(.[^\{]*)\}/ig;
if(!re.test(Msg))pltsTitle="提示";
else{
re=/\{(.[^\{]*)\}(.*)/ig;
pltsTitle=Msg.replace(re,"$1")+"&nbsp;";
re=/\{(.[^\{]*)\}/ig;
Msg=Msg.replace(re,"");
Msg=Msg.replace("<br />","");}
var attr=(document.location.toString().toLowerCase().indexOf("list.asp")>0?"nowrap":"");
var content =
'<table style="FILTER:alpha(opacity=90) shadow(color=#bbbbbb,direction=135);" id=toolTipTalbe border=0><tr><td><table  cellspacing="1" cellpadding="0" style="width:100%">'+
'<tr id=pltsPoptop><th height=18 valign=bottom><b><p id=topleft align=left>↖'+pltsTitle+'</p><p id=topright align=right style="display:none">'+pltsTitle+'↗</font></b></th></tr>'+
'<tr><td "+attr+"  style="padding-left:14px;padding-right:14px;padding-top: 6px;padding-bottom:6px;line-height:135%">'+Msg+'</td></tr>'+
'<tr id=pltsPopbot style="display:none"><th height=18 valign=bottom><b><p id=botleft align=left>↙'+pltsTitle+'</p><p id=botright align=right style="display:none">'+pltsTitle+'↘</font></b></th></tr>'+
'</table></td></tr></table>';
pltsTipLayer.innerHTML=content;
toolTipTalbe.style.width=Math.min(pltsTipLayer.clientWidth,document.body.clientWidth/2.2);
moveToMouseLoc();
return true;
}
else
{
pltsTipLayer.innerHTML='';
pltsTipLayer.style.display='none';
return true;
}
}

function moveToMouseLoc()
{
if(pltsTipLayer.innerHTML=='')return true;
var MouseX=event.x;
var MouseY=event.y;
//window.status=event.y;
var popHeight=pltsTipLayer.clientHeight;
var popWidth=pltsTipLayer.clientWidth;
if(MouseY+pltsoffsetY+popHeight>document.body.clientHeight)
{
popTopAdjust=-popHeight-pltsoffsetY*1.5;
pltsPoptop.style.display="none";
pltsPopbot.style.display="";
}
else
{
popTopAdjust=0;
pltsPoptop.style.display="";
pltsPopbot.style.display="none";
}
if(MouseX+pltsoffsetX+popWidth>document.body.clientWidth)
{
popLeftAdjust=-popWidth-pltsoffsetX*2;
topleft.style.display="none";
botleft.style.display="none";
topright.style.display="";
botright.style.display="";
}
else
{
popLeftAdjust=0;
topleft.style.display="";
botleft.style.display="";
topright.style.display="none";
botright.style.display="none";
}
pltsTipLayer.style.left=MouseX+pltsoffsetX+document.body.scrollLeft+popLeftAdjust;
pltsTipLayer.style.top=MouseY+pltsoffsetY+document.body.scrollTop+popTopAdjust;
return true;
}
pltsinits();
//-----------------------------------------
//-->
</script>
<table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" class="a2" >
<tr >
<td colspan=2 align="center" class="a1"  >网站图片文件管理</td>
</tr>
<%
If not IsObjInstalled("Scripting.FileSystemObject") Then
Response.Write "<b><font color=red>你的服务器不支持 FSO(Scripting.FileSystemObject)! 不能显示文件</font></b>"
Else
set fso=CreateObject("Scripting.FileSystemObject")
Select Case Action
Case   "Del"
'删除选中文件
call DelFiles()
Case  "DelAll"
'删除当前目录所有文件
call DelAll()
Case Else
%>
<tr >
<td width="150" height="20" rowspan="2" class="a3" ><strong>图片目录导航</strong></td>
</tr>

<tr  >
<td  class="a3"><strong>当前位置：</strong><%If Trim(forder)<>"" then response.write replace(UploadDir,c_UploadDirg,"总目录") Else response.write"总目录/"%>                        </td>
</tr>

<tr >
<td width="150" rowspan="2" valign="top" class="a3" >
<a title='返回总目录' href='<%=strFileName%>'><img alt='' border='0' src='images/alllist.gif' width='16' height='16'>总目录</a>
<%if forder<>"" then response.write"<br /><a title='↑返回上层目录' href='"&strFileName&"?forder="&upforder2&"'><img alt='' border='0' src='images/up.gif' width='16' height='16'>返回上层目录</a><br />"%>
<%=ShowFolderList(TruePath)%>   </td>
<td valign="top" class="a3" style="height: 15px; "><br />
<!--自定义开始-->
<%If c_cook  =  "YES" then%>
<form method="POST" action="<%=JoinChar(c_strFileName)%>action_cook=cookies">

<b>自定义：</b><span >每页图片数</span><input type="text" name="cook_MaxPerPage" size="3" value="<%=c_MaxPerPage%>"  title="输入1-30之间的数字！">
<span >
每行图片数</span>
<input type="text" name="cook_Page" size="3" value="<%=c_Page%>"  title="输入1-10之间的数字！">

图片宽
<input type="text" name="cook_picwidth" size="3" value="<%=c_picwidth%>"  title="输入20-800之间的数字！">
高<input type="text" name="cook_picheight" size="3" value="<%=c_picheight%>"  title="输入20-800之间的数字！">

<select size="1" name="CookieTime" >
<option selected value="0">是否记忆</option>
<option value="1">记忆一天</option>
<option value="2">记忆一周</option>
<option value="3">记忆一月</option>
<option value="4">记忆一年</option>
</select>

<input type="submit" value="提交" name="B1">
<input type="button" value="默认值" name="B3"  onClick="window.location.href='<%=JoinChar(c_strFileName)%>action_cook=con'">
</form>
<%End if%>
<!--自定义结束--></td>
</tr>
<tr >
<td  valign="top" class="a3" >
<!--图片列表-->
<%
call main()
%>
<!--图片列表-->	</td>
</tr>
</table>
<%
end select
end If
'图片列表
sub main()
if fso.FolderExists(TruePath)=False then
response.write "找不到文件夹！可能是配置有误！"
exit sub
end if

FileCount=0
TotalSize=0
Set theFolder=fso.GetFolder(TruePath)
For Each theFile In theFolder.Files
If instr(LCase(c_PicType),LCase(Right(Trim(theFile.name),3)))>0 Then
FileCount=FileCount+1
TotalSize=TotalSize+theFile.Size
End if
next
totalPut=FileCount
if currentpage<1 then
currentpage=1
end if
if (currentpage-1)*c_MaxPerPage>totalput then
if (totalPut mod c_MaxPerPage)=0 then
currentpage= totalPut \ c_MaxPerPage
else
currentpage= totalPut \ c_MaxPerPage + 1
end if
end if
if currentPage=1 then
Call showpage(c_strFileName,totalput,c_MaxPerPage)
call showContent()
Call showpage(c_strFileName,totalput,c_MaxPerPage)
else
if (currentPage-1)*c_MaxPerPage<totalPut then
call showpage(c_strFileName,totalput,c_MaxPerPage)
call showContent()
call showpage(c_strFileName,totalput,c_MaxPerPage)
else
currentPage=1
call showpage(c_strFileName,totalput,c_MaxPerPage)
call showContent()
call showpage(c_strFileName,totalput,c_MaxPerPage)
end if
end if
end sub

sub showContent()
dim c
FileCount=0
TotalSize_Page=0
%>
<form name="myform" method="Post" action="?forder=<%=forder%>" onsubmit="return confirm('确定要删除选中的文件吗？');">
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="3" >
<tr >
<%
For Each theFile In theFolder.Files
c=c+1
if FileCount>=Int(c_MaxPerPage) then
exit for
elseif c>Int(c_MaxPerPage)*(CurrentPage-1) then
strFileType=lcase(mid(theFile.Name,instrrev(theFile.Name,".")+1))
If instr(LCase(c_PicType),strFileType)>0 Then
%>
<td>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td align="center" width="<%=c_picwidth%>" height="<%=c_picheight+10%>" >
<%
response.write "<a href='" & UploadDir & theFile.Name & "' target='_blank'><img src='" & UploadDir & theFile.Name & "' alt='[文件]"&theFile.Name&Chr(10)&"[大小]"&round(theFile.size/1024)&"K "&Chr(10)&"[类型]"&theFile.type&"' border='0'  onmouseover=""this.style.cursor='hand';""    onload='javascript:DrawImage(this);'  width="&c_picwidth&" height="&c_picheight&"></a>"
%>          </td>
</tr>

<tr>
<td><input name="FileName" type="checkbox" id="FileName" value="<%=theFile.Name%>" onClick="unselectall()">选中  <a href="<%=JoinChar(c_strFileName)%>Action=Del&FileName=<%=theFile.Name%>" onClick="return confirm('你真的要删除吗!')">单个删除</a></td>
</tr>
</table>
</td>
<%
Else
FileCount=FileCount-1
End if
FileCount=FileCount+1
if FileCount mod c_Page=0 then response.write "</td><tr >"
TotalSize_Page=TotalSize_Page+theFile.Size
end If
Next
%>
</tr>
</table>
<table  border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td ><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
选中本页显示的所有文件</td>
<td><input name="Action" type="hidden" id="Action" value="Del">
<input name="UploadDir" type="hidden" id="UploadDir" value="<%=left(UploadDir,len(UploadDir)-1)%>">
<input type="submit" name="Submit" value="删除选中的文件">
<!--<input type="submit" name="Submit2" value="删除当前目录所有文件" onClick="document.myform.Action.value='DelAll';">-->
</td>
</tr>
</table>
</form>
<%
end sub
'删除单个文件或选中文件
sub DelFiles()
dim whichfile,arrFileName,i,UploadDir2
whichfile=trim(Request("FileName"))
if whichfile="" then exit sub
if instr(whichfile,",")>0 then
arrFileName=split(whichfile,",")
for iij=0 to ubound(arrFileName)
if left(trim(arrFileName(iij)),3)<>"../" and left(trim(arrFileName(iij)),1)<>"/" then
whichfile=server.MapPath(UploadDir  & trim(arrFileName(iij)))
set thisfile=fso.GetFile(whichfile)
thisfile.Delete True
end if
next
else
if left(whichfile,3)<>"../" and left(whichfile,1)<>"/" then
Set thisfile = fso.GetFile(server.MapPath(UploadDir & whichfile))
thisfile.Delete True
end if
end if
Response.Write("<script>alert(""所选文件删除成功"");location.href='"&c_strFileName&"';</script>")
end sub

'删除所有文件
sub DelAll()

Set theFolder=fso.GetFolder(TruePath)
For Each theFile In theFolder.Files
theFile.Delete True
next
Response.Write("<script>alert(""本目录所有文件删除成功"");location.href='"&c_strFileName&"';</script>")
end Sub
%>
</body>
</html>
