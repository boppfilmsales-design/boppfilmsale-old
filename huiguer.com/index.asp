<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="conn.asp"-->
<!--#include file="pub/md5.asp"-->
<title>慧谷动力网站后台管理系统</title>
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.STYLE1 {color: #FFFFFF}
-->
</style>
</head>

<body>
<%
dim action
action=trim(request("action"))
select case action
case "check"
call check()
case "out"
call out()
case else
call main()
end select
sub main()
%>
<script language="javascript">
function checklogin()
{
if(document.login.name.value=='')
{alert('请输入用户名！');
document.login.name.focus();
return false
}
if (document.login.password.value=='')
{alert('请输入密码！');
document.login.password.focus();
return false
}
if (document.login.code.value=='')
{alert('请输入验证码！');
document.login.code.focus();
return false
}
}
</script>
<body style="margin:0px; padding:0px;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="top" background="login/login_bgound.gif"><form name="Login" action="index.asp?action=check" method="post" target="_parent" onSubmit="return checklogin();" style="margin:0px; padding:0px;">
      <table style="margin-top:98px;" width="512" height="56" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="login/login_top.gif" width="512" height="119" alt="" /></td>
        </tr>
      </table>
      <table width="512" height="69" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center" valign="top" background="login/login_top2.gif"><table width="371" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="67" align="center" class="t2 STYLE1">用户名：</td>
                <td colspan="2" align="left" valign="middle"><input name="name" type="text" id="name" /></td>
              </tr>
              <tr>
                <td align="center" class="t2 STYLE1">密&nbsp;&nbsp;&nbsp;码：</td>
                <td colspan="2" align="left" valign="middle"><input name="password" type="password" id="password"/></td>
              </tr>
              <tr>
                <td align="center" class="t2 STYLE1">验证码：</td>
                <td width="215" align="left" valign="middle"><input name="code" type="text" id="code" size="4" maxlength="4" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../pub/code.asp?',Math.random()'" id="verImg" alt="点击刷新验证码" onclick="nchangeImg();" style=" cursor:pointer;">
<SCRIPT LANGUAGE="JavaScript">
<!--
function nchangeImg(){
var img = document.getElementById("verImg");
img.src = "../pub/code.asp?" + Math.random();
}
//-->
</SCRIPT></td>
                <td width="89" align="left" valign="middle" class="t2 STYLE1">&nbsp;&nbsp;&nbsp;</td>
              </tr>
          </table></td>
        </tr>
      </table>
      <table width="512" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="login/login_topleft.gif" width="119" height="34" alt="" /></td>
          <td><input type="submit" name="Submit" value="  " style="background-image: url(login/login_anniu1.gif); border:0px; height:34px; width:110px;"></td>
          <td><input name="Submit2" type="reset" style="background-image: url(login/login_anniu2.gif); height:34px; border:0px; width:129px;" value="  "></td>
          <td><img src="login/login_topright.gif" width="154" height="34" alt="" /></td>
        </tr>
      </table>
        </form>
      <table width="512" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="62" align="center" valign="bottom" background="login/login_bottom.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="20">&nbsp;</td>
              </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
          </table></td>
        </tr>
      </table>
      <table width="512" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="login/login_bottom2.gif" width="512" height="92" alt="" /></td>
        </tr>
      </table></td>
  </tr>
</table>
</td>
</tr>
<tr align="center" >
<td colspan="2" class="a3">
</td>
</tr></form>
</table>
<%
end sub
sub check()
dim name,password,code,getcode
name=trim(request("name"))
password=trim(request("password"))
code=trim(request("code"))
getcode=trim(session("code"))

if name="" then
Call alert ("用户名不能为空!","-1")
end if

if name<>"" and instr(name,chr(39))>0 or instr(name,chr(34))>0 then
Call alert ("用户名非法!","-1")
end if

if password="" then
Call alert ("密码不能为空!","-1")
end if

if code="" then
Call alert ("验证码不能为空!","-1")
end if

if code<>"" and not isnumeric(code) then
Call alert ("验证码必须为数字!","-1")
end if

if code<>getcode then
Call alert ("验证码错误!","-1")
end if
set rs=server.createobject("adodb.recordset")
sql="select * from yuzhiguo_administrator where name='"&name&"' and password='"&md5(password)&"'"
rs.open sql,conn,0,1
if rs.eof then
Call alert ("您输入的用户名或密码有误!","-1")
rs.close
set rs=nothing
else
session("yuzhiguo_admin")=rs("name")
session("power")=rs("power")
Call Alert ("登陆成功!","home.asp")
end if
rs.close
set rs=nothing
end sub
sub out()
session("yuzhiguo_admin")=""
session("power")=""
Call alert ("退出成功!","index.asp")
end sub
%>
<!--#include file="foot.asp"-->
</body>
</html>
