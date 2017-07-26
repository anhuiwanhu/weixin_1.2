<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ page import="org.springframework.web.util.HtmlUtils"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<%String newContent = "";%>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>邮件详情页面</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template115/css/alert/template.alert.css" />
</head>

<body class="grey-bg">
<c:choose>
<c:when test="${cloudcontrol == '1' }">
	<script>
 		wx.ready(function(){
	 		alert('该邮件不允许公有云查看，请与PC端查看！');
	 		wx.closeWindow();
 		});
 	</script>
</c:when>
<c:when test="${not empty docXml}">
  <div class="views" style="overflow-x: hidden;">
    <div class="view view-main" style="overflow-x: hidden;">
      <div class="pages" style="overflow-x: hidden;">
        <div class="page" data-page="page-webapp-mail-readonly" style="overflow-x: hidden;">
		 
          <section class="wh-section wh-section-bottomfixed" style="overflow-x: hidden;">
            <div class="webapp-mail-readonly">
			<x:parse xml="${docXml}" var="doc" />
			<c:set var="mailto"><x:out select="$doc//mailto/text()" /></c:set> 
			<c:set var="mailtosimple"><x:out select="$doc//mailtosimple/text()" /></c:set>
			<c:set var="mailposttime"><x:out select="$doc//mailposttime/text()" /></c:set>
			<c:set var="content">${mailcontent}</c:set> 
			<c:set var="mailpostername"><x:out select="$doc//mailpostername/text()"/></c:set> 
			<c:set var="mailsubject"><x:out select="$doc//mailsubject/text()" /></c:set> 
			<c:set var="accessorySize"><x:out select="$doc//accessorySize/text()" /></c:set> 
			<c:set var="gnome"><x:out select="$doc//gnome/text()" /></c:set> 
			<c:set var="mailcontent"><x:out select="$doc//mailcontent/text()" /></c:set>
			<c:set var="maillevel"><x:out select="$doc//maillevel/text()" /></c:set>
			<c:set var="mailSign"><x:out select="$doc//mailSign/text()" /></c:set>
			<c:set var="mailanonymous"><x:out select="$doc//mailanonymous/text()" /></c:set>
			<c:set var="mailneedrevert"><x:out select="$doc//mailneedrevert/text()" /></c:set>
			<c:if test="${fn:contains(mailpostername,'&lt;')}">
				<c:set var="mailpostername">${fn:substringAfter(mailpostername, "&lt;")}</c:set> 
			</c:if>
			<c:if test="${fn:contains(mailpostername,'/')}">
				<c:set var="mailpostername">${fn:substringBefore(mailpostername, "/")}</c:set> 
			</c:if>
			<c:if test="${empty mailto}">
				<c:set var="mailto"></c:set> 
			</c:if> 
			<c:if test="${empty mailtosimple}">
				<c:set var="mailtosimple"></c:set> 
			</c:if> 
			<c:set var="mailcc"><x:out select="$doc//mailcc/text()"/></c:set>
			<c:set var="mailccsimple"><x:out select="$doc//mailccsimple/text()"/></c:set>
			<c:if test="${empty mailcc}">
				<c:set var="mailcc"></c:set> 
			</c:if> 
			<c:if test="${empty mailccsimple}">
				<c:set var="mailccsimple"></c:set> 
			</c:if>
			<form action="" method="post" id="readForm">
              <table class="wh-table-edit" style="border-collapse:separate;border-spacing: 0 8px;width:100%;">
				<!-- 附件大小 -->
				<input type="hidden" name="accessorySize" id="accessorySize" value="${accessorySize}"  />
                
				<tr>
                  <th><div style="width:7rem;">时间：</div></th>
                  <td>
                  	<span class="edit-ipt-reslut-l">${fn:substring(mailposttime,0,16)}</span>
                  </td>
                </tr>
                <tr>
                  <th><div style="width:7rem;">发件人：</div></th>
                  <td>
                  	<span class="edit-ipt-reslut-l">${mailpostername}</span>
                  </td>
                </tr>
                <tr>
                  <th><div style="width:7rem;">收件人：</div></th>
                  <td>
                    <span class="edit-ipt-reslut-l">${mailto}</span>
                  </td>
                </tr>
                <c:if test="${mailcc != '' && mailcc != null}">
                	<tr>
                  		<th><div style="width:7rem;">抄送：</div></th>
                  		<td>
                    		<span class="edit-ipt-reslut-l">${mailcc}</span>
                  		</td>
                	</tr>
                </c:if>
                
                <tr>
                  <th><div style="width:7rem;">主题：</div></th>
                  <td><span class="edit-ipt-reslut-l"><x:out select="$doc//mailsubject/text()" /></span></td>
                </tr>
                <tr>
                	<th><div style="width:7rem;">发送选项：</div></th>
                	<td>
                		<ul class="edit-radio">
                            <li class=""><span class="edit-radio-l">紧急</span><input type="hidden" id="maillevel" name="maillevel" value="${empty maillevel ? '0' : maillevel}"/></li>
                            <li class=""><span class="edit-radio-l">回执</span><input type="hidden" id="mailneedrevert" name="mailneedrevert" value="${empty mailneedrevert ? '0' : mailneedrevert}"/></li>
                            <li class=""><span class="edit-radio-l">签名</span><input type="hidden" id="mailSign" name="mailSign" value="${empty mailSign ? '0' : mailSign}"/></li>
                            <!--  <li class=""><span class="edit-radio-l">匿名</span><input type="hidden" id="mailanonymous" name="mailanonymous" value="${empty mailanonymous ? '0' : mailanonymous}"/></li>-->
                        	<input type="hidden" id="mailanonymous" name="mailanonymous" value="${empty mailanonymous ? '0' : mailanonymous}"/>
                        </ul>
                	</td>
                </tr>
                <tr>
                  <th><div style="width:7rem;">附件：</div></th>
                  <td>
                    <p>
                     <c:if test="${not empty realFileNames}">
						<jsp:include page="../common/include_download.jsp" flush="true">
							<jsp:param name="realFileNames"	value="${realFileNames}" />
							<jsp:param name="saveFileNames" value="${saveFileNames}" />
							<jsp:param name="moduleName" value="innerMailbox" />
						</jsp:include>
					 </c:if>
                    </p>
                  </td>
                </tr>
                <tr>
                  <th><div style="width:7rem;">正文：</div></th>
                  <td></td>
                </tr>
				<tr>
					<%
						newContent = (String)pageContext.getAttribute("content");
						//System.out.print("newContent11111--------->"+newContent);
						newContent = newContent.replaceAll("\"","'");
						//System.out.print("newContent22222--------->"+newContent);
						String mailsubject = (String)pageContext.getAttribute("mailsubject");
						mailsubject = mailsubject.replace("\n","");
					%>
					<c:set var="newContent"><%=newContent %></c:set> 
					<c:set var="mailsubject"><%=mailsubject %></c:set>
					<td colspan="2">
						<div class="wh-iframe" id="iframeDiv" style="height:25rem;">
							<iframe id="iframeId" src="mailDetailContet.controller?mailuserId=${mailuserId}&mailId=${mailId}"	allowtransparency="transparent" scrolling="auto" style="zoom:75%" class="wh-portal" 
		                           width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0">
							</iframe>
		                </div>
					</td>
		         </tr>
              </table>
			<input type="hidden" name="mailreplySub" id="mailreplySub">
			<input type="hidden" name="mailreplyContent" id="mailreplyContent">
			<input type="hidden" name="mailId" id="mailId" value="${mailId}">
			<input type="hidden" name="mailuserId" id="mailuserId" value="${mailuserId}">
			<input type="hidden" name="openType" id="openType"/>
			<input type="hidden" name="openFlag" id="openFlag" value="${openFlag }"/>
			<input type="hidden" name="fromPage" id="fromPage" value="${param.fromPage }"/>
			  </form>
            </div>
          </section>
			
		 
          <!-- 底部导航 -->
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix">
					<a href="javascript:void(0);" class="panel-return-a" onclick="forward();">转发</a>
					<c:choose>
	            		<c:when test="${param.detailType eq 'receive'}">
							<a href="javascript:reply();" class="panel-return-a">回复</a>
						</c:when>
						<c:when test="${param.detailType eq 'send'}">
							<a href="javascript:sendAgain();" class="panel-send-a">再次发送</a>
						</c:when>
					</c:choose>
                  </div> 
                  <c:choose>
                  	<c:when test="${param.detailType eq 'receive'}">
                  		<a id="fbtn-form-more" data-popover=".popover-links" class="fr fbtn-more link open-popover "><span>更多</span></a> 
                  	</c:when>
                  </c:choose>
                  
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>

