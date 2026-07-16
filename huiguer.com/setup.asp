<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
dim lanmu_name
lanmu_name="网站基本配置"
%>
<title><%=lanmu_name%></title>
<!--#include file="check.asp"-->
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>

<%
dim action,filename
filename="setup.asp"'页面名称
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
if(document.myform.e_webname.value=='')
{alert('请填写网站名称!');
document.myform.e_webname.focus();
return false
}
if (document.myform.weburl.value=='')
{alert('请填写网站网址!');
document.myform.weburl.focus();
return false
}
}
</script>
<body onmouseover="self.status='慧谷设计提醒您，您正在处于网站后台管理，不进行操作请退出！';return true">
<br>
<table width="99%"  cellpadding="3"  cellspacing="1" border="0" align="center" class="a2">
<tr>
<td colspan="3" align="center" class="a1" >网站基本信息配置</td>
</tr>

<%
sql="select * from yuzhiguo_setup"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
%>
<form name="myform" id="myform" action="<%=filename%>?action=save" method="post" onSubmit="return check_form();">

<tr>
  <td rowspan="2" align="right" class="a3">网站名称：      </td>
  <td align="center" class="a4">中文</td>
  <td class="a3"><input name="yuzhiguo_webname" type="text" id="yuzhiguo_webname" value="<%=rs("yuzhiguo_webname")%>" size="50" maxlength="255" />
    <select name="webname_show" id="webname_show">
      <option value="1" <%if rs("webname_show")<>"" then response.write"selected" end if%> style="color:#FF0000;">显示</option>
      <option value="" <%if rs("webname_show")="" then response.write"selected" end if%>>隐藏</option>
    </select>
    <span class="hui">（提醒：隐藏则首页顶部不显示网站名称）</span></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
<td class="a3"><input name="e_webname" type="text" id="e_webname" value="<%=rs("e_webname")%>" size="50" maxlength="255"> <select name="e_webname_show" id="e_webname_show">
  <option value="1" <%if rs("e_webname_show")<>"" then response.write"selected" end if%> style="color:#FF0000;">显示</option>
  <option value="" <%if rs("e_webname_show")="" then response.write"selected" end if%>>隐藏</option>
</select></td>
</tr>

<tr>
<td align="right" class="a3">网站网址：      </td>
<td colspan="2" class="a3"><input name="weburl" type="text" id="weburl" value="<%=rs("weburl")%>" size="50" maxlength="50">
 （ <span class="hui">例如：http://www.yuzhiguo.com）</span></td>
</tr>
<tr>
  <td align="right" class="a3">网站目录：</td>
  <td colspan="2" class="a3"><input name="webfolder" type="text" id="webfolder" value="<%=rs("webfolder")%>" size="50" maxlength="50" />
    <span class="hui">（提醒：如是根目录请为斜杠</span><span class="red">/</span><span class="hui">，最好放置在根目录，不会出错）</span></td>
</tr>
<tr>
<td align="right" class="a3">LOGO图片：</td>
<td colspan="2" class="a3"><input name="logo" type="text" id="logo" value="<%=rs("logo")%>" size="50" maxlength="255" />
<input type="button" name="submit1"  id="submit" value="上传新logo" onClick="window.open('pic_upload_flash.asp?formname=myform&editname=logo&uppath=../pic/logo&filelx=jpg&file_name=logo','','status=no,scrollbars=no,top=20,left=110,width=420,height=420')">
<span class="hui">（提醒：为空则前台不显示logo）</span></td>
</tr>

<tr>
<th colspan="3" align="center" class="a2">网站使用开关</th>
</tr>
<tr>
<td align="right" class="a3">开关选择：</td>
<td colspan="2" class="a3"><input type="radio" name="webclose" value="false" <%if rs("webclose")=false then response.write"checked" end if%>>
使用网站 
  <input type="radio" name="webclose" value="true" <%if rs("webclose")=true then response.write"checked" end if%>>
  关闭网站</td>
</tr>
<tr>
<td align="right" class="a3">关闭提示：</td>
<td colspan="2" class="a3"><textarea name="webclosewhy"  cols="80" rows="3"><%=rs("webclosewhy")%></textarea></td>
</tr>
<tr>
<th colspan="3" align="center" class="a2">网站搜索优化</th>
</tr>

