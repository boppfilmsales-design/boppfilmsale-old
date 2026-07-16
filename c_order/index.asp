<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<!--#include file="../pub/function.asp"-->
<title><%=trim(request("name"))%> 产品询价,<%=yuzhiguo_webname%></title>
<meta name="keywords" content="<%=yuzhiguo_keywords%>" />
<meta name="description" content="<%=yuzhiguo_description%>" />
<meta name="author" content="慧谷设计,QQ:995226433" />
<link href="../css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
</head>

<body>


<%if request("action")="add" then
if request.form("code")="" then
response.write "<script language=javascript>"
response.write "alert('请输入验证码!');"
response.write "javascript:history.go(-1);"
response.write "</script>"
elseif Trim(Request.Form("code"))=Empty or Trim(Session("code"))<>Trim(Request.Form("code")) Then
response.write "<script language=javascript>"
response.write"alert('请输入正确的验证码!');"
response.write "javascript:history.go(-1);"
response.write "</script>"
else
set rs=server.CreateObject("adodb.recordset")
sql="select * from yuzhiguo_order"
rs.open sql,conn,1,3
rs.addnew

rs("title")=trim(request("title"))
rs("quantity")=trim(request("quantity"))
rs("content")=trim(request("content"))
rs("name")=trim(request("name"))
rs("company_name")=trim(request("company_name"))
rs("add")=trim(request("add"))
rs("tel")=trim(request("tel"))
rs("fax")=trim(request("fax"))
rs("email")=trim(request("email"))
rs("website")=trim(request("website"))
rs("msn")=trim(request("msn"))
rs("ip")=Request.ServerVariables("REMOTE_ADDR")
rs.update
rs.close
set rs=nothing
 
	if mail_jmail=1 then'判断发送邮件开关
	on error resume next
	'发送注册邮件
	mailbody="<html>"
	mailbody=mailbody & "<head>"
	mailbody=mailbody & "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
	mailbody=mailbody & "<title>★网站订单提醒★来自IP："&Request.ServerVariables("REMOTE_ADDR")&"</title>"
	mailbody=mailbody & "<head>"
	mailbody=mailbody & "<body>"
	mailbody=mailbody & "★订购产品编号："&trim(request("title"))&"<br />"
	mailbody=mailbody & "★订购数量："&trim(request("quantity"))&"<br />"
	mailbody=mailbody & "★订购备注："&trim(request("content"))&"<br /><br />"
	mailbody=mailbody & "★订购人："&trim(request("name"))&"<br />"
	mailbody=mailbody & "★公司名称："&trim(request("company_name"))&"<br />"
	mailbody=mailbody & "★电话："&trim(request("tel"))&"<br />"
	mailbody=mailbody & "★E-mail："&trim(request("email"))&"<br />"
	mailbody=mailbody & "★网站："&trim(request("website"))&"<br />"
	mailbody=mailbody & "</body>"
	mailbody=mailbody & "</html>"
	Set JMail=Server.CreateObject("JMail.Message")
	jmail.silent = true'JMAIL不会抛出例外错误，返回的值为FALSE跟TRUE
	jmail.Logging = true'启用使用日志
	JMail.Charset="utf-8"'邮件编码
	JMail.ContentType = "text/html"'邮件的格式为HTML的
	'jmail.ServerAddress = "Server Address"   '发送邮件的服务器
	jmail.AddRecipient email'邮件收件人的地址
	jmail.from = mail_send'发件人的E-MAIL地址
	jmail.FromName = mail_name'发件人的名称 
	jmail.mailserverusername = mail_username'登录邮件服务器所需的用户名
	jmail.mailserverpassword = mail_password'登录邮件服务器所需的密码
	JMail.Subject="★网站订单提醒★来自IP："&Request.ServerVariables("REMOTE_ADDR")'邮件标题
	jmail.body=mailbody'邮件内容
	jmail.Prority = 1      '邮件的紧急程序，1 为最快，5 为最慢， 3 为默认值
	if not jmail.Send ( mail_smtp ) then
	SendMail=""
	else
	SendMail="OK"
	end if
	jmail.Close()   '关闭对象
	set jmail = Nothing
	if SendMail="OK" then
	response.write"<script>alert('产品询价成功！同时您的询价单发送到管理邮箱!');location.href='../c_order/';</script>"
	else
	response.write"<script>alert('产品询价成功!');location.href='../c_order/';</script>"
	end if
	response.write mailbody
	
	elseif mail_jmail=2 then '判断godaddy
	
	on error resume next 

	sendUrl="http://schemas.microsoft.com/cdo/configuration/sendusing"
	smtpUrl="http://schemas.microsoft.com/cdo/configuration/smtpserver"
	' Set the mail server configuration
	Set objConfig=CreateObject("CDO.Configuration")
	objConfig.Fields.Item(sendUrl)=2 ' cdoSendUsingPort
	objConfig.Fields.Item(smtpUrl)="relay-hosting.secureserver.net"
	objConfig.Fields.Update
	' Create and send the mail
	Set objMail=CreateObject("CDO.Message")
	' Use the config object created above
	Set objMail.Configuration=objConfig
	objMail.From=trim(request("email"))
	objMail.To=email
	objMail.BodyPart.Charset = "utf-8" 
	objMail.Subject="★网站客户订单通知★订购人IP："&Request.ServerVariables("REMOTE_ADDR")
	objMail.TextBody="★订购产品："&trim(request("title"))&"★订购数量："&trim(request("quantity"))&"★订购人："&trim(request("name"))&" ★电话："&trim(request("tel"))&" ★E-mail："&trim(request("email"))&" ★MSN："&trim(request("msn"))&" ★公司："&trim(request("company_name"))&" ★订购备注："&trim(request("content"))
	objMail.Send
	Set objMail = Nothing

	if err.number <> 0 then 
	response.write"<script>alert('产品询价成功!');location.href='../c_order/';</script>"
	else
	response.write"<script>alert('产品询价成功！同时您的询价单发送到管理邮箱!');location.href='../c_order/';</script>"
	end if 

	rs.close
	set rs=nothing
	
	else
	response.write"<script>alert('产品询价成功!');location.href='../c_order/';</script>"
	end if
 
 end if
 end if%>
  <!--#include file="../pub/c_top.asp"-->
  <!--#include file="../pub/flash.asp"-->
  <div class="main">
  <table width="1000" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
      <td width="230" valign="top">
      <!--#include file="../pub/c_left.asp"-->
      </td>
      <td width="10"></td>
      <td width="740" valign="top">
