<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="/clientview/common/headerInit.jsp" %>
<%
String workId = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("workId"));
String orgId = session.getAttribute("orgId").toString();
%>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>表单页</title>
 </head>

<body class="grey-bg">
<c:if test="${not empty docXml}">
  <x:parse xml="${docXml}" var="doc"/>
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-form">
		<c:if test="${not empty workInfoDocXml}">
		<x:parse xml="${workInfoDocXml}" var="workInfoDoc"/>
		<!-- 此流程发起的时间 -->
		<c:set var="worksubmittime"><x:out select="$workInfoDoc//workInfo/worksubmittime/text()"/></c:set>
		<!-- true表示与退回按钮 -->
		<c:set var="hasbackbutton"><x:out select="$workInfoDoc//workInfo/havebackbutton/text()"/></c:set>
		<!-- 当前所处的办理 -->
		<c:set var="workcurstep"><x:out select="$workInfoDoc//workInfo/workcurstep/text()"/></c:set>
		<!-- 流程标题 -->
		<c:set var="worktitle"><x:out select="$workInfoDoc//workInfo/worktitle/text()"/></c:set>
		<!-- 能显示的按钮 -->
		<c:set var="modibutton"><x:out select="$workInfoDoc//workInfo/modibutton/text()"/></c:set>
		<!-- 此待办的Id  wf_work 的主键id -->
		<c:set var="wfworkId"><x:out select="$workInfoDoc//workInfo/wf_work_id/text()"/></c:set>
		<!-- 是否有短信权限 0：没有 1：有 -->
		<c:set var="wfsmsRight"><x:out select="$workInfoDoc//smsRight/text()"/></c:set>
          <section class="page-content wh-section wh-section-bottomfixed"  id="mainContent">
            <div class="webapp-form">
              <div class="app-tabheader-line clearfix">
                <div class="clearfix">
                  <a href="#tab11" class="tab-link active" style="width:50%">
                    <span>流程表单</span>
                  </a>
                  <a href="#tab13" onclick="openWorkFlowGetLog();" class="tab-link tab-link-rw" style="width:50%">
                    <span>流程记录</span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                <!-- 流程表单 -->
                <div id="tab11" class="tab active">
                  <div class="form-table">
                    <table style="border-collapse:separate;border-spacing: 0 10px;">
                        <!-- ssMode2:出库 or 3:退库 -->
		            	<c:set var="ssMode"><x:out select="$doc//fieldList/ssMode/text()"/></c:set>
		            	<!-- 出库单号/退库单号 -->
		            	<c:set var="serial"><x:out select="$doc//fieldList/serial/text()"/></c:set>
		            	<!-- 出库仓库ID/退库仓库ID -->
		            	<c:set var="stockId"><x:out select="$doc//fieldList/stockId/text()"/></c:set>
		            	<!-- 出库仓库名称/退库仓库名称 -->
		            	<c:set var="stockName"><x:out select="$doc//fieldList/stockName/text()"/></c:set>
		            	<!-- 出库部门ID/退库部门ID -->
		            	<c:set var="orgId"><x:out select="$doc//fieldList/orgId/text()"/></c:set>
		            	<!-- 出库部门名称/退库部门名称 -->
		            	<c:set var="orgName"><x:out select="$doc//fieldList/orgName/text()"/></c:set>
		            	<!-- 领用人ID/退库人ID -->
		            	<c:set var="ssUseManId"><x:out select="$doc//fieldList/ssUseManId/text()"/></c:set>
		            	<!-- 领用人名称/退库人名称 -->
		            	<c:set var="ssUseMan"><x:out select="$doc//fieldList/ssUseMan/text()"/></c:set>
		            	<!-- 出库类别ID/退库类别ID -->
		            	<c:set var="ssTypeId"><x:out select="$doc//fieldList/ssTypeId/text()"/></c:set>
		            	<!-- 出库日期/退库日期 -->
		            	<c:set var="ssDate"><x:out select="$doc//fieldList/ssDate/text()"/></c:set>
		            	<!-- 出库类别名称/退库类别名称 -->
		            	<c:set var="ssTypeName"><x:out select="$doc//fieldList/ssTypeName/text()"/></c:set>
		            	<!-- 领料部门ID -->
		            	<c:set var="lyDeptId"><x:out select="$doc//lyDeptId/ssDate/text()"/></c:set>
		            	<!-- 领料部门名称 -->
		            	<c:set var="lyDeptName"><x:out select="$doc//fieldList/lyDeptName/text()"/></c:set>
		            	<!-- 用途 -->
		            	<c:set var="uses"><x:out select="$doc//fieldList/uses/text()"/></c:set>
		            	<!-- 备注 -->
		            	<c:set var="remark"><x:out select="$doc//fieldList/remark/text()"/></c:set>
	           			<tr>
							<td>
								<c:if test="${ssMode == '2'}"><span>出库单号:</span></c:if>
								<c:if test="${ssMode == '3'}"><span>退库单号:</span></c:if>
							</td>
							<td>${serial }</td>
						</tr>
						<tr>
							<td>
								<c:if test="${ssMode == '2'}"><span>出库仓库:</span></c:if>
								<c:if test="${ssMode == '3'}"><span>退库仓库:</span></c:if>
							</td>
							<td>${stockName } </td>
						</tr>
						<tr>
							<td>
								<c:if test="${ssMode == '2'}"><span>出库部门:</span></c:if>
								<c:if test="${ssMode == '3'}"><span>退库部门:</span></c:if>
							</td>
							<td>${orgName }</td>
						</tr>
						<tr>
							<td>
								<c:if test="${ssMode == '2'}"><span>出库人:</span></c:if>
								<c:if test="${ssMode == '3'}"><span>退库人:</span></c:if>
							</td>
							<td>${ssUseMan }</td>
						</tr>
						<tr>
							<td>
								<c:if test="${ssMode == '2'}"><span>出库日期:</span></c:if>
								<c:if test="${ssMode == '3'}"><span>退库日期:</span></c:if>
							</td>
							<td>${ssDate }</td>
						</tr>
						<tr>
							<td>
								<c:if test="${ssMode == '2'}"><span>出库类别:</span></c:if>
								<c:if test="${ssMode == '3'}"><span>退库类别:</span></c:if>
							</td>
							<td>${ssTypeName }</td>
						</tr>
						<tr>
							<td>用途</td>
							<td>${uses }</td>
						</tr>
						<tr>
							<th>备注</th>
							<td>${remark }</td>
						</tr>
						<!--子表信息begin-->
						<c:set var="subTable"></c:set>
						<x:forEach select="$doc//subTableList/subFieldList" var="ct" varStatus="xh">
							<c:set var="subTable" >${xh.index+1}</c:set>
						</x:forEach>
						<tr>
							<td>子表填写：</td>
							<td>
								<div>
								<input id="subTableInput" placeholder="添加子表" type="text" class="edit-ipt-r edit-ipt-arrow" 
								<c:if test="${not empty subTable}">value="${subTable}条子表数据"</c:if>
								 readonly="readonly" onclick="addSubTable('1');"/></div>
							</td>
						</tr>
						<!--子表信息end-->
                      <!--批示意见begin-->
			    	<c:if test="${param.workStatus eq '0'}">
			    		<c:set var="commentField" ><x:out select="$workInfoDoc//workInfo/commentField/text()"/></c:set>
						<c:set var="actiCommFieldType" ><x:out select="$workInfoDoc//workInfo/actiCommFieldType/text()"/></c:set>
						<c:if test="${actiCommFieldType != '-1' && (commentField == '-1' || commentField == 'nullCommentField' || commentField == 'autoCommentField' || commentField == 'null') }">
							<tr>
								<td>
								<span>审批意见<c:if test="${commentmustnonull eq true}"><em></em></c:if>:</span>
								</td>
								<td>
		                            <div><textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="comment_input" id="comment_input" maxlength="50"></textarea></div>
									<div class="edit-direct" style="text-align:right;">
									<div class="edit-sel-show">
										<span>常用审批语</span>
									</div>    
									<select class="btn-bottom-pop" onchange="selectComment(this);">
										<option value="0">常用审批语</option> 
										<x:forEach select="$workInfoDoc//officelist" var="selectvalue" >
											<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
									    </x:forEach>
									</select>
								</div>
			                    </td>
							</tr>
						</c:if>
		    		</c:if>
					<c:if test="${param.workStatus eq '2'}">
			    		<c:set var="passRoundCommField" ><x:out select="$workInfoDoc//workInfo/passRoundCommField/text()"/></c:set>
						<c:set var="passRoundCommFieldType" ><x:out select="$workInfoDoc//workInfo/passRoundCommFieldType/text()"/></c:set>
						<c:if test="${passRoundCommField == 'autoCommentField'}">
							<tr>
								<td><span>审批意见<c:if test="${commentmustnonull eq true}"><em></em></c:if>:</span></td>
								<td>
		                           <div><textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="comment_input" id="comment_input" maxlength="50"></textarea></div>
									<div class="edit-direct" style="text-align:right;">
									<div class="edit-sel-show">
										<span>常用审批语</span>
									</div>    
									<select class="btn-bottom-pop" onchange="selectComment(this);">
										<option value="0">常用审批语</option> 
										<x:forEach select="$workInfoDoc//officelist" var="selectvalue" >
											<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
									    </x:forEach>
									</select>
								   </div>
			                    </td>
							</tr>
						</c:if>
		    		</c:if>
					<x:forEach select="$workInfoDoc//commentList/comment" var="ct" >
						<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
						<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
						<tr>
							<td><span><x:out select="$ct//step/text()"/>：</span></tds>
							<td><x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)</td>
						</tr>
					</x:forEach>
					<!--批示意见end-->
                    </table>
                  </div>
                </div>
                <!-- 流程图加载 -->
                <div id="tab12" class="tab">  
                  <p><img id="lct" width="100%" class="lazy lazy-fadeIn"></p> 
                </div>
                <!-- 流程图记录 -->
                <div id="tab13" class="tab">
                  <div class="form-table-record">
                  <form id="sendForm" action="/defaultroot/workflow/sendnew.controller" method="post">
                    <table style="border-collapse:separate;border-spacing: 0 10px;" id="workflowlog">
                    	
                    </table>
                    <input type="hidden" name="tableId" value="<x:out select="$workInfoDoc//workInfo/worktable_id/text()"/>" />
					<input type="hidden" name="recordId" value="<x:out select="$workInfoDoc//workInfo/workrecord_id/text()"/>" />
					<input type="hidden" name="activityId" value="<x:out select="$workInfoDoc//workInfo/initactivity/text()"/>" />
					<input type="hidden" name="workId" value="<x:out select="$workInfoDoc//workInfo/wf_work_id/text()"/>" />
					<input type="hidden" name="stepCount" value="<x:out select="$workInfoDoc//workInfo/workstepcount/text()"/>" />
					<input type="hidden" name="isForkTask" value="<x:out select="$workInfoDoc//isForkTask/text()"/>" />
					<input type="hidden" name="forkStepCount" value="<x:out select="$workInfoDoc//forkStepCount/text()"/>" />
					<input type="hidden" name="forkId" value="<x:out select="$workInfoDoc//forkId/text()"/>" />
					<input type="hidden" name="activityclass" value="<x:out select="$workInfoDoc//activityClass/text()"/>" />
					<input type="hidden" name="commentType" value="0" />
					<input type="hidden" name="pass_title" value="" />
					<input type="hidden" name="pass_time" value="" />
					<input type="hidden" name="pass_person" value="" />
					<input type="hidden" name="__sys_operateType" value="2" />
					<input type="hidden" name="__sys_infoId" value='<x:out select="$workInfoDoc//paramList/workrecord_id/text()"/>' />
					<input type="hidden" name="__sys_pageId" value='<x:out select="$workInfoDoc//paramList/worktable_id/text()"/>' />
					<input type="hidden" name="__sys_formType" value='<x:out select="$workInfoDoc//paramList/formType/text()"/>' />	
					<input type="hidden" name="__main_tableName" value='<x:out select="$workInfoDoc//fieldList/tableName/text()"/>' />	
					<input type="hidden" name="actiCommFieldType" value='<x:out select="$workInfoDoc//workInfo/actiCommFieldType/text()"/>' />
					<input type="hidden" name="curCommField" value='<x:out select="$workInfoDoc//workInfo/commentField/text()"/>' />
					<input type="hidden" name="trantype" value='<x:out select="$workInfoDoc//workInfo/trantype/text()"/>' />
					<x:if select="$workInfoDoc//workInfo/commentmustnonull" var="commentmustnonull">
						<input type="hidden" name="commentmustnonull" value='<x:out select="$workInfoDoc//workInfo/commentmustnonull/text()"/>' />
					</x:if>
					<x:if select="$workInfoDoc//workInfo/backnocomment" var="backnocomment">
						<input type="hidden" name="backnocomment" value='<x:out select="$workInfoDoc//workInfo/backnocomment/text()"/>' />
					</x:if>
					<x:if select="$workInfoDoc//workInfo/backMailRange" var="backMailRange">
						<input type="hidden" name="backMailRange" value='<x:out select="$workInfoDoc//workInfo/backMailRange/text()"/>' />
					</x:if>
					<x:if select="$workInfoDoc//workInfo/smsRight" var="smsRight">
						<input type="hidden" name="smsRight" value='<x:out select="$workInfoDoc//workInfo/smsRight/text()"/>' />
					</x:if>
					<input type="file" style="display:none;" value="" name="comment_input_shouxie" id="comment_input_shouxie"/>
					<input type="file" style="display:none;" value="" name="comment_input_yuyin" id="comment_input_yuyin"/>
					<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
					<input type="hidden" name="worktitle" value="${worktitle}">
					<input type="hidden" name="workcurstep" value="${workcurstep}">
					<input type="hidden" name="worksubmittime" value="${worksubmittime}">
					<input type="hidden" name="workStatus" value="0">
					</form>
                  </div>
                </div>
              </div>
            </div>
          </section>
          </c:if>
          <c:if test="${fn:indexOf(workcurstep,'办理完毕') == '-1'}">
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  	<c:choose>
                  		<c:when test="${param.workStatus eq '0'}">
                  			<div class="fl clearfix">
                  			<c:choose>
				                <c:when test="${hasbackbutton == 'true' }">
					               	<a href="javascript:$('#backForm').submit();" class="panel-return-a">退回</a>
			            			<a href="javascript:$('#sendForm').submit();" class="panel-send-a">发送</a>
				                </c:when>
				                <c:otherwise>
					                <a href="javascript:$('#sendForm').submit();" class="panel-send-a">发送</a>
				                </c:otherwise>
			                </c:choose>
			                </div>
                  			 <a id="fbtn-form-more" data-popover=".popover-links" class="fr fbtn-more link open-popover "><span>更多</span></a>
                  		</c:when>
                  		<c:when test="${param.workStatus eq '2'}">
                  			<div class="fl clearfix">
                  			 <a href="javascript:workfolwSend('${wfworkId}');" class="panel-send-a">发送</a>
                  			 </div>
                  		</c:when>
                  		<c:when test="${param.workStatus eq '101'}">
                  			<div class="fl clearfix">
                  			<c:if test="${fn:indexOf(workcurstep,'办理完毕') == '-1'}">
                  				<c:when test="${fn:indexOf(modibutton,'Undo') >0 && fn:indexOf(modibutton,'Wait') >0}">
			            			<a href="javascript:workfolwUndo('${wfworkId}');" class="panel-return-a">撤办</a>
			            			<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-send-a">催办</a>
			            		</c:when>
			            		<c:when test="${fn:indexOf(modibutton,'Undo') >0 && fn:indexOf(modibutton,'Wait') <=0}">
			            			<a href="javascript:workfolwUndo('${wfworkId}');" class="panel-return-a">撤办</a>
			            		</c:when>
			            		<c:when test="${fn:indexOf(modibutton,'Undo') <=0 && fn:indexOf(modibutton,'Wait') >0}">
			            			<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-send-a">催办</a>
			            		</c:when>
                  			</c:if>
                  			</div>
                  		</c:when>
                  		<c:when test="${param.workStatus eq '1100'}">
                  			<div class="fl clearfix">
							<c:if test="${fn:indexOf(modibutton,'Wait') >0}">
								<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-send-a">催办</a>
							</c:if>
							</div>
						</c:when>
                  	</c:choose>
                </div>
              </div>
            </div>
          </footer>
          </c:if>
          <jsp:include page="../common/include_stock_subTable.jsp" flush="true">
			<jsp:param name="docXml" value="${docXml}" />
			<jsp:param name="orgId" value="<%=orgId %>" />
		</jsp:include>
        </div>
      </div>
    </div>
  </div>
  <div class="fbtn-more-nav popover popover-links" id="fbtn-more-con">
    <div class="fbtn-more-nav-inner" id="fbtn-more-list">
      <c:if test="${param.workStatus ne '102' && param.workStatus eq '0'}">
      	<c:if test="${fn:indexOf(modibutton,'Tran') >0}">
        	<a href="javascript:$('#tranInfoForm').submit();" class="panel-turn-a fbtn-grey close-popover">转办</a>
        </c:if>
        <c:if test="${fn:indexOf(modibutton,'AddSign') >0}">
        	<a href="javascript:$('#addSignForm').submit();" class="panel-add-a close-popover">加签</a>
        </c:if>
        <c:if test="${fn:indexOf(modibutton,'Selfsend') >0}">
        	<a href="javascript:$('#selfsendForm').submit();" class="panel-read-a close-popover">阅件</a>
        </c:if>
      </c:if>
    </div>
  </div>
  <form id="sendFormAgain" action="/defaultroot/dealfile/pressInfo.controller?workId=${wfworkId}&amp;smsRight=${wfsmsRight }" method="post">
		<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
		<input type="hidden" name="worktitle" value="${worktitle}">
		<input type="hidden" name="workcurstep" value="${workcurstep}">
		<input type="hidden" name="worksubmittime" value="${worksubmittime}">
		<input type="hidden" name="workStatus" value="1100">
	</form>
	
	<form id="backForm" action="/defaultroot/workflow/back.controller" method="post">
		<input type="hidden" name="workId" value="<%=workId%>">
		<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
		<input type="hidden" name="worktitle" value="${worktitle}">
		<input type="hidden" name="workcurstep" value="${workcurstep}">
		<input type="hidden" name="worksubmittime" value="${worksubmittime}">
		<input type="hidden" name="workStatus" value="0">
		<input type="hidden" name="tableId" value='<x:out select="$workInfoDoc//workInfo/worktable_id/text()"/>'>
		<input type="hidden" name="recordId" value='<x:out select="$workInfoDoc//workInfo/workrecord_id/text()"/>'>
		<input type="hidden" name="stepCount" value='<x:out select="$workInfoDoc//workInfo/workstepcount/text()"/>'>
		<input type="hidden" name="forkId" value='<x:out select="$workInfoDoc//workInfo/forkId/text()"/>'>
		<input type="hidden" name="forkStepCount" value='<x:out select="$workInfoDoc//workInfo/forkStepCount/text()"/>'>
		<input type="hidden" name="isForkTask" value='<x:out select="$workInfoDoc//workInfo/isForkTask/text()"/>'>
		<input type="hidden" name="curCommField" value='<x:out select="$workInfoDoc//workInfo/commentField/text()"/>' />
	</form>
	<!----------转办开始---------->
	<form id="tranInfoForm" class="dialog" action="/defaultroot/dealfile/tranInfo.controller?workId=${wfworkId}" method="post">
		<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
		<input type="hidden" name="worktitle" value="${worktitle}">
		<input type="hidden" name="workcurstep" value="${workcurstep}">
		<input type="hidden" name="worksubmittime" value="${worksubmittime}">
		<input type="hidden" name="workStatus" value="0">
	</form>
	<!----------转办结束---------->
	<!----------加签开始---------->
	<form id="addSignForm" class="dialog" action="/defaultroot/dealfile/addSign.controller?workId=${wfworkId}" method="post">
		<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
		<input type="hidden" name="worktitle" value="${worktitle}">
		<input type="hidden" name="workcurstep" value="${workcurstep}">
		<input type="hidden" name="worksubmittime" value="${worksubmittime}">
		<input type="hidden" name="workStatus" value="0">
	</form>
	<!----------加签结束---------->
	<!----------阅件开始---------->
	<form id="selfsendForm" class="dialog" action="/defaultroot/dealfile/selfSend.controller?workId=${wfworkId}" method="post">
		<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
		<input type="hidden" name="worktitle" value="${worktitle}">
		<input type="hidden" name="workcurstep" value="${workcurstep}">
		<input type="hidden" name="worksubmittime" value="${worksubmittime}">
		<input type="hidden" name="workStatus" value="0">
	</form>
	<!----------阅件结束---------->
  </c:if>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/zepto.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7();
  var $$ = Dom7;
 
  //右下角菜单弹框
  $$('#fbtn-more').on('click', function() {
    var clickedLink = this;
    myApp.popover('#fbtn-more-con', clickedLink);
    myApp.closeModal('#fbtn-more-list a')
  });
 
 
  $$('.panel-close').on('click', function (e) {
    myApp.closePanel();
  });

  //成功办理
  var modal;

  $$('.panel-send-btn').on('click', function(e) {
    
    modal = myApp.modal({
      title: ' ',
      text: ' ',
      afterText: '<div class="panel-modal"><i class="fa fa-check-circle"></i><p>办理成功,返回中...</p></div>',
      buttons: []
    })
    myApp.swiper($$(modal).find('.swiper-container'), {
      pagination: '.swiper-pagination'
    });
 
    setTimeout(function() {
      myApp.hidePreloader(); 
    }, 2000); 
    });
    
	var getlogFlag = 0;
	function openWorkFlowGetLog() {
		if(getlogFlag == 0){
			workFlowGetLog();
		}
	}
    
    //流程记录
    function workFlowGetLog(){
    	myApp.showPreloader(' ');
		var val = '<%=workId%>';
        $.ajax({
            type: 'post',
            url: '/defaultroot/dealfile/workFlowGetLog.controller',
            dataType: 'text',
            data : {'workId':val},
            success: function(data){
                if(!data){
                	return;
                }
                var jsonData = eval("("+data+")");
                if(!jsonData){
                	return;
                }
               var listData = jsonData.data0;
                if(!listData){
                	return;
                }
                var addDom = '';    
                for(var i = 0;i < listData.length; i++){
                	var logTime = listData[i].logTime;
                	addDom +='<tr>'
                        +'<td width="33.2%">'
                        +'  <div class="step-username">'
                         +'   <p>'+listData[i].logUserName+' </p>'
                        +'    <em>'+logTime.substring(2,logTime.length)+'</em>'
                       +'   </div>'
                       +' </td>'
                      +'  <td width="33.2%">'
                        +'  <div class="step-name">'
                       +'     <em class="skyblue">'+listData[i].logAction+'</em>'
                       +'   </div>'
                      +'  </td>'
                      +'  <td>'
                      +'    <div class="step-recive">'
                       +'     <p>'+listData[i].logReceive+'</p>'
                       +'   </div>'
                      +'  </td>'
                     +' </tr>';
                      
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#workflowlog').append(addDom);
                getlogFlag = 1;
                myApp.hidePreloader();	
            },
            error: function(xhr, type){
                myApp.alert('数据查询异常！');
            }
        });
    }
    
    function workfolwSend(workId){
		//发送流程
		$.ajax({
			url : '/defaultroot/workflow/readover.controller',
			type : 'post',
			data : $('#sendForm').serialize(),
			success : function(data){
				if(data){
					var jsonData = eval('('+data+')');
					console.info(jsonData.result);
					if(jsonData.result = 'success'){
						myApp.alert('发送成功！');
						window.location = '/defaultroot/dealfile/list.controller?workStatus=0';
					}
				}else{
					myApp.alert('发送失败！');
				}
			},
			error : function(){
				myApp.alert('发送异常！');
			}
		});
	}
	
	function workfolwUndo(workId){
		var status = confirm('是否撤回该流程到您的待办文件中重新办理？');
        if(!status){
            return false;
        }
		var dialog = $.dialog({
	            content:"正在撤办中...",
	            title: 'load'
	        });
		var url ='/defaultroot/workflow/workfolwUndo.controller?workId='+workId;
		var openUrl ='/defaultroot/dealfile/list.controller?workStatus=101';
		$.ajax({
			type:'POST',
			url: url,
			async: true,
			dataType: 'text',
			success: function(data){
				if(dialog){
					dialog.close();
				}
				var json = eval("("+data+")");
				if(json!=null){
					if(json.result == 'success'){
						myApp.alert("撤办成功！");
						window.location.href =openUrl;
					}else{
						myApp.alert("撤办失败！");
					}
				}
			},
			error: function(){
				myApp.alert("异常！");
			}
		});
	}
	
	//选择批示意见
    function selectComment(obj){
    	var $selectObj = $(obj);
    	var selectVal = $selectObj.val();
    	if(selectVal == '0'){
        	selectVal = '';
        }
    	//var $textarea = $selectObj.parent().parent().siblings();
    	var textarea = $('#comment_input').val();
    	setSpanHtml(obj,selectVal);
    	//$textarea.val($textarea.val() + selectVal);
    	$('#comment_input').val(textarea + selectVal);
    }
  //设置span中的值
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	}
 
  </script>
</body>
</html>

