<%
'数据库操作
Function Mydb(MySqlstr,MyDBType)
	Select Case MyDBType
	Case 0 : Conn.Execute(MySqlstr) : Dataquery = Dataquery + 1
	Case 1 : Set Mydb = Conn.Execute(MySqlstr) : Dataquery = Dataquery + 1
	Case 2 : Set Mydb = Server.CreateObject("Adodb.Recordset") : Mydb.Open MySqlstr,Conn,1,1 : Dataquery = Dataquery + 1
	case 3:
		set db = server.createobject("Adodb.Recordset")
		db.open sqlstr, conn, 1, 3
	End Select
End Function
%>

<%
'提示消息
Function alert(message,gourl)
message = replace(message,"'","\'")
If gourl="-1" then
Response.Write ("<script language=javascript>alert('" & message & "');history.go(-1)</script>")
ElseIf gourl="-2" then
Response.Write ("<script language=javascript>alert('" & message & "');history.go(-2)</script>")
ElseIf gourl="Close" then
Response.Write ("<script language=javascript>alert('" & message & "');window.opener=null;window.close();</script>")
Else
Response.Write ("<script language=javascript>alert('" & message & "');location='" & gourl &"'</script>")
End If
Response.End()
End Function
%>

<%
'数组分隔
function checkreal(v)
dim w
if not isnull(v) then
w=replace(v,",","|")
w=replace(w," ","")
checkreal=w
end if
end function
%>

<%
'远程图片保存类型
Const sFileExt="jpg|gif|bmp|png"

'/////////////////////////////////////////////////////
'作 用：替换字符串中的远程文件为本地文件并保存远程文件
'参 数：
'      sHTML         : 要替换的字符串
'      sSaveFilePath     : 保存文件的路径
'      sFileExt          : 执行替换的扩展名
Function ReplaceRemoteUrl(sHTML, sSaveFilePath, sFileExt)
     Dim s_Content
     s_Content = sHTML
     If IsObjInstalled("Microsof" & "t.X" & "MLHTTP") = False then
         ReplaceRemoteUrl = s_Content
         Exit Function
     End If
     
     Dim re, RemoteFile, RemoteFileurl,SaveFileName,SaveFileType,arrSaveFileNameS,arrSaveFileName,sSaveFilePaths
     Set re = new RegExp
     re.IgnoreCase = True
     re.Global = True
     re.Pattern = "((http|https|ftp|rtsp|mms):(\/\/|\\\\){1}((\w)+[.]){1,}(net|com|cn|org|cc|tv|[0-9]{1,3})(\S*\/)((\S)+[.]{1}(" & sFileExt & ")))"
     Set RemoteFile = re.Execute(s_Content)
     For Each RemoteFileurl in RemoteFile
		 arrSaveFileName = Split(RemoteFileurl,".")
  		 SaveFileType=arrSaveFileName(UBound(arrSaveFileName))
		 RanNum=Int(900*Rnd)+100
         arrSaveFileName = Year(Now()) & Right("0" & Month(Now()),2)&  Right("0" & Day(Now()),2) & Right("0" & Hour(Now()),2) & Right("0" & Minute(Now()),2) & Right("0" & Second(Now()),2) &ranNum&"."&SaveFileType
  sSaveFilePaths= sSaveFilePath'保存路径
         SaveFileName = sSaveFilePaths & arrSaveFileName
         Call SaveRemoteFile(SaveFileName, RemoteFileurl)

If font_aspjpeg=1 then

Dim Jpeg,RV_img 
RV_img=SaveFileName

Set Jpeg = Server.CreateObject("Persits.Jpeg") 
Jpeg.Open Server.MapPath(RV_img)
   
Jpeg.Canvas.Font.Color = "&H"&""&font_color&""
Jpeg.Canvas.Font.Size = ""&font_size&""
Jpeg.Canvas.Font.Family = ""&font_family&""
Jpeg.Canvas.Font.ShadowColor = "&H"&""&font_bg_color&""
Jpeg.Canvas.Font.ShadowXoffset = 1
Jpeg.Canvas.Font.ShadowYoffset = 1
Jpeg.Canvas.Font.Quality = 10
Jpeg.Canvas.Font.Bold = false
Jpeg.Canvas.Print 10,10,""&font_text&""
Jpeg.Quality=95
Jpeg.Save Server.MapPath(RV_img)
Set Jpeg = Nothing 
Set Uprequest=nothing
end if
		 
         s_Content = Replace(s_Content,RemoteFileurl,SaveFileName)
     Next
     ReplaceRemoteUrl = s_Content
End Function

'////////////////////////////////////////
'作 用：保存远程的文件到本地
'参 数：LocalFileName ------ 本地文件名
'        RemoteFileUrl ------ 远程文件URL
'返回值：True ----成功
'  False ----失败
Sub SaveRemoteFile(s_LocalFileName,s_RemoteFileUrl)
     Dim Ads, Retrieval, GetRemoteData
     On Error Resume Next
     Set Retrieval = Server.CreateObject("Microsoft.XMLHTTP")
     With Retrieval
         .Open "Get", s_RemoteFileUrl, False, "", ""
         .Send
         GetRemoteData = .ResponseBody
     End With
     Set Retrieval = Nothing
     Set Ads = Server.CreateObject("Adodb.Stream")
     With Ads
         .Type = 1
         .Open
         .Write GetRemoteData
         .SaveToFile Server.MapPath(s_LocalFileName), 2
         .Cancel()
         .Close()
     End With
     Set Ads=nothing
