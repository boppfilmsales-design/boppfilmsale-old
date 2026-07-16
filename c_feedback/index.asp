<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<!--#include file="../pub/function.asp"-->
<title>在线留言,<%=yuzhiguo_webname%></title>
<meta name="keywords" content="<%=yuzhiguo_keywords%>" />
<meta name="description" content="<%=yuzhiguo_description%>" />
<meta name="author" content="慧谷设计,QQ:995226433" />
<link href="../css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div align="center">
<%
if request("action")="add" then

if request.form("code")="" then
response.write "<script language=javascript>"
response.write "alert('验证码不能为空!');"
response.write "javascript:history.go(-1);"
response.write "</script>"
elseif Trim(Request.Form("code"))=Empty or Trim(Session("code"))<>Trim(Request.Form("code")) Then
response.write "<script language=javascript>"
response.write"alert('请填写正确的验证码!');"
response.write "javascript:history.go(-1);"
response.write "</script>"
else
set rs=server.CreateObject("adodb.recordset")
sql="select * from yuzhiguo_feedback"
rs.open sql,conn,1,3
rs.addnew

rs("name")=trim(request("name"))
rs("company_name")=trim(request("company_name"))
rs("add")=trim(request("add"))
rs("tel")=trim(request("tel"))
rs("fax")=trim(request("fax"))
rs("email")=trim(request("email"))
rs("website")=trim(request("website"))
rs("msn")=trim(request("msn"))
rs("content")=trim(request("content"))
if feedback_verify=1 then
rs("show")=false
end if
rs("ip")=Request.ServerVariables("REMOTE_ADDR")
rs.update
rs.close
set rs=nothing

	if mail_jmail=1 then'判断jmail发送邮件开关
	
	on error resume next
	'发送注册邮件
	mailbody="<html>"
	mailbody=mailbody & "<head>"
	mailbody=mailbody & "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
	mailbody=mailbody & "<title>★网站留言提醒★来自IP："&Request.ServerVariables("REMOTE_ADDR")&"</title>"
	mailbody=mailbody & "<head>"
	mailbody=mailbody & "<body>"
	mailbody=mailbody & "★留言人："&trim(request("name"))&"<br />"
	mailbody=mailbody & "★公司名称："&trim(request("company_name"))&"<br />"
	mailbody=mailbody & "★电话："&trim(request("tel"))&"<br />"
	mailbody=mailbody & "★E-mail："&trim(request("email"))&"<br />"
	mailbody=mailbody & "★网站："&trim(request("website"))&"<br />"
	mailbody=mailbody & "★留言内容："&trim(request("content"))&"<br />"
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
	JMail.Subject="★网站留言提醒★来自IP："&Request.ServerVariables("REMOTE_ADDR")'邮件标题
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
	response.write"<script>alert('发送成功，您的留言同步发送到管理员邮箱!');location.href='../c_feedback/';</script>"
	else
	response.write"<script>alert('发送成功!');location.href='../c_feedback/';</script>"
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
	objMail.Subject="★网站客户留言通知★留言人IP："&Request.ServerVariables("REMOTE_ADDR")
	objMail.TextBody="★留言人："&trim(request("name"))&" ★电话："&trim(request("tel"))&" ★E-mail："&trim(request("email"))&" ★MSN："&trim(request("msn"))&" ★公司："&trim(request("company_name"))&" ★留言内容："&trim(request("content"))
	objMail.Send
	Set objMail = Nothing

	if err.number <> 0 then 
	response.write"<script>alert('发送成功!');location.href='../c_feedback/';</script>"
	else
	response.write"<script>alert('发送成功，您的留言同步发送到管理员邮箱!');location.href='../c_feedback/';</script>"
	end if 

	rs.close
	set rs=nothing
	
	else
	response.write"<script>alert('发送成功!');location.href='../c_feedback/';</script>"
	end if

 end if
 end if%>
  <!--#include file="../pub/c_top.asp"-->
    <!--#include file="../pub/flash.asp"-->
  <table width="1000" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
      <td width="230" valign="top">
      <!--#include file="../pub/c_left.asp"-->
      </td>
      <td width="10"></td>
      <td width="740" valign="top">
<div id="right_main">
<div class="iproducts">   <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">在线留言</span></div>
	  <div class="cmore"></div></div>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto;">

  <tr>
    <td valign="top">
    <div  style="line-height:20px;">
    <br />   
