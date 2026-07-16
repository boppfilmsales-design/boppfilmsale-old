<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>网站管理系统</title>
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<SCRIPT>
var status = 1;
function switchSysBar(){
     if (1 == window.status){
		  window.status = 0;
          switchPoint.innerHTML = '<img src="images/left.gif">';
          document.all("frmTitle").style.display="none"
     }
     else{
		  window.status = 1;
          switchPoint.innerHTML = '<img src="images/right.gif">';
          document.all("frmTitle").style.display=""
     }
}
</SCRIPT>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body style="overflow:scroll; overflow-y:hidden;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed">
  <tr>
    <td  style="width:3px;"> </td>
    <td width="220" id="frmTitle" style="border-right:solid 1px #698CC3;"><iframe name="I2" height="100%" width="220" border="0" frameborder="0" src="left.asp">
		浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</iframe></td>
    <td style="width:18px;background:#D6E0EF;" valign="middle">
    <div onClick="switchSysBar()">
		<span id="switchPoint" title="关闭/打开左栏"><img src="images/right.gif" alt="" /></span>
	</div></td>
    <td style="border-left:solid 1px #000000;"><iframe name="main" src="main.asp" height="100%" width="100%" border="0" frameborder="0">
		浏览器不支持嵌入式框架，或被配置为不显示嵌入式框架。</iframe></td>
    <td style="width:3px;"> </td>
  </tr>
</table>
</body>
</html>
