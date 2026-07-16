<div style="width:100%; height:97px; background: #048EBC;" class="foot">
<div style="width:1000px; COLOR: #fffffff; margin:auto; background-image:url(../images/bottom.jpg);">
<div style="width:980px; padding:10px; float:left; text-align:center;" class="foot1">
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_e_menu  where show=false order by sort asc",conn,1,1
if rs.eof and rs.bof then
%>
<%else%>
<%do while not rs.eof%>
<a href="<%=webfolder%><%=rs("url")%>" title="<%=rs("name")%>"><%=rs("name")%></a> | 
<%
rs.movenext
loop
end if
rs.close
set rs=nothing
%>
<a href="<%=webfolder%>c_sitemap/" target="_blank">Site Map</a><br />
      Copyright © <%=year(now())%>&nbsp;<%=e_webname%>

<%
conn.close '断开数据库连接
set conn=nothing
%>

</div>
<div style="clear:both;"></div>
</div>
</div>



  <!--#include file="e_online.asp"-->