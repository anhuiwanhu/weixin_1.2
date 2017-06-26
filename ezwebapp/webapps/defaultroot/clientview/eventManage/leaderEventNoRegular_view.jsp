<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>查看领导日程不定期</title>
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
        <div id="viewShowjsp" class="page" data-page="page-webapp-step-operation">		  
          <section class="page-content wh-section wh-section-bottomfixed leader-read">
		    <c:if test="${not empty docXml}">
		    <x:parse xml="${docXml}" var="doc"/>
            <c:set var="sType"><x:out select="$doc//leaderEvent/sType/text()"/></c:set>			
            <c:set var="eventId"><x:out select="$doc//leaderEvent/id/text()"/></c:set>
            <c:set var="leaderId"><x:out select="$doc//leaderEvent/leaderId/text()"/></c:set>
            <c:set var="leaderName"><x:out select="$doc//leaderEvent/leaderName/text()"/></c:set>
			<c:set var="leaderBegin"><x:out select="$doc//leaderEvent/leaderBegin/text()"/></c:set>
			<c:set var="leaderEnd"><x:out select="$doc//leaderEvent/leaderEnd/text()"/></c:set>
			<c:set var="fullDayEvent"><x:out select="$doc//leaderEvent/fullDayEvent/text()"/></c:set>
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
			<c:set var="leaderAttribute"><x:out select="$doc//leaderEvent/leaderAttribute/text()"/></c:set>
			<c:set var="leaderRemind"><x:out select="$doc//leaderEvent/leaderRemind/text()"/></c:set>
			<c:set var="leaderRemindTime"><x:out select="$doc//leaderEvent/leaderRemindTime/text()"/></c:set>
			<c:set var="leaderTag"><x:out select="$doc//leaderEvent/leaderTag/text()"/></c:set>
			<c:set var="realFileName"><x:out select="$doc//leaderEvent/realFileName/text()"/></c:set>
            <c:set var="saveFileName"><x:out select="$doc//leaderEvent/saveFileName/text()"/></c:set>
            <c:set var="fileNameCount" ><x:out select="$doc//leaderEvent/fileNameCount/text()"/></c:set>				
            <div class="app-tabheader-line clearfix">
                <div class="clearfix">
                  <c:if test="${leaderAttribute == '1' }">				
                  	<a href="javascript:void(0);" class="read-clock">公开</a>
				  <a href="javascript:void(0);" >私密</a>
				  </c:if>
				  <c:if test="${leaderAttribute == '0' }">
                  <a href="javascript:void(0);" >公开</a>
				  <a href="javascript:void(0);" class="read-clock">私密</a>
				  </c:if>
                </div>
            </div>
            <article class="wh-edit wh-edit-document">
              <div class="wh-container">   
                <form id="saveForm">			  
                <table class="wh-table-edit" style="border-collapse:separate;border-spacing: 0 2px;">				  
                  <tbody>				   
				   <input type="hidden" name="leaderAttribute" id="leaderAttribute" value="0"/>
				    <tr>
				    	<td>领导：</td>
				    	<td class="">
				    		<input class="edit-ipt-r edit-ipt-arrow" id="pickerDateS" type="text" name="leaderBegin" value="${leaderName}" />					   
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
                      <td>开始时间：</td>
                      <td class="">
                       <input class="edit-ipt-r edit-ipt-arrow" id="pickerDateS" type="text" name="leaderBegin" value="${leaderBegin}" readonly="true"/>   

                      </td>
                    </tr>
                    <tr>
                      <td>结束时间：</td>
                      <td class="">
                        <input class="edit-ipt-r edit-ipt-arrow" id="pickerDateE" type="text" name="leaderEnd" value="${leaderEnd}"  readonly="true"/>
                      </td>
                    </tr>
                    <tr>
                      <td>全天事件：</td>
                      <td class="">	                     			  
						<c:if test="${fullDayEvent == '1' }">	
                        <div id="pick-div" class="pick-div"><span></span></div>
						</c:if>
						<c:if test="${fullDayEvent != '1' }">	
                        <div id="pick-div" class="pick-div-close"><span></span></div>
						</c:if>
                      </td>
                    </tr>
                    <tr>
                      <td>提醒：</td>
                      <td class="">
                        <input class="edit-ipt-r edit-ipt-arrow" type="text" name="remindValues"  id="picker-auto" value="${leaderRemind}" readonly="true">
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
			</c:if>
          </section>
          <footer class="wh-footer wh-footer-forum" id="footerButton">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix">
                  	<a href="javascript:back(${sType});" class="panel-send-a">退出</a>
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
  
<script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/zepto.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/js/subClick.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/js/subClickYz.js"></script>


  
<script type="text/javascript">
	var myApp = new Framework7({
		fastClicks: false,
	});
  	var mainView = myApp.addView('.view');
  	var $$ = Dom7;	
   
  	function back(flag) {
    	window.history.back(-1);	  	    
  	}
  
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
</script>
</body>
