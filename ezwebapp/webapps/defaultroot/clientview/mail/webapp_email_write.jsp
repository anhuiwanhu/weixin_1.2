<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.component.security.crypto.*" %>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>

<%
	String openType = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("openType")));
	if(openType == null){
		openType = "";
	}
	String openFlag = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("openFlag")));
	if(openFlag == null){
		openFlag = "";
	}
	String mailreplySub = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("mailreplySub")));
	if(mailreplySub == null){
		mailreplySub = "";
	}
	String accessorySize = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("accessorySize")));
	if(accessorySize == null){
		accessorySize = "";
	}
	String fromPage = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("fromPage")));
	if(fromPage == null){
		fromPage = "";
	}
%>
<c:set var="openType"><%=openType %></c:set>
<c:set var="openFlag"><%=openFlag %></c:set>
<c:set var="mailreplySub"><%=mailreplySub %></c:set>
<c:set var="accessorySize"><%=accessorySize %></c:set>
<c:set var="fromPage"><%=fromPage %></c:set>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>
	<c:choose>
  		<c:when test="${openType eq 'reply'}">
  			答复邮件
  		</c:when>
  		<c:when test="${openType eq 'forward'}">
  			转发邮件
  		</c:when>
  		<c:when test="${openType eq 'sendAgain'}">
  			发送邮件
  		</c:when>
  		<c:when test="${openType eq 'replyAll'}">
  			答复全部
  		</c:when>
		<c:when test="${openType eq 'replyAllandAccessory'}">
  			答复全部(带附件)
  		</c:when>
  		<c:otherwise>写邮件</c:otherwise>
  	</c:choose>
  </title>
 </head>

<body class="grey-bg">

<!-- 选人界面的div开始 -->
<div class="panel panel-right panel-reveal" style="width:22rem;"> 
	<div class="panel-title">
        <p style="text-align: center;">已选列表</p>
    </div>
    <div class="todo-list">
       <div class="list-block">
             <ul id="selectedPer">
             </ul>
      </div>
    </div>
