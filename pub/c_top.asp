<div class="header">
  <div class="logo_l">
   <div class="logo">
  <% if logo<>"" then%><a href="<%=weburl%>"><img src="<%=webfolder%><%=get_pic(logo,1)%>" alt="<%=webname%>" border="0" /></a><%end if%>
  </div>
  
     <div class="company_name">
     <h1 class="company_name" style="font-family:黑体,黑体;"><%=yuzhiguo_webname%></h1> </div>
                  </div>
	
  <div class="logo_r">

  <div class="tz"></div><div class="bq"><a href="<%=webfolder%>index_cn.html"><img src="<%=webfolder%>images/cn.gif" alt="进入中文版" border="0"  /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=webfolder%>index_en.html"><img src="<%=webfolder%>images/en.gif" alt="ENGLISH" border="0"  /></a></div>   
  </div>
  
  
</div>
<div class="menu_box">
  <div class="menu"><div style="width:100px; line-height:27px; float:left; text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
   

      <%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_menu  where show=false order by sort asc",conn,1,1
if rs.eof and rs.bof then
%>
 <div style="width:100px; line-height:27px; float:left; text-align:center;">没有数据</div>
<%else%>
<%do while not rs.eof%>

    <div style="width:100px; line-height:27px; float:left; text-align:center;"><a href="<%=webfolder%><%=rs("url")%>" title="<%=rs("name")%>"><%=rs("name")%></a></div>
    
    <%
rs.movenext
loop
end if
rs.close
set rs=nothing
%>
	

  </div></div><div style="width:1000px; height:5px; float:left;"></div>