<tr>
  <td rowspan="2" align="right" class="a3">副标题：</td>
  <td align="center" class="a4">中文</td>
  <td class="a3"><input name="yuzhiguo_title" type="text" id="yuzhiguo_title" value="<%=rs("yuzhiguo_title")%>" size="80" maxlength="255" />
    <span class="hui">（提醒：显示在首页title网站名称之后）</span></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
<td class="a3"><input name="e_title" type="text" id="e_title" value="<%=rs("e_title")%>" size="80" maxlength="255" /></td>
</tr>

<tr>
  <td width="13%" rowspan="2" align="right" class="a3">网站关键字：</td>
  <td align="center" class="a4">中文</td>
  <td class="a3"><textarea name="yuzhiguo_keywords" cols="80" rows="3" id="yuzhiguo_keywords"><%=rs("yuzhiguo_keywords")%></textarea>
    <span class="hui">（提醒：不要超过255个字符）</span></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
<td class="a3"><textarea name="e_keywords" cols="80" rows="3" id="e_keywords"><%=rs("e_keywords")%></textarea></td>
</tr>

<tr>
  <td rowspan="2" align="right" class="a3">网站说明：</td>
  <td align="center" class="a4">中文</td>
  <td class="a3"><textarea name="yuzhiguo_description" cols="80" rows="3" id="yuzhiguo_description"><%=rs("yuzhiguo_description")%></textarea>
    <span class="hui">（提醒：不要超过255个字符）</span></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
<td class="a3"><textarea name="e_description" cols="80" rows="3" id="e_description"><%=rs("e_description")%></textarea></td>
</tr>

<tr>
  <th colspan="3" align="center" class="a2">网站统计代码区</th>
</tr>
<tr>
  <td align="right" class="a3">网站统计代码：</td>
  <td colspan="2" class="a3">
    <textarea name="tongji" cols="100" rows="3" id="tongji"><%=rs("tongji")%></textarea>    <br />    <span class="hui">（提醒：把自己的统计代码填入，没有统计可以到<a href="http://www.51.la/" target="_blank">51.la</a>、<a href="http://www.cnzz.com/" target="_blank">cnzz.com</a>、<a href="http://www.linezing.com/" target="_blank">linezing.com</a>、<a href="http://www.google.com/intl/zh-CN_ALL/analytics/" target="_blank">Google Analytics</a>等申请，不统计请为空）</span></td>
  </tr>
<tr>
<th colspan="3" align="center" class="a2">产品、新闻显示设定</th>
</tr>
<tr>
<td align="right" class="a3">产品：</td>
<td colspan="2" class="a3">一页显示数：
<input name="product_page" type="text" id="product_page" value="<%=rs("product_page")%>" size="5" maxlength="50" />
一行显示数：
<input name="product_hang" type="text" id="product_hang" value="<%=rs("product_hang")%>" size="5" maxlength="50" />
首页显示数：
<input name="product_hots" type="text" id="product_hots" value="<%=rs("product_hots")%>" size="5" maxlength="50" />
<span class="hui">（提醒：必须为数字，不然网站会出错）</span></td>
</tr>
<tr>
<td align="right" class="a3">新闻：</td>
<td colspan="2" class="a3">一页显示数：
<input name="news_page" type="text" id="news_page" value="<%=rs("news_page")%>" size="5" maxlength="50" /></td>
</tr>
<tr>
<th colspan="3" align="center" class="a2">缩略图、水印设定</th>
</tr>
<tr>
<td align="right" class="a3">缩略图开关：</td>
<td colspan="2" class="a3"><%If IsObjInstalled("Persits.Jpeg") Then%>
<input type="radio" name="pic_aspjpeg" value="1" <%if rs("pic_aspjpeg")=1 then response.write"checked" end if%>>开启 
<input type="radio" name="pic_aspjpeg" value="0" <%if rs("pic_aspjpeg")=0 then response.write"checked" end if%>>关闭 
<font color="#00CC00">√支持！</font>
<%else%>
<input type="radio" name="pic_aspjpeg" value="0" checked >关闭 
<font color="#FF0000">×不支持，默认关闭该功能，要支持请安装Aspjpeg组件！</font>
<%end if%>
</td>
</tr>
<tr>
<td align="right" class="a3">缩略图尺寸：</td>
<td colspan="2" class="a3">宽：
<input name="pic_width" type="text" id="pic_width" value="<%=rs("pic_width")%>" size="5" maxlength="50" />
px，
高：
<input name="pic_height" type="text" id="pic_height" value="<%=rs("pic_height")%>" size="5" maxlength="50" />
px<span class="hui">（提醒：如果一行显示4个最宽不要超过170像素，如果大于170像素请设置一行显示3个产品）</span></td>
</tr>
<tr>
<td align="right" class="a3">水印文字开关：</td>
<td colspan="2" class="a3">
<%If IsObjInstalled("Persits.Jpeg") Then%>
<input type="radio" name="font_aspjpeg" value="1" <%if rs("font_aspjpeg")=1 then response.write"checked" end if%>>开启 
<input type="radio" name="font_aspjpeg" value="0" <%if rs("font_aspjpeg")=0 then response.write"checked" end if%>>关闭
<font color="#00CC00">√支持！</font>
<%else%>
<input type="radio" name="font_aspjpeg" value="0" checked >关闭
<font color="#FF0000">×不支持，默认关闭该功能，要支持请安装Aspjpeg组件！</font>
<%end if%>
</td>
</tr>
<tr>
<td align="right" class="a3">水印文字属性：</td>
<td colspan="2" class="a3">文字大小：
<input name="font_size" type="text" id="font_size" value="<%=rs("font_size")%>" size="5" maxlength="50" />
px，
文字字体：


