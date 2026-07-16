<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>导航</title>
<meta name="author" content="Web Design：Yangxing QQ:995226433 E-mail:gzyjyx@163.com Website:http://yxshejitao.taobao.com" />
<link href="pub/css.css" rel="stylesheet" type="text/css" />
</head>
<script language="JavaScript">
function ClearAllDeploy(){
var deployitem=FetchCookie("deploy");
var admin_start;
var userdeploy='';
admin_start= deployitem ? deployitem.indexOf("\n") : -1;
if(admin_start!=-1){
userdeploy=deployitem.substring(0,admin_start);
}
for(i=0;i<20;i++){
obj=document.getElementById("cate_"+"id"+i);
img=document.getElementById("img_"+"id"+i);
if(obj && obj.style.display=="none"){
obj.style.display="";
img_re=new RegExp("_open\\.gif$");
img.src=img.src.replace(img_re,'_fold.gif');
}
}
deployitem=userdeploy+"\n\t\t";
SetCookie("deploy",deployitem);
}
function SetAllDeploy(){
var deployitem=FetchCookie("deploy");
var admin_start;
var userdeploy='';
var admindeploy='';
var i;
admin_start= deployitem ? deployitem.indexOf("\n") : -1;
if(admin_start!=-1){
userdeploy=deployitem.substring(0,admin_start);
}
for(i=0;i<20;i++){
obj=document.getElementById("cate_"+"id"+i);
img=document.getElementById("img_"+"id"+i);
if(obj && obj.style.display==""){
obj.style.display="none";
img_re=new RegExp("_fold\\.gif$");
img.src=img.src.replace(img_re,'_open.gif');
}
admindeploy=admindeploy+"id"+i+"\t";
}
deployitem=userdeploy+"\n\t"+admindeploy;
SetCookie("deploy",deployitem);
}
function IndexDeploy(ID,type){
obj=document.getElementById("cate_"+ID);
img=document.getElementById("img_"+ID);
if(obj.style.display=="none"){
obj.style.display="";
img_re=new RegExp("_open\\.gif$");
img.src=img.src.replace(img_re,'_fold.gif');
SaveDeploy(ID,type,false);
}else{
obj.style.display="none";
img_re=new RegExp("_fold\\.gif$");
img.src=img.src.replace(img_re,'_open.gif');
SaveDeploy(ID,type,true);
}
return false;
}
function SaveDeploy(ID,type,is){
var foo=new Array();
var deployitem=FetchCookie("deploy");
var admin_start;
var admindeploy='';
var userdeploy='';
admin_start= deployitem ? deployitem.indexOf("\n") : -1;
if(admin_start!=-1){
admindeploy= deployitem.substring(admin_start+1,deployitem.length);
userdeploy = deployitem.substring(0,admin_start);
}
if(deployitem!=null){
if(admin_start!=-1){
deployitem = type==0 ? userdeploy : admindeploy;
}
deployitem=deployitem.split("\t");
for(i in deployitem){
if(deployitem[i]!=ID && deployitem[i]!=""){
foo[foo.length]=deployitem[i];
}
}
}
if(is){
foo[foo.length]=ID;
}
deployitem = type==0 ? "\t"+foo.join("\t")+"\t\n"+admindeploy : userdeploy+"\n\t"+foo.join("\t")+"\t";
SetCookie("deploy",deployitem)
}
function SetCookie(name,value){
expires=new Date();
expires.setTime(expires.getTime()+(86400*365));
document.cookie=name+"="+escape(value)+"; expires="+expires.toGMTString()+"; path=/";
}
function FetchCookie(name){
var start=document.cookie.indexOf(name);
var end=document.cookie.indexOf(";",start);
return start==-1 ? null : unescape(document.cookie.substring(start+name.length+1,(end>start ? end : document.cookie.length)));
}
</script>
<body>
<table width="100%" cellspacing="1" cellpadding="4" border="0" class=a2>
<tr>
<td><table width="98%" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td align="center" class="a3"><a href="#" onClick="return ClearAllDeploy()" class="a_bold">[展开+]</a> <a href="#" onClick="return SetAllDeploy()" class="a_bold">[关闭-]</a> </td>
</tr>
</table></td>
</tr>
<tr><td>
<table width="98%" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td class="a1">
<a style="float:right"><img src="images/cate_fold.gif" border=0></a>
<a href="main.asp" class="a1" target="main"><b>后台管理首页</b></a></td>
</tr>
<tr>
<td align="center"><font color="#0066FF"><%=session("yuzhiguo_admin")%></font> | <a href="administrator.asp" target="main">修改密码</a></td>
</tr>
</table>
</td></tr>
<tr><td>
<table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td class="a1">
<a style="float:right" href="#" onClick="return IndexDeploy('id1',1)"><img id="img_id1" src="images/cate_fold.gif" border=0></a>
<a href="#" onClick="return IndexDeploy('id1',1)" class="a1"><b>网站基本信息</b></a></td>
</tr>
<tbody id="cate_id1" style="display:none;">

