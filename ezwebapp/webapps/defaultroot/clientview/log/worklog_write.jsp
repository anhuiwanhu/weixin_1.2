<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ include file="../common/headerInit.jsp" %>
		
<%
	String loadFlag =  com.whir.component.security.crypto.EncryptUtil.sqlcode(com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("loadFlag")));
	String logType =  com.whir.component.security.crypto.EncryptUtil.sqlcode(com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("logType")));
 %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1">
  <title>填写日志</title>
  <link rel="stylesheet" href="/defaultroot/clientview/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/frameworktemplate/css/template.style.colors.min.css" />
</head>
<body class="theme-green">
<c:if test="${not empty docXml}">
 <x:parse xml="${docXml}" var="doc"/>
 <c:set var="logId"><x:out select="$doc//logDetail/id/text()"/></c:set>
 <c:set var="weather"><x:out select="$doc//logDetail/weather/text()"/></c:set>
 <c:set var="logDate"><x:out select="$doc//logDetail/logDate/text()"/></c:set>
 <c:set var="logType"><x:out select="$doc//logDetail/logType/text()"/></c:set>
 <c:set var="workTime"><x:out select="$doc//logDetail/workTime/text()"/></c:set>
 <c:set var="startPeriod"><x:out select="$doc//logDetail/startPeriod/text()"/></c:set>
 <c:set var="endPeriod"><x:out select="$doc//logDetail/endPeriod/text()"/></c:set>
 <c:set var="projectId"><x:out select="$doc//logDetail/projectId/text()"/></c:set>
 <c:set var="projectName"><x:out select="$doc//logDetail/projectName/text()"/></c:set>
 <c:set var="projectCode"><x:out select="$doc//logDetail/projectCode/text()"/></c:set>
 <c:set var="logContent"><x:out select="$doc//logDetail/logContent/text()"/></c:set>
 <c:set var="workResult"><x:out select="$doc//logDetail/workResult/text()"/></c:set>
 <c:set var="remark"><x:out select="$doc//logDetail/remark/text()"/></c:set>
 <%
 	String remark = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("remark"));
 	remark =remark.replaceAll("<.*?>", "");
  %>
  <c:set var="remark"><%=remark %></c:set>