</div>
<!-- 选人界面的div结束 -->

  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-mail-edit">
		
          <section class="wh-section wh-section-bottomfixed" id="mainContent">
            <article class="wh-edit wh-edit-forum">
              <div class="mail-edit">
			  <form id="sendForm">
                <table class="wh-table-edit" style="border-collapse:separate;border-spacing: 0 10px;">
                  <tr>
	                    <th><em class="red-em">*</em>收件人<i class="fa fa-asterisk"></i>：</th>
	                    <td><span class="fr" style="float:left" onclick="$(this).next('input').click()" id="shoujian"></span>
	                    	<input onclick="selectUser('1','empName','empId','*0*');"  class="edit-ipt-r edit-ipt-arrow" readonly type="text" 
	                    	id="empName" name="mailto" <c:if test="${openType eq 'reply'}">value="${requestScope.userName}"</c:if>
	                    	<c:if test="${openType eq 'personSend'}">value="${param.empName},"</c:if>
	                    	<c:if test="${openType eq 'sendAgain'}">value="${mailTo}"</c:if>  
	                    	<c:if test="${openType eq 'replyAll'}">value="${requestScope.userName}"</c:if>
							<c:if test="${openType eq 'replyAllandAccessory'}">value="${requestScope.userName}"</c:if>
	                    	placeholder="请选择"/>
	                    	<input type="hidden" name="mailtoid" <c:if test="${openType eq 'reply'}">value="${requestScope.userId}"</c:if> 
	                    	<c:if test="${openType eq 'personSend'}">value="${param.personId}"</c:if>
	                    	<c:if test="${openType eq 'sendAgain'}">value="${mailToId}"</c:if> 
	                    	<c:if test="${openType eq 'replyAll'}">value="${requestScope.userId}"</c:if>
							<c:if test="${openType eq 'replyAllandAccessory'}">value="${requestScope.userId}"</c:if>
	                    	id="empId"/>
	                    </td>
	              </tr>
	                <tr>
	                    <th>抄送：</th>
	                    <td><span class="fr" style="float:left" onclick="$(this).next('input').click()" id="chaosong"></span>
		                   <input onclick="selectUser('1','mailcc','mailccid','*0*');" class="edit-ipt-r edit-ipt-arrow" type="text" readonly value="${mailCc}" id="mailcc" name="mailcc" placeholder="请选择"/>
	                        <input type="hidden" value="${mailccId}" name="mailccid" id="mailccid"/>
	                    </td>
				    </tr>
                  <tr>
                    <th><em class="red-em">*</em>主题<i class="fa fa-asterisk"></i>：</th>
                    <td>
                    	<input placeholder="请输入" class="edit-ipt-r" type="text" id="mailsubject" name="mailsubject" value="${empty mailreplySub ? title : mailreplySub}"/>
                    </td>
                  </tr>
                  <tr>
                     <th>发送选项<i class="fa fa-asterisk"></i>：</th>
                    <td>
                      <ul class="edit-radio">
                            <li class=""><span class="edit-radio-l">紧急</span><input type="hidden" id="maillevel" name="maillevel" value="${empty mailLevel ? '0' : mailLevel}"/></li>
                            <li class=""><span class="edit-radio-l">回执</span><input type="hidden" id="mailneedrevert" name="mailneedrevert" value="${empty mailNeedRevert ? '0' : mailNeedRevert}"/></li>
                            <li class=""><span class="edit-radio-l">签名</span><input type="hidden" id="mailSign" name="mailSign" value="${empty mailSign ? '0' : mailSign}"/></li>
                            <!--  <li class=""><span class="edit-radio-l">匿名</span><input type="hidden" id="mailanonymous" name="mailanonymous" value="${empty mailAnonymous ? '0' : mailAnonymous}"/></li>-->
                            <input type="hidden" id="mailanonymous" name="mailanonymous" value="${empty mailAnonymous ? '0' : mailAnonymous}"/>
                            <li class=""><span class="edit-radio-l">移动端提醒</span><input type="hidden" id="SendRongCloudRemind" name="SendRongCloudRemind" value="${empty SendRongCloudRemind ? '0' : SendRongCloudRemind}"/></li>
                        </ul>
                    </td>
                  </tr>
                  <tr>
                    <th>附件<i class="fa fa-asterisk"></i>：</th>
                    <td>
                      <ul class="edit-upload">
                        <li class="edit-upload-in" onclick="addImg();"><span><i class="fa fa-plus"></i></span></li>
                      </ul>
                      <input type="hidden" id="fileSizeCount" name="fileSizeCount" value="0"/>
                    </td>
                  </tr>
                  <c:if test="${(openType eq 'forward' || openType eq 'sendAgain' || openType eq 'replyAllandAccessory') && not empty realFileNames}">
                  	<tr>
		                	<td colspan="2">
			                        <c:set var="realFileNames">${realFileNames}</c:set> 
			                        <c:set var="saveFileNames">${saveFileNames}</c:set> 
			                        <%
				                        //真实文件名
										String realFileNames = pageContext.getAttribute("realFileNames") != null ? pageContext.getAttribute("realFileNames").toString() : "";
										//保存文件名
										String saveFileNames = pageContext.getAttribute("saveFileNames") != null ? pageContext.getAttribute("saveFileNames").toString() : "";
										String[] realFileNamesArray = realFileNames.split("\\|");
										String[] saveFileNamesArray = saveFileNames.split("\\|");
										for(int i=0,length=realFileNamesArray.length;i<length;i++){%>
					                        <input type="hidden" id="imgName" name="imgName" value="<%=realFileNamesArray[i] %>"/>
					                        <input type="hidden" id="imgSaveName" name="imgSaveName" value="<%=saveFileNamesArray[i] %>"/>
										<%}
									%>
									<div class="wh-article-atta">
										<c:if test="${not empty realFileNames}">
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames %>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames %>" />
												<jsp:param name="moduleName" value="innerMailbox" />
											</jsp:include>
										</c:if>
									</div>
		                	</td>
		                </tr>
                  </c:if>
                  <tr>
	                    <th>正文：</th>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td colspan="2">
	                    	<input type="hidden" name="mailOldContent" id="mailOldContent" value="${mailOldContent }">
	                        <div class="edit-txta-box">
	                        <c:set var="content">${empty mailreplyContent ? content : mailreplyContent}</c:set> 
	                        <%
		                		String newContent = (String)pageContext.getAttribute("content");
	                        	System.out.print("--newContent111--------->"+newContent);
							    //newContent = com.whir.util.StringUtils.resizeImgSize(newContent, "100", "100");
		                		//newContent.replaceAll("<a href[^>]*>","").replaceAll("</a>","");
		                		newContent = newContent.replaceAll("<br>","\n");
		   
		                		System.out.print("--newContent222--------->"+newContent);
							%>
							<c:set var="newContent"><%=newContent %></c:set> 
							<c:choose>
							<c:when test="${openType eq 'reply'}">
					  			<textarea onmousedown="cursorReset(event,this)" id="mailcontent" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">
								                         ${newContent}
								</textarea>	
					  		</c:when>
							<c:when test="${openType eq 'forward'}">
					  		    <textarea onmousedown="cursorReset(event,this)" id="mailcontent" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">
								                          ${newContent}
								</textarea>	
					  		</c:when>
						  	<c:when test="${openType eq 'replyAll'}">
						  		<textarea onmousedown="cursorReset(event,this)" id="mailcontent" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">
								                          ${newContent}
								</textarea>		
						  	</c:when>
						  	<c:when test="${openType eq 'sendAgain'}">
						  		<textarea onmousedown="cursorReset(event,this)" id="mailcontent" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">
								                          ${newContent}
								</textarea>		
						  	</c:when>
					  		<c:otherwise>
				                <textarea onmousedown="cursorReset(event,this)" id="mailcontent" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">${newContent}</textarea>	
							</c:otherwise>
					  		</c:choose>
	                        </div>
	                    </td>
	                </tr>
                </table>
				</form>
              </div>
            </article>
          </section>
		
          <footer class="wh-footer wh-footer-forum" id="footerButton">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix">
                  	 <c:choose>
                  	 	<c:when test="${openType eq 'forward' || openType eq 'sendAgain' || openType eq 'replyAllandAccessory' || openType eq 'reply' || openType eq 'replyAll'}">
                  	 		
                  	 	</c:when>
                  	 	<c:otherwise>
                  	 		<a href="javascript:reset();" class="panel-return-a">清空</a>
                  	 	</c:otherwise>
                  	 </c:choose>
                    <a href="javascript:sendMail();" class="panel-send-a" id="sendMail">发送</a>
                  </div>
                </div>
              </div>
            </div>
          </footer>
          <section id="selectContent" style="display:none">
		  
		  </section>
        </div>
      </div>
    </div>
  </div>

	
 
