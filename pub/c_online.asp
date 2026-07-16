<% if skype<>"" or qq<>"" or msn<>"" or taobao<>"" or alibabacn<>"" then%>

<script type="text/javascript">
<!-- 
lastScrollY = 0;
function heartBeat(){ 
var diffY;
if (document.documentElement && document.documentElement.scrollTop)
 diffY = document.documentElement.scrollTop;
else if (document.body)
 diffY = document.body.scrollTop
else
    {/*Netscape stuff*/}
 
//alert(diffY);
percent=.1*(diffY-lastScrollY); 
if(percent>0)percent=Math.ceil(percent); 
else percent=Math.floor(percent); 
document.getElementById("leftDiv").style.top = parseInt(document.getElementById("leftDiv").style.top)+percent+"px";
document.getElementById("rightDiv").style.top = parseInt(document.getElementById("leftDiv").style.top)+percent+"px";
lastScrollY=lastScrollY+percent; 
//alert(lastScrollY);
}
//下面这段删除后，对联将不跟随屏幕而移动。
window.setInterval("heartBeat()",1);
//-->
</script>

<style type="text/css">
<!--
#rightDiv{width:118px; background: #F8FBFE; text-align:center; margin:0; padding:0;border: #00CCFF solid 1px;display:block;overflow:hidden;position:absolute;}
#rightDiv p{background: #00CCFF; color:#FFFFFF; height:22px; line-height:22px; font-weight:bold; display:block;margin:0 0 10px 0; padding:0; font-size:11px;}
#rightDiv a {margin:0 0 5px 0; display:block; padding:0;}
-->
</style>

<div id="leftDiv" style="top:210px; left:10px;">

</div>

<div id="rightDiv" style="top:210px; right:10px;">

<p>在线 服务</p>


<%'MSN
if msn<>"" then
msn=split(msn,",")
for N=0 to UBound(msn)
Mymsn=Mymsn+msn(N)+":"
next
for N=0 to UBound(msn) 
%>
<a href="http://settings.messenger.live.com/Conversation/IMMe.aspx?invitee=<%=trim(msn(n))%>&mkt=Zh-cn" >

<img src="<%=webfolder%>images/msn.gif" alt="MSN: <%=trim(msn(n))%>" border="0" />
</a>
<%next
end if %>

<%'Skype
if skype<>"" then
skype=split(skype,",")
for N=0 to UBound(skype)
Myskype=Myskype+skype(N)+":"
next
for N=0 to UBound(skype) 
%>
<a href="skype:<%=trim(skype(n))%>?call" >
<img src="http://skype.tom.com/products/image/skypeme_btn_small_green.gif" alt="Skype: <%=trim(skype(n))%>" border="0" />
</a>
<%next
end if %>

<%'QQ
if qq<>"" then
qq=split(qq,",")
for N=0 to UBound(qq)
Myqq=Myqq+qq(N)+":"
next
for N=0 to UBound(qq) 
%>
<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=<%=trim(qq(n))%>&Site=<%=e_webname%>&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:<%=trim(qq(n))%>:41" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
<%next
end if %>

<%'Taobao
if taobao<>"" then
taobao=split(taobao,",")
for N=0 to UBound(taobao)
Mytaobao=Mytaobao+taobao(N)+":"
next
for N=0 to UBound(taobao) 
%>
<a target="_blank" href="http://amos1.taobao.com/msg.ww?v=2&uid=<%=trim(taobao(n))%>&s=1" ><img border="0" src="http://amos1.taobao.com/online.ww?v=2&uid=<%=trim(taobao(n))%>&s=1" alt="点击这里给我发消息" /></a>
</a>
<%next
end if %>

<%'Alibabacn
if alibabacn<>"" then
alibabacn=split(alibabacn,",")
for N=0 to UBound(alibabacn)
Myalibabacn=Myalibabacn+alibabacn(N)+":"
next
for N=0 to UBound(alibabacn) 
%>
<a target=_blank href=http://scs1.sh1.china.alibaba.com/msg.atc?v=1&uid=<%=trim(alibabacn(n))%>><img border=0 src="http://scs1.sh1.china.alibaba.com/online.atc?v=1&uid=<%=trim(alibabacn(n))%>&s=2" alt="点击这里给我发消息" align="absmiddle"></a>
</a>
<%next
end if %>

</div>

<% end if%>

