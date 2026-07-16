<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="../pub/conn.asp"-->
<!--#include file="../pub/function.asp"-->
<%
key=trim(request("key"))
%>
<%
big_id=trim(request("big_id"))
small_id=trim(request("small_id"))
%>
<title>
<%set rss=server.createobject("adodb.recordset") 
if big_id="" then
big=0
response.write ""&yuzhiguo_keywords&""
else
sql="select * from yuzhiguo_big_class where big_id="&big_id&""
rss.open sql,conn,1,1
if rss.eof and rss.bof then
else 
weizhi=" > "+rss("name")
big_url=rss("html_url_cn")
%>
<%=rss("name")%>
<%
rss.close
set rss=nothing
end if
end if%><%set rss=server.createobject("adodb.recordset") 
if small_id="" then
small=0
else
sql="select * from yuzhiguo_small_class where small_id="&small_id&""
rss.open sql,conn,1,1
if rss.eof and rss.bof then
else 
weizhi=weizhi+" > "+rss("name")
small_url=rss("html_url_cn")
%> - <%=rss("name")%>
<%rss.close
set rss=nothing
end if
end if%>,产品展示</title>
<meta name="keywords" content="<%=yuzhiguo_keywords%>" />
<meta name="description" content="<%=yuzhiguo_description%>" />
<meta name="author" content="慧谷设计,QQ:995226433" />
<link href="../css/<%=skin_css%>.css" rel="stylesheet" type="text/css" />
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
<div class="right">
  <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 auto;">
  <tr>
    <td bgcolor="#E6F2EF">    <div class="iproducts">   <div class="company_ico"><div align="center"></div></div>
	  <div class="company_title"><span class="ztitle">产品展示</span></div>
	  <div class="cmore"></div>
	  </div>
	  </td>
      </tr>
  <tr>
    <td><br />
<%if key<>"" then%>关键词 “<font  color="#FF0000"><%=key%></font>”搜索结果如下：<%end if%>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <%
 			DIM totalPut   
 			DIM CurrentPage
 			DIM TotalPages
			DIM MaxPerPage
			DIM pagename
 			MaxPerPage=product_page'定义一页显示产品数
 			pagename=""'页面名称
  			DIM i,j
  			IF not isempty(request("page")) then
    		currentPage=cint(request("page"))
  			ELSE
   			currentPage=1
 			END IF
  		    DIM sql
  
	  	   Set Rs=Server.CreateObject("ADODB.Recordset")
		   if request("big_id")="" then 
		   Sql="Select * From yuzhiguo_products where cpmc like '%"&key&"%' or cpbh like '%"&key&"%' or intro like '%"&key&"%' order by sort desc,id desc"
		   elseif request("big_id")<>"" and request("small_id")="" then
		   Sql="Select * From yuzhiguo_products where big_id="&int(request("big_id"))&"  order by sort desc,id desc"
		   elseif request("big_id")<>"" and request("small_id")<>"" then
		   Sql="Select * From yuzhiguo_products where big_id="&int(request("big_id"))&" and small_id="&int(request("small_id"))&"  order by sort desc,id desc"
		   end if
		   Rs.Open Sql,Conn,1,1
  		   if rs.eof and rs.bof then 
     	  response.write "<tr><td><center>没有数据</center></td></tr>" 
  			else 
     		totalPut=rs.recordcount 
       if currentpage<1 then 
          currentpage=1 
       end if 
       if (currentpage-1)*MaxPerPage>totalput then 
          if (totalPut mod MaxPerPage)=0 then 
            currentpage= totalPut \ MaxPerPage 
	      else 
	         currentpage= totalPut \ MaxPerPage + 1 
          end if 
       end if 
       if currentPage=1 then 
          showContent
          showpage totalput,MaxPerPage,pagename
       else 
          if (currentPage-1)*MaxPerPage<totalPut then 
            rs.move  (currentPage-1)*MaxPerPage 
            dim bookmark 
            bookmark=rs.bookmark 
            showContent
            showpage totalput,MaxPerPage,pagename
          else 
            currentPage=1 
            showContent
            showpage totalput,MaxPerPage,pagename
          end if 
       end if 
           rs.close 
   end if
   set rs=nothing
   sub showContent
   %>
        
          <%
		   cols=product_hang'一行显示产品数
		   do while not rs.eof
		   if a mod cols=0 then response.Write("</tr><tr>")
		   a=a+1
	 		 %>
          <td valign="top"><table width="<%=pic_width%>"  border="0" cellpadding="0" cellspacing="0" style="margin:0 auto 10px auto;">
            <tr>
              <td height="<%=pic_height%>" align="center" bgcolor="#FFFFFF" class="border_hui"><a href="../c_html_products/<%=rs("html_url_cn")%>" target="_blank"> <img <% if pic_aspjpeg=1 then %>src="<%=get_pic(rs("pic"),2)%>" <% else %> src="<%=rs("pic")%>" width="<%=pic_width%>" height="<%=pic_height%>" <% end if %> alt="<%=rs("cpmc")%>" border="0" /></a></td>
            </tr>
            <tr>
              <td align="center" ><a href="../c_html_products/<%=rs("html_url_cn")%>" target="_blank" ><%=rs("cpbh")%><br />
                    <%=rs("cpmc")%></a></td>
            </tr>
          </table>
            </td>
          <%
		 if a=MaxPerPage then exit do
		 rs.movenext
		 loop
		%>
        </tr>
      </table>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" >
<tr >
<td >
 <div id="page">
<%
  	end sub
	function showpage(totalnumber,maxperpage,filename)
   dim n
   if totalnumber mod maxperpage=0 then 
     n= totalnumber \ maxperpage 
   else 
     n= totalnumber \ maxperpage+1 
   end if 
      if request("big_id")="" then
      big_id=""
   else
      big_id=request("big_id")
   end if
   if request("small_id")="" then
      small_id=""
   else
      small_id=request("small_id")
   end if   	  
   %>

  <span class="text">产品总数: <b><%=totalnumber%></b></span> 
 <span class="text">页次: <b><%=CurrentPage%></b> / <b><%=n%></b></span> 

	<% if CurrentPage=1 then%>
    <span class="text">首页</span>
 	<span class="text">←上一页</span>
    <% else %>
 	 <a href="<%=filename%>?big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;page=1&amp;key=<%=key%>" >首页</a> &nbsp; 
 <a href="<%=filename%>?big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;page=<%=CurrentPage-1%>&amp;key=<%=key%>" >←上一页</a> &nbsp; 
    <% end if%>
    <% if CurrentPage<n then%>
     <a href="<%=filename%>?big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;page=<%=CurrentPage+1%>&amp;key=<%=key%>">下一页→</a> &nbsp; 
 <a href="<%=filename%>?big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;page=<%=n%>&amp;key=<%=key%>" >末页</a> &nbsp;
    <% else %>
    <span class="text">下一页→</span>
 	<span class="text">末页</span>
    <% end if%>
<select name="page" onchange="location=this.options[this.selectedIndex].value" style="border:0;" >
   <% for i=1 to n %>
   <option value="?big_id=<%=big_id%>&amp;small_id=<%=small_id%>&amp;page=<%=i%>&amp;key=<%=key%>" <% if i = CurrentPage then response.Write("selected")%>><%=i%> 页</option>
   <% next %>
   </select>
            <%end function%>
            </div></td>
</tr>
</table>    </td>
  </tr>
  </table>
</div></td>
    </tr>
  </table>

</div>
  <!--#include file="../pub/c_foot.asp"-->
</body>
</html>