<tr>
<td align="center" class="a3">
<a href="setup.asp" target="main">网站基本配置</a>		  </td>
</tr>
<tr>
  <td align="center" class="a3"><a href="e_flash.asp" target="main">FLASH图片管理</a></td>
</tr>
<tr>
<td align="center" class="a3"><a href="../space.asp" target="main">空间占用情况</a></td>
</tr>
<tr>
  <td align="center" class="a3"><a href="sql.asp" target="main">防注入管理</a></td>
</tr>
<tr>
<td align="center" class="a3"><a href="pic_manage.asp" target="main">上传图片管理</a></td>
</tr>
<tr>
<td align="center" class="a3"><a href="bots_view.asp" target="main">蜘蛛来访情况</a></td>
</tr>
</tbody>
</table>
</td></tr>
<tr>
  <td><table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td colspan="2" class="a1">
<a style="float:right" href="#" onClick="return IndexDeploy('id2',1)"><img id="img_id2" src="images/cate_fold.gif" border=0></a>
<a href="#" onClick="return IndexDeploy('id2',1)" class="a1"><b>导航管理</b></a></td>
</tr>
<tbody id="cate_id2" style="display:none;">

<tr>
  <td width="30%" align="center" class="a3">中文</td>
  <td align="left" class="a3"><a href="c_menu.asp" target="main">导航管理</a></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
  <td align="left" class="a4"><a href="e_menu.asp" target="main">导航管理</a></td>
</tr>
</tbody>
</table></td>
</tr>
<tr>
  <td>
  <table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
    <tr>
      <td colspan="2" class="a1"><a style="float:right" href="#" onclick="return IndexDeploy('id3',1)"><img id="img_id3" src="images/cate_fold.gif" border="0" /></a> <a href="#" onclick="return IndexDeploy('id3',1)" class="a1"><b>静态管理</b></a></td>
    </tr>
    
      <tr>
        <td colspan="2" align="center"><a href="html_all.asp" target="main" onclick="return confirm('确认要重新生成网站静态吗，此操作比较耗费服务器资源！')">一键生成全站静态</a></td>
      </tr>
      <tbody id="cate_id3" style="display:none;">
      <tr>
        <td width="30%" rowspan="4" align="center" class="a3">中文</td>
        <td align="left" class="a3"><a href="c_html_index.asp" target="main" onclick="return confirm('确认要重新生成网站首页静态吗，此操作比较耗费服务器资源！')">网站首页</a></td>
      </tr>
      <tr>
        <td align="left" class="a3"><a href="c_html_info.asp" target="main" onclick="return confirm('确认要重新生成单栏目静态吗，此操作比较耗费服务器资源！')">单栏目</a></td>
      </tr>
      
      <tr>
        <td align="left" class="a3"><a href="c_html_products.asp" target="main" onclick="return confirm('确认要重新生成所有产品静态吗，此操作比较耗费服务器资源！')">全部产品</a></td>
      </tr>
      <tr>
        <td align="left" class="a3"><a href="c_html_news.asp" target="main" onclick="return confirm('确认要重新生成所有新闻静态吗，此操作比较耗费服务器资源！')">全部新闻</a></td>
      </tr>
      <tr>
        <td rowspan="4" align="center" class="a4">英文</td>
        <td align="left" class="a4"><a href="e_html_index.asp" target="main" onclick="return confirm('确认要重新生成首页静态吗，此操作比较耗费服务器资源！')">网站首页</a></td>
      </tr>
      <tr>
        <td align="left" class="a4"><a href="e_html_info.asp" target="main" onclick="return confirm('确认要重新生成单栏目静态吗，此操作比较耗费服务器资源！')">单栏目</a></td>
      </tr>
      
      <tr>
        <td align="left" class="a4"><a href="e_html_products.asp" target="main" onclick="return confirm('确认要重新生成所有产品静态吗，此操作比较耗费服务器资源！')">全部产品</a></td>
      </tr>
      <tr>
        <td align="left" class="a4"><a href="e_html_news.asp" target="main" onclick="return confirm('确认要重新生成所有新闻静态吗，此操作比较耗费服务器资源！')">全部新闻</a></td>
      </tr>
    </tbody>
  </table>
  </td>
