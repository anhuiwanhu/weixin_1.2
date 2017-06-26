<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="/clientview/common/headerInit.jsp" %>
<%
String pageId = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("pageId"));
String processId = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("processId"));
String process_type = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("process_type"));
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
%>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title><c:out value='${param.processName}' escapeXml='false'/></title>
</head>

<body class="grey-bg">
	<!-- 选人div -->
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
	<!-- 选人divover -->
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-form-edit">
          <section class="wh-section wh-section-bottomfixed" id="mainContent">
            <div class="webapp-form">
              <div class="form-table">
              <form id="sendForm" class="dialog"  method="post">
              	<input type="hidden" id="process_type" name="process_type" value="<c:out value='${param.process_type}' escapeXml='false'/>"/>
				<input  id="processId" type="hidden"  name="processId" value="<%=processId%>" />
                <table style="border-collapse:separate;border-spacing: 0 10px;">
                <c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
				<x:forEach select="$doc//fieldList/field" var="fd" >
         			<c:set var="voitureName"><x:out select="$fd/voitureName/text()"/></c:set>
         			<c:set var="orgName"><x:out select="$fd/orgName/text()"/></c:set>
         			<c:set var="empName"><x:out select="$fd/empName/text()"/></c:set>
         			<c:set var="destination"><x:out select="$fd/destination/text()"/></c:set>
         			<c:set var="personNum"><x:out select="$fd/personNum/text()"/></c:set>
         			<c:set var="genchePerson"><x:out select="$fd/genchePerson/text()"/></c:set>
         			<c:set var="motorMan"><x:out select="$fd/motorMan/text()"/></c:set>
         			<c:set var="startDate"><x:out select="$fd/startDate/text()"/></c:set>
         			<c:set var="endDate"><x:out select="$fd/endDate/text()"/></c:set>
         			<c:set var="voitureStyle"><x:out select="$fd/voitureStyle/text()"/></c:set>
         			<c:set var="reason"><x:out select="$fd/reason/text()"/></c:set>
         			<c:set var="remark"><x:out select="$fd/remark/text()"/></c:set>
         			<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
                   <!-- 申请车辆名称 -->
            		<c:if test="${voitureName !='null' && voitureName !=''}">
						<tr>
							<td><span><em>*</em>${voitureName}：</span></td>
							<td>
								<div class="edit-direct">
									<div class="edit-sel-show">
										<span>请选择</span>
									</div>    
									<select onchange="setCar(this);" class="btn-bottom-pop" name='voitureName' id='voitureName'>
										<option value="">请选择</option>
										<x:forEach select="$fd/dataList/val" var="selectvalue" >
											<option value='<x:out select="$selectvalue/motorMan/text()"/>,<x:out select="$selectvalue/hiddenval/text()"/>' >
												<x:out select="$selectvalue/showval/text()"/>
											</option>
										</x:forEach>
									</select>
								</div>
								<input type="hidden" id="voitureId" name="voitureId"/>
							</td>
						</tr>
					</c:if>
					<!-- 申请部门名称 -->
            		<c:if test="${orgName !='null' && orgName !=''}">
						<tr>
							<td><span>${orgName}</span>：</td>
							<td>
							  <div>
								<input type="hidden" readonly="readonly" id='orgId' name='orgId' value='<x:out select="$fd/hiddenval/text()"/>' />
			           			<input type="text"   readonly="readonly" id='orgName'  name='orgName' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","orgName","orgId","*0*","org");' placeholder="请选择"/>
			           		  </div>
							</td>
						</tr>
					</c:if>
					<!-- 申请人名称 -->
					<c:if test="${empName !='null' && empName !=''}">
						<tr>
							<td><span><em>*</em>${empName}：</span></td>
							<td>
							   <div>
								<input type="hidden" readonly="readonly" id='empId' name='empId' value='<x:out select="$fd/hiddenval/text()"/>,' />
			           			<input type="text"   readonly="readonly" id='empName' name='empName' value='<x:out select="$fd/value/text()"/>,' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","empName","empId","*0*","user")' placeholder="请选择"/>
			           		   </div>
							</td>
						</tr>
					</c:if>
					<!-- 目的地 -->
					<c:if test="${destination !='null' && destination !=''}">
						<tr>
							<td><span>${destination}</span>：</td>
							<td>
								<div>
									<input class="edit-ipt-r" placeholder="请输入" id="destination"  type="text" maxlength="30" name='destination'/>
								</div>
							</td>
						</tr>
					</c:if>
					<!-- 跟车人数 -->
					<c:if test="${personNum !='null' && personNum !=''}">
						<tr>
							<td><span>${personNum}</span>：</td>
							<td>
								<div>
									<input class="edit-ipt-r" placeholder="请输入"  type="text" maxlength="3" name='personNum' id='personNum'  oninput="value=value.replace(/[^\d]/g,'')"/>
								</div>
							</td>
						</tr>
					</c:if>
					<!-- 跟车人 -->
					<c:if test="${genchePerson !='null' && genchePerson !=''}">
						<tr>
							<td><span>${genchePerson}</span>：</td>
							<td>
								<div>
									<input class="edit-ipt-r" placeholder="请输入"  type="text" maxlength="100" name='genchePerson' id="genchePerson"/>
								</div>
							</td>
						</tr>
					</c:if>
					<!-- 司机 -->
					<c:if test="${motorMan !='null' && motorMan !=''}">
						<tr>
							<td><span>${motorMan}</span>：</td>
							<td>
								<div>
									<input class="edit-ipt-r" placeholder="请输入"  type="text" maxlength="20" name='motorMan' id='motorMan'/>
								</div>
							</td>
						</tr>
					</c:if>
					 <!-- 预计用车开始时间 -->
					 <c:if test="${startDate !='null' && startDate !=''}">
						<tr>
							<td><span><em>*</em>预计用车开始时间：</span></td>
							<td>
								<div class="edit-ipt-a-arrow">
									<input  class="edit-ipt-r edit-ipt-arrow" type="text" id='startDateTime' name='startDateTime' onfocus="selectDateTimeNew(this)" placeholder="选择日期时间"/>
									<label class="edit-ipt-label" for="scroller"></label>
								</div>
							</td>
						</tr>
					</c:if>
					<!-- 预计用车结束时间 -->
					<c:if test="${endDate !='null' && endDate !=''}">
						<tr>
							<td><span><em>*</em>预计用车结束时间：</span></td>
							<td>
								<div class="edit-ipt-a-arrow">
								<input  class="edit-ipt-r edit-ipt-arrow" type="text" id='endDateTime' name='endDateTime' onfocus="selectDateTimeNew(this)" placeholder="选择日期时间"/>
							    <label class="edit-ipt-label" for="scroller"></label>
							    </div>
							</td>
						</tr>
					</c:if>
					<!-- 用车类型 -->
					<c:if test="${voitureStyle !='null' && voitureStyle !=''}">
						<tr>
							<td><span>${voitureStyle}</span>：</td>
							<td>
								<div class="edit-direct">
									<div class="edit-sel-show">
										<span>普通用车</span>
									</div>    
									<select onchange="setSpanHtml(this);" name='voitureStyle' id ='voitureStyle' class="btn-bottom-pop">
										<x:forEach select="$fd/dataList/val" var="selectvalue" >
											<c:set var ="selFlag"><x:out select="$selectvalue/showval/text()"/></c:set>
											<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selFlag == '普通用车'}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
										</x:forEach>
									</select>
								</div>
							</td>
						</tr>
					</c:if>
					<!-- 事由 -->
					<c:if test="${reason !='null' && reason !=''}">
						<tr>
							<td><span>${reason}</span>：</td>
							<td>
								<div>
									<textarea name='reason' id='reason'  placeholder="请填写"  class="edit-txta edit-txta-l" maxlength="300"></textarea>
								</div>
							</td>
						</tr>
					</c:if>
					<!-- 备注 -->
					<c:if test="${remark !='null' && remark !=''}">
						<tr>
							<td><span>${remark}</span>：</td>
							<td>
								<div>
								<textarea name='remark' id='remark' placeholder="请填写"  class="edit-txta edit-txta-l" maxlength="300"></textarea>
								</div>
							</td>
						</tr>
					</c:if>
                  </x:forEach>
              </c:if>
              </table>
              </form>
              </div>
            </div>
          </section>
          <footer class="wh-footer wh-footer-forum" id="footerButton">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix">
                    <a href="javascript:formCheck();">发送</a>
                  </div> 
                </div>
              </div>
            </div>
          </footer>
          <section id="selectContent" style="display:none">
		  </section>
		  <jsp:include page="../common/include_workflow_subTable.jsp" flush="true">
			 <jsp:param name="docXml" value="${docXml}" />
			 <jsp:param name="orgId" value="<%=orgId %>" />
		  </jsp:include>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/common.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/touch.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/fx.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/swiper/swiper.min.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/selector.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/mobiscroll/mobiscroll.zepto.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/mobiscroll/mobiscroll.core.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/mobiscroll/mobiscroll.scroller.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/mobiscroll/mobiscroll.datetime.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/mobiscroll/mobiscroll.select.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/followskip/followskip.js"></script>
 <script type="text/javascript">
 	 var myApp = new Framework7();
 	 var $$ = Dom7;
 	//设置车辆id和司机
	function setCar(obj,selectVal){
		var selVal = $(obj).find("option:selected").val();
		if(selVal==''){
			$('#motorMan').val('');
			$('#voitureId').val('');
		}else{
			var selVals = selVal.split(",");
			$('#motorMan').val(selVals[0]);
			$('#voitureId').val(selVals[1]);
		}
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	} 

	//设置span中的值
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	} 
	
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range,listType){
		var selectIdVal = $('input[id="'+selectId+'"]').val();
		if( selectIdVal.indexOf(";") > 0 ){
			var selectIdArray = selectIdVal.split(';');
			selectIdVal = selectIdArray[1];
		}
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
		var postUrl = '';
		if(listType == 'org'){
			postUrl = '/defaultroot/newperson/orgList.controller';
		}else if(listType=='user'){
			postUrl = '/defaultroot/newperson/personList.controller';
		}
		$.ajax({
			url : postUrl,
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('input[id="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$("#selectContent").append(data);
				hiddenContent(0);
			}
		});
	}
	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag == 0){
			if($('#mainContent').is(':hidden')){
				$('[id="subHeader_'+subTableName+'"]').hide();
				$('[id="subSection_'+subTableName+'"]').hide();
				$('[id="subFooter_'+subTableName+'"]').hide();
				$('[id="subHeader_'+subTableName+'"]').data('hide','1');
			}else{
				$("#mainContent").css("display","none");
				$("#footerButton").css("display","none");
			}
			$("#selectContent").css("display","block");
		}else if(flag == 1){
			if($('[id="subHeader_'+subTableName+'"]') && $('[id="subSection_'+subTableName+'"]').is(':hidden') 
					&& $('[id="subHeader_'+subTableName+'"]').data('hide') == '1'){
				$('[id="subHeader_'+subTableName+'"]').data('hide','0');
				$('#selectContent').hide();
				$('[id="subHeader_'+subTableName+'"]').show();
				$('[id="subSection_'+subTableName+'"]').show();
				$('[id="subFooter_'+subTableName+'"]').show();
			}else{
				$("#selectContent").css("display","none");
				$("#mainContent").css("display","block");
				$("#footerButton").css("display","block");
			}
			$("#selectContent").empty();
		}
	}
	
	//日期时分选择器
  function selectDateTimeNew(obj){
	  var myApp = new Framework7();//设成全局变量会影响附件上传
	  var id = obj.id;
	  var today = new Date();
	  var pickerDate = myApp.picker({
		input: "#"+id,
		toolbarTemplate: '<div class="toolbar">' +
		  '<div class="toolbar-inner">' +
		  '<div class="left">' +
		  '<a href="#" class="link reset-picker">重设</a>' +
		  '</div>' +
		  '<div class="right">' +
		  '<a href="#" class="link close-picker">完成</a>' +
		  '</div>' +
		  '</div>' +
		  '</div>',

		//当触发的时候
		onOpen: function(picker, values, displayValues) {
		  //var todayArr = [today.getFullYear(), today.getMonth()+1, today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
		  var todayArr = [today.getFullYear(), (today.getMonth()+1 < 10 ? '0' + today.getMonth()+1 : today.getMonth()+1), (today.getDate() < 10 ? '0' + today.getDate() : today.getDate()), (today.getHours() < 10 ? '0' + today.getHours() : today.getHours()), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
		  picker.setValue(todayArr);
		  picker.container.find('.reset-picker').on('click', function() {
			picker.setValue(todayArr);
		  })
		},
		onChange: function(picker, values, displayValues) {
		  //获取当前月份的总天数
		  var daysInMonth = new Date(picker.value[0], picker.value[1] * 1, 0).getDate();
		  //如果设置月数大于当前月的总天数，设置天数为总天数
		  if (values[2] > daysInMonth) {
			picker.cols[2].setValue(daysInMonth);
		  }
		},
		//返回给input的格式，“-” 可以换成“年月日”
		formatValue: function(p, values, displayValues) {
		  return values[0] + '-' + values[1] + '-' + values[2] + ',' + values[3] + ':' + values[4];
		},
		//返回 value数组
		cols: [
		  // 年
		  {
			values: (function() {
			  var arr = [];
			 var date = new Date();
			 newYear = date.getFullYear() + 15;
			  for (var i = 1990; i <= newYear; i++) {
				arr.push(i);
			  }
			  return arr;
			})(),
		  },
		  // 月
		  {
			values: ['0'+1, '0'+2, '0'+3, '0'+4, '0'+5, '0'+6, '0'+7, '0'+8, '0'+9, 10, 11, 12],
		  },
		  // 日
		  {
			values: ['0'+1, '0'+2, '0'+3, '0'+4, '0'+5, '0'+6, '0'+7, '0'+8, '0'+9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
		  },
		  // 空格
		  {
			divider: true,
			content: ' '
		  },
		  // 时
		  {
			values: (function() {
			  var arr = [];
			  for (var i = 0; i <= 23; i++) {
				arr.push(i < 10 ? '0' + i : i);
			  }
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
			values: (function() {
			  var arr = [];
			  for (var i = 0; i <= 59; i++) {
				arr.push(i < 10 ? '0' + i : i);
			  }
			  return arr;
			})(),
		  }
		]
	  });
  }
	//表单必填项验证
    function formCheck(){
    	if($('#voitureId').val() == ''){
    		myApp.alert("请选择车辆！");
    		return false;
    	}
    	if($('#empId').val() == ''){
    		myApp.alert("申请人不能为空！");
    		return false;
    	}
    	if($('#startDateTime').val() == ''){
    		myApp.alert("开始时间不能为空！");
    		return false;
    	}
    	if($('#endDateTime').val() == ''){
    		myApp.alert("结束时间不能为空！");
    		return false;
    	}
    	var checkDatetime = checkDate($('#startDateTime').val(),$('#endDateTime').val());
    	if(checkDatetime >= 0){
    		myApp.alert("开始时间要在结束时间之前！");
    		return false;
    	}
		var checkOk = '';
		var checkUrl = '/defaultroot/workflow/checkVoitureApplyed.controller';
		var voitureId = $('#voitureId').val();
		var startDateTime = $('#startDateTime').val();
		var endDateTime = $('#endDateTime').val();
		$.ajax({
			url : checkUrl,
			type : "post",
			data : 'voitureId='+voitureId+'&startDateTime='+startDateTime+'&endDateTime='+endDateTime,
			success : function(data){
				if(data=='0'){
					myApp.alert("您申请的车辆在此时间段已被占用！");
				}else{
					$('#empId').val($('#empId').val().replace(',',''));
					$('#empName').val($('#empName').val().replace(',',''));
					sendFlow();
				}
			}
		});
    }
    
    //提交表单
	var flag = 1;
	function sendFlow(){
		//防止重复提交
		if(flag == 0){
    		return;
    	}
    	flag = 0;
		var url = '/defaultroot/workflow/sendVoitureApply.controller';
		$.ajax({
			url : url,
			type : "post",
			data : $('#sendForm').serialize(),
			success : function(infoId){
				openNextPage(infoId);
			}
		});
	}
    
    //流程开始
	function openNextPage(infoId){
		var processId = $('#processId').val();
		var mainLinkFile = '/defaultroot/voitureApply!modi.action';
		var process_type = '${param.process_type}';
		var openUrl = '';
		if(process_type=='0'){
			openUrl='/defaultroot/workflow/sendFlow.controller?mainLinkFile='+mainLinkFile+'&infoId='+infoId+'&processId='+processId;
		}else{
			openUrl='/defaultroot/workflow/sendezFlow.controller?mainLinkFile='+mainLinkFile+'&infoId='+infoId+'&processId='+processId;
		}
		window.location = openUrl;
	}
	
	function checkDate(d1,d2){
	  return ((new Date(d1.replace(/-/g,"\/"))) - (new Date(d2.replace(/-/g,"\/"))));
	}
 </script>
</body>
</html>
