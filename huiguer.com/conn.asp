<!--#include file="../pub/data_name.asp"-->
<%
session.timeout=1440'session保持时间，分钟
Response.Buffer=True
db = data_name
Connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source="&Server.MapPath(db)
SqlNowString="Now()"
SqlChar="'"
On Error Resume Next
Set Conn=Server.CreateObject("ADODB.Connection")
Conn.open ConnStr
If Err Then
err.Clear
Set Conn = Nothing
Response.Write "网站数据库连接出错，请检查设置的数据库路径是否正确！"
Response.End
End If
On Error GoTo 0
%>
<!--#include file="../pub/config.asp"-->
<!--#include file="../pub/function.asp"-->
<script language="javascript" type="text/javascript" src="pub/chkall.js" ></script>
<script language="javascript" type="text/javascript" src="pub/css.js" ></script>