<%
if feedback_view=1 then
dim page
page=trim(request("page"))
if page="" and not isnumeric(page) then
page=1
end if
filename=""'当前页面文件名称
Set Rs=Server.CreateObject("ADODB.Recordset")
sql="select * from yuzhiguo_feedback where show=true order by id desc"
rs.open sql,conn,1,1
if rs.eof then
response.Write("<center>没有数据</center>")
else
rs.pagesize=10 '一页显示数
currentpage=Clng(page)
i=0
if currentpage<1 then currentpage=1
if currentpage>rs.pagecount then currentpage=rs.pagecount
rs.absolutepage=currentpage
Do While Not rs.Eof and i<rs.pagesize
%>
<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#E2E9EF" style="word-wrap:break-word; overflow:hidden;margin:8px auto;">
<tr>
<td colspan="2" >留言时间：<%=rs("date")%></td>
</tr>
<tr>
<td width="50%" valign="top" bgcolor="#FFFFFF" ><font color="#FF6600"><%=rs("name")%></font> 留言内容：<%=rs("content")%></td>
<td width="50%" valign="top" bgcolor="#FFFFFF"><font color="#FF6600">回复内容：</font><%=rs("reply")%></td>
</tr>
</table>

<%
i=i+1
rs.MoveNext
If i>=rs.pagesize Then Exit Do
Loop
%>
<div id="page">
<span class="text">留言数: <b><%=rs.recordcount%></b></span> 
<span class="text">页次: <b><%=CurrentPage%></b> / <b><%=rs.pagecount%></b></span>
<a href="<%=filename%>">首页</a>&nbsp; 
<a href="<%=filename%>?page=<%=currentpage-1%>">←上一页</a>&nbsp; 
<a href="<%=filename%>?page=<%=currentpage+1%>">下一页→</a>&nbsp; 
<a href="<%=filename%>?page=<%=rs.pagecount%>">末页</a> 
<select name="page" onchange="location=this.options[this.selectedIndex].value" >
<% for i=1 to rs.pagecount %>
<option value="<%=filename%>?page=<%=i%>" <% if i = CurrentPage then response.Write("selected")%>><%=i%> 页</option>
<% next %>
</select>
</div>
<%
end if
rs.close
set rs=nothing
end if
%>

    <script language="javascript">
     function checkadd()
     {
         if (document.feedback.name.value=='')
         {alert('请输入联系人姓名!');
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
          alert('请输入正确的E-mail地址！');
          document.feedback.email.focus();
          return false;
         }
          if (document.feedback.content.value=='')
         {alert('请输入留言内容!');
         document.feedback.content.focus
         return false
         }
		 if (document.feedback.code.value=='')
         {alert('请输入验证码!');
         document.feedback.code.focus
         return false
         }
     }
      </script>    
    <form action="index.asp?action=add" method="post" name="feedback" id="feedback" onsubmit="return checkadd();"><table width="100%"  border="0" align="left" cellpadding="3" cellspacing="1" >
        
          <tr >
            <td colspan="2" align="center" bgcolor="#E2E9EF" class="color_huise2"><strong>请在下面填写留言信息</strong></td>
            </tr>
          <tr >
            <td width="123" align="right" bgcolor="#FFFFFF" class="color_huise2">联系人：</td>
            <td width="562" align="left" bgcolor="#FFFFFF" ><input name="name" type="text" id="name" size="40" maxlength="50" />
                <span class="red">*</span></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">公司名称：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="company_name" type="text" id="company_name" size="50" maxlength="255" /></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">地址：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="add" type="text" id="add" size="60" maxlength="255" /></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">电话：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="tel" type="text" id="tel" size="40" maxlength="50" /></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">传真：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="fax" type="text" id="fax" size="40" maxlength="50" /></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">E-mail：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="email" type="text" id="email" size="50" maxlength="50" />
                <span class="red">*</span></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">网站：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="website" type="text" id="website" size="50" maxlength="50" /></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">MSN：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="msn" type="text" id="msn" size="50" maxlength="50" /></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">QQ：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="qq" type="text" id="qq" size="20" maxlength="50" /></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" class="color_huise2">留言内容：</td>
            <td align="left" bgcolor="#FFFFFF" ><textarea name="content" cols="60" rows="8" id="content"></textarea>
                <span class="red">*</span><br /></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" >验证码：</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="code" type="text" id="code" size="4" maxlength="4" />
                <img src="../pub/code.asp" border="0"  alt="" /><span class="red">*</span></td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" >&nbsp;</td>
            <td align="left" bgcolor="#FFFFFF" >(所有 <span class="red">*</span> 星号必填)</td>
          </tr>
          <tr >
            <td align="right" bgcolor="#FFFFFF" >&nbsp;</td>
            <td align="left" bgcolor="#FFFFFF" ><input name="OK" type="submit" class="input_submit"  id="OK" value=" 提交 " />
              &nbsp;&nbsp;
              <input name="reset" type="reset" class="input_submit"  value=" 重置 " /></td>
          </tr>
       
      </table></form> </div>  </td>
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
