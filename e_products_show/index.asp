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
response.write"<script>alert('No Data');location.href='../e_products/';</script>"
else
%>
<title><%=pro("e_title")%></title>
<meta name="keywords" content="<%=pro("e_keywords")%>" />
<meta name="description" content="<%=pro("e_description")%>" />
<meta name="author" content="Web Design：Xiehui QQ:995226433@qq.com Website:http://huigur.taobao.com" />
<link href="../css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
<script language="javascript"  type="text/javascript" src="../pub/e_hits.asp?action=pro_hits&amp;id=<%=trim(request("id"))%>"></script>
</head>

<body>


  <!--#include file="../pub/e_top.asp"-->
<!--#include file="../pub/flash.asp"-->
<div class="main">
  <table width="1000" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
      <td width="230" valign="top">
      <!--#include file="../pub/e_left.asp"-->
      </td>
      <td width="10"></td>
      <td width="740" valign="top">
<div id="right_main">
<div class="iproducts">   <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">Products</span></div>
	  <div class="cmore"></div>
	  </div>
  <table width="100%" border="0" cellpadding="0" cellspacing="1" style="margin:0 auto;">

  <tr>
    <td colspan="2" align="center" valign="middle" class="line_buttom_hui_xuxian">



<% if pro("pic1")="" and pro("pic2")="" and pro("pic3")="" then%>
<a href="<%=pro("pic")%>"><img src="<%=pro("pic")%>" alt="<%=pro("e_cpmc")%>" border="0"  /></a>
<%else%>
<div class="Pro_Info">
<script language="javascript" src="../js/jquery-1.2.6.pack.js" type="text/javascript"></script>
<script language="javascript" src="../js/pro_images.js" type="text/javascript"></script>
<div class="Pro_Images">
<img <% if pic_aspjpeg=1 then %>src="<%=get_pic(pro("pic"),2)%>" <% else %> src="<%=pro("pic")%>" <% end if %> name="0||<%=pro("pic")%>" alt="<%=pro("e_cpmc")%>"/>
<% if pro("pic1")<>"" then%>
<img <% if pic_aspjpeg=1 then %>src="<%=get_pic(pro("pic1"),2)%>" <% else %> src="<%=pro("pic1")%>" <% end if %> name="1||<%=pro("pic1")%>" alt="<%=pro("e_cpmc")%>"/>
<%end if%>
<% if pro("pic2")<>"" then%>
<img <% if pic_aspjpeg=1 then %>src="<%=get_pic(pro("pic2"),2)%>" <% else %> src="<%=pro("pic2")%>" <% end if %> name="2||<%=pro("pic2")%>" alt="<%=pro("e_cpmc")%>"/>
<%end if%>
<% if pro("pic3")<>"" then%>
<img <% if pic_aspjpeg=1 then %>src="<%=get_pic(pro("pic3"),2)%>" <% else %> src="<%=pro("pic3")%>" <% end if %> name="3||<%=pro("pic3")%>" alt="<%=pro("e_cpmc")%>"/>
<%end if%>

</div>
</div>
<div class="Pro_BigImage"></div>
<%end if%>
</td>
    </tr>
  <tr>
    <td colspan="2" valign="middle">Product name : <strong><%=pro("e_cpmc")%></strong></td>
  </tr>
  <tr>
    <td colspan="2" valign="middle">Item : <strong><%=pro("cpbh")%></strong></td>
  </tr>
  <% if pro("e_price")<>"" then%>
  <tr>
    <td colspan="2" valign="middle">Price : <strong><%=pro("e_price")%></strong></td>
  </tr>
  <%end if%>
  <% if pro("e_intro")<>"" then%>
  <tr>
    <td colspan="2" valign="middle">Details : </td>
    </tr>
  <tr>
    <td colspan="2" class="line_buttom_hui_xuxian"><div class="hangju"><%=pro("e_intro")%> </div></td>
  </tr>
  <%end if%>
  <tr>
    <td width="260" align="left"><img src="../images/inquire_now.gif" width="116" height="21" onclick="javascript:document.location.href='../e_order/?name=<%=pro("cpbh")%>'" style="cursor:pointer;"/></td>
    <td align="right"><%
						Set rs=conn.Execute("Select top 1 * from yuzhiguo_products Where big_id="&pro("big_id")&" and small_id="&pro("small_id")&" and id > "&trim(request("id"))&"  order by id asc")
						If Not rs.eof Then
						%>
      <a href="../html_products/<%=rs("html_url_en")%>" title="<%=rs("e_cpmc")%>">←[Previous : <%=rs("cpbh")%>]</a>
      <%
						End If 
						
						%>
      <%
						Set rs=conn.Execute("Select top 1 * from yuzhiguo_products Where big_id="&pro("big_id")&" and small_id="&pro("small_id")&" and id < "&trim(request("id"))&"  order by id desc")
						If Not rs.eof Then
						%>
      <a href="../html_products/<%=rs("html_url_en")%>" title="<%=rs("e_cpmc")%>">[Next : <%=rs("cpbh")%>]→</a>
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

</div>
  <!--#include file="../pub/e_foot.asp"-->
</body>
</html>