<div class="right">
<div class="iproducts">   <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">产品询价</span></div>
	  <div class="cmore"></div></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto;">

  <tr>
    <td valign="top">
    <script language="javascript">
     function checkadd()
     {	 
		 if (document.feedback.title.value=='')
         {alert('请输入您要询价的产品!');
         document.feedback.title.focus
         return false
         }
         if (document.feedback.name.value=='')
         {alert('请输入联系人的姓名!');
         document.feedback.name.focus
         return false
         }
          if (document.feedback.email.value=='')
         {alert('请输入您的E-mail地址!');
         document.feedback.email.focus
         return false
         }
         var Mail = document.feedback.email.value;
         if(Mail.indexOf('@',0) == -1 || Mail.indexOf('.',0) == -1)
         {
          alert('请输入正确的E-mail地址，以方便我们回复您！');
          document.feedback.email.focus();
          return false;
         }
		 if (document.feedback.code.value=='')
         {alert('请输入验证码!');
         document.feedback.code.focus
         return false
         }
     }
      </script>
    <br /><form action="index.asp?action=add" method="post" name="feedback" id="feedback" onsubmit="return checkadd();"><table width="100%"  border="0" align="left" cellpadding="0" cellspacing="5" >
        
          <tr >
            <td height="25" align="right" class="color_huise2">询价产品：</td>
            <td height="25" align="left" ><input name="title" type="text" id="title" value="<%=trim(request("name"))%>" size="40" maxlength="255" />
              <span class="red">*</span></td>
          </tr>
          <tr >
            <td height="25" align="right" class="color_huise2">产品数量：</td>
            <td height="25" align="left" ><input name="quantity" type="text" id="quantity" size="20" maxlength="50" /></td>
          </tr>
          <tr >
            <td align="right" class="color_huise2">询价说明：</td>
            <td align="left" ><textarea name="content" cols="60" rows="12" id="content"></textarea>
                        <br /></td>
          </tr>
          <tr >
            <td width="123" height="25" align="right" class="color_huise2">联系人：</td>
            <td width="562" height="25" align="left" ><input name="name" type="text" id="name" size="40" maxlength="50" />
                <span class="red">*</span></td>
          </tr>
          <tr >
            <td height="26" align="right" class="color_huise2">公司名称：</td>
            <td height="26" align="left" ><input name="company_name" type="text" id="company_name" size="50" maxlength="255" /></td>
          </tr>
          <tr >
            <td height="25" align="right" class="color_huise2">地址：</td>
            <td height="25" align="left" ><input name="add" type="text" id="add" size="60" maxlength="255" /></td>
          </tr>
          <tr >
            <td height="26" align="right" class="color_huise2">电话：</td>
            <td height="26" align="left" ><input name="tel" type="text" id="tel" size="40" maxlength="50" /></td>
          </tr>
          <tr >
            <td height="26" align="right" class="color_huise2">传真：</td>
            <td height="26" align="left" ><input name="fax" type="text" id="fax" size="40" maxlength="50" /></td>
          </tr>
          <tr >
            <td height="25" align="right" class="color_huise2">E-mail：</td>
            <td height="25" align="left" ><input name="email" type="text" id="email" size="50" maxlength="50" />
                <span class="red">*</span></td>
          </tr>
          <tr >
            <td height="25" align="right" class="color_huise2">网站：</td>
            <td height="25" align="left" ><input name="website" type="text" id="website" size="50" maxlength="50" /></td>
          </tr>
          <tr >
            <td height="25" align="right" class="color_huise2">MSN：</td>
            <td height="25" align="left" ><input name="msn" type="text" id="msn" size="50" maxlength="50" /></td>
          </tr>
          <tr >
            <td align="right" >QQ：</td>
            <td align="left" ><input name="qq" type="text" id="qq" size="20" maxlength="50" /></td>
          </tr>
          <tr >
            <td align="right" >验证码：</td>
            <td align="left" ><input name="code" type="text" id="code" size="4" maxlength="4" />
                <img src="../pub/code.asp" border="0"  alt="" /><span class="red">*</span></td>
          </tr>
          <tr >
            <td align="right" >&nbsp;</td>
            <td align="left" >(所有 <span class="red">*</span> 星号必填)</td>
          </tr>
          <tr >
            <td align="right" >&nbsp;</td>
            <td align="left" ><input name="OK" type="submit" class="input_submit"  id="OK" value=" 提交 " />
              &nbsp;&nbsp;
              <input name="reset" type="reset" class="input_submit"  value=" 重置 " /></td>
          </tr>
        
      </table> </form>  </td>
    </tr>
</table>
</div>
</td>
    </tr>
  </table>
  <!--#include file="../pub/c_foot.asp"-->
</div>

</body>
</html>
