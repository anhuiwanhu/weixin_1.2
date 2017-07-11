<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="/clientview/common/headerInit.jsp" %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>文件办理</title>
</head>
<%
	String worktitle = request.getParameter("worktitle")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("worktitle"));
	String workcurstep = request.getParameter("workcurstep")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("workcurstep"));
	String worksubmittime = request.getParameter("worksubmittime")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("worksubmittime"));
	String workStatus = request.getParameter("workStatus")==null?"":com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("workStatus"));
	String userId = session.getAttribute("userId").toString();
	String fromPage = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("fromPage"));
%>
<body class="grey-bg">
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
  <div class="views">
    <div class="view view-main">
      <div class="pages">
        <div class="page" data-page="page-webapp-step-operation">
          <section class="wh-section wh-section-bottomfixed" id="mainContent">
           <div class="step-operation" style="display: block;">
            <div class="panel-sub panel-return" style="display: block;">
              <div class="panel-title">
                <p class="panel-title-p">加签选项</p>
              </div>
              <c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
				<form id="sendForm" class="dialog" action="/defaultroot/workflow/updateprocess2.controller" method="post">
					<c:set var="scopeType"><x:out select="$doc//scopeType/text()"/></c:set>
					<input type="hidden" value="<c:out value='${param.workId}' escapeXml='false'/>" name="workId"/>
					<input type="hidden" id="hasReceiveWf" value='<x:out select="$doc//sendedUser/text()"/>'/>
					<input type="hidden" id="isEzflow" value='<x:out select="$doc//isezflow/text()"/>'/>
					<input type="hidden" id="fromFlag" name="fromFlag"  value="<c:out value='${param.fromFlag}' escapeXml='false'/>" />
					<div class="panel-con">
		                <p class="panel-title-p">选择办理人：</p>
		                <div class="panel-direct">
						    <c:set var="scopeType"><x:out select="$doc//scopeType/text()"/></c:set>
							<x:if select="$doc//scopeType/text() = 'default_users' ">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='<x:out select="$doc//scopeId/text()"/>' />
			           			<input type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='<x:out select="$doc//scopeName/text()"/>' class="edit-ipt-r" />
							</x:if>
							<x:if select="$doc//scopeType/text() = 'scopes_user' ">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
			           			<input type="text" readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$doc//scopeId/text()"/>");' placeholder="请选择"/>
							</x:if>
							<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
			           			<input type="text" readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$doc//scopeId/text()"/>");' placeholder="请选择"/>
							</c:if>
		                </div>
		             </div>
		             <div class="panel-con">
		                <p class="panel-title-p">当前办理环节：</p>
		                <div class="panel-direct2">
		                  <p><%=workcurstep%></p>
		                </div>
		             </div>
				</form>
				</c:if>
            </div>
          </div>
        </section>
        <div class="panel-btn" id="footerButton">
           	<a href="javascript:onSubmit();" class="panel-btn-a panel-close">确认加签</a>
         </div>
       <section id="selectContent" style="display:none">
		</section>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript">
  var myApp = new Framework7();
  var mainView = myApp.addView('.view');
  var $$ = Dom7;
  //右下角菜单弹框
  $$('#fbtn-more').on('click', function () {
    var clickedLink = this;
    myApp.popover('#fbtn-more-con', clickedLink);
    myApp.closeModal('#fbtn-more-list a')
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
    
	//配合evo原表单
	$(document).ready(function(){
		var apptype ='<%=apptype%>';
		if(apptype == 'evo'){
			setTimeout(function(){$imag.exec("deleteOriginalFormView()");},500);
		}
	});

  	//加签防止重复提交
  	var addsignFlag='0';
	function onSubmit(){
	    if(addsignFlag=='1'){
	    	return false;
	    }
	    addsignFlag='1';
	    var userId = '<%=userId%>';
	  	var cbUserId =$("#chooseUserId").val();
		var cbUserName = $("#chooseUserName").val();
		var isEzFlow = $("#isEzFlow").val();
		if(cbUserId == ""){
			myApp.alert("办理人不能为空！");
			addsignFlag='0';
			return false;
		}
		var hasReceive = $('#hasReceiveWf').val();
		var hasArr = hasReceive.split(',');
		for(var i=0; i<hasArr.length;i++){
		if(isEzFlow == '1' || isEzFlow == 1){
			if(cbUserName.indexOf(hasArr[i]+',')>-1 || cbUserName.indexOf(userId+',')>-1){
				myApp.alert('加签办理人不能包含当前活动办理人！');
				addsignFlag='0';
				return false;
			}
		}else{
			if(cbUserId.indexOf(hasArr[i]+',')>-1 || cbUserId.indexOf(userId+',')>-1){
				myApp.alert('加签办理人不能包含当前活动办理人！');
				addsignFlag='0';
				return false;
			}
		}	
		}
		var url ='/defaultroot/workflow/workflowAddSign.controller';
		var openUrl ='/defaultroot/dealfile/list.controller?workStatus=<%=workStatus%>';
		myApp.showPreloader('正在加签');
		$.ajax({
			type: 'POST',
			url: url,
			data: $('#sendForm').serialize(),
			async: true,
			dataType: 'text',
			success: function(data){
				var fromPage = '<%=fromPage%>';
				myApp.hidePreloader();
				var json = eval("("+data+")");
				if(json!=null){
					if(json.result == 'success'){
						myApp.alert("加签成功！");
						//window.location.href =openUrl;
						var fromFlag = $("#fromFlag").val();
						if(fromPage == 'evo'){
							$imag.exec('closeEvoPage()');
						}else{
							if(fromFlag == '1'){
								window.history.go(-2);
							}else{
								WeixinJSBridge.call('closeWindow');
							}
						}
					}else{
						addsignFlag='0';
						myApp.alert("加签失败！");
					}
				}
			},
			error: function(){
				addsignFlag='0';
				myApp.alert("异常！");
			}
		});
	}
	
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		var selectIdVal = $('input[name="'+selectId+'"]').val();
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
		myApp.showPreloader('页面加载中...');
		$.ajax({
			url : '/defaultroot/newperson/personList.controller',
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$("#selectContent").append(data);
				hiddenContent(0);
				myApp.hidePreloader();
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
	
	//选人选组织代码-----开始
	function hiddenDiv(flag){
		if(flag==0){
			document.getElementById("dd").style.display="none";
			document.getElementById("user").style.display="";
		}else if(flag==1){
			document.getElementById("dd").style.display="";
			document.getElementById("user").style.display="none";
			document.getElementById("user").innerHTML="";
		}
	}
	
	/**
	 * range：选人范围
	 * selectUserId：赋值的用户ID，用于程序保存用
	 * selectUserName：赋值的用户名称，用于页面展示
	 * flag：user：选人；org：选组织
	 * selectType：选择类型，radio：单选；checkbox：多选
	 */
	function selectUserWithConditions(range,selectUserId,selectUserName,flag,selectType){
		var url_param ='/defaultroot/person/newsearch.controller';
		url_param +='?range='+range;
		
		var selectedUserId = document.getElementById(selectUserId).value;
		if(selectType =='radio'){//处理选中问题
			selectedUserId = selectedUserId + ",";
		}
		url_param += "&type=1";//文件办理中选人特有参数 0：文件办理选人字段 1：一般选人
		url_param += "&selectUserId="+selectUserId;
		url_param += "&selectUserName="+selectUserName;
		url_param += "&flag="+flag;
		url_param += "&selectType="+selectType;//选择类型
		url_param += "&selectedUserId="+selectedUserId;//已选中的赋值
		XHReq(url_param,'user', false, false);
		hiddenDiv(0);
	}
</script>
</body>