</tr>
<tr><td>
<table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td colspan="2" class="a1">
<a style="float:right" href="#" onClick="return IndexDeploy('id4',1)"><img id="img_id4" src="images/cate_fold.gif" border=0></a>
<a href="#" onClick="return IndexDeploy('id4',1)" class="a1"><b>单栏目管理</b></a></td>
</tr>
<tbody id="cate_id4" style="display:display;">
<tr>
  <td width="30%" rowspan="2" align="center" class="a3">中文</td>
  <td align="left" class="a3"><a href="c_lanmu.asp" target="main">栏目管理</a></td>
</tr>
<tr>
  <td align="left" class="a3"><a href="c_lanmu.asp?action=add" target="main">添加栏目</a></td>
</tr>
<tr>
  <td rowspan="2" align="center" class="a4">英文</td>
  <td align="left" class="a4"><a href="e_lanmu.asp" target="main">栏目管理</a></td>
</tr>
<tr>
  <td align="left" class="a4"><a href="e_lanmu.asp?action=add" target="main">添加栏目</a></td>
</tr>
</tbody>
</table>
</td></tr>
<tr>
<td><table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td colspan="2" class="a1"><a style="float:right" href="#" onClick="return IndexDeploy('id5',1)"><img id="img_id5" src="images/cate_fold.gif" border="0" /></a> <a href="#" onClick="return IndexDeploy('id5',1)" class="a1"><b>产品管理</b></a> </td>
</tr>
<tbody id="cate_id5" style="display:display;">
<tr>
<td colspan="2" align="center" class="a3"><a href="pro_big_class.asp" target="main">产品大类</a> | <a href="pro_small_class.asp" target="main">产品小类</a></td>
</tr>
<tr>
<td colspan="2" align="center" class="a3"><a href="pro_manage.asp" target="main">管理产品</a> | <a href="pro_manage.asp?action=add" target="main" class="red">添加产品</a></td>
</tr>
<tr>
<td width="30%" align="center" class="a3">中文</td>
<td align="left" class="a3"><a href="c_order.asp" target="main">订单管理</a></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
  <td align="left" class="a4"><a href="e_order.asp" target="main">订单管理</a></td>
</tr>
</tbody>
</table></td>
</tr>
<tr>
<td><table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td colspan="2" class="a1"><a style="float:right" href="#" onClick="return IndexDeploy('id6',1)"><img id="img_id6" src="images/cate_fold.gif" border="0" /></a> <a href="#" onClick="return IndexDeploy('id6',1)" class="a1"><b>新闻管理</b></a> </td>
</tr>
<tbody id="cate_id6" style="display:none;">

<tr>
  <td width="30%" rowspan="3" align="center" class="a3">中文</td>
  <td align="left" class="a3"><a href="c_news_class.asp" target="main">新闻分类管理</a></td>
</tr>
<tr>
  <td align="left" class="a3"><a href="c_news.asp" target="main">新闻管理</a></td>
</tr>
<tr>
  <td align="left" class="a3"><a href="c_news.asp?action=add" target="main">添加新闻</a></td>
</tr>
<tr>
  <td rowspan="3" align="center" class="a4">英文</td>
  <td align="left" class="a4"><a href="e_news_class.asp" target="main">新闻分类管理</a></td>
</tr>
<tr>
  <td align="left" class="a4"><a href="e_news.asp" target="main">新闻管理</a></td>
  </tr>
<tr>
  <td align="left" class="a4"><a href="e_news.asp?action=add" target="main">添加新闻</a></td>
  </tr>
