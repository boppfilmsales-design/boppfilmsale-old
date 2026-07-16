<table width="980" border="0" cellpadding="0" cellspacing="0" id="menu">
  <%
  menu_width=980/Mydb("Select Count([ID]) From [yuzhiguo_menu] where show=false",1)(0)
  %>
  <%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_menu  where show=false order by sort asc",conn,1,1
if rs.eof and rs.bof then
%>
<tr>
  <td align="center">没有数据</td>
</tr>
<%else%>
    <tr>
		<%do while not rs.eof%>
        <td  width="<%=menu_width%>">
        <a href="<%=webfolder%><%=rs("url")%>" title="<%=rs("name")%>"><%=rs("name")%></a>
        </td>
<%
rs.movenext
loop
end if
rs.close
set rs=nothing
%>
    </tr>
  </table>