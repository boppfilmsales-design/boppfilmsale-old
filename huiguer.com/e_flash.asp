<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="FLASH图片管理"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<%
dim action,filename
filename="e_flash.asp"'页面名称
action=trim(request("action"))
select case action
case "save"
call save()
case else
call main()
end select
sub main()
%>

<script language="javascript" type="text/javascript">
function check_form()
{
if(document.myform.image_width.value=='')
{alert('高度必填!');
document.myform.image_width.focus();
return false
}
if (document.myform.image_height.value=='')
{alert('宽度必填!');
document.myform.image_height.focus();
return false
}
}
</script>
<body onmouseover="self.status='您正在处于网站后台管理，不进行操作请退出！';return true">
<br>
<table width="99%"  cellpadding="3"  cellspacing="1" border="0" align="center" class="a2">
<tr>
<td colspan="4" align="center" class="a1" >英文FLASH图片切换管理</td>
</tr>

<%
sql="select * from yuzhiguo_e_flash"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
%>
<form name="myform" id="myform" action="<%=filename%>?action=save" method="post" onSubmit="return check_form();">

<tr>
  <td rowspan="3"   align="center" class="a3">图片1</td>
  <td   align="center" class="a3">链接</td>
      <td class="a3"><input name="alink" type="text" id="alink" value="<%=rs("alink")%>" size="60"></td>
    </tr>
          <tr>
            <td   align="center" class="a3">文件</td>
            <td class="a3"><input name="aimage" type="text" id="aimage" value="<%=rs("aimage")%>" size="60"> 
            <input name="Submit1" type="button" class="button" id="Submit1" onClick="window.open('pic_upload_flash.asp?formname=myform&editname=aimage&uppath=../pic/flash&file_name=1&filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" value="上传图片1">
            <span class="hui">（提醒：为空则前台不显示）</span></td>
    </tr>
          <tr>
            <td   align="center" class="a3">简述</td>
            <td class="a3"><input name="atext" type="text" id="atext" value="<%=rs("atext")%>" size="60"></td>
    </tr>

          <tr>
            <td rowspan="3"   align="center" class="a4">图片2</td> 
            <td   align="center" class="a4">链接</td>
            <td class="a4"><input name="blink" type="text" id="blink" value="<%=rs("blink")%>" size="60"></td>
    </tr>
          <tr>
            <td   align="center" class="a4">文件</td>
            <td class="a4"><input name="bimage" type="text" id="bimage" value="<%=rs("bimage")%>" size="60">
            <input name="Submit2" type="button" class="button" id="Submit2" onClick="window.open('pic_upload_flash.asp?formname=myform&editname=bimage&uppath=../pic/flash&file_name=2&filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" value="上传图片2">
            <span class="a3"><span class="hui">（提醒：为空则前台不显示）</span></span></td>
    </tr>
          <tr>
            <td   align="center" class="a4">简述</td>
            <td class="a4"><input name="btext" type="text" id="btext" value="<%=rs("btext")%>" size="60"></td>
    </tr>

          <tr>
            <td rowspan="3"   align="center" class="a3">图片3</td> 
            <td   align="center" class="a3">链接</td>
            <td class="a3"><input name="clink" type="text" id="clink" value="<%=rs("clink")%>" size="60"></td>
    </tr>
          <tr>
            <td   align="center" class="a3">文件</td>
            <td class="a3"><input name="cimage" type="text" id="cimage" value="<%=rs("cimage")%>" size="60">
            <input name="Submit3" type="button" class="button" id="Submit3" onClick="window.open('pic_upload_flash.asp?formname=myform&editname=cimage&uppath=../pic/flash&file_name=3&filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" value="上传图片3">
            <span class="hui">（提醒：为空则前台不显示）</span></td>
    </tr>
          <tr>
            <td   align="center" class="a3">简述</td>
            <td class="a3"><input name="ctext" type="text" id="ctext" value="<%=rs("ctext")%>" size="60"></td>
    </tr>

          <tr>
            <td rowspan="3"   align="center" class="a4">图片4</td> 
            <td   align="center" class="a4">链接</td>
            <td class="a4"><input name="dlink" type="text" id="dlink" value="<%=rs("dlink")%>" size="60"></td>
    </tr>
          <tr>
            <td   align="center" class="a4">文件</td>
            <td class="a4"><input name="dimage" type="text" id="dimage" value="<%=rs("dimage")%>" size="60">
            <input name="Submit4" type="button" class="button" id="Submit4" onClick="window.open('pic_upload_flash.asp?formname=myform&editname=dimage&uppath=../pic/flash&file_name=4&filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" value="上传图片4">
            <span class="a3"><span class="hui">（提醒：为空则前台不显示）</span></span></td>
    </tr>
          <tr>
            <td   align="center" class="a4">简述</td>
            <td class="a4"><input name="dtext" type="text" id="dtext" value="<%=rs("dtext")%>" size="60"></td>
    </tr>

          <tr>
            <td rowspan="3"   align="center" class="a3">图片5</td> 
            <td   align="center" class="a3">链接</td>
            <td class="a3"><input name="elink" type="text" id="elink" value="<%=rs("elink")%>" size="60"></td>
    </tr>
          <tr>
            <td   align="center" class="a3">文件</td>
            <td class="a3"><input name="eimage" type="text" id="eimage" value="<%=rs("eimage")%>" size="60">
            <input name="Submit5" type="button" class="button" id="Submit5" onClick="window.open('pic_upload_flash.asp?formname=myform&editname=eimage&uppath=../pic/flash&file_name=5&filelx=jpg','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')" value="上传图片5">
            <span class="hui">（提醒：为空则前台不显示）</span></td>
    </tr>
          <tr>
            <td   align="center" class="a3">简述</td>
            <td class="a3"><input name="etext" type="text" id="etext" value="<%=rs("etext")%>" size="60"></td>
    </tr>
          <tr align="center"> 
            <th height="25" colspan="3" bgcolor="#F3F3FA" class="a2"> 视觉选项</th>
          </tr>
          <tr>
            <td colspan="2" align="center" class="a3">展示宽度</td> 
            <td class="a3"> <input name="image_width" type="text" id="image_width" value="<%=rs("image_width")%>" size="6">
              px<span class="hui">（提醒：宽度不建议改动，以免影响页面美观。）</span></td>
    </tr>
          <tr>
            <td colspan="2"   align="center" class="a3">展示高度</td> 
            <td class="a3"> <input name="image_height" type="text" id="image_height" value="<%=rs("image_height")%>" size="6">
              px</td>
    </tr>
    <tr>
      <td colspan="2"   align="center" class="a3">底部文字行高</td> 
      <td class="a3"><input name="text_height" type="text" id="text_height" value="<%=rs("text_height")%>" size="6">
        px</td>