<div id="fbtn-more-con" class="fbtn-more-nav popover popover-links">
  <div class="fbtn-more-nav-inner">
    <a href="javascript:replyAll();" class="fbtn-matter col-xs-12"><i class="fa fa-reply-all"></i>回复全部</a>
    <a href="javascript:replyAllandAccessory();" class="fbtn-matter col-xs-12"><i class="fa fa-reply-all"></i>回复全部（带附件）</a>
  </div>
</div>
</c:when>
<c:otherwise>
 	<script>
 		wx.ready(function(){
	 		alert('该邮件已被撤回或删除！');
	 		wx.closeWindow();
 		});
 	</script>
 </c:otherwise>
</c:choose>
</body>
</html>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script> 
  <script type="text/javascript">
	var myApp = new Framework7();
	var mainView = myApp.addView('.view');
	var $$ = Dom7;

	//右下角菜单弹框
	$$('#fbtn-more').on('click', function () {
		var clickedLink = this;
		myApp.popover('#fbtn-more-con', clickedLink);
		myApp.closeModal('#fbtn-more-list a');
	});

	
	$(function(){
		
		mark();
		//处理oa端发邮件时，html编辑正文手机显示出现问题
		$('iframeId p').css();

	});

	
	$$(function(){
		var agent = navigator.userAgent;
		if(agent.indexOf('iPhone')){
			$$('#iframeDiv').addClass('wh-ios-iframe-bug');
		}
		 //更多菜单展开
        var fbtnMore = $$("#fbtnMore");
        var fbtnMoreCon = $$(".fbtn-more-nav");
        if(fbtnMoreCon.is(':visible')){
            fbtnMoreCon.hide();
            $$(".wh-section").click(function(){
                fbtnMoreCon.hide();
            })
        }
        fbtnMoreCon.hide();
        fbtnMore.click(function(){
            fbtnMoreCon.toggle();
        });
	});


	//标记紧急程度等选项
  	function mark(){
  	  	
  		var mailLevel = '${maillevel}';//紧急
		var mailNeedRevert = '${mailneedrevert}';//回执
		var mailSign = '${mailSign}';//签名
		var mailAnonymous = '${mailanonymous}';//匿名
		if(mailLevel != '0' && mailLevel != ''){
  			$('input[name=maillevel]').parent().addClass('radio-active');
  		}
  		if(mailNeedRevert != '0' && mailNeedRevert != ''){
  			$('input[name=mailneedrevert]').parent().addClass('radio-active');
  		}
  		if(mailSign != '0' && mailSign != ''){
  			$('input[name=mailSign]').parent().addClass('radio-active');
  		}
  		//if(mailAnonymous != '0' && mailAnonymous != ''){
  		//	$('input[name=mailanonymous]').parent().addClass('radio-active');
  		//}
  	}

	//转发
	function forward(){
		var newContent = "${newContent}";
		newContent = newContent.replace(/<br>/g,"\r\n");
		//alert(newContent);
		var replySub = "Fw:" + "${mailsubject}";
		var replyContent = "---------- 来源信息 ----------" + "\r\n";
		replyContent += "来自: " + "${mailpostername}" + "\r\n";
		replyContent += "给: " + "${mailtosimple}" + "${mailto}" + "\r\n";
		replyContent += "抄送:" + "${mailcc}" + "\r\n";
		replyContent += "发送时间:  " + "${mailposttime}" + "\r\n";
		replyContent += "主题:  " + "${mailsubject}" + "\r\n";
		replyContent += "内容: " + newContent + "\r\n";
		replyContent += "----------  End  ----------" + "\r\n";

		//alert(replyContent);
		
		$("#mailreplySub").val(replySub);
		$("#mailreplyContent").val(replyContent);
		$('#openType').val('forward');
		$("#readForm").attr("action","forward.controller?openType=forward");
		$("#readForm").submit(); 
	}

	
	//回复全部
	function replyAll(){
		var newContent = "${newContent}";
		newContent = newContent.replace(/<br>/g,"\r\n");
		var replySub = "Re:" + "${mailsubject}";
		var replyContent = "---------- 来源信息 ----------" + "\r\n";
		replyContent += "来自: " + "${mailpostername}" + "\r\n";
		replyContent += "给: " + "${mailtosimple}" + "${mailto}" + "\r\n";
		replyContent += "抄送:" + "${mailcc}" + "\r\n";
		replyContent += "发送时间:  " + "${mailposttime}" + "\r\n";
		replyContent += "主题:  " + "${mailsubject}" + "\r\n";
		replyContent += "内容: " + newContent + "\r\n";
		replyContent += "-----------  End  ------------" + "\r\n";
		$("#mailreplySub").val(replySub);
		$("#mailreplyContent").val(replyContent);
		$('#openType').val('replyAll');
		$("#readForm").attr("action","replyAll.controller?openType=replyAll");
		$("#readForm").submit();
	}


	//回复全部（带附件）
	function replyAllandAccessory(){
		var newContent = "${newContent}";
		newContent = newContent.replace(/<br>/g,"\r\n");
		var replySub = "Re:" + "${mailsubject}";
		var replyContent = "---------- 来源信息 ----------" + "\r\n";
		replyContent += "来自: " + "${mailpostername}" + "\r\n";
		replyContent += "给: " + "${mailtosimple}" + "${mailto}" + "\r\n";
		replyContent += "抄送:" + "${mailcc}" + "\r\n";
		replyContent += "发送时间:  " + "${mailposttime}" + "\r\n";
		replyContent += "主题:  " + "${mailsubject}" + "\r\n";
		//replyContent += "相关附件:"
		replyContent += "内容: " + newContent + "\r\n";
		replyContent += "-----------  End  ------------" + "\r\n";
		$("#mailreplySub").val(replySub);
		$("#mailreplyContent").val(replyContent);
		$('#openType').val('replyAllandAccessory');
		$("#readForm").attr("action","replyAllandAccessory.controller?openType=replyAllandAccessory");
		$("#readForm").submit();
	}


	//回复
	function reply(){
		var newContent = "${newContent}";
		newContent = newContent.replace(/<br>/g,"\r\n");
		var replySub = "Re:" + "${mailsubject}";
		var replyContent ="---------- 来源信息 ----------" + "\r\n";
		replyContent += "来自: " + "${mailpostername}" + "\r\n";
		replyContent += "给: " + "${mailtosimple}" + "${mailto}" + "\r\n";
		replyContent += "抄送:" + "${mailcc}" + "\r\n";
		replyContent += "发送时间:  " + "${mailposttime}" + "\r\n";
		replyContent += "主题:  " + "${mailsubject}" + "\r\n";
		replyContent += "内容: " + newContent + "\r\n";
		replyContent += "-----------  End  ------------" + "\r\n";
		$("#mailreplySub").val(replySub);
		$("#mailreplyContent").val(replyContent);
		$('#openType').val('reply');
		$("#readForm").attr("action","reply.controller?openType=reply");
		$("#readForm").submit();
	}



	//再次发送
    function sendAgain(){
    	$('#openType').val('sendAgain');
    	$("#readForm").attr("action","sendAgain.controller?openType=sendAgain");
		$("#readForm").submit();
    }

	

	



  </script>