<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ include file="../common/headerInit.jsp" %>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>会议转发</title>
    <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.style.ios.min.css" />
    <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.webapp-style.min.css" />
    <link rel="stylesheet" href="<%=rootPath%>/clientview/template115/css/alert/template.alert.css" />
</head>
<%
	String orgId = session.getAttribute("orgId").toString();
	String userId = session.getAttribute("userId").toString();
%>
<body>
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
    <div class="view view-main">
        <div class="pages">
            <div class="page" data-page="page-webapp-mail">
                <section class="meeting-hzzt meeting-open wh-section wh-section-bottomfixed" id="mainContent">
                    <div class="mail-todo">
                        <div class="app-tabheader-line clearfix">
                            <div class="clearfix">
                                <a href="#tab-mail-todo1" class="tab-link active">
                                     <span>转发选项</span>
                                </a>
                                <a href="#tab-mail-todo2" class="tab-link ">
                                     <span>转发记录</span>
                                </a>
                            </div>
                        </div>
                        <div class="tabs">
                            <!-- Tab 1, 默认激活 -->
                            <div id="tab-mail-todo1" class="tab active">
                                <header class="meeting-open-head">
                                    <div class="title">
                                       <p>
											<c:choose>
												<c:when test="${param.noticeTypeName != null && param.noticeTypeName != 'null' && param.noticeTypeName != ''}">
													 <em class="skyblue">${param.noticeTypeName}</em>
												</c:when>
												<c:otherwise>	
												</c:otherwise>
											</c:choose>
						                   	<span>${param.meetingMotif}</span>
						                </p>
                                    </div>
                                </header>
                                <form id="receiptForm">
                                	<div class="mail-edit">
                                   <div class="wh-container">
                                     <table class="wh-table-edit" style="border-collapse:separate;border-spacing:0;">
                                         <tr>
						                    <th class="" style="width: 10rem;border-bottom: 1px solid #ccc">转发人员：</th>
						                    <td>
						                        <input type="text" style="width: 75%;border: none;" id="joinMeetUserName" name="joinMeetUserName" readonly="readonly" placeholder="请选择" onclick='selectUser("1","joinMeetUserName","joinMeetUserId","*0*");'/>
						                        <input type="hidden" value="" name="joinMeetUserId" id="joinMeetUserId"/>
						                        <input type="hidden" value="${param.noticeId}" name="noticeId" id="noticeId"/>
						                        <span class="document-span" onclick='selectUser("1","joinMeetUserName","joinMeetUserId","*0*");'>&#xf005;</span>
						                    </td>
						                  </tr>
						                  <x:parse xml="${docXml}" var="doc" />
						                  <c:set var="mail"><x:out select="$doc//mail/text()"/></c:set>
						                  <c:set var="rtx"><x:out select="$doc//rtx/text()"/></c:set>
						                  <c:set var="sms"><x:out select="$doc//sms/text()"/></c:set>
						                  <c:set var="mobile"><x:out select="$doc//mobile/text()"/></c:set>
						                  <tr class="txfs">
                                             <th class="" style="border-bottom: 1px solid #ccc">提醒方式：</th>
                                             <td>
                                               	<div class="edit-txta-box">
                                                    <ul class="edit-radio">
		                                                <c:if test="${mail == true || mail == 'true'}">
							                            	<li>
			                                                    <label class="label-checkbox item-content">
			                                                        <input type="checkbox" name="mail" value="1">
			                                                        <span class="edit-radio-l">邮件</span>
			                                                    </label>
			                                                </li>
							                            </c:if>
							                            <c:if test="${rtx == true || rtx == 'true'}">
							                             	<li>
			                                                    <label class="label-checkbox item-content">
			                                                        <input type="checkbox" name="rtx" value="1">
			                                                        <span class="edit-radio-l">即时通讯</span>
			                                                    </label>
			                                                </li>
							                            </c:if>
							                            <c:if test="${sms == true || sms == 'true'}">
							                             	<li>
			                                                    <label class="label-checkbox item-content">
			                                                        <input type="checkbox" name="sms" value="1">
			                                                        <span class="edit-radio-l">短信</span>
			                                                    </label>
			                                                </li>
							                            </c:if>
							                            <c:if test="${mobile == true || mobile == 'true'}">
							                             	<li>
			                                                    <label class="label-checkbox item-content">
			                                                        <input type="checkbox" name="mobile" value="1">
			                                                        <span class="edit-radio-l">移动端</span>
			                                                    </label>
			                                                </li>
							                            </c:if>
		                                             </ul>
		                                          </div>
                                             </td>
                                         </tr>
                                         <tr class="txfs">
                                             <th class="" style="border-bottom: 1px solid #ccc">同步到日程：</th>
                                             <td>
                                               	<div class="edit-txta-box">
                                                    <ul class="edit-radio">
						                             	<li>
		                                                    <label class="label-checkbox item-content">
		                                                        <input type="checkbox" name="event" value="1">
		                                                        <span class="edit-radio-l">同步到日程</span>
		                                                    </label>
		                                                </li>
		                                             </ul>
		                                          </div>
                                             </td>
                                         </tr>
						                  <tr>
						                    <th colspan="2" style="border-bottom: none;">转发备注：</th>
						                  </tr>
						                  <tr>
						                    <td colspan="2" style="padding: 0 1rem 1rem 0;">
						                      <div class="edit-txta-box">
						                        <textarea class="edit-txta edit-txta-l" style="font-family: Helvetica,Arial,sans-serif;" name="remark" id="remark" maxlength="500" placeholder="请输入文字"></textarea>
						                      </div>
						                    </td>
						                  </tr>
                                     </table>
                                   </div>
                                 </div>
                                </form>
                                <footer class="footer-hzzt" id="footerButton">
                                     <a href="###" onclick="saveForward();">提交</a>
                                </footer>
                            </div>
                            <!-- Tab 2 -->
                            <div id="tab-mail-todo2" class="tab">
                             <header class="meeting-open-head">
                                    <div class="title">
                                       <p>
											<c:choose>
												<c:when test="${param.noticeTypeName != null && param.noticeTypeName != 'null' && param.noticeTypeName != ''}">
													 <em class="skyblue">${param.noticeTypeName}</em>
												</c:when>
												<c:otherwise>	
												</c:otherwise>
											</c:choose>
						                   	<span>${param.meetingMotif}</span>
						                </p>
                                    </div>
                                </header>
                                  <div class="wh-container">
                                    <div class="hzzt-list" id="forwardLog">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section id="selectContent" style="display:none">
		  		</section>
          </div>
     </div>
  </div>