</tr>
<tr>
<td colspan="4" align="center"><input name="submit" type="submit" id="submit" value="提交修改"></td>
</tr>
<%
rs.close
set rs=nothing
%>
</form>
</table>
<%
end sub
sub save()

   alink=request("alink")
   aimage=request("aimage")
   atext=request("atext")
   blink=request("blink")
   bimage=request("bimage")
   btext=request("btext")
   clink=request("clink")
   cimage=request("cimage")
   ctext=request("ctext")
   dlink=request("dlink")
   dimage=request("dimage")
   dtext=request("dtext")
   elink=request("elink")
   eimage=request("eimage")
   etext=request("etext")
   image_width=request("image_width")
   image_height=request("image_height")
   text_height=request("text_height")

set rs=server.CreateObject("adodb.recordset")
sql="select * from yuzhiguo_e_flash"
rs.open sql,conn,1,3
rs.update

   rs("alink")=alink
   rs("aimage")=aimage
   rs("atext")=atext
   rs("blink")=blink
   rs("bimage")=bimage
   rs("btext")=btext
      rs("clink")=clink
   rs("cimage")=cimage
   rs("ctext")=ctext
   rs("dlink")=dlink
   rs("dimage")=dimage
   rs("dtext")=dtext
   rs("elink")=elink
   rs("eimage")=eimage
   rs("etext")=etext
   rs("image_width")=image_width
   rs("image_height")=image_height
   rs("text_height")=text_height

rs.update
Call Alert ("修改成功",""&filename&"")
rs.close
set rs=nothing
end sub
%>
<!--#include file="foot.asp"-->
</body>
</html>