</body>
</html>
<script src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>

<script type="text/javascript">

	/*function ios(){
		//alert("ios-android");
		var userAgent = navigator.userAgent.toLowerCase();
		if(!((userAgent.indexOf("android") != -1) || ((userAgent.indexOf("linux") != -1) && (((userAgent.indexOf("chrome") != -1) || (userAgent.indexOf("safari") != -1)))))){
			//alert("ios--->"+userAgent);
			var head = document.getElementsByTagName('HEAD').item(0);
			var script = document.createElement("script");
			script.type = "text/javascript";
			script.src = "/defaultroot/clientview/cordova/cordova.js";
			head.appendChild(script);
		}else{
			//alert("android--->"+userAgent);
			var head = document.getElementsByTagName('HEAD').item(0);
			var script = document.createElement("script");
			script.type = "text/javascript";
			script.src = "/defaultroot/clientview/cordova_android/cordova.js";
			head.appendChild(script);
		}
	}*/
	

  	//Export DOM7 to local variable to make it easy accessable
  	var myApp = new Framework7({
		fastClicks: false,
  	});
  	var $$ = Dom7;

	//解决   安卓系统底部输入框太低时，输入键盘弹起会遮挡输入框
  	if(/Android [4-6]/.test(navigator.appVersion)) {
	    window.addEventListener("resize", function() {
	        if(document.activeElement.tagName=="INPUT" || document.activeElement.tagName=="TEXTAREA") {
	            window.setTimeout(function() {
	                document.activeElement.scrollIntoViewIfNeeded();
	            },0);
	        }
	    })
	}

  
	$(function(){
  		//多选
      	$(".edit-radio li").click(function(){
      		if($(this).attr("class")){
      			$(this).find("input:hidden").val("0");
      			$(this).removeClass('radio-active');
      		}else{
      			if($(this).index() == 0){
	        		$(this).find("input:hidden").val("2");
	        	}else{
	        		$(this).find("input:hidden").val("1");
	        	}
	      		$(this).addClass('radio-active');
      		}
   		});
  		//标记紧急程度等选项
  		mark();
  		//ios();
  	});

	//标记紧急程度等选项
  	function mark(){
  		var mailLevel = '${mailLevel}';//紧急
  		var mailNeedRevert = '${mailNeedRevert}';//回执
  		var mailSign = '${mailSign}';//签名
  		var mailAnonymous = '${mailAnonymous}';//匿名
  		var SendRongCloudRemind = '${SendRongCloudRemind}';
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
  		if(SendRongCloudRemind != '0' && SendRongCloudRemind != ''){
  			$('input[name=SendRongCloudRemind]').parent().addClass('radio-active');
  	  	}
  	}

	//清空
	function reset(){
		$('#shoujian').html("");
		$('#chaosong').html("");
		$('#empName').val("");
    	$('#empId').val("");
		$('#empName').css("display","block");
		$('#mailcc').val("");
    	$('#mailccid').val("");
		$('#mailcc').css("display","block");
    	$('#mailsubject').val("");
    	$('#mailcontent').val("");
		$('#maillevel').val("0");
		$('#mailneedrevert').val("0");
		$('#mailSign').val("0");
		$('#mailanonymous').val("0");
		$('#SendRongCloudRemind').val("0");

		$(".edit-radio li").each(
			function (){
				$(this).removeClass('radio-active').addClass(' ');
			} 	
		);

	}

	

	var m ='${mm}';
  	var index = 0;
    //添加图片
    function addImg(){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="imgName"/>'+
		       '<input type="hidden" id="img_save_name_'+index+'" name="imgSaveName" data-filesize="0"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
   	
    //删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove();
	   $("#up_img_"+index).remove();
    }
	
	//回调函数上传图片
	function callBackFun(upImgId,imgliId){
		myApp.showPreloader('正在上传...');
		$("#img_name_"+(index-1)).val($("#"+upImgId).val());
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=innerMailbox', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				//alert(1);
				$("#img_save_name_"+(index-1)).val(msg.data);
				$("#img_save_name_"+(index-1)).data("filesize",msg.fileSize);
				$("#img_name_"+(index-1)).val(fileShowName);
				$("#"+imgliId).show();
				myApp.hidePreloader();
				//loadingDialog.close();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				//alert(2);
				myApp.alert("文件上传失败！");
			}
		});
	}

	//选择人员
	function selectCallBack(input ){
		if( $(input).val() != ""){
			$(input).prev('span').html($(input).val());
			$(input).hide();
		}else{
			$(input).prev('span').html($(input).val());
			$(input).show();
		}
	}

	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		//var dialog = openTipsDialog('正在加载...');
		myApp.showPreloader('正在加载中...');
		$.ajax({
			url : '/defaultroot/newperson/personList.controller',
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':$('#'+selectId).val(),'range':range},
			success : function(data){
				$("#selectContent").append(data);
				myApp.hidePreloader();
				hiddenContent(0);
			}
		});
	}
    	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag==0){
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
			$("#selectContent").css("display","block");
		}else if(flag==1){
			$("#selectContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
			$("#selectContent").empty();
		}
	}
	

	var loading = false;
	//绑定发送点击事件
    function sendMail(){
        //alert("1111");
		if(loading){
			return;
		}
		//alert("33333333333");
    	if(!checkForm()){
	    	return;
	    }
	    //alert("222222222");
		loading = true;
		//alert("进来了。。。。。");
		ajaxSendMail();
    }

	//判断邮件类型
    var openType = '${openType}';
    var openFlag = '${openFlag}';
	var fromPage = '${fromPage}'; 
    //ajax方式发送邮件
    function ajaxSendMail(){
    	//myApp.showPreloader('正在发送中...');
    	var fileSize;
    	//回复全部（带附件时的附件大小）
		var oldfileSize = '${accessorySize}';
		//alert(oldfileSize);
		if(oldfileSize != ""){
			fileSize = parseFloat(oldfileSize);
		}else{
			fileSize = 0;
		}
		//alert(fileSize);
	    //计算附件总大小
	    //var fileSize = 0;
	    $("input[id^='img_save_name_']").each(function(){
	    	fileSize += parseFloat($(this).data("filesize"));
	    });
		
		//alert("fileSize------------>"+fileSize);
	    $("#fileSizeCount").val(fileSize);
	    $.ajax({
	    	url : 'sendMail.controller',
	    	data : $('#sendForm').serialize(),
	    	type : 'post',
	    	success : function(data){
	    		if(!data){
	    			//openTipsDialog('邮件发送失败！','',1000);
	    			myApp.alert('邮件发送失败，无返回数据！');
	    		}
	    		var json = eval("("+data+")");
				//alert(json.result);
	    		if(json.result == 'fail'){
	    			myApp.alert('邮件发送失败！');
	    		}else if(json.result == 'success'){
	    			myApp.alert('邮件发送成功！');
	    			//alert('邮件发送成功！');
	     			//window.location = 'mailBox.controller';
	     			//alert("openFlag----------->"+openFlag);
					//alert("fromPage----------->"+fromPage);
					setTimeout(function(){
						if(openFlag == 'yes'){
							if(openType == 'write'){
								if(fromPage == 'evo'){
									$imag.exec('closeEvoPage()');
								}else{
									window.history.back();
								}
							}else{
								if(fromPage == 'evo'){
									$imag.exec('closeEvoPage()');
								}else{
									window.history.go(-2);
								}
							}
			     		}else{
			     			WeixinJSBridge.call('closeWindow');
			     			//window.location = 'mailBox.controller';
			     			//alert("从通讯录进来的。。。。");
			     			//alert("cdv------------>"+cdv);
			     			//alert("cdv.window------------>"+cdv.window);
			     			//alert("cdv.window.close------------>"+cdv.window.close);
			     			//cdv.window.close();
				     	}
    				},1000);
	    		}
	    	},
	    	error : function(){
	    		//openTipsDialog('邮件发送异常！','',1000);
    			alert('邮件发送异常！');
	    	}
	    });
    }
    
    //校验表单
    //function checkForm(){
    //	var empName = $('#empName').val();
	//	//alert("收件人---------->"+empName);
    //	var empId = $('#empId').val();
		//alert("收件人id---------->"+empId);
    //	var mailsubject = $('#mailsubject').val();
		//alert("mailsubject------->"+mailsubject);
    //	var mailcontent = $('#mailcontent').val();
		//alert("mailcontent------->"+mailcontent);
   // 	if(!empName || !empId){
   // 		myApp.alert('请选择收件人！');
    //		return false;
  //  	}
   // 	if(!mailsubject){
  //  		myApp.alert('请输入主题！');
  //  		return false;
  //  	}
	//	if(/[\\\/?#&'"]+/g.test($$('#mailsubject').val())){
	//		myApp.alert('标题不可以包含特殊字符！');
//	/		return false;
	//	}
    //	return true;
 //   }


	//校验表单
    function checkForm(){
    	var empName = $('#empName').val();
    	//alert("empName----->"+empName);
    	var empId = $('#empId').val();
    	//alert("empId----->"+empId);
		
    	if(!empName || !empId){
    		myApp.alert('请选择收件人！');
    		return false;
    	}
    	if(!mailsubject){
    		myApp.alert('请输入主题！');
    		return false;
    	}
		if(mailsubject == ""){
			myApp.alert('主题不能为空！');
			return false;
		}
		if(/[\\\/?#&'"]+/g.test($$('#mailsubject').val())){
			myApp.alert('标题不可以包含特殊字符！');
			return false;
		}
    	return true;
    }


	//正文光标定位
    function cursorReset(e,a){
		if ( e && e.preventDefault )
		e.preventDefault();
		else 
		window.event.returnValue=false;
		a.focus();
	}



  </script>
