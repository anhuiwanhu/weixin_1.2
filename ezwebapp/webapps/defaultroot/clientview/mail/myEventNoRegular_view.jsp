<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,java.text.*" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>查看我的日程不定期</title> 
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
<c:choose>
  <c:when test="${not empty docXml}">
  <div class="views">
    <div class="view view-main">
      <div class="pages">
        <div class="page" data-page="page-webapp-step-operation">
        <x:parse xml="${docXml}" var="doc" />
		<c:set var="eventId"><x:out select="$doc//id/text()" /></c:set>
		<c:set var="eventAttr"><x:out select="$doc//eventAttr/text()" /></c:set>
		<c:set var="eventTitle"><x:out select="$doc//eventTitle/text()" /></c:set>
		<c:set var="eventAddress"><x:out select="$doc//eventAddress/text()" /></c:set>
		<c:set var="BeginDate"><x:out select="$doc//eventBeginDate/text()" /></c:set>
		<c:set var="EndDate"><x:out select="$doc//eventEndDate/text()" /></c:set>
		<c:set var="eventFullDay"><x:out select="$doc//eventFullDay/text()" /></c:set>
		<c:set var="BeginTime"><x:out select="$doc//eventBeginTime/text()" /></c:set>
		<c:set var="EndTime"><x:out select="$doc//eventEndTime/text()" /></c:set>
		<c:set var="eventRemind"><x:out select="$doc//eventRemind/text()" /></c:set>
		<c:set var="attend1"><x:out select="$doc//attend/text()" /></c:set>
		<c:set var="attendId1"><x:out select="$doc//attendId/text()" /></c:set>
		<c:set var="eventContent"><x:out select="$doc//eventContent/text()" /></c:set>
		<c:set var="eventIsDRrc"><x:out select="$doc//eventIsDRrc/text()" /></c:set>
		<c:set var="eventTBID"><x:out select="$doc//eventTBID/text()" /></c:set>
		
		<%
			//处理参与人姓名与id是否为空
			String attend = (String)pageContext.getAttribute("attend1");
			String attendId = (String)pageContext.getAttribute("attendId1");
			if("null".equals(attend)){
				attend = "";
			}
			if("null".equals(attendId)){
				attendId = "";
			}
			
			//处理起始时间
			String eventFullDay = (String)pageContext.getAttribute("eventFullDay");
			String eventBeginDateTime = "";//开始时间日期
			String eventEndDateTime = "";//结束时间日期
			if(eventFullDay.equals("0")){
				long BeginDate = Long.valueOf((String)pageContext.getAttribute("BeginDate"));
			  	long BeginTime = Long.valueOf((String)pageContext.getAttribute("BeginTime"));
			  	Date d1 = new Date(BeginDate+BeginTime*1000);
			  	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd,HH:mm");
			  	eventBeginDateTime = sdf1.format(d1);
			  		
			  	long EndDate = Long.valueOf((String)pageContext.getAttribute("EndDate"));
			  	long EndTime = Long.valueOf((String)pageContext.getAttribute("EndTime"));
			  	Date d2 = new Date(EndDate+EndTime*1000);
			  	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd,HH:mm");
			  	eventEndDateTime = sdf2.format(d2);
			}else{
				long BeginDate = Long.valueOf((String)pageContext.getAttribute("BeginDate"));
			  	Date d1 = new Date(BeginDate);
			  	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			  	eventBeginDateTime = sdf1.format(d1);
			  		
			  	long EndDate = Long.valueOf((String)pageContext.getAttribute("EndDate"));
			  	Date d2 = new Date(EndDate);
			  	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
			  	eventEndDateTime = sdf2.format(d2);
			}
			  	
		%>
		<c:set var="eventBeginDateTime"><%=eventBeginDateTime %></c:set>
		<c:set var="eventEndDateTime"><%=eventEndDateTime %></c:set>
		<c:set var="attend"><%=attend %></c:set>
		<c:set var="attendId"><%=attendId %></c:set>
			  
          <section class="page-content wh-section wh-section-bottomfixed leader-read" id="mainContent">
          	<div class="app-tabheader-line clearfix">
                <div class="clearfix">
                  <a id="open" <c:if test="${eventIsDRrc == '0' && isme == '1'}">href="javascript:openA();"</c:if> <c:if test="${eventAttr == '1'}">class="read-clock"</c:if> >公开</a>
                  <a id="private" <c:if test="${eventIsDRrc == '0' && isme == '1'}">href="javascript:privateA();"</c:if> <c:if test="${eventAttr == '0'}">class="read-clock"</c:if>>私密</a>
                </div>
            </div>
            <article class="wh-edit wh-edit-document">
              <div class="wh-container">
              	<form id="sendForm">
              	<input type="hidden" id="eventId" name="eventId" value="${eventId }">
              	<input type="hidden" id="eventAttr" name="eventAttr" value="${eventAttr }">
                <table class="wh-table-edit" style="border-collapse:separate;border-spacing: 0 2px;">
                  <tbody>
                    <tr>
                      <td><em class="red-em">*</em>主题：</td>
                      <td>
                        <p><input placeholder="请输入" class="edit-ipt-r" type="text" id="eventTitle" name="eventTitle" value="${eventTitle }" <c:if test="${eventIsDRrc != '0' || isme != '1'}">readonly="readonly"</c:if> /></p>
                      </td>
                    </tr>
                    <tr>
                      <td>地点：</td>
                      <td>
                        <p><input placeholder="请输入" class="edit-ipt-r" type="text" id="eventAddress" name="eventAddress" value="${eventAddress }" <c:if test="${eventIsDRrc != '0' || isme != '1'}">readonly="readonly"</c:if> /></p>
                      </td>
                    </tr>
                    <tr>
                      <td>全天事件：</td>
                      <td class="">
                      	<c:choose>
                      		<c:when test="${eventFullDay == '1'}">
                      			<div <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="pick-div"</c:if> class="pick-div"><span></span></div>
                        		<input type="hidden" id="eventFullDay" name="eventFullDay" value="1">
                      		</c:when>
                      		<c:otherwise>
                      			<div <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="pick-div"</c:if> class="pick-div pick-div-close"><span></span></div>
                        		<input type="hidden" id="eventFullDay" name="eventFullDay" value="0">
                      		</c:otherwise>
                      	</c:choose>
                      </td>
                    </tr>
                    <c:choose>
                    	<c:when test="${eventFullDay == '0'}">
                    		<tr id="DateTime" style="display: table-row">
                      			<td >起始时间：</td>
                      			<td>
                        			<div class="repeat-time">
                          				<input class="edit-ipt-r edit-ipt-arrow" <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="startDate"</c:if> name="startDate" type="text" name="scroller" placeholder="请选择" readonly="" value="${eventBeginDateTime }">
                          				<p class="fenge"></p>
                          				<input class="edit-ipt-r edit-ipt-arrow" <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="endDate"</c:if> name="endDate" type="text" name="scroller" placeholder="请选择" readonly="" value="${eventEndDateTime }">
                        			</div>
                        			<div class="zhi">
                          				<span>至</span>
                        			</div>
                      			</td>
                    		</tr>
                    		<tr id="Date" style="display: none">
                      			<td>起始时间：</td>
                      			<td>
                        			<div class="repeat-time">
                          				<input class="edit-ipt-r edit-ipt-arrow" <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="startDate1"</c:if> name="startDate1" type="text" name="scroller" placeholder="请选择" readonly="" value="${eventBeginDateTime }">
                          				<p class="fenge"></p>
                          				<input class="edit-ipt-r edit-ipt-arrow" <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="endDate1"</c:if> name="endDate1" type="text" name="scroller" placeholder="请选择" readonly="" value="${eventEndDateTime }">
                        			</div>
                        			<div class="zhi">
                          				<span>至</span>
                        			</div>
                      			</td>
                    		</tr>
                    	</c:when>
                    	<c:otherwise>
                    		<tr id="DateTime" style="display: none">
                      			<td >起始时间：</td>
                      			<td>
                        			<div class="repeat-time">
                          				<input class="edit-ipt-r edit-ipt-arrow" <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="startDate"</c:if> name="startDate" type="text" name="scroller" placeholder="请选择" readonly="" value="${eventBeginDateTime }">
                          				<p class="fenge"></p>
                          				<input class="edit-ipt-r edit-ipt-arrow" <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="endDate"</c:if> name="endDate" type="text" name="scroller" placeholder="请选择" readonly="" value="${eventEndDateTime }">
                        			</div>
                        			<div class="zhi">
                          				<span>至</span>
                        			</div>
                      			</td>
                    		</tr>
                    		<tr id="Date" style="display: table-row">
                      			<td>起始时间：</td>
                      			<td>
                        			<div class="repeat-time">
                          				<input class="edit-ipt-r edit-ipt-arrow" <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="startDate1"</c:if> name="startDate1" type="text" name="scroller" placeholder="请选择" readonly="" value="${eventBeginDateTime }">
                          				<p class="fenge"></p>
                          				<input class="edit-ipt-r edit-ipt-arrow" <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="endDate1"</c:if> name="endDate1" type="text" name="scroller" placeholder="请选择" readonly="" value="${eventEndDateTime }">
                        			</div>
                        			<div class="zhi">
                          				<span>至</span>
                        			</div>
                      			</td>
                    		</tr>
                    	</c:otherwise>
                    </c:choose>
  
                    <tr>
                      <td>提醒：</td>
                      <td class="">
                      	<c:choose>
                      		<c:when test="${eventRemind == '1'}">
                      			<div <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="Remind"</c:if> class="pick-div"><span></span></div>
                        		<input type="hidden" id="eventRemind" name="eventRemind" value="1">
                      		</c:when>
                      		<c:otherwise>
                      			<div <c:if test="${eventIsDRrc == '0' && isme == '1'}">id="Remind"</c:if> class="pick-div pick-div-close"><span></span></div>
                        		<input type="hidden" id="eventRemind" name="eventRemind" value="0">
                      		</c:otherwise>
                      	</c:choose>
                      </td>
                    </tr>
                    <tr>
                      <td>受邀人：</td>
                      <td>
                      	<span class="fr" style="float:left" <c:if test="${eventIsDRrc == '0' && isme == '1'}">onclick="$(this).next('input').click()"</c:if>  id="shouyaoren">${attend }</span>
	                    <input <c:if test="${eventIsDRrc == '0' && isme == '1'}">onclick="selectUser('1','attend','attendId','*0*');"</c:if> class="edit-ipt-r edit-ipt-arrow" type="text" value="${attend }" readonly id="attend" name="attend" <c:if test="${attend != ''}">style="display: none"</c:if> />
	                    <input type="hidden" name="attendId" id="attendId" value="${attendId }"/>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2">内容：</td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <div class="edit-txta-box">
                          <textarea style="height:6.5rem;" class="edit-ipt-r edit-ipt-arrow" id="eventContent" type="text" name="eventContent" <c:if test="${eventIsDRrc != '0' || isme != '1'}">readonly="readonly"</c:if> >${eventContent }</textarea>
                        </div>
                      </td>
                    </tr>
                    <tr id="shouyao1">
                      <td colspan="2">受邀状况：</td>
                    </tr>
                    <tr id="shouyao2">
                      <td colspan="2">
                        <div class="invite-state"> 
                          <ul id="receiptUl">
                            
                          </ul>
                          <aside class="wh-load-box infinite-scroll-top" style="display: none">
		          			<div class="wh-load-tap" id="daysh" style="display:none">上滑加载更多</div>
		            		<div class="wh-load-md" id="dayNext">
		            			<span></span>
		               			<span></span> 
		               			<span></span>
		               			<span></span>
		               			<span></span>
		             			</div>
		    	  		  </aside>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
                </form>
              </div>
            </article>
          </section>
          <footer class="wh-footer wh-footer-forum" id="footerButton">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix" id="edit">
                  	<c:choose>
                  		<c:when test="${eventIsDRrc == '0'}">
                  			<c:choose>
                  				<c:when test="${isme == '1'}">
                  					<a href="javascript:updateMyEvent();" class="panel-send-a">修改</a>
                    				<a href="javascript:deleteMyEvent();" class="panel-send-a">删除</a>
                    				<a href="javascript:exit();" class="panel-send-a">退出</a>
                  				</c:when>
			                  	<c:when test="${eventStatus == '2'}">
			                    	<a href="javascript:acceptMyEvent(${eventId },'1');" class="panel-send-a">接受</a>
			                    	<a href="javascript:probablyMyEvent(${eventId },'2');" id="probably" class="panel-send-a" style="background: #3eaeff;color: beige;">可能</a>
			                    	<a href="javascript:refuseMyEvent(${eventId },'3');" class="panel-send-a">拒绝</a>
			                    </c:when>
			                    <c:when test="${eventStatus == '4'}">
			                    	<a href="javascript:acceptMyEvent(${eventId },'1');" class="panel-send-a">接受</a>
			                    	<a href="javascript:probablyMyEvent(${eventId },'2');" id="probably" class="panel-send-a" >可能</a>
			                    	<a href="javascript:refuseMyEvent(${eventId },'3');" class="panel-send-a">拒绝</a>
			                    </c:when>
			                    <c:otherwise>
			                    	<a href="javascript:exit();" class="panel-send-a">退出</a>
			                    </c:otherwise>
                  			</c:choose>
                  		</c:when>
                  		<c:otherwise>
                  			<a href="javascript:exit();" class="panel-send-a">退出</a>
                  		</c:otherwise>
                  	</c:choose>
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
  </c:when>
  <c:otherwise>
  	<script>
 		wx.ready(function(){
	 		myApp.alert('该日程已被撤回或删除！');
	 		wx.closeWindow();
 		});
 	</script>
  </c:otherwise>
