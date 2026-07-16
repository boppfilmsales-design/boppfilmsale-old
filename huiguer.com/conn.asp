<!--#include file="../pub/data_name.asp"-->
<%
' ============================================================
'  conn.asp —— 纯数据库连接文件（已净化）
'  原文件含黑帽 SEO 劫持后门（针对搜索引擎 UA 替换/重定向内容），
'  已于 2026-07-16 移除。本文件仅负责建立 Access 数据库连接。
' ============================================================

session.timeout = 1440  ' session 保持时间，分钟
Response.Buffer = True

db = data_name
Connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(db)
SqlNowString = "Now()"
SqlChar = "'"

On Error Resume Next
Set Conn = Server.CreateObject("ADODB.Connection")
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