<select name="font_family" id="font_family">
<option value="宋体" <%if rs("font_family")="宋体" then response.write"selected='selected'" end if%>>宋体</option>
<option value="黑体" <%if rs("font_family")="黑体" then response.write"selected='selected'" end if%>>黑体</option>
<option value="隶书" <%if rs("font_family")="隶书" then response.write"selected='selected'" end if%>>隶书</option>
<option value="华文行楷" <%if rs("font_family")="华文行楷" then response.write"selected='selected'" end if%>>华文行楷</option>
<option value="微软雅黑" <%if rs("font_family")="微软雅黑" then response.write"selected='selected'" end if%>>微软雅黑</option>
<option value="Arial" <%if rs("font_family")="Arial" then response.write"selected='selected'" end if%>>Arial</option>
<option value="Arial Black" <%if rs("font_family")="Arial Black" then response.write"selected='selected'" end if%>>Arial Black</option>
<option value="Tahoma" <%if rs("font_family")="Tahoma" then response.write"selected='selected'" end if%>>Tahoma</option>
<option value="Times New Roman" <%if rs("font_family")="Times New Roman" then response.write"selected='selected'" end if%>>Times New Roman</option>
<option value="Verdana" <%if rs("font_family")="Verdana" then response.write"selected='selected'" end if%>>Verdana</option>
</select>

，文字颜色：
<input name="font_color" type="text" id="font_color" value="<%=rs("font_color")%>" size="8" maxlength="50" />
<img src="images/Rect.gif" name="ColorBG" border=0 align="absmiddle" ID="ColorBG1" style="cursor:pointer;background:<%=rs("font_color")%>;" title="选取颜色" onClick="Getcolor(this,'font_color');">
，文字阴影颜色：
<input name="font_bg_color" type="text" id="font_bg_color" value="<%=rs("font_bg_color")%>" size="8" maxlength="50" />
<img src="images/Rect.gif" name="ColorBG" border=0 align="absmiddle" ID="ColorBG2" style="cursor:pointer;background:<%=rs("font_bg_color")%>;" title="选取颜色" onClick="Getcolor(this,'font_bg_color');"></td>
</tr>
<tr>
<td align="right" class="a3">水印文字内容：</td>
<td colspan="2" class="a3"><input name="font_text" type="text" id="font_text" value="<%=rs("font_text")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
<th colspan="3" align="center" class="a2">邮件发送设置</th>
</tr>
<tr>
<td align="right" class="a3">邮件发送开关：</td>
<td colspan="2" class="a3">
<%If IsObjInstalled("JMail.Message") Then%>
<input type="radio" name="mail_jmail" value="1" <%if rs("mail_jmail")=1 then response.write"checked" end if%>>开启 
<input type="radio" name="mail_jmail" value="0" <%if rs("mail_jmail")=0 then response.write"checked" end if%>>关闭
<font color="#00CC00">√支持，有新留言、新订单将发送邮件通知！</font>
<%else%>
<input type="radio" name="mail_jmail" value="0" checked >关闭
<font color="#FF0000">×不支持，默认关闭该功能，如需支持请安装Jmail组件!</font>
<%end if%></td>
</tr>
<tr>
<td align="right" class="a3">邮局服务器地址：</td>
<td colspan="2" class="a3"><input name="mail_smtp" type="text" id="mail_smtp" value="<%=rs("mail_smtp")%>" size="50" maxlength="50" />
  <span class="hui">（例如：smtp.163.com:25，25为端口号，Google gmail不支持）</span></td>
