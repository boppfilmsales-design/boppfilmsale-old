<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<!--#include file="../pub/function.asp"-->
<%
Set pro=Server.CreateObject("ADODB.Recordset")
Sql="Select * From yuzhiguo_products where id="&trim(request("id"))
pro.Open Sql,Conn,1,1
if pro.bof and pro.eof then
response.write"<script>alert('没有数据');location.href='../c_products/';</script>"
else
%>
<title><%=pro("title")%></title>
<meta name="keywords" content="<%=pro("keywords")%>" />
<meta name="description" content="<%=pro("description")%>" />
<meta name="author" content="慧谷设计,QQ:995226433" />
<link href="../css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
<script language="javascript"  type="text/javascript" src="../pub/e_hits.asp?action=pro_hits&amp;id=<%=trim(request("id"))%>"></script>
</head>

<body>


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

  <table width="100%" border="0" cellpadding="0" cellspacing="1" style="margin:0 auto;">
  <tr>
    <td>
      <div class="right">
       <div class="iproducts">   <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">产品展示</span></div>
	  <div class="cmore"></div>
	  </div>
	</td>
  </tr>
  <tr>
    <td colspan="2" align="center" bgcolor="#E6F2EF"><h1 class="weizhi"><%=pro("cpmc")%></h1></td>
  </tr>
  <tr>
    <td colspan="2" align="center" valign="middle" class="line_buttom_hui_xuxian">
<% if pro("pic1")="" and pro("pic2")="" and pro("pic3")="" then%>
<a href="<%=pro("pic")%>"><img src="<%=pro("pic")%>" alt="<%=pro("cpmc")%>" border="0" /></a>
<%else%>
<div class="Pro_Info">
<script language="javascript" src="../js/jquery-1.2.6.pack.js" type="text/javascript"></script>
<script language="javascript" src="../js/pro_images.js" type="text/javascript"></script>
<div class="Pro_Images">
<img <% if pic_aspjpeg=1 then %>src="<%=get_pic(pro("pic"),2)%>" <% else %> src="<%=pro("pic")%>" <% end if %> name="0||<%=pro("pic")%>" alt="<%=pro("cpmc")%>"/>
<% if pro("pic1")<>"" then%>
<img <% if pic_aspjpeg=1 then %>src="<%=get_pic(pro("pic1"),2)%>" <% else %> src="<%=pro("pic1")%>" <% end if %> name="1||<%=pro("pic1")%>" alt="<%=pro("cpmc")%>"/>
<%end if%>
<% if pro("pic2")<>"" then%>
<img <% if pic_aspjpeg=1 then %>src="<%=get_pic(pro("pic2"),2)%>" <% else %> src="<%=pro("pic2")%>" <% end if %> name="2||<%=pro("pic2")%>" alt="<%=pro("cpmc")%>"/>
<%end if%>
<% if pro("pic3")<>"" then%>
<img <% if pic_aspjpeg=1 then %>src="<%=get_pic(pro("pic3"),2)%>" <% else %> src="<%=pro("pic3")%>" <% end if %> name="3||<%=pro("pic3")%>" alt="<%=pro("cpmc")%>"/>
<%end if%>
</div>
</div>
<div class="Pro_BigImage"></div>
<%end if%>
</td>
    </tr>
  <tr>
    <td colspan="2" valign="middle">产品名称：<strong><%=pro("cpmc")%></strong></td>
  </tr>
  <tr>
    <td colspan="2" valign="middle">产品编号：<strong><%=pro("cpbh")%></strong></td>
  </tr>
  <% if pro("price")<>"" then%>
  <tr>
    <td colspan="2" valign="middle">产品价格：<strong><%=pro("price")%></strong></td>
  </tr>
  <%end if%>
  <% if pro("intro")<>"" then%>
  <tr>
    <td colspan="2" valign="middle">详细说明：</td>
    </tr>
  <tr>
    <td colspan="2" class="line_buttom_hui_xuxian"><div class="hangju"><%=pro("intro")%> </div></td>
  </tr>
  <%end if%>
  <tr>
    <td width="260" align="left"><img src="../images/icon_inquire_now_cn.gif" onclick="javascript:document.location.href='../c_order/?name=<%=pro("cpbh")%>'" style="cursor:pointer;"/></td></tr>
  <tr><td align="right"><%
						Set rs=conn.Execute("Select top 1 * from yuzhiguo_products Where big_id="&pro("big_id")&" and small_id="&pro("small_id")&" and id > "&trim(request("id"))&"  order by id asc")
						If Not rs.eof Then
						%>
      <a href="../c_html_products/<%=rs("html_url_cn")%>" title="<%=rs("cpmc")%>">←[上一个产品：<%=rs("cpbh")%>]</a>
      <%
						End If 
						
						%>
      <%
						Set rs=conn.Execute("Select top 1 * from yuzhiguo_products Where big_id="&pro("big_id")&" and small_id="&pro("small_id")&" and id < "&trim(request("id"))&"  order by id desc")
						If Not rs.eof Then
						%>
      <a href="../c_html_products/<%=rs("html_url_cn")%>" title="<%=rs("cpmc")%>">[下一个产品：<%=rs("cpbh")%>]→</a>
      <%
						End If 
						Set rs=nothing
						%></td>
  </tr>
</table>
</div>
</td>
    </tr>
  </table>
  <%
end if
pro.close
set pro=nothing
%>
  <!--#include file="../pub/c_foot.asp"-->
</div>

</body>
</html>
