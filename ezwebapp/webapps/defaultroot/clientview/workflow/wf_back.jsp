<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="/clientview/common/headerInit.jsp" %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>文件办理</title>
</head>
<%
String worktitle = request.getParameter("worktitle")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("worktitle"));
String workcurstep = request.getParameter("workcurstep")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("workcurstep"));
String worksubmittime = request.getParameter("worksubmittime")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("worksubmittime"));
String workStatus = request.getParameter("workStatus")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("workStatus"));
String fromPage = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("fromPage"));
%>
<body class="grey-bg">
  <div class="views">
    <div class="view view-main">
      <div class="pages">
        <div class="page" data-page="page-webapp-step-operation">
          <section class="wh-section wh-section-bottomfixed">
           <div class="step-operation" style="display: block;">
            <div class="panel-sub panel-return" style="display: block;">
              <div class="panel-title">
                <p class="panel-title-p">退回选项</p>
              </div>
              <form id="sendForm" class="dialog" action="/defaultroot/workflow/backprocess.controller" method="post">
					<input type="hidden" name="workId" value="<c:out value='${param.workId}' escapeXml='false'/>" />
					<input type="hidden" name="commentField" value="<c:out value='${param.curCommField}' escapeXml='false'/>"/>
					<!--backMailRange 邮件提醒范围0:退回环节经办人1:所有办理人-->
					<input type="hidden" name="backMailRange" value="0"/>
					<!--needSmsRemind 是否短信提醒 0：不提醒  1：提醒-->
					<input type="hidden" name="needSmsRemind" value="0"/>
					<input type="hidden" id="fromFlag" name="fromFlag" value="<c:out value='${param.fromFlag}' escapeXml='false'/>" />
						<c:choose>
				            <c:when test="${not empty docXml}">
								<x:parse xml="${docXml}" var="doc"/>
									<div class="panel-con">
						                <p class="panel-title-p">退回环节</p>
						                <input type="hidden" id="activity" name="activity" value="0"/>
						                <div class="panel-direct2" style="background-color: #fff;">
						                  <ul class="edit-radio">
						                    <li onclick="changeActi('0','')">
						                      <label class="label-radio item-content">
						                        <input type="radio" name="my-radio" checked="checked" value="0">
						                        <span class="edit-radio-l">退回发起人</span>
						                      </label>
						                    </li>
						                    <x:forEach select="$doc//backWorkFlow" var="n" varStatus="status">
												<li onclick="changeActi('<x:out select="$n/activityId/text()"/>;<x:out select="$n/activityName/text()"/>;<x:out select="$n/curstepcount/text()"/>;<x:out select="$n/dealwithEmpId/text()"/>;<x:out select="$n/dealwithEmpName/text()"/>;<x:out select="$n/forkStepCount/text()"/>','<x:out select="$n/dealwithEmpName/text()"/>')">
							                      <label class="label-radio item-content">
							                        <input type="radio" name="my-radio" value="<x:out select="$n/activityId/text()"/>;<x:out select="$n/activityName/text()"/>;<x:out select="$n/curstepcount/text()"/>;<x:out select="$n/dealwithEmpId/text()"/>;<x:out select="$n/dealwithEmpName/text()"/>;<x:out select="$n/forkStepCount/text()"/>">
							                        <span class="edit-radio-l"><x:out select="$n/activityName/text()"/><x:if select="$n//dealwithEmpName/text() != 'null'">:<x:out select="$n/dealwithEmpName/text()"/></x:if></span>
							                      </label>
							                    </li>
											</x:forEach>
						                  </ul>
						                </div>
						              </div>
									<div class="panel-con" id="backPerson" style="display:none">
						                <p class="panel-title-p">退回人</p>
						                <div class="panel-direct">
						                  <p id="backPerName"></p>
						                </div>
						             </div>
							</c:when>
							<c:otherwise>
								<div class="panel-con">
					                <p class="panel-title-p">退回环节</p>
					                <input type="hidden" id="activity" name="activity" value="0"/>
					                <div class="panel-direct2" style="background-color: #fff;">
					                  <ul class="edit-radio">
					                    <li>
					                      <label class="label-radio item-content">
					                        <input type="radio" name="my-radio" checked="checked" value="0">
					                        <span class="edit-radio-l">退回发起人</span>
					                      </label>
					                    </li>
					                  </ul>
					                </div>
								</div>
							</c:otherwise>
						</c:choose>
						<div class="panel-con">
			                <p class="panel-title-p">退回意见</p>
			                <div class="panel-textarea">
			                  <textarea name='comment' placeholder="请输入退回意见" maxlength="166" id="backcomment" onkeyup="$(this).next('#fontNum').html($(this).attr('maxlength')-$(this).val().length );"></textarea>
			                  <em id="fontNum">166</em>
			                </div>
			             </div>
				</form>
            </div>
          </div>
        </section>
        <div id="footer-hb" class="panel-btn">
           	<a href="javascript:onSubmit();" class="panel-btn-a panel-close">确认退回</a>
         </div>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript">
  var myApp = new Framework7();
  var mainView = myApp.addView('.view');
  var $$ = Dom7;
  //右下角菜单弹框
  $$('#fbtn-more').on('click', function () {
    var clickedLink = this;
    myApp.popover('#fbtn-more-con', clickedLink);
    myApp.closeModal('#fbtn-more-list a')
  });
  
  	//解决input输入框的问题
	if(/Android [4-6]/.test(navigator.appVersion)) {
	    window.addEventListener("resize", function() {
	        if(document.activeElement.tagName=="INPUT" || document.activeElement.tagName=="TEXTAREA") {
	            window.setTimeout(function() {
	                document.activeElement.scrollIntoViewIfNeeded();
	            },0);
	        }
	    })
	}
	document.write( '<style>#footer-hb{visibility:hidden}@media(min-height:' + ($( window ).height() - 10) + 'px){#footer-hb{visibility:visible}}</style>' );
	 
	//解决input输入框的问题
   
   //配合evo原表单
    $(document).ready(function(){
	    var apptype ='<%=apptype%>';
		if(apptype == 'evo'){
			setTimeout(function(){$imag.exec("deleteOriginalFormView()");},500);
		}
	});

   //设置span中的值
	function setSpanHtml(obj,selectVal){
	   	if(!selectVal){
	   		selectVal = $(obj).find("option:selected").text();
	   	}
		$(obj).parent().find('div>p').html(selectVal);
	}
  
	function changeActi(acti,name){
		$('#activity').val(acti);
		if(name==''){
			$('#backPerson').css("display","none"); 
		}else{
			$('#backPerson').css("display",""); 
			$('#backPerName').html(name); 
		}
	}
	var backFlag='0';
	function onSubmit(){
		if(backFlag=='1'){
			return;
		}
		backFlag='1';
		var backcomment = $("#backcomment").val();
		if(backcomment.replace(/\s/g,"")==""){
			myApp.alert("退回意见不能为空!");
			backFlag='0';
			return;
		}
		var url ='/defaultroot/workflow/backprocess.controller';
		var openUrl ='/defaultroot/dealfile/list.controller?workStatus=<%=workStatus%>';
		myApp.showPreloader('正在退回');
		$.ajax({
			type: 'POST',
			url: url,
			data: $('#sendForm').serialize(),
			async: true,
			dataType: 'text',
			success: function(data){
				var fromPage = '<%=fromPage%>';
				myApp.hidePreloader();
				var json = eval("("+data+")");
				if(json!=null){
					if(json.result == 'success'){
						myApp.alert("退回成功！");
						//window.location.href =openUrl;
						var fromFlag = $("#fromFlag").val();
						if(fromPage == 'evo'){
							$imag.exec('closeEvoPage()');
						}else{
							if(fromFlag == '1'){
								window.history.go(-2);
							}else{
								WeixinJSBridge.call('closeWindow');
							}
						}
					}else{
						backFlag='0';
						myApp.alert("退回失败！");
					}
				}
			},
			error: function(){
				backFlag='0';
				myApp.alert("异常！");
			}
		});
	}
</script>
</body>