</c:if>
  <div class="views">
    <div class="view view-content">
      <div class="pages">
        <div class="page">  
          <section id="sectionScroll" class="wh-section wh-section-bottomfixed"> 
            <article class="wh-edit wh-edit-forum wh-article-log-edit">
              <div>
              	<form id="sendForm" method="post" action="/defaultroot/worklog/saveWorkLog.controller">
              	<c:set var="fromPage">${param.fromPage}</c:set>
				<c:if test="${logId != 'null' && logId !=''}">
					<input type="hidden" name="logId" value="${logId }">
				</c:if>
                <div class="log-edit-tip clearfix">
                  <ul>
                    <li id="org" <c:if test="${weather == '晴天'}">class="current"</c:if>>
                      <div class="org"><span>晴</span><i style="width: 2rem;height: 2.8rem;font-size: 1.5rem;padding: 0;" class="fa fa-check-circle"></i></div>
                    </li>
                    <li <c:if test="${weather == '雨天'}">class="current"</c:if>>
                      <div class="blue"><span>雨</span><i style="width: 2rem;height: 2.8rem;font-size: 1.5rem;padding: 0;" class="fa fa-check-circle"></i></div>
                    </li>
                    <li <c:if test="${weather == '阴天'}">class="current"</c:if>>
                      <div class="zee"><span>阴</span><i style="width: 2rem;height: 2.8rem;font-size: 1.5rem;padding: 0;" class="fa fa-check-circle"></i></div>
                    </li>
                    <li <c:if test="${weather == '雪天'}">class="current"</c:if>>
                      <div class="yel"><span>雪</span><i style="width: 2rem;height: 2.8rem;font-size: 1.5rem;padding: 0;" class="fa fa-check-circle"></i></div>
                    </li>
                  </ul>
                  <input type="hidden" name="weather" id="weather" value="${weather }"/>
                </div> 
                <table class="wh-table-edit">
                  <tbody>
                    <tr>
                      <th>日期：</th> 
                      <td>
                        <input class="edit-ipt-r edit-ipt-arrow" id="picker-date" type="text" value="${logDate }" name="logDate" placeholder="选择日期&nbsp;" readonly="">
                      </td>
                    </tr>
                    <tr>
                      <th>日志类型：</th>
                      <td>
                        <ul class="edit-radio">
                          <li> 
                            <label class="label-radio item-content" onclick="selType(0)">
                            <input type="radio" name="logType" <c:if test="${logType == '0'}"> checked="checked"</c:if> value="0" >
                            <span class="edit-radio-l">全天日志</span>
                          </label>
                          </li>
                          <li> 
	                          <label class="label-radio item-content"  onclick="selType(1)">
	                            <input type="radio" name="logType"  <c:if test="${logType == '1'}"> checked="checked"</c:if> value="1">
	                            <span class="edit-radio-l">分时段日志</span>
	                          </label>
                          </li>
                        </ul>
                      </td>
                    </tr>
                    <tr id="datetype1" style="display: none">
                      <th>工时：</th>
                      <td>
                        <div class="edit-ipt-r">
                          <i class="fa fa-minus-circle" onclick="decline(0)" style="font-size: 1.7rem;"></i>
                          <span id="date1">
                          	<c:choose>
                          		<c:when test="${workTime eq 'null' }">
                          			8.0小时
                          			<c:set var="NewworkTime">8.0</c:set>
                          		</c:when>
                          		<c:otherwise>
                          			${workTime }
                          			<c:set var="NewworkTime">${workTime }</c:set>
                          		</c:otherwise>
                          	</c:choose>
                          </span>
                          <i class="fa fa-plus-circle" onclick="increasing(0)" style="font-size: 1.7rem;"></i>
                        </div>
                        <input type="hidden" name="workTime" id="workTime" value="${NewworkTime }"/>
                      </td>
                    </tr>
                    <tr id="datetype2" style="display: none">
                      <th>分时段：</th>
                      <td>
                        <div class="edit-ipt-r" style="height:3rem;padding-bottom: 4rem;">
                          <i class="fa fa-minus-circle"  onclick="decline(1)" style="font-size: 1.7rem;"></i>
                          <span id="date2">${startPeriod }</span>
                          <input type="hidden" name="startPeriod" id="startPeriod" value="${startPeriod }"/>
                          <i class="fa fa-plus-circle" onclick="increasing(1)" style="font-size: 1.7rem;"></i>
                          <em>至</em><br/>
                          <i class="fa fa-minus-circle" onclick="decline(2)" style="font-size: 1.7rem;"></i>
                          <span id="date3">${endPeriod }</span>
                          <input type="hidden" name="endPeriod" id="endPeriod" value="${endPeriod }"/>
                          <i class="fa fa-plus-circle" onclick="increasing(2)" style="font-size: 1.7rem;"></i>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th><em class="red-em">*</em>内容：</th>
                      <td>
                        <div class="edit-txta-box">
                          <textarea id="logContent" onfocus="fours(0)"  name="logContent" class="edit-txta edit-txta-l" placeholder="请输入文字">${logContent }</textarea>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th>项目编号：</th>
                      <td>
                      	<input type="hidden" name="projectId" <c:if test="${projectId!='null' }"> value="${projectId }"</c:if> id="projectId"/>
                      	<input type="hidden" name="projectName" <c:if test="${projectName!='null' }"> value="${projectName }"</c:if> id="projectName"/>
                        <input class="edit-ipt-r" type="text" readonly="readonly" <c:if test="${projectCode!='null' }"> value="${projectCode }"</c:if> name="projectCode" id="projectCode" placeholder="" />
                      </td>
                    </tr>
                    <tr>
                      <th>项目名称：</th>
                      <td id="protd">
                        <!-- <input class="edit-ipt-r edit-ipt-arrow" type="text" maxlength="50" name="projectName" value="${projectName }" id="projectName" readonly="readonly" placeholder="请选择&nbsp;" onclick="selPro()"/> -->
                        <c:if test="${projectName!='null' }"> ${projectName }</c:if>
                        <c:if test="${empty projectName || projectName == 'null' }">
                        <input class="edit-ipt-r edit-ipt-arrow" type="text" readonly placeholder="请选择" onclick="selPro()"/>
                        </c:if>
                      </td>
                    </tr>
                    <tr>
                      <th>结果：</th>
                      <td>
                      	<c:if test="${workResult!='null' }">
                      		<input class="edit-ipt-r" onfocus="fours(1)" id="workResult" value="${workResult }" name="workResult" type="text" placeholder="请填写" />
                      	</c:if>
                      	<c:if test="${workResult == 'null' }">
                        	<input class="edit-ipt-r" onfocus="fours(1)" id="workResult" value="" name="workResult" type="text" placeholder="请填写" />
                        </c:if>
                      </td>
                    </tr>
                     <tr>
                      <th>备注：</th>
                      <td>
                        <div class="edit-txta-box" style="cursor:pointer" >
                        	<c:if test="${remark!='null' }">
	                      		<textarea id="remark" onfocus="fours(2)"  name="remark" class="edit-txta edit-txta-l" placeholder="请输入文字">${remark}</textarea>
	                      	</c:if>
	                      	<c:if test="${remark == 'null' }">
	                        	<textarea id="remark" onfocus="fours(2)"  name="remark" class="edit-txta edit-txta-l" placeholder="请输入文字"></textarea>
	                        </c:if>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
                </form>
              </div>
            </article>
          </section>
          <footer id="footer-hb" class="wh-footer wh-footer-forum">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix" style="padding-top: 0.85rem;">
                  <c:set var="loadFlag"><%=loadFlag %></c:set>
                  <c:choose>
                  	<c:when test="${loadFlag == '0' }">
                  		<a href="javascript:checkForm(1);" style="display: inline;" class="panel-return-a" id="commitLog">提交日志</a>
                  	</c:when>
                  	<c:otherwise>
                  		<a href="javascript:checkForm(0);" style="display: inline;" class="panel-return-a" id="commitLog">提交日志</a>
                  	</c:otherwise>
                  </c:choose>
                  	<a href="javascript:yesSel();" class="panel-return-a" id="commitSel" style="display:none;">确定已选</a>
                  </div>
                </div>
              </div>
            </div>
          </footer>
          <!--<footer id="submitLog" class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="wh-footer-btn row">
                	<c:choose>
                		<c:when test="${param.loadFlag =='0'}">
                			<a href="javascript:checkForm(1);" class="fbtn-matter col-100" id="commitLog">提交日志</a>
                		</c:when>
                		<c:otherwise>
                			<a href="javascript:checkForm(0);" class="fbtn-matter col-100" id="commitLog">提交日志</a>
                		</c:otherwise>
                	</c:choose>
                    <a href="javascript:yesSel();" class="fbtn-matter col-100" id="commitSel" style="display: none">确定已选</a>
                </div>
              </div>
            </div>
          </footer>
           --><section id="sectionScroll1" class="wh-section wh-section-bottomfixed infinite-scroll">
           </section>
        </div>
      </div>
    </div>
  </div>
  <script src="/defaultroot/clientview/frameworktemplate/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/frameworktemplate/js/jquery-1.8.2.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/frameworktemplate/js/plugin/zepto.js"></script>
  <script type="text/javascript"> 
  var myApp = new Framework7();
  var $$ = Dom7;  
  //切换状态
  $$(".log-edit-tip li").click(function(){
    $$(".log-edit-tip li").removeClass("current");
    $$(this).addClass("current");
    setWeather($$(".current span").html()+"天");
  })
  
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
document.write( '<style>#footer-hb{visibility:hidden}@media(min-height:' + ($( window ).height() - 10) + 'px){#footer-hb{visibility:visible}}</style>' );  
   $(function () {
   		var loadFlag = "<%=loadFlag%>";
		var logType = "<%=logType%>";
   		if(loadFlag != '0'){
   			$$("#org").addClass("current");
   			$$("#weather").val('晴天');
   			$('.edit-radio input[name="logType"]').eq(0).attr("checked","checked");
   			$$("#date1").html("8小时");
   			$$("#date2").html("08:00");
   			$$("#date3").html("08:30");
   			$$("#startPeriod").val("08:00");
   			$$("#endPeriod").val("08:30");
   			$$("#workTime").val("8");
   			var myDate = new Date();
   			var m = myDate.getMonth()+1;
   			$$("#picker-date").val(myDate.getFullYear()+'-'+m+'-'+myDate.getDate());
   		}
		if(logType==''){
		}else{
			$('.edit-radio input[name="logType"]').eq(logType).attr("checked","checked");
		}
   		if($('.edit-radio input[name="logType"]:checked').val() == '0'){
   			$("#datetype1").show();
   		}else{
   			$("#datetype2").show();
   		}
    });
  
  //天气
  function setWeather(weatherObj) {
	$$("#weather").val(weatherObj);
  }
  //日期选择器
  var today = new Date();
  var pickerDate = myApp.picker({
    input: '#picker-date',
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
      //var todayArr = [today.getFullYear(), today.getMonth(), today.getDate(), today.getHours(), (today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes())];
      var todayArr = [today.getFullYear(), today.getMonth()+1, today.getDate()];
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
      return values[0] + '-' + values[1] + '-' + values[2];// + ',' + values[3] + ':' + values[4];
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
        values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      },
      // 日
      {
        values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
      },
      // 空格
      {
        divider: true,
        content: ' '
      }//,
      // 时
      /*{
        values: (function() {
          var arr = [];
          for (var i = 0; i <= 23; i++) {
            arr.push(i);
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
      }*/
    ]
  });
  
   function decline(flag){
		if(flag == 0){
			var sp = $$(".edit-ipt-r span").html();
			sp = sp.replace("小时","");
			sp = parseFloat(sp);
			if(sp!= 0.5){
				sp = sp - 0.5;
			}
			$$("#date1").html(sp+'小时');
			$$('#workTime').val(sp);
		}else if(flag == 1){
			var declingDate = $$("#date2").html();
			if(declingDate!='00:00'){
				setStartPeriod(declingDate,'jian','start');
				$$("#startPeriod").val($$("#date2").html());
			}else{
				$$("#startPeriod").val('00:00');
			}
		}else{
			var endPeriodDate = $$("#date3").html();
			if(endPeriodDate!='00:00'){
				setStartPeriod(endPeriodDate,'jian','end');
				$$("#endPeriod").val($$("#date3").html());
			}else{
				$$("#endPeriod").val('00:00');
			}
		}
	}

	function increasing(flag){
		if(flag == 0){
			var sp = $$(".edit-ipt-r span").html();
			sp = sp.replace("小时","");
			sp = parseFloat(sp);
			if(sp!= 24){
				sp = sp + 0.5;
			}
			$$("#date1").html(sp+'小时');
			$$('#workTime').val(sp);
		}else if(flag == 1){
			var declingDate = $$("#date2").html();
			if(declingDate!='24:00'){
				setStartPeriod(declingDate,'jia','start');
				$$("#startPeriod").val($$("#date2").html());
			}else{
				$$("#startPeriod").val('24:00');
			}
		}else{
			var endPeriodDate = $$("#date3").html();
			if(endPeriodDate!='24:00'){
				setStartPeriod(endPeriodDate,'jia','end');
				$$("#endPeriod").val($$("#date3").html());
			}else{
				$$("#endPeriod").val('24:00');
			}
		}
	}
	
	//实现时间加减
	function setStartPeriod(date,flag,type) {
		var h = Number(date.substring(0,2));
		var m = Number(date.substring(3,5));
		if(flag == 'jian'){
			m = m-30;
			if(m == -30){
				m = 30;
				h = h-1;
			}
		}else{
			m = m+30;
			if(m == 60){
				m = 0;
				h = h+1;
			}
		}
		var startDate = '';
		if(h.toString().length>1 && m.toString().length>1){
			startDate = h+":"+m;
		}else if(h.toString().length>1 && m.toString().length==1){
			startDate = h+":"+m+"0";
		}else if(h.toString().length==1 && m.toString().length>1){
			startDate = "0"+h+":"+m;
		}else{
			startDate = "0"+h+":"+m+"0";
		}
		if(type == 'start'){
			$$("#date2").html(startDate);
		}else{
			$$("#date3").html(startDate);
		}
	}
 
 	function checkForm(flag) {
 		var date1 = $$("#date2").html();
 		var date2 = $$("#date3").html();
 		var hour1 = "";
 		var hour2 = "";
 		var min1 = "";
 		var min2 = "";
 		if(date1.lastIndexOf(":")=="2"){
 			hour1 = date1.substring(0,2);
 			hour2 = date2.substring(0,2);
 			min1 = date1.substring(3,5);
 		    min2 = date2.substring(3,5);
 		}else{
 			hour1 = date1.substring(0,1);
 			hour2 = date2.substring(0,1);
 			min1 = date1.substring(2,4);
 		    min2 = date2.substring(2,4);
 		}
 		
 		var len = $$("#protd").text().length;
		if($$("#logContent").val().replace(/\s/g,"")==""){
			myApp.alert('内容不能为空！');
			return;
		}else if(/[\\\/?#&'"]+/g.test($$("#logContent").val())){
			myApp.alert('内容不可以包含特殊字符！');
			return;
		}else if(/[\\\/?#&'"]+/g.test($$("#workResult").val())){
			myApp.alert('结果不可以包含特殊字符！');
			return;
		}else if(hour1 > hour2){
			myApp.alert('开始时间必须在结束时间之前！');
			return;
		}else if(min1 >= min2 && hour1 == hour2){
			myApp.alert('开始时间必须在结束时间之前！');
			return;
		}else if(len > 50){
			myApp.alert('项目名称不能超过最大长度50！');
			return;
		}else{
			if(flag == '0'){
				saveWorkLog();
			}else{
				updateWorkLog();
			}
		}
	}
 	//保存日志
 	var comflag = 1;
 	var fromPage = '${fromPage}';
 	function saveWorkLog() {
 		if(comflag == 0){
    		return;
    	}
    	comflag = 0;
 		$$.ajax({
		    type: "post",
		    url: "/defaultroot/worklog/saveWorkLog.controller",
		    data:$('#sendForm').serialize(),
		    success: function(data) {
		    	var jsonData = eval("("+data+")");
		    	var commentFlag = jsonData.data0;
		    	if(commentFlag=='1'){
			    	if(fromPage == 'evo'){
			    		myApp.alert('保存成功!', function () {
			    			 $imag.exec('closeEvoPage()');
					    });
				    }else{
				    	myApp.alert('保存成功!', function () {
					      	 window.location = "/defaultroot/worklog/getWorkLogList.controller";
					    });
					}
		    	}else{
		    		myApp.alert('保存失败！');
		    	}
		    }
		});
	}
	
	//显示隐藏时间
	function selType(flag) {
		if(flag == '0'){
			$("#datetype1").show();
			$("#datetype2").hide();
			$$("#date2").html("08:00");
   			$$("#date3").html("08:30");
		}else{
			$("#datetype2").show();
			$("#datetype1").hide();
		}
	}
	
	function hiddenContent(flag) {
		if(flag == '0'){
			$$('#sectionScroll').hide();
			$('#commitLog').css("display","none");
			$('#commitSel').css("display","inline");
			$("#sectionScroll1").css("display","block");
		}else{
			document.title="填写日志"; 
			$$('#sectionScroll').show();
			$('#commitLog').css("display","inline");
			$('#commitSel').css("display","none");
			$("#sectionScroll1").css("display","none");
			$("#sectionScroll1").html('');
		}
	}
	
	//选择项目
	function selPro() {
		var liId = $('#projectId').val();
		//myApp.showPreloader('页面加载中...');
		var selUrl = '/defaultroot/worklog/getMineProjectList.controller';
		$.ajax({
	      type: "post",
	      url: selUrl,
	      dataType: "text",
	      success: function(data) {
				$("#sectionScroll1").append(data);
				var index = $$('#proListUl li').length;
		    	if(index < 15){
		    		 $$('.wh-load-md').hide();
		    	}else{
		    		 $$('.wh-load-md').show();
		    	}
		    	if(index == 0){
		    		$$('.wh-article-lists ul').html('<li>系统没有查询到相关记录</li>');
		    	}
				$("#proLi_"+liId).addClass("current");
				$("#proLi_"+liId+' i').css("color","#3eaeff");
				selProId = liId;
				selProName = $$('#projectName').val();
				selProCode = $$('#projectCode').val();
				//myApp.hidePreloader();
				hiddenContent(0);
				document.title="项目列表"; 
			}
		});
	}
	//修改日志
 	var updateflag = 1;
	function updateWorkLog() {
		if(updateflag == 0){
    		return;
    	}
    	updateflag = 0;
		$$.ajax({
		    type: "post",
		    url: "/defaultroot/worklog/updateWorkLog.controller",
		    data:$('#sendForm').serialize(),
		    success: function(data) {
		    	var jsonData = eval("("+data+")");
		    	var commentFlag = jsonData.data0;
		    	if(commentFlag=='1'){
		    		myApp.alert('修改成功！', function () {
				      	 window.location = "/defaultroot/worklog/getWorkLogList.controller";
				      });
		    	}else{
		    		myApp.alert('修改失败！');
		    	}
		    }
		});
	}
	
	function fours(flag) {
		if(flag == 0){
			var t=$("#logContent").val();
			$("#logContent").val("");
			$("#logContent").val(t);
		}else if(flag == 1){
			var t=$("#workResult").val();
			$("#workResult").val("");
			$("#workResult").val(t);
		}else{
			var t=$("#remark").val();
			$("#remark").val("");
			$("#remark").val(t);
		}
	}
	
  </script>
</body>
</html>