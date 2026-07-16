<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_e_link  where show=true and class_id=0 order by sort asc,link_id asc",conn,1,1
if rs.eof and rs.bof then
else
%>
<table width="980" border="0" cellpadding="0" cellspacing="0" class="border_hui_xuxian" style="margin-top:8px;">
<tr>
<td>
<div class="hangju">
<%
do while not rs.eof%>
<a href="<%=rs("url")%>" target="_blank" ><%=rs("name")%></a> |
<%rs.movenext
loop
%>
</div></td>
</tr>
</table>
<%
end if
rs.close
set rs=nothing
%>

<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_e_link  where show=true and class_id=1 order by sort asc,link_id asc",conn,1,1
if rs.eof and rs.bof then
else
%>
<table width="980" border="0" cellpadding="0" cellspacing="0" class="border_hui_xuxian" style="margin-top:8px;">
<tr>
<td>

<%
do while not rs.eof%>
<a href="<%=rs("url")%>"  target="_blank" ><img src="<%=rs("logo")%>"  alt="<%=rs("name")%>" border="0" /></a>
<%rs.movenext
loop
%>

</td>
</tr>
</table>
<%
end if
rs.close
set rs=nothing
%>