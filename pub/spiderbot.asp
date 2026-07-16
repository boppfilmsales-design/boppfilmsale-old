<%
'获取IP地址
Dim Guest_IP 
Guest_IP=Replace(Request.ServerVariables("HTTP_X_FORWARDED_FOR"),"'","")
If Guest_IP=Empty Then Guest_IP=Replace(Request.ServerVariables("REMOTE_ADDR"),"'","")

'获取网页地址
Function GetLocationURL() 
Dim Url 
Dim ServerPort,ServerName,ScriptName,QueryString 
ServerName = Request.ServerVariables("SERVER_NAME") 
ServerPort = Request.ServerVariables("SERVER_PORT") 
ScriptName = Request.ServerVariables("SCRIPT_NAME") 
QueryString = Request.ServerVariables("QUERY_STRING") 
Url="http://"&ServerName 
If ServerPort <> "80" Then Url = Url & ":" & ServerPort 
Url=Url&ScriptName 
If QueryString <>"" Then Url=Url&"?"& QueryString 
GetLocationURL=Url 
End Function 

function spiderbot()
'获取蜘蛛信息
dim agent 
agent = replace(lcase(request.servervariables("http_user_agent")),"+"," ") '+加号替换为空格
dim bot: bot = ""
'百度
if instr(agent, "baiduspider") > 0 then bot = "Baiduspider"
if instr(agent, "baiducustomer") > 0 then bot = "BaiduCustomer"
if instr(agent, "baidu-thumbnail") > 0 then bot = "Baidu-Thumbnail"
if instr(agent, "baiduspider-mobile-gate") > 0 then bot = "Baiduspider-Mobile-Gate"
if instr(agent, "baidu-transcoder/1.0.6.0") > 0 then bot = "Baidu-Transcoder/1.0.6.0"
'谷歌google
if instr(agent, "googlebot/2.1") > 0 then bot = "Googlebot/2.1"
if instr(agent, "googlebot-image/1.0") > 0 then bot = "Googlebot-Image/1.0"
if instr(agent, "feedfetcher-google") > 0 then bot = "Feedfetcher-Google"
if instr(agent, "mediapartners-google") > 0 then bot = "Google Adsense"
if instr(agent, "adsbot-google") > 0 then bot = "Google AdWords"
if instr(agent, "googlebot-mobile/2.1") > 0 then bot = "Googlebot-Mobile/2.1"
if instr(agent, "googlefriendconnect/1.0") > 0 then bot = "GoogleFriendConnect/1.0"
'雅虎yahoo
if instr(agent, "yahoo! slurp;") > 0 then bot = "Yahoo! Slurp"
if instr(agent, "yahoo! slurp/3.0") > 0 then bot = "Yahoo! Slurp/3.0"
if instr(agent, "yahoo! slurp china") > 0 then bot = "Yahoo! Slurp China"
if instr(agent, "yahoofeedseeker/2.0") > 0 then bot = "YahooFeedSeeker/2.0"
if instr(agent, "yahoo-blogs") > 0 then bot = "Yahoo Blogs"
if instr(agent, "yahoo-mmcrawler") > 0 then bot = "Yahoo Image"
if instr(agent, "yahoo contentmatch crawler") > 0 then bot = "Yahoo AD"
'微软bing
if instr(agent, "msnbot/1.1") > 0 then bot = "msnbot/1.1"
if instr(agent, "msnbot/2.0b") > 0 then bot = "msnbot/2.0b"
if instr(agent, "msrabot/2.0/1.0") > 0 then bot = "msrabot/2.0/1.0"
if instr(agent, "msnbot-media/1.0") > 0 then bot = "msnbot-media/1.0"
if instr(agent, "msnbot-products") > 0 then bot = "MSNBot-Products"
if instr(agent, "msnbot-academic") > 0 then bot = "MSNBot-Academic"
if instr(agent, "msnbot-newsblogs") > 0 then bot = "MSNBot-NewsBlogs"
'腾讯搜搜soso
if instr(agent, "sosospider") > 0 then bot = "Sosospider"
if instr(agent, "sosoblogspider") > 0 then bot = "Sosoblogspider"
if instr(agent, "sosoimagespider") > 0 then bot = "Sosoimagespider"
'网易有道
if instr(agent, "youdaobot/1.0") > 0 then bot = "YoudaoBot/1.0"
if instr(agent, "yodaobot-image/1.0") > 0 then bot = "YodaoBot Image/1.0"
if instr(agent, "yodaobot-reader/1.0") > 0 then bot = "YodaoBot-Reader/1.0"
'搜狐搜狗
if instr(agent, "sogou web robot") > 0 then bot = "Sogou web robot"
if instr(agent, "sogou web spider/3.0") > 0 then bot = "Sogou web spider/3.0"
if instr(agent, "sogou web spider/4.0") > 0 then bot = "Sogou web spider/4.0"
if instr(agent, "sogou head spider/3.0") > 0 then bot = "Sogou head spider/3.0"
if instr(agent, "sogou-test-spider/4.0") > 0 then bot = "Sogou-Test-Spider/4.0"
if instr(agent, "sogou orion spider/4.0") > 0 then bot = "Sogou Orion spider/4.0"
'Alexa
if instr(agent, "ia_archiver") > 0 then bot = "Ia_archiver"
if instr(agent, "iaarchiver") > 0 then bot = "Iaarchiver"
'Cuil
if instr(agent, "twiceler-0.9") > 0 then bot = "Twiceler-0.9" 
'奇虎
if instr(agent, "qihoo") > 0 then bot = "Qihoo"
'ASK.com
if instr(agent, "ask jeeves/teoma") > 0 then bot = "Ask Jeeves/Teoma"