</tr>
<tr>
<td align="right" class="a3">发送邮箱：</td>
<td colspan="2" class="a3"><input name="mail_send" type="text" id="mail_send" value="<%=rs("mail_send")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
<td align="right" class="a3">登录名：</td>
<td colspan="2" class="a3"><input name="mail_username" type="text" id="mail_username" value="<%=rs("mail_username")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
<td align="right" class="a3">登陆密码：</td>
<td colspan="2" class="a3"><input name="mail_password" type="password" id="mail_password" value="<%=rs("mail_password")%>" size="50" maxlength="50" /></td>
</tr>
<tr>
<td align="right" class="a3">显示名称：</td>
<td colspan="2" class="a3"><input name="mail_name" type="text" id="mail_name" value="<%=rs("mail_name")%>" size="50" maxlength="50" /></td>
</tr>

<tr>
<th colspan="3" align="center" class="a2">留言开关</th>
</tr>
<tr>
<td align="right" class="a3">留言前台显示开关：</td>
<td colspan="2" class="a3"><input type="radio" name="feedback_view" value="1" <%if rs("feedback_view")=1 then response.write"checked" end if%>>
显示 
  <input type="radio" name="feedback_view" value="0" <%if rs("feedback_view")=0 then response.write"checked" end if%>>
  隐藏</td>
</tr>
<tr>
<td align="right" class="a3">留言审核开关：</td>
<td colspan="2" class="a3"><input type="radio" name="feedback_verify" value="1" <%if rs("feedback_verify")=1 then response.write"checked" end if%>>使用 <input type="radio" name="feedback_verify" value="0" <%if rs("feedback_verify")=0 then response.write"checked" end if%>>关闭</td>
</tr>
<tr>
<th colspan="3" align="center" class="a2">联系方式</th>
</tr>

<tr>
  <td rowspan="2" align="right" class="a3">联系人：</td>
  <td align="center" class="a4">中文</td>
  <td class="a3"><input name="yuzhiguo_name" type="text" id="yuzhiguo_name" value="<%=rs("yuzhiguo_name")%>" size="20" maxlength="50" />
    <span class="hui"> （提醒：以下联系方式，不填写则不显示。）</span></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
<td class="a3"><input name="e_name" type="text" id="e_name" value="<%=rs("e_name")%>" size="20" maxlength="50"></td>
</tr>

<tr>
<td align="right" class="a3">电 话：</td>
<td colspan="2" class="a3"><input name="tel" type="text" id="tel" value="<%=rs("tel")%>" size="30" maxlength="50"></td>
</tr>
<tr>
<td align="right" class="a3">传真： </td>
<td colspan="2" class="a3"><input name="fax" type="text" id="fax" value="<%=rs("fax")%>" size="30" maxlength="50"></td>
</tr>
<tr>
<td align="right" class="a3">手机：</td>
<td colspan="2" class="a3"><input name="mobile" type="text" id="mobile" value="<%=rs("mobile")%>" size="30" maxlength="50"></td>
</tr>
<tr>
<td  align="right" class="a3">E-mail：</td>
<td colspan="2" class="a3"><input name="email" type="text" id="email" value="<%=rs("email")%>" size="50" maxlength="50">
  <span class="hui">（提醒：只可填写一个，不可多填，如开启“邮件发送开关”则发送邮件到此邮箱）</span></td>
</tr>
<tr>
<td align="right" class="a3">QQ：</td>
<td colspan="2" class="a3"><input name="qq" type="text" id="qq" value="<%=rs("qq")%>" size="30" maxlength="50" />
  <span class="hui">（提醒：只可填写一个，不可多填）</span></td>
</tr>
<tr>
<td align="right" class="a3">MSN：</td>
<td colspan="2" class="a3"><input name="msn" type="text" id="msn" value="<%=rs("msn")%>" size="50" maxlength="50" />
  <span class="hui">（提醒：只可填写一个，不可多填）</span></td>
</tr>
<tr>
<td align="right" class="a3">SKYPE：</td>
<td colspan="2" class="a3"><input name="skype" type="text" id="skype" value="<%=rs("skype")%>" size="30" maxlength="50" />
  <span class="hui">（提醒：只可填写一个，不可多填）</span></td>
