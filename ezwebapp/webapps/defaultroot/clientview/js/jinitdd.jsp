<%@page import="com.whir.util.DConfigUtils"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.UUID"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Formatter"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.security.NoSuchAlgorithmException"%>
<%@ page import="java.io.UnsupportedEncodingException"%>
<%@ page import="java.util.List"%>
<%@ page import="com.whir.util.HttpUtils"%>
<% 
String  url_dingding  =  "http://" + request.getServerName() //服务器地址  
                    + ":"   
                    + request.getServerPort()           //端口号  
                    + request.getAttribute("javax.servlet.forward.request_uri")      //项目名称  
                            ; //参数  
if(request.getAttribute("javax.servlet.forward.query_string")!=null)
{  
    url_dingding+="?"+request.getAttribute("javax.servlet.forward.query_string");          
} 
%>
 
<%
		com.whir.webplatform.manage.bd.DingPlatformBD bd = new com.whir.webplatform.manage.bd.DingPlatformBD();
		Map<String, String> map = com.whir.aop.ding.utils.DingUtils.getJsConfig();
		String agentId = map.get("agentId");
		String corpId = map.get("corpid");
		String jsapi_ticket = map.get("jsapi_ticket");
		Map<String, String> ret_ding = DConfigUtils.sort(jsapi_ticket, url_dingding);
        for (Map.Entry entry : ret_ding.entrySet()) {
           // System.out.println(entry.getKey() + ", " + entry.getValue());
        }
%>

<script charset="utf-8" src="http://g.alicdn.com/dingding/open-develop/1.0.0/dingtalk.js"></script>
<script>
dd.config({
	agentId : '<%=agentId%>',
	corpId : '<%=corpId%>',
	timeStamp : '<%=ret_ding.get("timestamp")%>',
	nonceStr : '<%=ret_ding.get("nonceStr")%>',
	signature : '<%=ret_ding.get("signature")%>',
	jsApiList : [ 'runtime.info', 'biz.contact.choose','device.geolocation.get',
			'device.notification.confirm', 'device.notification.alert',
			'device.notification.prompt', 'biz.ding.post',
			'biz.util.openLink','biz.map.locate','biz.map.view','biz.util.scan','biz.navigation.setRight' ]
});

dd.error(function(err) {
	//myApp.alert('获取位置失败，请重新定位！');
});
</script>
