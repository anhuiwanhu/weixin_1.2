<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="/clientview/common/headerInit.jsp" %>
<%
String workId = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("workId"));
String orgId = session.getAttribute("orgId").toString();
request.setAttribute("now",new java.util.Date());
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("empLivingPhoto"));
%>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>表单页</title>
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-form">
		<c:if test="${not empty docXml}"><!--1-->
		<x:parse xml="${docXml}" var="doc"/>
		<c:set var="wfworkId"><x:out select="$doc//wf_work_id/text()"/></c:set>
		<c:set var="wfsmsRight"><x:out select="$doc//smsRight/text()"/></c:set>
		<c:set var="modibutton"><x:out select="$doc//workInfo/modibutton/text()"/></c:set>
		<c:set var="workcurstep"><x:out select="$doc//workInfo/workcurstep/text()"/></c:set>
		<c:set var="worktitle"><x:out select="$doc//workInfo/worktitle/text()"/></c:set>
		<c:set var="worksubmittime"><x:out select="$doc//workInfo/worksubmittime/text()"/></c:set>
		<c:set var="EmpLivingPhoto"><x:out select="$doc//workInfo/empLivingPhoto/text()"/></c:set>
		<c:set var="flowgraphurl"><x:out select="$doc//workInfo/flowgraphurl/text()"/></c:set>
		<c:set var="isEzFlow"><x:out select="$doc//workInfo/isEzFlow/text()"/></c:set>
			<section class="page-content wh-section wh-section-bottomfixed" id="mainContent">
            <div class="webapp-form">
              <div class="app-tabheader-line clearfix">
                <div class="clearfix">            
					<a href="#tab11" class="tab-link active" style="width:50%">
						<span>流程表单</span>
					</a>
					<a href="#tab13" class="tab-link tab-link-rw" style="width:50%">
						<span>流程记录</span>
					</a>               
                </div>
              </div>
              <div class="tabs">
                <!-- 流程表单 -->
                <div id="tab11" class="tab active">
                  <div class="form-table">
                    <table style="border-collapse:separate;border-spacing: 0 10px;">
					<c:if test="${not empty docXml2}"><!--2-->
					<x:parse xml="${docXml2}" var="doc2"/>
						<!--主表信息begin-->
						<x:forEach select="$doc2//fieldList/field" var="fd" >
							<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
							<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
							<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
							<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
                      <tr>
                        <td>
                          <span>	
						  <c:if test="${mustfilled == '1' && readwrite == '1'}">
						  <em>*</em>
						  </c:if>
						  <x:out select="$fd/name/text()"/>						  
						  ：						  
						  </span>
                        </td>
                        <td>
                          <c:choose>
								<%--附件上传 115--%>
								<c:when test="${showtype =='115'}">
									<c:set var="values"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty values}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="customform";
										String aValues =(String)pageContext.getAttribute("values");
										aValues = aValues.replaceAll("&amp;", "&");
										String[] aval  = aValues.split(";");
										String[] aval0=new String[0];
										String[] aval1=new String[0];
										if(aval[0] != null && aval[0].endsWith(",")) {
											saveFileNames =aval[0].substring(0, aval[0].length() -1);
											saveFileNames =saveFileNames.replaceAll(",","|");
										}
										if(aval[1] != null && aval[1].endsWith(",")) {
											realFileNames =aval[1].substring(0, aval[1].length() -1);
											realFileNames =realFileNames.replaceAll(",","|");
										}
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
								</c:when>

								<%--Word编辑 116--%>
								<c:when test="${showtype =='116'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames =(String)pageContext.getAttribute("filename")+".doc";
										saveFileNames =(String)pageContext.getAttribute("filename")+".doc";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
								</c:when>

								<%--Excel编辑 117--%>
								<c:when test="${showtype =='117'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames =(String)pageContext.getAttribute("filename")+".xls";
										saveFileNames =(String)pageContext.getAttribute("filename")+".xls";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
								</c:when>

								<%--WPS编辑 118--%>
								<c:when test="${showtype =='118'}">
									<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
									<c:if test="${not empty filename}">
										<%
										String realFileNames ="";
										String saveFileNames ="";
										String moduleName ="information";
										realFileNames =(String)pageContext.getAttribute("filename")+".wps";
										saveFileNames =(String)pageContext.getAttribute("filename")+".wps";
										%>
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
											<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
											<jsp:param name="moduleName" value="<%=moduleName%>" />
										</jsp:include>
									</c:if>
								</c:when>

								<%--批示意见 401--%>
								<c:when test="${showtype =='401' }">
									<x:forEach select="$fd//dataList/comment" var="ct" >
										<c:set var="data"><x:out select="$ct//date/text()"/></c:set>
										<%
											String newData =(String)pageContext.getAttribute("data");
											if(newData !=null && newData !="" && newData !="null"){
												newData = newData.substring(0,16);
											}
										%>
										<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<%=newData%>)<br/>
									</x:forEach>
									<%
										StringBuilder saveNames = new StringBuilder();
										StringBuilder showNames = new StringBuilder();
									%>
									<c:set var="fileNum" value="0"/>
									<x:forEach select="$fd//dataList/comment/attachments/file" var="file">
										<c:set var="saveName" ><x:out select="$file/saveName/text()" /></c:set>
										<c:set var="showName" ><x:out select="$file/showName/text()" /></c:set>
										<c:set var="fileNum" value="${fileNum+1}"/>
										<%
										saveNames.append(pageContext.getAttribute("saveName").toString()).append("|");
										showNames.append(pageContext.getAttribute("showName").toString()).append("|");
										%>
									</x:forEach>
									<c:if test="${fileNum > 0}">
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=showNames.toString() %>" />
											<jsp:param name="saveFileNames" value="<%=saveNames.toString() %>" />
											<jsp:param name="moduleName" value="workflow_acc" />
										</jsp:include>
									</c:if>
								</c:when>

								<c:otherwise>
									<x:out select="$fd/value/text()"/>
								</c:otherwise>
							</c:choose>
                        </td>
                      </tr>
					  </x:forEach>
					  <!--主表信息end-->
						<!--子表信息begin-->
						<%--<c:set var="subTable" ></c:set>
						<x:forEach select="$doc2//subTableList/subTable/subFieldList" var="ct" varStatus="xh">
							<c:set var="subTable" >${xh.index+1}</c:set>
						</x:forEach>
						<c:if test="${not empty subTable}">
						<tr>
							<th>子表填写：</th>
							<td>
								<input type="text" class="edit-ipt-r" value="${subTable}条子表数据" onclick="addSubTable(${param.workId});"/>
							</td>
						</tr>
						</c:if>
						--%>
						<x:forEach select="$doc2//subTableList/subTable" var="st">
							<c:set var="subTable"></c:set>
							<x:forEach select="$st/subFieldList" var="ct" varStatus="xh">
								<c:set var="subTable" >${xh.index+1}</c:set>
							</x:forEach>
							<c:set var="subName" ><x:out select="$st/name/text()"/></c:set>
							<c:set var="subTableName" ><x:out select="$st/tableName/text()"/></c:set>
							<input name="subTableName" value="${subTableName}" type="hidden" />
							<input name="subName" value="${subName}" type="hidden" />
							<tr>
								<td><span>子表填写：</span></td>
								<td>
								    <div class="edit-direct">
									<input id="subTableInput" placeholder="添加子表" type="text" class="edit-ipt-r edit-ipt-arrow" 
									<c:if test="${not empty subTable}">value="${subTable}条子表数据"</c:if>
									 readonly="readonly" onclick="addSubTable('${subTableName}');"/>
                                    </div>
								</td>
							</tr>
						</x:forEach>
						<!--子表信息end-->
	
						<!--批示意见begin-->
						<x:forEach select="$doc2//commentList/comment" var="ct" >
							<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
							<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
							<c:set var="data"><x:out select="$ct//date/text()"/></c:set>
							<%
								String newData =(String)pageContext.getAttribute("data");
								if(newData !=null && newData !="" && newData !="null"){
									newData = newData.substring(0,16);
								}
							%>
							<tr>
								<td><span><x:out select="$ct//step/text()"/>：</span></td>
								<td>
									<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<%=newData%>)<br/>
									<%
										StringBuilder saveNames = new StringBuilder();
										StringBuilder showNames = new StringBuilder();
									%>
									<c:set var="fileNum" value="0"/>
									<x:forEach select="$ct/attachments/file" var="file">
										<c:set var="saveName" ><x:out select="$file/saveName/text()" /></c:set>
										<c:set var="showName" ><x:out select="$file/showName/text()" /></c:set>
										<c:set var="fileNum" value="${fileNum+1}"/>
										<%
										saveNames.append(pageContext.getAttribute("saveName").toString()).append("|");
										showNames.append(pageContext.getAttribute("showName").toString()).append("|");
										%>
									</x:forEach>
									<c:if test="${fileNum > 0}">
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=showNames.toString() %>" />
											<jsp:param name="saveFileNames" value="<%=saveNames.toString() %>" />
											<jsp:param name="moduleName" value="workflow_acc" />
										</jsp:include>
									</c:if>
								</td>
							</tr>
						</x:forEach>
						<!--批示意见end-->
	
						<!--退回意见begin-->
						<c:set var="backcomment" ><x:out select="$doc2//backComment/text()"/></c:set>
						<c:if test="${not empty backcomment}">
							<tr>
								<th>退回意见：</th>
								<td>${backcomment}</td>
							</tr>
						</c:if>
						<!--退回意见end-->
					</c:if>
					</table>
                  </div>
                </div>
                <!-- 流程图加载 -->
                <div id="tab12" class="tab">  
                  <p><img id="wfImg" width="100%" class="lazy lazy-fadeIn"></p> 
                </div>
                <!-- 流程图记录 -->
                <div id="tab13" class="tab">
                  <div class="form-table-record">
                    <table style="border-collapse:separate;border-spacing: 0 10px;" id="workflowlog">
                     
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
  </div>
  <div class="fbtn-more-nav popover popover-links" id="footerButton">
    <div class="fbtn-more-nav-inner" id="fbtn-more-list">
      <a href="#" class="panel-add-a close-popover">加签</a>
      <a href="#" class="panel-turn-a fbtn-grey close-popover">转办</a>
      <a href="#" class="panel-read-a close-popover">阅件</a>
      <a href="#" class="panel-press-a close-popover">催办</a>
    </div>
  </div>
  </c:if>
  <jsp:include page="../common/include_workflow_subTable_view.jsp" flush="true">
	<jsp:param name="docXml" value="${docXml2}" />
	<jsp:param name="orgId" value="<%=orgId %>" />
  </jsp:include>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
  <script type="text/javascript">
  //Export DOM7 to local variable to make it easy accessable
  var myApp = new Framework7();
  var $$ = Dom7;

  //右下角菜单弹框
  $$('#fbtn-more').on('click', function() {
    var clickedLink = this;
    myApp.popover('#footerButton', clickedLink);
    myApp.closeModal('#fbtn-more-list a')
  });
 
  //退回
  $$('.panel-return-a').on('click', function () { 
    $$(".panel-sub").hide();
    $$(".panel-return").show();
    myApp.openPanel('right');
  });
  //发送
  $$('.panel-send-a').on('click', function () {
    $$(".panel-sub").hide();
    $$(".panel-send").show();
    myApp.openPanel('right');
  });
  //加签
  $$('.panel-add-a').on('click', function () {
    $$(".panel-sub").hide();
    $$(".panel-add").show();
    myApp.openPanel('right');
  });
  //转办
  $$('.panel-turn-a').on('click', function () {
    $$(".panel-sub").hide();
    $$(".panel-turn").show();
    myApp.openPanel('right');
  });
  //阅件
  $$('.panel-read-a').on('click', function () {
    $$(".panel-sub").hide();
    $$(".panel-read").show();
    myApp.openPanel('right');
  });
  //催办
  $$('.panel-press-a').on('click', function () {
    $$(".panel-sub").hide();
    $$(".panel-press").show();
    myApp.openPanel('right');
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
    
	var flowgraphurl = '${flowgraphurl}';
	$(document).ready(function(){
	 workFlowGetLog('/defaultroot/dealfile/workFlowGetLog.controller');
	});
    var flag = '0';
	function workFlowGraph(){
		if(flowgraphurl!='' && flowgraphurl!=undefined && flag =='0'){
			openImg(flowgraphurl);
		}
	}
	
	//解决input输入框的问题
	document.write( '<style>#footerButton{visibility:hidden}@media(min-height:' + ($( window ).height() - 10) + 'px){#footerButton{visibility:visible}}</style>' );
	if(/Android [4-6]/.test(navigator.appVersion)) {
	    window.addEventListener("resize", function() {
	        if(document.activeElement.tagName=="INPUT" || document.activeElement.tagName=="TEXTAREA") {
	            window.setTimeout(function() {
	                document.activeElement.scrollIntoViewIfNeeded();
	            },0);
	        }
	    })
	}
	//解决input输入框的问题
	
	//加载流程图
	function openImg(fileName) {
		myApp.showPreloader('正在加载...');
		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/downloadImg.controller",
			 dataType:'text',
			 data : {"fileName": fileName,"name": fileName,"path":"workflow_acc","realtime":"1"},
			 success: function(data){
			 $('#wfImg').attr("src", "<%=rootPath%>"+data);
			 flag = '1';
			 myApp.hidePreloader();
			 },error: function(xhr, type){
				 myApp.alert('数据查询异常！');
			 }
		
		});
	}
  

	//流程记录
	   function workFlowGetLog(url){
		var val = '<%=workId%>';
        $.ajax({
            type: 'post',
            url: url,
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
                	addDom +='<tr>'
                        +'<td width="33.2%">'
                        +'  <div class="step-username">'
                         +'   <p>'+listData[i].logUserName+' </p>'
                        +'    <em>'+(listData[i].logTime!=null?listData[i].logTime.substring(2,listData[i].logTime.length):"")+'</em>'
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
            },
            error: function(xhr, type){
                myApp.alert('数据查询异常！');
            }
        });
    }
 
  </script>
</body>
