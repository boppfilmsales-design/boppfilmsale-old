<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_link  where show=true and class_id=0 order by sort asc,link_id asc",conn,1,1
if rs.eof and rs.bof then
else
%>
<div style=" width:980px; padding:3px 10px 3px 10px; clear:both; margin: 0px auto; background:#FFF;">
<%
do while not rs.eof%>
<a href="<%=rs("url")%>" target="_blank" ><%=rs("name")%></a> |
<%rs.movenext
loop
%>
</div>

<%
end if
rs.close
set rs=nothing
%>

<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_link  where show=true and class_id=1 order by sort asc,link_id asc",conn,1,1
if rs.eof and rs.bof then
else
%>
<div style=" width:980px; padding:3px 10px 3px 10px; clear:both; margin: 0px auto; background:#FFF;">

<%
do while not rs.eof%>
<a href="<%=rs("url")%>"  target="_blank" ><img src="<%=rs("logo")%>"  alt="<%=rs("name")%>" border="0" /></a>
<%rs.movenext
loop
%>

</div>
<%
end if
rs.close
set rs=nothing
%>