</tbody>
</table></td>
</tr>
<tr>
<td><table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td colspan="2" class="a1"><a style="float:right" href="#" onClick="return IndexDeploy('id7',1)"><img id="img_id7" src="images/cate_fold.gif" border="0" /></a> <a href="#" onClick="return IndexDeploy('id7',1)" class="a1"><b>留言管理</b></a> </td>
</tr><tbody id="cate_id7" style="display:none;">
<tr>
  <td width="30%" align="center" class="a3">中文</td>
  <td align="left" class="a3"><a href="c_feedback.asp" target="main">留言管理</a></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
  <td align="left" class="a4"><a href="e_feedback.asp" target="main">留言管理</a></td>
</tr>

</tbody>
</table></td>
</tr>

<tr>
<td><table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td colspan="2" class="a1"><a style="float:right" href="#" onClick="return IndexDeploy('id8',1)"><img id="img_id8" src="images/cate_fold.gif" border="0" /></a> <a href="#" onClick="return IndexDeploy('id8',1)" class="a1"><b>友情链接管理</b></a> </td>
</tr>
<tbody id="cate_id8" style="display:none;">

<tr>
  <td width="30%" align="center" class="a3">中文</td>
  <td align="left" class="a3"><a href="c_link.asp" target="main">友情链接</a></td>
</tr>
<tr>
  <td align="center" class="a4">英文</td>
  <td align="left" class="a4"><a href="e_link.asp" target="main">友情链接</a></td>
</tr>
</tbody>
</table></td>
</tr>

<tr>
<td><table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td class="a1"><a style="float:right" href="#" onClick="return IndexDeploy('id10',1)"><img id="img_id10" src="images/cate_fold.gif" border="0" /></a> <a href="#" onClick="return IndexDeploy('id10',1)" class="a1"><b>网站提交</b></a> </td>
</tr>
<tbody id="cate_id10" style="">
<tr>
<td align="center"><a href="http://www.baidu.com/search/url_submit.html" target="_blank">百度登录入口</a></td>
</tr>
<tr>
  <td align="center"><a href="http://www.google.com/intl/zh-CN/add_url.html" target="_blank">Google登录入口</a></td>
</tr>
<tr>
  <td align="center"><a href="http://search.help.cn.yahoo.com/h4_4.html" target="_blank">Yahoo登录入口</a></td>
</tr>
<tr>
  <td align="center"><a href="http://search.msn.com/docs/submit.aspx" target="_blank">Live登录入口</a></td>
</tr>
<tr>
  <td align="center"><a href="http://www.dmoz.org/World/Chinese_Simplified/" target="_blank">Dmoz登录入口</a></td>
</tr>
<tr>
  <td align="center"><a href="http://www.alexa.com/site/help/webmasters" target="_blank">Alexa登录入口</a></td>
</tr>
<tr>
  <td align="center"><a href="http://ads.zhongsou.com/register/page.jsp" target="_blank">中搜登录入口</a></td>
</tr>
</tbody>
</table></td>
</tr>

<tr>
<td><table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr>
<td class="a1"><a style="float:right" href="#" onClick="return IndexDeploy('id9',1)"><img id="img_id9" src="images/cate_fold.gif" border="0" /></a> <a href="#" onClick="return IndexDeploy('id9',1)" class="a1"><b>用户管理</b></a> </td>
</tr>
<tbody id="cate_id9" style="display:none;">
<tr>
<td align="center"><a href="administrator.asp" target="main">查看管理员</a></td>
</tr>
</tbody>
</table></td>
</tr>

<tr><td>
<table width="98%" align="center" cellspacing="1" cellpadding="4" class="a2">
<tr><td class="a1">
<a style="float:right" href="#" onClick="return IndexDeploy('id10',1)"><img id="img_id10" src="images/cate_fold.gif" border=0></a>
<a href="#" onClick="return IndexDeploy('id10',1)" class="a1"><b>常用链接</b></a>
</td></tr>
<tbody id="cate_id10" style="display:">

<tr>
<td align="center">
<a href="../" target="_blank">网站首页</a></td>
</tr>

<tr>
<td align="center">
<a target="_top" href="index.asp?action=out">退出管理</a></td>
</tr>
</tbody>
</table>
</td></tr>
<tr>
<td height="2"></td>
</tr>
</table>
</body>
</html>
