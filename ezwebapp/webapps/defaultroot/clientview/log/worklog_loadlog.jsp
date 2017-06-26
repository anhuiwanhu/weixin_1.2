<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ include file="../common/headerInit.jsp" %>
<%
	String logFlag =  com.whir.component.security.crypto.EncryptUtil.sqlcode(com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("logFlag")));
 %>
<head lang="en">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1">
	<title>查看日志</title>
	<link rel="stylesheet" href="<%=rootPath%>/clientview/template115/css/alert/template.alert.css" />
	<link rel="stylesheet" href="/defaultroot/clientview/frameworktemplate/css/template.style.colors.min.css" />
	<link rel="stylesheet" href="/defaultroot/clientview/frameworktemplate/css/template.style.min.css" />
	
</head>

<body class="theme-green">
 <c:if test="${not empty docXml}">
 <x:parse xml="${docXml}" var="doc"/>
  <div class="views">
    <div class="view view-content">
      <div class="pages">
        <div class="page">
          <section id="sectionScroll" class="wh-section wh-section-bottomfixed">
            <article class=" wh-edit wh-article wh-article-document wh-article-log wh-article-log-edit">
              <c:set var="weather"><x:out select="$doc//logDetail/weather/text()"/></c:set>
              <c:set var="logDate"><x:out select="$doc//logDetail/logDate/text()"/></c:set>
              <c:set var="logType"><x:out select="$doc//logDetail/logType/text()"/></c:set>
              <c:set var="logId"><x:out select="$doc//logDetail/id/text()"/></c:set>
              <div>
                <div class="log-edit-tip clearfix">
                  <ul>
                    <li <c:if test="${weather == '晴天'}">class="current"</c:if>>
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
                </div>
                <table class="wh-table-edit">
                  <tbody>
                    <tr>
                      <th>日期：</th>
                      <td>
                        <div class="edit-ipt-a-arrow">
                          <input class="edit-ipt-r edit-ipt-arrow" id="scroller" type="text" name="scroller" placeholder="选择日期" readonly="" value="${logDate }">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th>日志类型：</th>
                      <td>
                        <ul class="edit-radio">
                          <li>
                            <label class="label-radio item-content">
                              <input disabled="disabled" type="radio" name="my-radio" value="实名" <c:if test="${logType == '0'}">checked="checked"</c:if>>
                              <span class="edit-radio-l">全天日志</span>
                            </label>
                          </li>
                          <li>
                            <label class="label-radio item-content">
                              <input disabled="disabled" type="radio" name="my-radio" value="实名" <c:if test="${logType == '1'}">checked="checked"</c:if>>
                              <span class="edit-radio-l">分时段日志</span>
                            </label>
                          </li>
                        </ul>
                      </td>
                    </tr>
                    <c:if test="${logType == '0'}">
	                    <tr>
	                      <th>工时：</th>
	                      <td>
	                        <div class="edit-ipt-r">
	                          <span><x:out select="$doc//logDetail/workHour/text()"/></span>
	                        </div>
	                      </td>
	                    </tr>
                    </c:if>
                    <c:if test="${logType == '1'}">
	                    <tr>
	                      <th>分时段：</th>
	                      <td>
	                        <div class="edit-ipt-r">
	                          <span><x:out select="$doc//logDetail/startPeriod/text()"/>至<x:out select="$doc//logDetail/endPeriod/text()"/></span>
	                        </div>
	                      </td>
	                    </tr>
                    </c:if>
                    <tr>
                      <th>内容：</th>
                      <td>
                        <div class="edit-txta-box">
                          <textarea class="edit-txta edit-txta-l" readonly="readonly" placeholder=" "><x:out select="$doc//logDetail/logContent/text()"/>
                          </textarea>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th>项目编号：</th>
                      <td>
                        <p>
                        	<c:set var="projectCode"><x:out select="$doc//logDetail/projectCode/text()"/></c:set>
                        	<c:if test="${projectCode!='null' }">
                        		<x:out select="$doc//logDetail/projectCode/text()"/>
                        	</c:if>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <th>项目名称：</th>
                      <td>
                        <p>
                        	<c:set var="projectName"><x:out select="$doc//logDetail/projectName/text()"/></c:set>
                        	<c:if test="${projectName!='null' }">
                        		<x:out select="$doc//logDetail/projectName/text()"/>
                        	</c:if>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <th>结果：</th>
                      <td>
                        <p>
                        	<c:set var="workResult"><x:out select="$doc//logDetail/workResult/text()"/></c:set>
                        	<c:if test="${workResult!='null' }">
                        		<x:out select="$doc//logDetail/workResult/text()"/>
                        	</c:if>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <th>备注：</th>
                      <td id="bzstyle">
                      		<c:set var="remark">${remark} </c:set>
                        	<c:if test="${remark!='null' }">
                        		${fn:replace(remark,"nbsp;", "")}
                        	</c:if>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <div class="log-notice">
                </div>
                <div class="log-notice-con">
                  <p style="font-size:1.3rem;color:#000;font-weight:bold">留言：</p>
                </div>
                <div class="log-notice-list">
                	<x:forEach select="$doc//logDetail/commentList/comment" var="list" >
                		<c:set var="name"><x:out select="$list/name/text()"/></c:set>
                		<c:set var="date"><x:out select="$list/date/text()"/></c:set>
                		<c:set var="content"><x:out select="$list/content/text()"/></c:set>
		                <li>
		                  <span>${name }</span>&nbsp;&nbsp;&nbsp;<em>${date }</em>
		                  <p>${content }</p>
		                </li>
	                </x:forEach>
	                <li>
		                  
		            </li>
                </div>
              </div>
            </article>
          </section>
          <footer class="wh-footer wh-footer-forum">
          <form method="post" id="saveComment">
          		<input type="hidden" name="logId" id="logId" value="${logId }"/>
          		<input type="hidden" name="content" id="content"/>
          	</form>
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix" style="padding-top: 2.2rem;">
                  <c:set var="logFlag"><%=logFlag %></c:set>
                  <c:choose>
                  	<c:when test="${logFlag == '0' }">
                  		<a href="javascript:updateLog('${logId }');" style="display:inline;line-height:0;" class="fbtn-cancel col-50">修改日志</a>
                  		<a href="javascript:subprompt();" style="display:inline;line-height:0;" class="fbtn-matter col-50 log-submit">提交留言</a>
                  	</c:when>
                  	<c:otherwise>
                  		<a href="javascript:subprompt();" style="display:inline;line-height:0;" class="fbtn-matter col-100 log-submit">提交留言</a>
                  	</c:otherwise>
                  </c:choose>
                  	
                  </div>
                </div>
              </div>
            </div>
          </footer>
          <!--<footer class="wh-footer wh-footer-forum">
          	<form method="post" id="saveComment">
          		<input type="hidden" name="logId" id="logId" value="${logId }"/>
          		<input type="hidden" name="content" id="content"/>
          	</form>
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="wh-footer-btn row">
              	  <c:set var="logFlag">${param.logFlag}</c:set>
              	  <c:if test="${logFlag == '0' }">
                  	<a href="javascript:updateLog('${logId }');" class="fbtn-cancel col-50">修改日志</a>
                  	<a href="#" class="fbtn-matter col-50 log-submit">提交留言</a>
                  </c:if>
                  	<a href="#" class="fbtn-matter col-100 log-submit">提交留言</a>
                </div>
              </div>
            </div>
          </footer>
        --></div>
      </div>
    </div>
  </div>
  </c:if>
   <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
   <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/zepto.js"></script>
   <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/simplecalendar.js"></script>
   <script type="text/javascript" src="<%=rootPath%>/clientview/js/subClick.js"></script>
   <script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/alert/zepto.alert.js"></script>
   <script type="text/javascript"> 
    //Export DOM7 to local variable to make it easy accessable
    var myApp = new Framework7();
    var $$ = Dom7;
    var logId=$("#logId").val();
    var logFlag="${logFlag}";
    $(function(){
		if(logId==""){
			myApp.alert('该日志已被删除!', function () {
		      	getWorkLogList(logFlag)
		    });
			return;
		}
		loadImg();
  });
      
    $$('#bzstyle font').css("line-height","100%");
    
    function subprompt(){
    	 myApp.prompt('请输入留言内容', ' ', function (value) {
      	 if(value.replace(/\s/g,"") == ''){
      	 	myApp.alert('内容不能为空');
      	 	subprompt();
      	 	return;
      	 }
      	 if(/[\\\/?#&'"]+/g.test(value)){
				myApp.alert('内容不可以包含特殊字符！');
				subprompt();
				return false;
			}
      	  $$('#content').val(value);
      	  newComment();
      });
    }
	var comflag = 1;
	function newComment() {
		if(comflag == 0){
    		return;
    	}
    	comflag = 0;
		$$.ajax({
		    type: "post",
		    url: "/defaultroot/worklog/saveComment.controller",
		    data:$('#saveComment').serialize(),
		    success: function(data) {
		    	var jsonData = eval("("+data+")");
		    	var commentFlag = jsonData.data0;
		    	if(commentFlag){
		    		myApp.alert('保存成功!', function () {
				      	window.location= '/defaultroot/worklog/loadWorkLog.controller?workLogId=${logId}&logFlag=${logFlag}';
				      });
		    	}else{
		    		myApp.alert('保存失败！');
		    	}
		    }
		});
	}
	
	function loadImg(){
		$("input[name='pictureName']").each( 
			function (){
				var filename = $(this).val();
				var id = filename.substring(0,17);
				if(filename == 'null'){
					//alert("1111"+filename);
					//$('#'+id).attr("src","/defaultroot/clientview/images/user3.png");
				}else{
					//alert("2222--------->"+filename);
					$.ajax({
						type : 'post',
						url : '<%=rootPath%>/download/downloadImg.controller',
						dataType : 'text',
						data : {"fileName":filename,"name":filename,"path":"html"},
						success : function(data){
							$('#'+id).attr("src","<%=rootPath%>"+data);
							$('#'+id).attr("width","50%");
							$('#'+id).attr("hight","240");
						},
						error : function (xhr,type){
							//alert('数据查询异常！');
						}
					});
				}
			}		
		);
	}
	
	//打开附件
  	function downFile(menuHtmlLink,menuFileLink) {
 		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/getOpenFileUrl_New.controller",
			 dataType:'text',
			 data : {"fileName": menuHtmlLink,"name": menuFileLink,"path":"html"},
			 success: function(data){
			 	var jsonData = eval("("+data+")");
			 	clickSub(jsonData.url,$('#'+menuHtmlLink.substring(0,17)),menuHtmlLink,"html",jsonData.smartInUse,jsonData.isEncrypt,jsonData.tmpurl,jsonData.apptype);
			 },error: function(xhr, type){
				 alert('数据查询异常！');
			 }
		});
	}
	
	//日志列表
    function getWorkLogList(logFlag) {
		window.location= '/defaultroot/worklog/getWorkLogList.controller?logFlag='+logFlag;
	}
	//修改日志
    function updateLog(logId) {
		window.location = "/defaultroot/worklog/loadWorkLog.controller?workLogId="+logId+"&loadFlag=0";
	}
  </script>
</body>
</html>
