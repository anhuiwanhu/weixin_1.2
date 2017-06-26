<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,java.text.*" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>查看领导日程定期</title>
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template115/css/alert/template.alert.css" />
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/uploadPreview.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/ajaxfileupload.js"></script>
  <script src="<%=rootPath%>/clientview/js/common.js"></script>
</head>
<%
	String isYzOffice = com.whir.util.PropertyUtil.getPropertyByKey("isYzOffice");
	String downloadType = com.whir.util.PropertyUtil.getPropertyByKey("downloadType"); 
	if(downloadType==null || "null".equals("downloadType") || "".equals(downloadType)){
		downloadType = "1";
	}
%>
<c:set var="isYzOffice" ><%=isYzOffice %></c:set>
<c:set var="downloadType" ><%=downloadType %></c:set>
<body class="grey-bg">
<c:choose>
 <c:when test="${not empty docXml}">
  <div class="views">
    <div class="view view-main">
      <div class="pages">
        <div class="page" data-page="page-webapp-step-operation">
        <x:parse xml="${docXml}" var="doc" />
        <c:set var="leaderAttribute"><x:out select="$doc//leaderEvent/leaderAttribute/text()"/></c:set>
        <c:set var="leaderName"><x:out select="$doc//leaderEvent/leaderName/text()"/></c:set>
        <c:set var="showCotent"><x:out select="$doc//leaderEvent/showCotent/text()"/></c:set>
        <%
			String showCotent = (String)pageContext.getAttribute("showCotent");
			showCotent = showCotent.replaceAll("&lt;br&gt;","\r\n");
			System.out.println("showCotent------------>"+showCotent);
		%>
		<c:set var="workCotent"><x:out select="$doc//leaderEvent/workCotent/text()"/></c:set>
		<%
			String workCotent = (String)pageContext.getAttribute("workCotent");
			workCotent = workCotent.replaceAll("&lt;br&gt;","\r\n");
			System.out.println("workCotent------------>"+workCotent);
		%>
		<c:set var="echoMode"><x:out select="$doc//leaderEvent/echoMode/text()"/></c:set>
		<c:set var="echoBeginDate"><x:out select="$doc//leaderEvent/echoBeginDate/text()"/></c:set>
		<c:set var="echoEndDate"><x:out select="$doc//leaderEvent/echoEndDate/text()"/></c:set>
		<c:set var="leaderBeginTime"><x:out select="$doc//leaderEvent/leaderBeginTime/text()"/></c:set>
		<c:set var="leaderEndTime"><x:out select="$doc//leaderEvent/leaderEndTime/text()"/></c:set>
		<c:set var="onTimeMode"><x:out select="$doc//leaderEvent/onTimeMode/text()"/></c:set>
		<c:set var="onTimeContent"><x:out select="$doc//leaderEvent/onTimeContent/text()"/></c:set>
		<c:set var="leaderRemind"><x:out select="$doc//leaderEvent/leaderRemind/text()"/></c:set>
		<c:set var="workCotent"><x:out select="$doc//leaderEvent/workCotent/text()"/></c:set>
		<c:set var="fileNameCount" ><x:out select="$doc//leaderEvent/fileNameCount/text()"/></c:set>
          <section class="page-content wh-section wh-section-bottomfixed leader-read" id="mainContent">
          	<div class="app-tabheader-line clearfix">
                <div class="clearfix">
                  <a id="open"  <c:if test="${leaderAttribute == '1'}">class="read-clock"</c:if> >公开</a>
                  <a id="private" <c:if test="${leaderAttribute == '0'}">class="read-clock"</c:if> >私密</a>
                </div>
            </div>
            <article class="wh-edit wh-edit-document">
              <div class="wh-container">          
                <table class="wh-table-edit" style="border-collapse:separate;border-spacing: 0 2px;">
                  <tbody>
                    <tr>
                      <td>领导：</td>
                      <td>
                        <p><input placeholder="请输入" class="edit-ipt-r" type="text" id="leaderName" name="leaderName" value="${leaderName }" readonly="readonly" /></p>
                      </td>
                    </tr>
                    <tr>
                      <td style="height: 6rem;line-height: 6rem;">工作内容：</td>
                      <td>
                        <div class="edit-txta-box">
                          <textarea style="height:10rem;" class="edit-ipt-r edit-ipt-arrow" id="showCotent" type="text" readonly="true" name="showCotent" ><%=workCotent %></textarea>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>重复模式：</td>
                      <td>
                        <ul class="edit-radio">
                        	<li>
                            	<label class="label-radio item-content">
                              		<input type="radio" name="echoMode" id="echoMode" <c:if test="${echoMode == '0'}">checked="checked"</c:if> value="0" disabled="disabled" >
                              		<span class="edit-radio-l">有结束日期</span>
                            	</label>
                          	</li>
                          	<li>
                            	<label class="label-radio item-content">
                              		<input type="radio" name="echoMode" id="echoMode" <c:if test="${echoMode == '-1'}">checked="checked"</c:if> value="-1" disabled="disabled" >
                              		<span class="edit-radio-l">无结束日期</span>
                            	</label>
                          	</li>
                        </ul>
                      </td>
                    </tr>	
                    <tr>
                      <td>重复范围：</td>
                      <td>
                        <div class="repeat-time">
                          <input class="edit-ipt-r edit-ipt-arrow" type="text" name="echoBeginDate" readonly="readonly" value="${echoBeginDate }">
                          <p class="fenge"></p>
                          <c:choose>
                          	<c:when test="${echoMode == '-1'}">
                          		<input class="edit-ipt-r edit-ipt-arrow" type="text" name="echoEndDate" readonly="readonly" style="display: none">
                          	</c:when>
                          	<c:otherwise>
                          		<input class="edit-ipt-r edit-ipt-arrow" type="text" name="echoEndDate" readonly="readonly" value="${echoEndDate }">
                          	</c:otherwise>
                          </c:choose>
                        </div>
                        <div class="zhi">
                          <span>至</span>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>起始时间：</td>
                      <td>
                        <div class="repeat-time">
                          <input class="edit-ipt-r edit-ipt-arrow" type="text" name="eventBeginTime" readonly="readonly" value="${leaderBeginTime }">
                          <p class="fenge"></p>
                          <input class="edit-ipt-r edit-ipt-arrow" type="text" name="eventEndTime" readonly="readonly" value="${leaderEndTime }">
                        </div>
                        <div class="zhi">
                          <span>至</span>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>定期模式：</td>
                      <td>
                        <ul class="edit-radio">
                        	<li>
                            	<label class="label-radio item-content">
									<input type="radio" name="onTimeMode" value="1" <c:if test="${onTimeMode == '1'}">checked="checked"</c:if> disabled="disabled" >
                              		<span class="edit-radio-l">按天</span>
                            	</label>
                          	</li>
                          	<li>
                            	<label class="label-radio item-content">
                              		<input type="radio" name="onTimeMode" value="2" <c:if test="${onTimeMode == '2'}">checked="checked"</c:if> disabled="disabled" >
                              		<span class="edit-radio-l">按周</span>
                            	</label>
                          	</li>
                          	<li>
                            	<label class="label-radio item-content">
                              		<input type="radio" name="onTimeMode" value="3" <c:if test="${onTimeMode == '3'}">checked="checked"</c:if> disabled="disabled" >
                              		<span class="edit-radio-l">按月</span>
                            	</label>
                          	</li>
                          	<li>
                            	<label class="label-radio item-content">
                              		<input type="radio" name="onTimeMode" value="4" <c:if test="${onTimeMode == '4'}">checked="checked"</c:if> disabled="disabled" >
                              		<span class="edit-radio-l">按年</span>
                            	</label>
                          	</li>			
                        </ul>
                      </td>
                    </tr>
                    <tr id="day" style="display:table-row;">
                      <td></td>
                      <td>
                        <ul class="edit-radio">
                          <li>
                            <label class="label-radio item-content">
                              <input type="radio" id="onTimeContentDay0" name="onTimeContentDay" checked="checked" value="0" disabled="disabled">
                              <span class="edit-radio-l">每一天</span>
                            </label>
                          </li>
                          <li>
                            <label class="label-radio item-content">
                              <input type="radio" id="onTimeContentDay1" name="onTimeContentDay" value="1" disabled="disabled">
                              <span class="edit-radio-l">每一工作日</span>
                            </label>
                          </li>
                        </ul>
                      </td>
                    </tr>
                    <tr id="week" style="display:none">
                      <td></td>
                      <td>
                      	<input type="hidden" id="onTimeContentWeek" name="onTimeContentWeek" value="">
                        <ul class="edit-radio">
                          <li>
                            <label class="label-checkbox item-content">
                              <input type="checkbox" id="checkbox0" name="checkbox" value="0" disabled="disabled">
                              <span class="edit-radio-l" >星期日</span>
                            </label>
                          </li>
                          <li>
                            <label class="label-checkbox item-content">
                              <input type="checkbox" id="checkbox1" name="checkbox" value="1" disabled="disabled">
                              <span class="edit-radio-l" >星期一</span>
                            </label>
                          </li>
                          <li>
                            <label class="label-checkbox item-content">
                              <input type="checkbox" id="checkbox2" name="checkbox" value="2" disabled="disabled">
                              <span class="edit-radio-l" >星期二</span>
                            </label>
                          </li>
                          <li>
                            <label class="label-checkbox item-content">
                              <input type="checkbox" id="checkbox3" name="checkbox" value="3" disabled="disabled">
                              <span class="edit-radio-l" >星期三</span>
                            </label>
                          </li>
                          <li>
                            <label class="label-checkbox item-content">
                              <input type="checkbox" id="checkbox4" name="checkbox" value="4" disabled="disabled">
                              <span class="edit-radio-l" >星期四</span>
                            </label>
                          </li>
                          <li>
                            <label class="label-checkbox item-content">
                              <input type="checkbox" id="checkbox5" name="checkbox" value="5" disabled="disabled">
                              <span class="edit-radio-l" >星期五</span>
                            </label>
                          </li>
                          <li>
                            <label class="label-checkbox item-content">
                              <input type="checkbox" id="checkbox6" name="checkbox" value="6" disabled="disabled">
                              <span class="edit-radio-l" >星期六</span>
                            </label>
                          </li>
                        </ul>
                      </td>
                    </tr>
                    <tr id="month" style="display:none">
                      <td></td>
                      <td>
                        <p class="anyue">
                            <span>第一个月的第</span>
                            <select class="" id="onTimeContentMonth" name="onTimeContentMonth" disabled="disabled">
                              <option value="01">01</option>
                              <option value="02">02</option>
                              <option value="03">03</option>
                              <option value="04">04</option>
                              <option value="05">05</option>
                              <option value="06">06</option>
                              <option value="07">07</option>
                              <option value="08">08</option>
                              <option value="09">09</option>
                              <option value="10">10</option>
                              <option value="11">11</option>
                              <option value="12">12</option>
                              <option value="13">13</option>
                              <option value="14">14</option>
                              <option value="15">15</option>
                              <option value="16">16</option>
                              <option value="17">17</option>
                              <option value="18">18</option>
                              <option value="19">19</option>
                              <option value="20">20</option>
                              <option value="21">21</option>
                              <option value="22">22</option>
                              <option value="23">23</option>
                              <option value="24">24</option>
                              <option value="25">25</option>
                              <option value="26">26</option>
                              <option value="27">27</option>
                              <option value="28">28</option>
                              <option value="29">29</option>
                              <option value="30">30</option>
                              <option value="31">31</option>
                            </select>
                            <span>天</span>
                        </p>
                      </td>
                    </tr>
                    <tr id="year" style="display:none">
                      <td></td>
                      <td>
                        <p class="anyue">
                            <span>每年的第</span>
                            <select class="" id="onTimeContentYearmonth" name="onTimeContentYearmonth" disabled="disabled">
                              <option value="01">01</option>
                              <option value="02">02</option>
                              <option value="03">03</option>
                              <option value="04">04</option>
                              <option value="05">05</option>
                              <option value="06">06</option>
                              <option value="07">07</option>
                              <option value="08">08</option>
                              <option value="09">09</option>
                              <option value="10">10</option>
                              <option value="11">11</option>
                              <option value="12">12</option>
                            </select>
                            <span>月的第</span>
                            <select class="" id="onTimeContentYearday" name="onTimeContentYearday" disabled="disabled">
                              <option value="01">01</option>
                              <option value="02">02</option>
                              <option value="03">03</option>
                              <option value="04">04</option>
                              <option value="05">05</option>
                              <option value="06">06</option>
                              <option value="07">07</option>
                              <option value="08">08</option>
                              <option value="09">09</option>
                              <option value="10">10</option>
                              <option value="11">11</option>
                              <option value="12">12</option>
                              <option value="13">13</option>
                              <option value="14">14</option>
                              <option value="15">15</option>
                              <option value="16">16</option>
                              <option value="17">17</option>
                              <option value="18">18</option>
                              <option value="19">19</option>
                              <option value="20">20</option>
                              <option value="21">21</option>
                              <option value="22">22</option>
                              <option value="23">23</option>
                              <option value="24">24</option>
                              <option value="25">25</option>
                              <option value="26">26</option>
                              <option value="27">27</option>
                              <option value="28">28</option>
                              <option value="29">29</option>
                              <option value="30">30</option>
                              <option value="31">31</option>
                            </select>
                            <span>天</span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>提醒：</td>
                      <td class="">
                        <input class="edit-ipt-r edit-ipt-arrow" type="text" name="remindValues"  id="picker-auto" value="${leaderRemind}" readonly="readonly">
                      </td>
                    </tr>
                    <tr>
                      <td>标签：</td>
                      <td class="">	
                        <c:if test="${not empty leaderTag}">	
                        <span class="biaoqian" id="showTag">${leaderTag}</span>  
						</c:if>						 			                                            
                      </td>
                    </tr>
                    <tr>
                      <td>附件：</td>
                      <td class="" >					   					
                     	<c:if test="${fileNameCount>0}">				 	             				 
                     		<x:forEach select="$doc//leaderEvent/fileNameList" var="files"  varStatus="status">
    		         			<c:set var="filenameW"><x:out select="$files/saveFileName/text()"/></c:set>
		             			<c:set var="appNameW"><x:out select="$files/realFileName/text()"/></c:set> 		              
		             			<c:set var="aid">${fn:substring(filenameW,0,25)}</c:set> 
                      			<i class="fa fa-paperclip" style="color: #3eaeff;"></i>					 
                      			<a href="javascript:downFile('${filenameW}','${appNameW}','${aid}')" id="${aid}">
                          			<strong class="atta-name" style="color: #3eaeff;">						  
						  				${appNameW}
						  			</strong>
                      			</a><br>
					  		</x:forEach>                     			  
				     	</c:if>
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
                  <div class="fl clearfix">
                  	<a href="javascript:exit();" class="panel-send-a">退出</a>
                  </div>
                </div>
              </div>
            </div>
		  </footer>
          
        </div>
      </div>
    </div>
  </div>
  </c:when>
  <c:otherwise>
  	<script>
 		wx.ready(function(){
	 		myApp.alert('该日程已被撤回或删除！');
	 		window.history.back(-1);
 		});
 	</script>
  </c:otherwise>