</div>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
    <script type="text/javascript">
    var myApp = new Framework7();
    var $$ = Dom7;
    //添加视图
    var mainView = myApp.addView('.view');
   $$("ul.edit-radio li").click(function(){
       if($$(this).hasClass("radio-active")){
          $$(this).removeClass("radio-active");
      }
      else{
          $$(this).addClass("radio-active");
      }
  })
  
   $(document).ready(function(){
	  getForwardLog('/defaultroot/newmeeting/getForwardLog.controller');
   });
  
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
	
    //流程记录
    function getForwardLog(url){
		var val = $('#noticeId').val();
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'noticeId':val},
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
                var length=0;
                var addDom = '<ul>'; 
                for(var i = 0;i < listData.length; i++){
                	length=1;
                	addDom +='<li><div class="libox clearfix"><div class="le-1 fl">'+listData[i].sender+'</div>'
		                   +'<div class="mid-1 fl"><span>'+listData[i].sendDate+'</span><em>转发给 </em></div>'
		                   +'<div class="ri-1 fl">'+listData[i].attendnames+'</div></div>'
		                   +'<p>'+listData[i].remark+'</p></li>';
                }
                addDom += '</ul>';
                if(length==0){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#forwardLog').append(addDom);
            },
            error: function(xhr, type){
                myApp.alert('数据查询异常！');
            }
        });
    }
  
  function changeJoin(joinFlag){
   	 $('#isJoin').val(joinFlag);
   }
  
   var comflag = 1;
   function saveForward(){
   	if(comflag==0){
   		return;
   	}
   	if($$('#joinMeetUserId').val() == ''){
		myApp.alert('转发人员不能为空！');
		return;
	}
   	comflag = 0;
   	var val = $('#noticeId').val();
	$$.ajax({
		url : "/defaultroot/newmeeting/meetingSaveforward.controller",
		data : $("#receiptForm").serialize(),
		type : "post",
		success : function(data){
			var jsonData = eval("("+data+")");
			if(jsonData.result == 'success'){
				myApp.alert('转发成功！', function () {
			      	 //window.location="/defaultroot/newmeeting/meetingNoticeDetail.controller?noticeId="+val;
			      	 //window.history.back();
			      	 window.history.go(-1);
			     });
			}else if(jsonData.result == 'fail'){
				comflag = 1;
				myApp.alert("转发失败！");
			}
		},
		error : function(){
			comflag = 1;
			myApp.alert("转发异常！");
		}
	});
   }
    
    //打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		myApp.showPreloader('正在加载中...');
		$.ajax({
			url : '/defaultroot/newperson/personList.controller',
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':$('#'+selectId).val(),'range':range},
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
    </script>
</body>
