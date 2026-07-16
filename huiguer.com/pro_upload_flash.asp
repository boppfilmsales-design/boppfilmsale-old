<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%if  session("yuzhiguo_admin")<>"" then%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="conn.asp"-->
<title>图片上传</title>
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css">
</head>
<body >
<script language="javascript">
<!--
function mysub()
{
esave.style.visibility="visible";
}
-->
</script>
<script>
function viewmypic(mypic,file1) {
if (file1.value){
mypic.src=file1.value;
mypic.style.display="";
mypic.border=1;
mypic.width=200;
}
}
</script>
<%
uppath=request("uppath")&"/"		'文件上传路径
filelx=request("filelx")				'文件上传类型
formName=request("formName")			'回传到上页面编辑框所在Form的Name
EditName=request("EditName")			'回传到上页面编辑框的Name
file_name=request("file_name")
%>
<form name="form1" method="post" action="pro_upfile_flash.asp" enctype="multipart/form-data" >
<div id="esave" style="position:absolute; top:18px; left:40px; z-index:10; visibility:hidden">
<TABLE WIDTH=340 BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><td width=20%></td>
<TD bgcolor=#104A7B width="60%">
<TABLE WIDTH=100% height=120 BORDER=0 CELLSPACING=1 CELLPADDING=0>
<TR>
<td bgcolor=#eeeeee align=center><font color=red>正在上传文件，请稍候...</font></td>
</tr>
</table>
</td><td width=20%></td>
</tr></table></div>
<br>
<table width="400" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC" class="a2">
<tr>
<td width="400" height="22" align="center" valign="middle" class="a1">图片上传
<input type="hidden" name="filepath" value="<%=uppath%>">
<input type="hidden" name="filelx" value="<%=filelx%>">
<input type="hidden" name="EditName" value="<%=EditName%>">
<input type="hidden" name="FormName" value="<%=formName%>">
<input type="hidden" name="file_name" value="<%=file_name%>">
<input type="hidden" name="act" value="uploadfile"></td>
</tr>
<tr align="center" valign="middle">
<td width="400" height="80" align="left" class="a3" id="upid"> 选择文件:
<input type="file" id="file1" name="file1" style="width:300'" value="" onChange="viewmypic(showimg,this.form.file1);" >      </td>
</tr>
<tr align="center" valign="middle">
<td width="400" height="24" class="a3">
<input type="submit" name="Submit" value="开始上传" onClick="javascript:mysub()">      </td>
</tr>
<tr align="center" valign="middle">
<td height="24" class="a3"><img name="showimg" id="showimg" src="" style="display:none;" alt="预览图片" /></td>
</tr>
</table>
</form>
<div style="display:none">
</div>
</body>
</html>
<%
else
response.Redirect("index.asp")
end if
%>