</c:choose>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/template115/js/alert/zepto.alert.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/subClickYz.js"></script>
  <script type="text/javascript">
	var myApp = new Framework7();
	var mainView = myApp.addView('.view');
	var $$ = Dom7;
	
	
	$(function(){
		//定期模式内容设置
		var eventOnTimeMode = '${onTimeMode}';//定期模式
		var eventOnTimeContent = '${onTimeContent}';//定期模式内容
		if(eventOnTimeMode == '1'){
			$('#day').css("display","table-row");
			$('#week').css("display","none");
			$('#month').css("display","none");
			$('#year').css("display","none");
			$('#onTimeContentDay'+eventOnTimeContent).attr("checked","checked");
		}else if(eventOnTimeMode == '2'){
			$('#day').css("display","none");
			$('#week').css("display","table-row");
			$('#month').css("display","none");
			$('#year').css("display","none");
			var arr = [];
			arr = eventOnTimeContent.match(/./g);//将字符串拆分成字符数组
			for(var i = 0;i<arr.length;i++){
				if(arr[i] == '1'){
					$('#checkbox'+i).attr("checked","checked");
				}
			} 
		}else if(eventOnTimeMode == '3'){
			$('#day').css("display","none");
			$('#week').css("display","none");
			$('#month').css("display","table-row");
			$('#year').css("display","none");
			$('#onTimeContentMonth').val(eventOnTimeContent);
		}else if(eventOnTimeMode == '4'){
			$('#day').css("display","none");
			$('#week').css("display","none");
			$('#month').css("display","none");
			$('#year').css("display","table-row");
			$('#onTimeContentYearmonth').val(eventOnTimeContent.split("$")[0]);
			$('#onTimeContentYearday').val(eventOnTimeContent.split("$")[1]);
		}
	});
	
	
	//打开附件
  	function downFile(menuHtmlLink,menuFileLink,aId) {
  		var isYzOffice = "${isYzOffice}";
  		var downloadType = "${downloadType}"
  		var path = 'leader';
  		if(aId == undefined){
  			aId = menuHtmlLink.split('.')[0];
  			path = 'html';
  		}		 
  		$.ajax({
			type: 'post',
			url: "<%=rootPath%>/download/getOpenFileUrl_New.controller",
			dataType:'text',
			data : {"fileName": menuHtmlLink,"name": menuFileLink,"path":path},
			success: function(data){
				var jsonData = eval("("+data+")");
				if(jsonData.apptype == "evo" && downloadType=="1"){
			 		$imag.exec("clickSubyz(\""+menuHtmlLink+"\",\""+path+"\",\""+jsonData.tmpurl+"\",\""+menuFileLink+"\")");
			 	}else{
			 		clickSubyz(jsonData.url,$('#'+aId),menuHtmlLink,"information",jsonData.smartInUse,jsonData.isEncrypt,jsonData.tmpurl,jsonData.apptype,'',isYzOffice);
			 	}
			},
			error: function(xhr, type){
				//alert('数据查询异常！');
			}
		});
	}
	

	//退出
	function exit(){
		window.history.back(-1);
	}

  </script>
</body>

