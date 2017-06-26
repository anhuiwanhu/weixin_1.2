<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>发起流程</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" />  
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-document">
          <section class="wh-section">
            <div class="webapp-document list-a">
              <div class="doc-list">
                <c:if test="${not empty docXml}">
					<x:parse xml="${docXml}" var="doc"/>
	        		<input type="hidden"  name="personNum" value="${personNum}" id="personNum"/>
					<input type="hidden"  name="startDate" value="${startDate}" id="startDate"/>
					<input type="hidden"  name="endDate" value="${endDate}" id="endDate"/>
					<input type="hidden"  name="meetRoomId" value="${meetRoomId}" id="meetRoomId"/>
					<input type="hidden"  name="meetRoomName" value="${meetRoomName}" id="meetRoomName"/>
					 <%
						int packageCount = 0;
					%>
					 <div class="list-block">
	                  <ul class="webapplist">
	                  	<x:forEach select="$doc//processList/process" var="ct" >
						<%
							packageCount ++;
						%>
							<c:set var="processId" ><x:out select="$ct//processId/text()" /></c:set>
							<c:set var="processName" ><x:out select="$ct//processName/text()" /></c:set>
							<c:set var="ezflowprocess_defid" ><x:out select="$ct//pool_ezflowprocess_defid/text()" /></c:set>
							<c:set var="pool_ezflowprocess_formKey" ><x:out select="$ct//pool_ezflowprocess_formKey/text()" /></c:set>
							<li class="swipeout" onclick="newezform('${pool_ezflowprocess_formKey}','${ezflowprocess_defid}','${processName}');">
								 <a href="#" class="swipeout-content item-content">
			                        <div>
			                          <i class="point"></i>
			                          <p><x:out select="$ct//processName/text()" /></p>
			                        </div>
			                        <div class="item-after"><i class="fa fa-angle-right"></i></div>
			                      </a>
			                </li>
			            </x:forEach>
	                  
	                  </ul>
	                 </div>
	         	</c:if>
	         	<c:if test="${empty docXml}">
					<div class="no-message">暂无可用的会议申请ezFLOW流程！</div>
				</c:if>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
  </div> 
  <script type="text/javascript" src="/defaultroot/clientview/template/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script>
	$(document).ready(function(){
		if($(".webapplist li").length == "1"){
			var pageId = '${pool_ezflowprocess_formKey}';
			var processId = '${ezflowprocess_defid}';
			var processName = '${processName}';
			newezform(pageId,processId,processName);
		}
	});
    //新建新流程
	function newezform(pageId,processId,processName){
		var personNum =$("#personNum").val();
		var startDate =$("#startDate").val();
		var endDate =$("#endDate").val();
		var meetRoomId =$("#meetRoomId").val();
        var meetRoomName =$("#meetRoomName").val();
		window.location = '/defaultroot/newmeeting/newEzmeetForm.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&personNum='+personNum+'&startDate='+startDate+'&endDate='+endDate+'&meetRoomId='+meetRoomId+'&meetRoomName='+meetRoomName;
	}
  </script>
</body>