End Sub

%>

<%
'文件重命名
Function file_rename(oldname,newname)
set fso=Server.CreateObject("scripting.filesystemobject")
oldname=Server.mappath(oldname)
newname=Server.mappath(newname)
fso.movefile oldname,newname
Set fso=Nothing
End Function
%>

<%
Function file_delete(filename)
set Fs=server.CreateObject("Scripting.FileSystemObject")
if filename<>"" then
If Fs.FileExists(server.mappath(filename)) Then
Set Os = Fs.GetFile(server.mappath(filename))
Os.Delete
end if
if err.Number<>0 then
err.clear
response.write "删除文件失败!"
end if
end if
End Function
%>

<%
'////////////////////////////////////////
'作 用：检查组件是否已经安装
'参 数：strClassString ----组件名
'返回值：True ----已经安装
'      False ----没有安装
Function IsObjInstalled(s_ClassString)
     On Error Resume Next
     IsObjInstalled = False
     Err = 0
     Dim xTestObj
     Set xTestObj = Server.CreateObject(s_ClassString)
     If 0 = Err Then IsObjInstalled = True
     Set xTestObj = Nothing
     Err = 0
End Function
%>

<%
  '获取文件名
  Function get_filename(filename) 
  if filename<>"" then
  filename=replace(filename,right(filename,4),"")
  get_filename=Mid(filename,InStrRev(filename,"/")+1)  
  end if
End Function 
%>

<%
  '大图地址转换
  Function get_pic(filename,mulu) 
  if filename<>"" and mulu=3  then
  get_pic=replace(replace(filename,"big","small"),"../","")
  else if filename<>"" and mulu=2  then
  get_pic=replace(filename,"big","small")
  else if filename<>"" and mulu=1  then
  get_pic=replace(filename,"../","")
  end if
  end if
  end if
End Function 
%>

<%
  '生成静态文件名
  Function get_html_name(html_url) 
  if html_url<>"" then
  get_html_name=Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(html_url,",",""),".",""),"/",""),"\",""),"'","")," ","-"),"*","-"),":","-"),"#","")
  end if
End Function 
%>

<%
'汉字转拼音
public function cn2en(html_url_cn)
html_url_cn=Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(html_url_cn,",",""),".",""),"/",""),"\",""),"'","")," ","-"),"*","-"),":","-"),"#","")
    dim I1,l2,l3,l4,i,rs,Sql
    'on error resume next

    if err.number<>0 then response.Write("error")
    l4=true
    for i=1 to len(html_url_cn)
        l3=l4
        l2=mid(html_url_cn,i,1)
        if len(trim(l2))=1 then'长度为1
		set rs=server.CreateObject("adodb.recordset")
        Sql="select top 1 pinyin,hanzi from pinyin where hanzi ='"&l2&"' and PutOut=true"
        rs.open Sql,conn,1,2
                if not rs.eof and not rs.bof then'中文
                    l2=rs(0)
                      If len(l2)>0 then
                           l2=Ucase(Left(l2,1)) & right(l2,len(l2)-1)
                      End If  
                    l4=true'当前为中文，即true
                else '没有找到就自动添加，PutOut设置为False,并用"-"替换
                    rs.addnew
                       rs("hanzi")=l2
                    rs.update
                    l2="-"    
                    l4=false'当前为英文，false
                end if
                rs.close
            set rs=nothing
        else
            l2=""'换行替换为空格
        end if
        if l3=l4 then' l2=l2&" "
            I1=I1&l2
        else
            I1=I1&""&l2
        end if
    next
    cn2en=left(LCase(trim(I1)),250)
end function
%>

<%
'生成html
Function Fso_info(host,folder,filename)
host="http://"+Request.ServerVariables("HTTP_HOST")&webfolder&host
if SaveFile(""&folder&filename&"",""&host&"") then 
response.Write ""&folder&filename&" 生成成功. <br />"
else 
Response.write ""&folder&filename&" 生成<font color='#FF0000'>失败</font>,可能您的文件名含有特殊字符.<br />" 
end if
End Function
%>

<%
'生成文件
function SaveFile(LocalFileName,RemoteFileUrl) 
Dim Ads, Retrieval, GetRemoteData 
On Error Resume Next 
Set Retrieval = Server.CreateObject("Microso" & "ft.XM" & "LHTTP") '//把单词拆开防止杀毒软件误杀
With Retrieval 
.Open "Get", RemoteFileUrl, False, "", "" 
.Send 
GetRemoteData = .ResponseBody 
End With 
Set Retrieval = Nothing 
Set Ads = Server.CreateObject("Ado" & "db.Str" & "eam") '//把单词拆开防止杀毒软件误杀
With Ads 
.Type = 1 
.Open 
.Write GetRemoteData 
.SaveToFile Server.MapPath(LocalFileName), 2 
.Cancel() 
.Close() 
End With 
Set Ads=nothing 
if err <> 0 then 
SaveFile = false 
err.clear 
else 
SaveFile = true 
end if 
End function 
%>