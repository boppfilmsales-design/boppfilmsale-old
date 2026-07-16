<div style="width:100%; height:97px; background-image:url(../images/bottom.gif);" class="foot">
<div style="width:1000px; COLOR: #fffffff; margin:auto;">
<div style="width:980px; padding:10px; float:left; text-align:center;" class="foot1">
<%set rs=server.CreateObject("adodb.recordset")
rs.open "select * from  yuzhiguo_menu  where show=false order by sort asc",conn,1,1
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
<a href="<%=webfolder%>c_sitemap/" target="_blank">网站地图</a><br />
      皖ICP备11005402号 版权所有 © <%=year(now())%>&nbsp;<%=yuzhiguo_webname%>

<%
conn.close '断开数据库连接
set conn=nothing
%>

</div>
<div style="clear:both;"></div>
</div>
</body>
</html>
<div align="center"><script src="http://s21.cnzz.com/stat.php?id=4839800&web_id=4839800&show=pic" language="JavaScript"></script>
</div>
<!--#include file="c_online.asp"-->