</tr>

<tr>
  <td rowspan="2" align="right" class="a3">地址：</td>
  <td align="center" class="a4">中文</td>
  <td class="a3"><input name="yuzhiguo_add" type="text" id="yuzhiguo_add" value="<%=rs("yuzhiguo_add")%>" size="80" maxlength="255" /></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
<td class="a3"><input name="e_add" type="text" id="e_add" value="<%=rs("e_add")%>" size="80" maxlength="255"></td>
</tr>
<tr>
<td colspan="3" align="center"><input name="submit" type="submit" id="submit" value="提交修改"></td>
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
set rs=server.CreateObject("adodb.recordset")
sql="select * from yuzhiguo_setup"
rs.open sql,conn,1,3
rs.update
rs("yuzhiguo_webname")=trim(request("yuzhiguo_webname"))
rs("e_webname")=trim(request("e_webname"))
rs("weburl")=trim(request("weburl"))

if trim(request("webfolder"))<>"" then
rs("webfolder")=trim(request("webfolder"))
else
rs("webfolder")="/"
end if

rs("logo")=trim(request("logo"))
rs("icp")=trim(request("icp"))

rs("webclose")=trim(request("webclose"))
rs("webclosewhy")=trim(request("webclosewhy"))

rs("yuzhiguo_title")=trim(request("yuzhiguo_title"))
rs("e_title")=trim(request("e_title"))
rs("yuzhiguo_keywords")=left(trim(request("yuzhiguo_keywords")),255)
rs("e_keywords")=left(trim(request("e_keywords")),255)
rs("yuzhiguo_description")=left(trim(request("yuzhiguo_description")),255)
rs("e_description")=left(trim(request("e_description")),255)

rs("webname_show")=trim(request("webname_show"))
rs("e_webname_show")=trim(request("e_webname_show"))
rs("tongji")=trim(request("tongji"))

if trim(request("product_page"))<>"" then
rs("product_page")=trim(request("product_page"))
else
rs("product_page")="12"
end if

if trim(request("product_hang"))<>"" then
rs("product_hang")=trim(request("product_hang"))
else
rs("product_hang")="4"
end if

if trim(request("product_hots"))<>"" then
rs("product_hots")=trim(request("product_hots"))
else
rs("product_hots")="8"
end if

if trim(request("news_page"))<>"" then
rs("news_page")=trim(request("news_page"))
else
rs("news_page")="8"
end if

rs("pic_aspjpeg")=trim(request("pic_aspjpeg"))
rs("pic_width")=trim(request("pic_width"))
rs("pic_height")=trim(request("pic_height"))

rs("font_aspjpeg")=trim(request("font_aspjpeg"))
rs("font_size")=trim(request("font_size"))
rs("font_family")=trim(request("font_family"))
rs("font_color")=trim(request("font_color"))
rs("font_bg_color")=trim(request("font_bg_color"))
rs("font_text")=trim(request("font_text"))

rs("mail_jmail")=trim(request("mail_jmail"))
rs("mail_smtp")=trim(request("mail_smtp"))
rs("mail_send")=trim(request("mail_send"))
rs("mail_username")=trim(request("mail_username"))
rs("mail_password")=trim(request("mail_password"))
rs("mail_name")=trim(request("mail_name"))

'rs("kefu")=trim(request("kefu"))
'rs("kefu_x")=trim(request("kefu_x"))
'rs("kefu_y")=trim(request("kefu_y"))

rs("feedback_view")=trim(request("feedback_view"))
rs("feedback_verify")=trim(request("feedback_verify"))

rs("yuzhiguo_name")=trim(request("yuzhiguo_name"))
rs("e_name")=trim(request("e_name"))
rs("tel")=trim(request("tel"))
rs("email")=trim(request("email"))
rs("qq")=trim(request("qq"))
rs("msn")=trim(request("msn"))
rs("skype")=trim(request("skype"))
rs("yuzhiguo_add")=trim(request("yuzhiguo_add"))
rs("e_add")=trim(request("e_add"))
rs("mobile")=trim(request("mobile"))
rs("fax")=trim(request("fax"))
rs.update
Call Alert ("修改成功",""&filename&"")
rs.close
set rs=nothing
end sub
%>
<!--#include file="foot.asp"-->
</body>
</html>