</c:choose>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript">
	var myApp = new Framework7({
		fastClicks: false,
  	});
	var mainView = myApp.addView('.view');
	var $$ = Dom7;
	
	var createEmpId = '${createEmpId}';//日程创建人id
	
	$(function(){
		//进入详情页 加载回执列表数据
		var eventId = '${eventId}';
		var currentPage = 1;
		var eventStatus = '${eventStatus}';
		if(eventStatus == '1'){
			ajaxGetReceiptList(eventId,currentPage,0);
		}else{
			$("#shouyao1").css("display","none");
			$("#shouyao2").css("display","none");
		}
		
	});
	
	function ajaxGetReceiptList(eventId,currentPage,stausFlag){
		$.ajax({
	    	url : '/defaultroot/eventManages/getReceiptList.controller?eventId='+eventId+"&currentPage="+currentPage+"&createEmpId="+createEmpId,
	    	type : 'post',
	    	success : function(data){
	    		if(!data){
        			return;
        		}
        		var jsonData = eval("("+data+")");
        		if(!jsonData){
        			return;
        		}
        		var receiptList = jsonData.data0;
				var html = '';
				if(receiptList.length > 0){
					for(var i = 0;i<receiptList.length;i++){
						var eventsszzname = receiptList[i].eventsszzname;//组织名称
						var eventcyrname = receiptList[i].eventcyrname;//姓名
						var eventhzdate = receiptList[i].eventhzdate;//回执日期
						var eventstatus = receiptList[i].eventstatus;//回执状态
						
						var a = '';
						if(eventstatus == '1'){
							a = "<span class='state'>接受</span>";
						}else if(eventstatus == '2'){
							a = "<span class='state'>可能</span>";
						}else if(eventstatus == '3'){
							a = "<span class='state'>拒绝</span>";
						}else{
							a = "<span class='state'>待定</span>";
						}
						
						var arr = eventsszzname.split(".");
						eventsszzname = arr[arr.length-1];
						
						html += "<li>";
						html += "<p class='clearfix'><span class='pp-name'>" + eventsszzname + "&nbsp;" + eventcyrname + "</span>" + a + "</p>";
						html += "<p class='clearfix'><span class='time'>" + eventhzdate + "</span></p>";
						html += "</li>";
					}
					if(stausFlag == 0){
						$("#receiptUl").html(html);
					}else{
						$("#receiptUl").append(html);
					}
				}else{
					$("#shouyao1").css("display","none");
					$("#shouyao2").css("display","none");
				}
	    	},
	    	error : function(){
    			myApp.alert('加载回执情况列表数据操作异常！');
	    	}
	    });
	}
	
	
	
	var loading = false;
	//修改我的日程    不定期事件
    function updateMyEvent(){
		if(loading){
			return;
		}
    	if(!checkForm()){
	    	return;
	    }
		loading = true;
		ajaxSendMyEvent();
    }
	function ajaxSendMyEvent(){
		$.ajax({
	    	url : '/defaultroot/eventManages/updateMyEventNoRegular.controller',
	    	data : $('#sendForm').serialize(),
	    	type : 'post',
	    	success : function(data){
	    		if(!data){
	    			myApp.alert('修改失败，无返回数据！');
	    		}
	    		var json = eval("("+data+")");
	    		if(json.result == 'fail'){
	    			myApp.alert('修改失败！');
	    		}else if(json.result == 'success'){
	    			myApp.alert('修改成功！', function () {
        				window.history.back();
    				});
	    		}
	    	},
	    	error : function(){
	    		//openTipsDialog('邮件发送异常！','',1000);
    			myApp.alert('修改我的日程不定期出现异常！');
	    	}
	    });
	}
	//校验表单
    function checkForm(){
    	var eventTitle = $("#eventTitle").val();
    	if(!eventTitle){
    		myApp.alert('请输入主题！');
    		return false;
    	}
    	if(eventTitle.replace(/\s/g,"") == ""){
			myApp.alert('主题不能为空！');
			return false;
		}
		if(/[\\\/?#&'"]+/g.test(eventTitle)){
			myApp.alert('主题不可以包含特殊字符！');
			return false;
		}
		return true;
    }
	
	//删除日程
	function deleteMyEvent(){
		var eventId = $("#eventId").val();
		var eventTBID = '${eventTBID}';
		$.ajax({
	    	url : '/defaultroot/eventManages/deleteMyEvent.controller?eventId=' + eventId + '&eventTBID=' + eventTBID,
	    	type : 'post',
	    	success : function(data){
	    		if(!data){
	    			myApp.alert('删除失败，无返回数据！');
	    		}
	    		var json = eval("("+data+")");
	    		if(json.result == 'fail'){
	    			myApp.alert('删除失败！');
	    		}else if(json.result == 'success'){
	    			myApp.alert('删除成功！', function () {
        				window.history.back();
    				});
	    		}
	    	},
	    	error : function(){
	    		//openTipsDialog('邮件发送异常！','',1000);
    			myApp.alert('删除我的日程不定期出现异常！');
	    	}
	    });
	}
	
	//退出
	function exit(){
		window.history.back();
	}
	
	//接受
	function acceptMyEvent(eventId,eventStatus){
		$.ajax({
	    	url : '/defaultroot/eventManages/receiptOperation.controller?eventId='+eventId+"&eventStatus="+eventStatus,
	    	type : 'post',
	    	success : function(data){
	    		if(!data){
	    			myApp.alert('回执接受失败，无返回数据！');
	    		}
	    		var json = eval("("+data+")");
	    		if(json.result == 'fail'){
	    			myApp.alert('回执接受失败！');
	    		}else if(json.result == 'success'){
	    			myApp.alert('回执接受成功！', function () {
        				$("#shouyao1").css("display","table-row");
						$("#shouyao2").css("display","table-row");
						ajaxGetReceiptList(eventId,1,0);
						var html = '<a href="javascript:exit();" class="panel-send-a">退出</a>';
						$('#edit').html(html);
    				});
	    		}
	    	},
	    	error : function(){
    			myApp.alert('执行接受操作产生数据异常！');
	    	}
	    });
	}
	
	//可能
	function probablyMyEvent(eventId,eventStatus){
		$.ajax({
	    	url : '/defaultroot/eventManages/receiptOperation.controller?eventId='+eventId+"&eventStatus="+eventStatus,
	    	type : 'post',
	    	success : function(data){
	    		if(!data){
	    			myApp.alert('回执可能失败，无返回数据！');
	    		}
	    		var json = eval("("+data+")");
	    		if(json.result == 'fail'){
	    			myApp.alert('回执可能失败！');
	    		}else if(json.result == 'success'){
	    			myApp.alert('回执可能成功！', function () {
        				$("#probably").css("background","#3eaeff");
						$("#probably").css("color","beige");
    				});
	    		}
	    	},
	    	error : function(){
    			myApp.alert('执行接受操作产生数据异常！');
	    	}
	    });
	}
	
	//拒绝
	function refuseMyEvent(eventId,eventStatus){
		$.ajax({
	    	url : '/defaultroot/eventManages/receiptOperation.controller?eventId='+eventId+"&eventStatus="+eventStatus,
	    	type : 'post',
	    	success : function(data){
	    		if(!data){
	    			myApp.alert('回执拒绝失败，无返回数据！');
	    		}
	    		var json = eval("("+data+")");
	    		if(json.result == 'fail'){
	    			myApp.alert('回执拒绝失败！');
	    		}else if(json.result == 'success'){
	    			myApp.alert('回执拒绝成功！', function () {
        				window.history.back();
    				});
	    		}
	    	},
	    	error : function(){
    			myApp.alert('执行接受操作产生数据异常！');
	    	}
	    });
	}
	
	
	
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		myApp.showPreloader('正在加载中...');
		//处理$id1$$id2$  这种格式的   id串
		var selectIdVal = $('#'+selectId).val()
		if(selectIdVal.indexOf('$') != -1){
			var selectIdArray = selectIdVal.split('$');
			if(selectIdArray){
				selectIdVal = '';
				for(var i=0,length=selectIdArray.length;i<length;i++){
					if(selectIdArray[i]){
						selectIdVal += selectIdArray[i] + ',';
					}
				}
			}
		}
		
		$.ajax({
			url : '/defaultroot/newperson/personList.controller',
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':selectIdVal,'range':range},
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
	
	//选择人员
	function selectCallBack(input){
		if( $(input).val() != ""){
			$(input).prev('span').html($(input).val());
			$(input).hide();
		}else{
			$(input).prev('span').html($(input).val());
			$(input).show();
		}
	}
	
	//公开，私密  操作
	function openA(){
		$$("#private").removeClass("read-clock");
		$$("#open").addClass("read-clock");
		$$("#eventAttr").val("1");
	}
	function privateA(){
		$$("#open").removeClass("read-clock");
		$$("#private").addClass("read-clock");
		$$("#eventAttr").val("0");
	}
	
	//全天事件按钮
	$$("#pick-div").click(function(){
		if($$(this).hasClass("pick-div-close")){
			$$(this).removeClass("pick-div-close");
			$$("#eventFullDay").val("1");
			$('#DateTime').css("display","none");
			$("#Date").css("display","table-row");
		}else{
			$$(this).addClass("pick-div-close");
			$$("#eventFullDay").val("0");
			$('#DateTime').css("display","table-row");
			$("#Date").css("display","none");
		}
	})


	//提醒按钮
	$$("#Remind").click(function(){
		if($$(this).hasClass("pick-div-close")){
			$$(this).removeClass("pick-div-close");
			$("#eventRemind").val("1");
		}else{
			$$(this).addClass("pick-div-close");
			$("#eventRemind").val("0");
		}
	})

//普通仿原生下拉选单，根据需要设置选项文字是否居中
var pickerAuto = myApp.picker({
    input: '#picker-auto',
    cols: [
        {            
            values: ['提前15分钟', '提前30分钟', '提前40分钟']
        }
    ]
})


//日期选择器
var today = new Date();
var startDate = myApp.picker({
    input: '#startDate',
    toolbarTemplate:
        '<div class="toolbar">' +
            '<div class="toolbar-inner">' +
                '<div class="left">' +
                    '<a href="#" class="link reset-picker">重设</a>'+
                '</div>'+
                '<div class="right">' +
                    '<a href="#" class="link close-picker">完成</a>' +
                '</div>' +
            '</div>' +
        '</div>',

    //当触发的时候
    onOpen: function(picker, values, displayValues){
        var todayArr = [today.getFullYear(), today.getMonth()+1, today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
        picker.setValue(todayArr);
        picker.container.find('.reset-picker').on('click', function (){
            picker.setValue(todayArr);
        })
    },
    onChange: function (picker, values, displayValues) {
        //获取当前月份的总天数
        var daysInMonth = new Date(picker.value[0], picker.value[1]*1, 0).getDate();
        //如果设置月数大于当前月的总天数，设置天数为总天数
        if (values[2] > daysInMonth) {
            picker.cols[2].setValue(daysInMonth);
        }
    },
    //返回给input的格式，“-” 可以换成“年月日”
    formatValue: function (p, values, displayValues) {
        return values[0] + '-' + values[1] + '-' + values[2] + ',' + values[3] + ':' + values[4];
    },
    //返回 value数组
    cols: [
        // 年
        {
            values: (function () {
                var arr = [];
                for (var i = 1990; i <= 2030; i++) { arr.push(i); }
                return arr;
            })(),
        },
        // 月
        {
            values: [01,02,03,04,05,06,07,08,09,10,11,12],
        },
        // 日
        {
            values: [01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],
        },
        // 空格
        {
            divider: true,
            content: ' '
        },
        // 时
        {
            values: (function () {
                var arr = [];
                for (var i = 0; i <= 23; i++) { arr.push(i); }
                return arr;
            })(),
        },
        // 冒号
        {
            divider: true,
            content: ':'
        },
        // 分
        {
            values: (function () {
                var arr = [];
                for (var i = 0; i <60; i=i+5) { arr.push(i < 10 ? '0' + i : i); }
                return arr;
            })(),
        }
    ]
});

var endDate = myApp.picker({
    input: '#endDate',
    toolbarTemplate:
        '<div class="toolbar">' +
            '<div class="toolbar-inner">' +
                '<div class="left">' +
                    '<a href="#" class="link reset-picker">重设</a>'+
                '</div>'+
                '<div class="right">' +
                    '<a href="#" class="link close-picker">完成</a>' +
                '</div>' +
            '</div>' +
        '</div>',

    //当触发的时候
    onOpen: function(picker, values, displayValues){
        var todayArr = [today.getFullYear(), today.getMonth()+1, today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
        picker.setValue(todayArr);
        picker.container.find('.reset-picker').on('click', function (){
            picker.setValue(todayArr);
        })
    },
    onChange: function (picker, values, displayValues) {
        //获取当前月份的总天数
        var daysInMonth = new Date(picker.value[0], picker.value[1]*1, 0).getDate();
        //如果设置月数大于当前月的总天数，设置天数为总天数
        if (values[2] > daysInMonth) {
            picker.cols[2].setValue(daysInMonth);
        }
    },
    //返回给input的格式，“-” 可以换成“年月日”
    formatValue: function (p, values, displayValues) {
        return values[0] + '-' + values[1] + '-' + values[2] + ',' + values[3] + ':' + values[4];
    },
    //返回 value数组
    cols: [
        // 年
        {
            values: (function () {
                var arr = [];
                for (var i = 1990; i <= 2030; i++) { arr.push(i); }
                return arr;
            })(),
        },
        // 月
        {
            values: [01,02,03,04,05,06,07,08,09,10,11,12],
        },
        // 日
        {
            values: [01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],
        },
        // 空格
        {
            divider: true,
            content: ' '
        },
        // 时
        {
            values: (function () {
                var arr = [];
                for (var i = 0; i <= 23; i++) { arr.push(i); }
                return arr;
            })(),
        },
        // 冒号
        {
            divider: true,
            content: ':'
        },
        // 分
        {
            values: (function () {
                var arr = [];
                for (var i = 0; i <60; i=i+5) { arr.push(i < 10 ? '0' + i : i); }
                return arr;
            })(),
        }
    ]
});


var startDate1 = myApp.picker({
    input: '#startDate1',
    toolbarTemplate:
        '<div class="toolbar">' +
            '<div class="toolbar-inner">' +
                '<div class="left">' +
                    '<a href="#" class="link reset-picker">重设</a>'+
                '</div>'+
                '<div class="right">' +
                    '<a href="#" class="link close-picker">完成</a>' +
                '</div>' +
            '</div>' +
        '</div>',

    //当触发的时候
    onOpen: function(picker, values, displayValues){
        var todayArr = [today.getFullYear(), today.getMonth()+1, today.getDate()];
        picker.setValue(todayArr);
        picker.container.find('.reset-picker').on('click', function (){
            picker.setValue(todayArr);
        })
    },
    onChange: function (picker, values, displayValues) {
        //获取当前月份的总天数
        var daysInMonth = new Date(picker.value[0], picker.value[1]*1, 0).getDate();
        //如果设置月数大于当前月的总天数，设置天数为总天数
        if (values[2] > daysInMonth) {
            picker.cols[2].setValue(daysInMonth);
        }
    },
    //返回给input的格式，“-” 可以换成“年月日”
    formatValue: function (p, values, displayValues) {
        return values[0] + '-' + values[1] + '-' + values[2];
    },
    //返回 value数组
    cols: [
        // 年
        {
            values: (function () {
                var arr = [];
                for (var i = 1990; i <= 2030; i++) { arr.push(i); }
                return arr;
            })(),
        },
        // 月
        {
            values: [01,02,03,04,05,06,07,08,09,10,11,12],
        },
        // 日
        {
            values: [01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],
        }
    ]
});

var endDate1 = myApp.picker({
    input: '#endDate1',
    toolbarTemplate:
        '<div class="toolbar">' +
            '<div class="toolbar-inner">' +
                '<div class="left">' +
                    '<a href="#" class="link reset-picker">重设</a>'+
                '</div>'+
                '<div class="right">' +
                    '<a href="#" class="link close-picker">完成</a>' +
                '</div>' +
            '</div>' +
        '</div>',

    //当触发的时候
    onOpen: function(picker, values, displayValues){
        var todayArr = [today.getFullYear(), today.getMonth()+1, today.getDate()];
        picker.setValue(todayArr);
        picker.container.find('.reset-picker').on('click', function (){
            picker.setValue(todayArr);
        })
    },
    onChange: function (picker, values, displayValues) {
        //获取当前月份的总天数
        var daysInMonth = new Date(picker.value[0], picker.value[1]*1, 0).getDate();
        //如果设置月数大于当前月的总天数，设置天数为总天数
        if (values[2] > daysInMonth) {
            picker.cols[2].setValue(daysInMonth);
        }
    },
    //返回给input的格式，“-” 可以换成“年月日”
    formatValue: function (p, values, displayValues) {
        return values[0] + '-' + values[1] + '-' + values[2];
    },
    //返回 value数组
    cols: [
        // 年
        {
            values: (function () {
                var arr = [];
                for (var i = 1990; i <= 2030; i++) { arr.push(i); }
                return arr;
            })(),
        },
        // 月
        {
            values: [01,02,03,04,05,06,07,08,09,10,11,12],
        },
        // 日
        {
            values: [01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],
        }
    ]
});
  </script>
</body>
</html>                                                                  