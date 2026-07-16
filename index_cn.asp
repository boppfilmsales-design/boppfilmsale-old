<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="pub/conn_index.asp"-->
<!--#include file="pub/function.asp"-->
<title><%=yuzhiguo_webname%> - <%=yuzhiguo_title%></title>
<meta name="keywords" content="<%=yuzhiguo_keywords%>" />
<meta name="description" content="<%=yuzhiguo_description%>" />
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
</head>

<body>
  <!--#include file="pub/c_top.asp"-->
  <!--#include file="pub/flash.asp"-->
  <div class="main">
  <!--#include file="pub/c_left.asp"-->

 <!--left end-->
 
 <div class="right">

      <div class="index_company">
      <div class="icompany">
	  <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">关于我们</span></div>
	  <div class="cmore"></div>
	  </div>
	  <div class="a_content">    <% 
	set rs=Server.CreateObject("ADODB.RecordSet")
	sql="select * from yuzhiguo_other where id=1"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then 
	response.write "<center>没有数据</center>" 
	else 
	%>
	<img align="left" src="images/jianjie.gif" /><%=rs("content")%><a href="c_html_info/guanyuwomen-home.html">更多...</a>
	<%
	rs.close 
	set rs=nothing
	end if
	%>
	</div>
    </div>
   <div style="clear:both"></div>

   <div class="index_news">
   <div class="inews">
	  <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">公司新闻</span></div>
	  <div class="cmore"><a href="c_news/?class_id=1">+ More </a></div>
	  </div>
	  <div class="c_content">
	  
	  <%set rs=server.CreateObject("adodb.recordset")
rs.open "select top 3 * from  yuzhiguo_news where class_id=1 order by id desc",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
	  <div class="index_news_title">
		   <div class="news_ico"><img src="./images/icon_news.gif" width="7" height="9"></div>
		   <div class="news_list"><a href="../c_html_news/<%=rs("html_url")%>"  > &bull; <%=left(rs("name"),15)%></a></div>
	
		</div>


<%
i=i+0
rs.MoveNext
If i>=5 Then Exit Do
Loop
%>
<%
end if
rs.close
set rs=nothing
%>


		
	  
	  
			
	  </div>
   </div>

   
   <div class="index_news">
   <div class="inews">
	  <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">行业新闻</span></div>
	  <div class="cmore"><a href="c_news/?class_id=2">+ More </a></div>
	  </div>
	  <div class="c_content">
	  
	 	  <%set rs=server.CreateObject("adodb.recordset")
rs.open "select top 3 * from  yuzhiguo_news where class_id=2 order by id desc",conn,1,1
if rs.eof and rs.bof then
else
%>
<%
do while not rs.eof%>
	  <div class="index_news_title">
		   <div class="news_ico"><img src="./images/icon_news.gif" width="7" height="9"></div>
		   <div class="news_list"><a href="../c_html_news/<%=rs("html_url")%>"  > &bull; <%=left(rs("name"),15)%></a></div>
	
		</div>


<%
i=i+0
rs.MoveNext
If i>=5 Then Exit Do
Loop
%>
<%
end if
rs.close
set rs=nothing
%>
	
	  </div>
   </div>
   <div style="clear:both"></div>
   
   
   <div class="iproducts">
	  <div class="products_ico"><div align="center"></div></div>
	  <div class="products_title"><span class="ztitle">热销产品</span></div>
	  <div class="cmore"><a href="c_products/">+ More </a></div>
	  </div>
	  
   <div class="products_content">
   
    <%
	  	   Set Rs=Server.CreateObject("ADODB.Recordset")
		   Sql="Select * From yuzhiguo_products where newpro=1 order by sort desc,id desc"
		   Rs.Open Sql,Conn,1,1
		   
  if rs.eof and rs.bof then 
     response.write "<tr><td><center>没有数据</center></td></tr>" 
  else 
   %>
        <%
		   cols=product_hang
		   do while not rs.eof
		   if a mod cols=0 then response.Write("<tr>")
		   a=a+1
	  %>
   
      <div style="width:150px; height:200px; float:left; padding:15px;">
	  <table width="150" border="0" cellpadding="0" cellspacing="0">
  <tbody><tr>
    <td height="150" class="hui" onmouseover="this.className=&#39;huang&#39;" onmouseout="this.className=&#39;hui&#39;"><div align="center"><a href="c_html_products/<%=rs("html_url_cn")%>" target="_blank"> <img <% if pic_aspjpeg=1 then %>src="<%=get_pic(rs("pic"),3)%>" <% else %> src="<%=get_pic(rs("pic"),1)%>" width="<%=pic_width%>" height="<%=pic_height%>" <% end if %> alt="<%=rs("cpmc")%>" border="0" /></a></div></td>
  </tr>
  <tr>
     <td><div align="center"><a href="c_html_products/<%=rs("html_url_cn")%>" target="_blank" ><%=rs("cpbh")%><br /><%=rs("cpmc")%></a></div></td>
  </tr>
</tbody></table>	  
	  </div>
	
    <%
		 if a=product_hots then exit do
		 rs.movenext
		 loop
		 %>
        <%
          end if
          rs.close
          set rs=nothing
          %>
   
	  
    </div> 
    </div>
 <div style="clear:both"></div>
</div>

  <!--#include file="pub/c_link.asp"-->
  <!--#include file="pub/c_foot.asp"-->



</body>
</html>
