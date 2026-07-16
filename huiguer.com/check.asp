<!--#include file="conn.asp"-->
<SCRIPT language="JavaScript">
if(parent.location == location) location = "index.asp";;
</SCRIPT>
<%
if session("yuzhiguo_admin")=""  then
response.redirect"index.asp"
response.end
else
set rs=conn.execute("select * from yuzhiguo_administrator where name='"&session("yuzhiguo_admin")&"'")
if rs.eof then
response.redirect"index.asp"
response.end
rs.close
end if

if session("power")<>"0" then
	
		cls = Instr(session("power"), lanmu_name)
		if cls <= 0 then
		response.write"<script>alert('系统提示↓\n\n您的操作权限不够,系统拒绝你的访问!');location.href='main.asp';</script>"
		response.end
		end if
end if

end if
%>