if instr(agent, "50.nu/0.01") > 0 then bot = "50.nu/0.01"
if instr(agent, "aspseek") > 0 then bot = "ASPSeek"
if instr(agent, "betabot") > 0 then bot = "betaBot"
if instr(agent, "blogpulselive") > 0 then bot = "BlogPulseLive"
if instr(agent, "blogpulse (isspider-3.0)") > 0 then bot = "BlogPulse (ISSpider-3.0)"
if instr(agent, "blogvibebot-v1.1") > 0 then bot = "BlogVibeBot-v1.1"
if instr(agent, "blogsearch/2") > 0 then bot = "BlogSearch/2"
if instr(agent, "builtwith/0.3") > 0 then bot = "BuiltWith/0.3"
if instr(agent, "buzzbot/1.0") > 0 then bot = "BuzzBot/1.0"
if instr(agent, "daumoa/2.0") > 0 then bot = "Daumoa/2.0"
if instr(agent, "domaintools") > 0 then bot = "DomainTools"
if instr(agent, "dotbot/1.1") > 0 then bot = "DotBot/1.1"
if instr(agent, "eapollobot") > 0 then bot = "eApolloBot"
if instr(agent, "exabot") > 0 then bot = "Exabot"
if instr(agent, "fast-webcrawler") > 0 then bot = "Alltheweb"
if instr(agent, "feedburner/1.0") > 0 then bot = "FeedBurner/1.0"
if instr(agent, "followsite bot") > 0 then bot = "FollowSite Bot"
if instr(agent, "gaisbot/3.0") > 0 then bot = "Gaisbot/3.0"
if instr(agent, "gigabot") > 0 then bot = "Gigabot"
if instr(agent, "gingercrawler/1.0") > 0 then bot = "GingerCrawler/1.0"
if instr(agent, "hitcrawler_0.1") > 0 then bot = "hitcrawler_0.1"
if instr(agent, "iaskspider/1.0") > 0 then bot = "iaskspider/1.0"
if instr(agent, "iaskspider/2.0") > 0 then bot = "iaskspider/2.0"
if instr(agent, "iearthworm") > 0 then bot = "iearthworm"
if instr(agent, "jyxobot/1") > 0 then bot = "Jyxobot/1"
if instr(agent, "larbin") > 0 then bot = "Larbin"
if instr(agent, "lanshanbot") > 0 then bot = "lanshanbot"
if instr(agent, "lycos_spider_(t-rex)") > 0 then bot = "Lycos"
if instr(agent, "markmonitor robots") > 0 then bot = "MarkMonitor Robots"
if instr(agent, "mj12bot/v1.2.1") > 0 then bot = "MJ12bot/v1.2.1"
if instr(agent, "mj12bot/v1.2.2") > 0 then bot = "MJ12bot/v1.2.2"
if instr(agent, "mj12bot/v1.2.3") > 0 then bot = "MJ12bot/v1.2.3"
if instr(agent, "mj12bot/v1.2.4") > 0 then bot = "MJ12bot/v1.2.4"
if instr(agent, "mj12bot/v1.2.5") > 0 then bot = "MJ12bot/v1.2.5"
if instr(agent, "naverbot/1.0") > 0 then bot = "NaverBot/1.0"
if instr(agent, "netcraftsurveyagent/1.0") > 0 then bot = "NetcraftSurveyAgent/1.0"
if instr(agent, "netcraft web server survey") > 0 then bot = "Netcraft Web Server Survey"
if instr(agent, "page2rss/0.5") > 0 then bot = "Page2RSS/0.5"
if instr(agent, "panscient.com") > 0 then bot = "panscient.com"'恶意爬虫
if instr(agent, "pku student spider") > 0 then bot = "PKU Student Spider"
if instr(agent, "psbot/0.1") > 0 then bot = "psbot/0.1"
if instr(agent, "scooter") > 0 then bot = "Altavista"
if instr(agent, "servage robot") > 0 then bot = "Servage Robot"
if instr(agent, "snapbot") > 0 then bot = "Snapbot"
if instr(agent, "spinn3r") > 0 then bot = "Spinn3r"
if instr(agent, "sqworm") > 0 then bot = "AOL"
if instr(agent, "stealer") > 0 then bot = "Stealer"
if instr(agent, "tagoobot/3.0") > 0 then bot = "Tagoobot/3.0"
if instr(agent, "twingly recon") > 0 then bot = "Twingly Recon"
if instr(agent, "urlfan-bot/1.0") > 0 then bot = "urlfan-bot/1.0"
if instr(agent, "webalta") > 0 then bot = "WebAlta"
if instr(agent, "yandex/1.01.001") > 0 then bot = "Yandex/1.01.001"
if instr(agent, "yeti/1.0") > 0 then bot = "Yeti/1.0"
	
if len(bot) > 0 then
set rs_bot = server.CreateObject ("adodb.recordset")
sql="select [botname],[lastdate],[hits_day],[hits_year],[lasturl],[ip] From [yuzhiguo_bots] Where [botname]='" & bot & "'"
		rs_bot.open sql,conn,1,3
		if rs_bot.eof and rs_bot.bof then
		rs_bot.AddNew 
		rs_bot("botname") = bot
		rs_bot("lastdate") = now()
		rs_bot("hits_day") = 1
		rs_bot("hits_year") = rs_bot("hits_year")+1
		rs_bot("lasturl")= GetLocationURL
		rs_bot("ip")= Guest_IP
		else
		
		if day(rs_bot("lastdate"))=day(now()) then
		rs_bot("hits_day") = rs_bot("hits_day")+1
		else
		rs_bot("hits_day") = 1
		end if
		
		rs_bot("hits_year") = rs_bot("hits_year")+1
		rs_bot("lastdate") = now()
		rs_bot("lasturl")= GetLocationURL
		rs_bot("ip")= Guest_IP
		end if
		rs_bot.update
		rs_bot.close: set rs_bot = nothing
	end if
end function

call spiderbot()
%>