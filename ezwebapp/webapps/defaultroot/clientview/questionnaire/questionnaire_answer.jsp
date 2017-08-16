﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/clientview/common/taglibs.jsp"%>
<%@ include file="../common/headerInit.jsp" %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1">
  <title>调查问卷</title>
   <link rel="stylesheet" href="/defaultroot/clientview/frameworktemplate/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/frameworktemplate/css/template.style.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/frameworktemplate/css/template.style.colors.min.css" />
</head>
<body class="theme-green">
<c:if test="${empty docXml}">
	<script>
 		alert("该问卷调查已被删除");
 	</script>
</c:if>
<c:if test="${not empty docXml}">
<x:parse xml="${docXml}" var="doc"/>
  <div class="views">
    <div class="view view-content">
      <div class="pages">
        <div class="page">
          <form id="saveForm">
          <c:set var="questionnaireId"><x:out select="$doc//questionnaire/questionnaireId/text()"/></c:set>
          <c:set var="questionnaireTitle"><x:out select="$doc//questionnaire/questionnaireTitle/text()"/></c:set>
          <c:set var="isSubmitAnswered"><x:out select="$doc//questionnaire/isSubmitAnswered/text()"/></c:set>
          <section class="wh-section wh-section-bottomfixed">
            <article class="wh-edit wh-questionnaire wh-questionnaire-forum">
            <c:set var="answerNum" value="0" />
            <c:set var="title" value="" />
            <x:forEach select="$doc//questhemeRadioList" var="r" >
            	<c:set var="title"><x:out select="$r/questhemeTitle/text()"/></c:set>
           		<c:set var="answerNum">${answerNum+1 }</c:set>
            </x:forEach>
            <x:forEach select="$doc//questhemeCheckList" var="c" >
            	<c:set var="title"><x:out select="$c/questhemeTitle/text()"/></c:set>
            	<c:set var="answerNum">${answerNum+1 }</c:set>
            </x:forEach>
            <x:forEach select="$doc//questhemeEssayList" var="e" >
            	<c:set var="title"><x:out select="$e/questhemeTitle/text()"/></c:set>
            	<c:set var="answerNum">${answerNum+1 }</c:set>
            </x:forEach>
              <div class="wh-section-title">
              	<c:if test="${answerNum == 1}">${title }</c:if>
              	<c:if test="${answerNum != 1}">${questionnaireTitle }</c:if>
              	</div>
              <div class="wh-container">
              <!-- 单选 -->
               <c:set var="liNum" value="0" />
               <x:forEach select="$doc//questhemeRadioList" var="qr" >
               		<c:set var="liNum">${liNum+1 }</c:set>
               		<c:set var="questhemeId"><x:out select="$qr/questhemeId/text()"/></c:set>
               		<c:set var="questionnaireTitle"><x:out select="$qr/questhemeTitle/text()"/></c:set>
               		<c:set var="contents"><x:out select="$qr/contents/text()"/></c:set>
               		<c:set var="isOtherAnswer"><x:out select="$qr/isOtherAnswer/text()"/></c:set>
               		<c:set var="imgFlag" value=""/>
               		<x:forEach select="$qr//themeOptionList" var="tolPhoto" >
               			<c:set var="imgFlag"><x:out select="$tolPhoto/opImgSaveName/text()"/></c:set>
               		</x:forEach>
               		<div class="wj ques <c:if test="${imgFlag !='' }">wh-questionnaire-img-list clearfix</c:if>" >
	                  <h3><c:if test="${answerNum !=1 }">${liNum}.${questionnaireTitle }</c:if></h3>
	                  <c:if test="${contents !='' }">
	                  	<textarea readonly="readonly">${contents }</textarea>
	                  </c:if>
	                  <ul>
	                    <c:set var="customAnswer"></c:set>
	                  	<x:forEach select="$qr//themeOptionList" var="tolR" >
	                  		<c:set var="themeOptionId"><x:out select="$tolR/themeOptionId/text()"/></c:set>
	                  		<c:set var="themeOptionTitle"><x:out select="$tolR/themeOptionTitle/text()"/></c:set>
	                  		<c:set var="opImgSaveName"><x:out select="$tolR/opImgSaveName/text()"/></c:set>
	                  		<c:set var="isMySelected"><x:out select="$tolR/isMySelected/text()"/></c:set>
	                  		<c:set var="customAnswer"><x:out select="$tolR/customAnswer/text()"/></c:set>
	                  		<c:choose>
	                  			<c:when test="${opImgSaveName !='null' && opImgSaveName !=''}">
	                  				<li class="current" style="margin-bottom:0;">
				                      <em style="height:6rem">
				                      	<%
							            	String opImgSaveName = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("opImgSaveName"));
							            	String[] arr = opImgSaveName.split(",");
							            	for (int i = 0; i < arr.length; i++) {
							             %>	
							             	<c:set var="opImgSaveName" ><%=arr[i] %></c:set>
											<input type="hidden" name="imgNameRadio" value="<%=arr[i] %>" />
				                        	<img style="display:inline-block;max-width:50%;max-height:7rem;" id="Radio${fn:substring(opImgSaveName,0,25)}" src=''/>
				                        <%
				                        	}
				                         %>
				                      </em>
				                      <p>
				                        <label class="label-radio item-content" onclick="radioSel('${questhemeId}','${themeOptionId }')">
				                          <input type="radio" <c:if test="${isSubmitAnswered ==1 }">disabled</c:if> <c:if test="${isMySelected =='1' }">checked="checked"</c:if>  name="questhemeRadioList_${questhemeId }"  value="<x:out select="$tolR/themeOptionId/text()"/>">
				                          <span class="edit-radio-l">${themeOptionTitle }</span>
				                        </label>
				                      </p>
				                    </li>
	                  			</c:when>
	                  			<c:otherwise>
	                  				<li class="current">
				                      <label class="label-radio item-content" onclick="radioSel('${questhemeId}','${themeOptionId }')">
				                        <input type="radio" <c:if test="${isSubmitAnswered ==1 }">disabled</c:if> <c:if test="${isMySelected =='1' }">checked="checked"</c:if> name="questhemeRadioList_${questhemeId }" value="<x:out select="$tolR/themeOptionId/text()"/>">
				                        <span class="edit-radio-l">${themeOptionTitle }</span>
				                      </label>
				                    </li>
	                  			</c:otherwise>
	                  		</c:choose>
	                  	</x:forEach>
	                  	<c:if test="${isOtherAnswer == '1' }">
	                  	  <c:set var="isMyOtherAnswer"><x:out select="$qr/isMyOtherAnswer/text()"/></c:set>
                      	  <c:set var="myOtherAnswerContent"><x:out select="$qr/myOtherAnswerContent/text()"/></c:set>
                  			<li class="current">
		                      <label class="label-radio item-content" onclick="radioSel('${questhemeId}','other')">
		                        <input <c:if test="${isSubmitAnswered ==1 }">disabled</c:if>  <c:if test="${isMyOtherAnswer =='1' }">checked="checked"</c:if> type="radio" name="questhemeRadioList_${questhemeId }" value="">
		                        <span class="edit-radio-l">其他意见</span>
		                      </label>
		                    </li>
		                    <textarea readonly="readonly" class="textarea_a" name="questhemeRadioListOther_${questhemeId }" id="other_${questhemeId }" onblur="radioOther('${questhemeId }')">${myOtherAnswerContent }</textarea>
                  			<input class="edit-ipt-r" readonly="readonly" type="text"  />
                  		</c:if>
	                  </ul>
	                </div>
	                <input type="hidden" name="questhemeRadioList" id="${questhemeId }"/>
               </x:forEach>
               <!-- 复选 -->
               <x:forEach select="$doc//questhemeCheckList" var="qc" >
               		<c:set var="liNum">${liNum+1 }</c:set>
               		<c:set var="questhemeId"><x:out select="$qc/questhemeId/text()"/></c:set>
               		<c:set var="questionnaireTitle"><x:out select="$qc/questhemeTitle/text()"/></c:set>
               		<c:set var="contents"><x:out select="$qc/contents/text()"/></c:set>
               		<c:set var="isOtherAnswer"><x:out select="$qc/isOtherAnswer/text()"/></c:set>
               		<c:set var="imgCFlag" value=""/>
               		<input type="hidden" name = "checkQuesthemeId" value="${questhemeId }"/>
               		<x:forEach select="$qc//themeOptionList" var="tolCImg" >
               			<c:set var="imgCFlag"><x:out select="$tolCImg/opImgSaveName/text()"/></c:set>
               		</x:forEach>
               		<div class="wj ques <c:if test="${imgCFlag !='' }">wh-questionnaire-img-list clearfix</c:if>">
	                  <h3><c:if test="${answerNum !=1 }">${liNum}.${questionnaireTitle }</c:if></h3>
	                  <c:if test="${contents !='' }">
	                  	<textarea readonly="readonly">${contents }</textarea>
	                  </c:if>
	                  <ul>
	                  	<x:forEach select="$qc//themeOptionList" var="tolC" >
	                  		<c:set var="themeOptionId"><x:out select="$tolC/themeOptionId/text()"/></c:set>
	                  		<c:set var="themeOptionTitle"><x:out select="$tolC/themeOptionTitle/text()"/></c:set>
	                  		<c:set var="opImgSaveName"><x:out select="$tolC/opImgSaveName/text()"/></c:set>
	                  		<c:set var="isMySelected"><x:out select="$tolC/isMySelected/text()"/></c:set>
	                  		<c:choose>
	                  			<c:when test="${opImgSaveName !='null' && opImgSaveName !=''}"> 
	                  				<li class="current" style="padding:0">
				                     <em style="height:6rem">
				                     	<%
							            	String opImgSaveName = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("opImgSaveName"));
							            	String[] arr = opImgSaveName.split(",");
							            	for (int i = 0; i < arr.length; i++) {
												
							             %>	
							             	<c:set var="opImgSaveName" ><%=arr[i] %></c:set>
				                     		<input type="hidden" name="imgNameCheck" value="<%=arr[i] %>" />
				                        	<img style="display:inline-block;max-width:50%;max-height:7rem;" id="Check${fn:substring(opImgSaveName,0,25)}" src=''/>
				                   		 <%
				                        	}
				                         %>
				                     </em>
				                     <label class="label-checkbox item-content" onclick="checkSel('${questhemeId}','${themeOptionId }')">
				                       <input type="checkbox" <c:if test="${isSubmitAnswered ==1 }">disabled</c:if> <c:if test="${isMySelected =='1' }">checked="checked"</c:if> name="questhemeCheckList_${questhemeId }" value="<x:out select="$tolC/themeOptionId/text()"/>">
				                       <div class="item-media">
				                         <span class="edit-radio-r">${themeOptionTitle }</span>
				                       </div>
				                     </label>
				                   </li>
	                  			</c:when>
	                  			<c:otherwise>
	                  				<li style="padding:0">
				                      <label class="label-checkbox item-content" onclick="checkSel('${questhemeId}','${themeOptionId }')"> 
				                        <input type="checkbox" <c:if test="${isSubmitAnswered ==1 }">disabled</c:if> <c:if test="${isMySelected =='1' }">checked="checked"</c:if> name="questhemeCheckList_${questhemeId }" value="<x:out select="$tolC/themeOptionId/text()"/>">
				                        <div class="item-media">
				                          <span class="edit-radio-r">${themeOptionTitle }</span>
				                        </div>
				                      </label>
				                    </li>
	                  			</c:otherwise>
	                  		</c:choose>
	                  	</x:forEach>
	                  	<c:if test="${isOtherAnswer == '1' }">
	                  		<c:set var="isMyOtherAnswer"><x:out select="$qc/isMyOtherAnswer/text()"/></c:set>
                      	  <c:set var="myOtherAnswerContent"><x:out select="$qc/myOtherAnswerContent/text()"/></c:set>
                  			<li class="current">
		                      <label class="label-checkbox item-content" onclick="checkOther('${questhemeId}')"> 
		                        <input type="checkbox" id="cbox_${questhemeId }" <c:if test="${isMyOtherAnswer =='1' }">checked="checked"</c:if> <c:if test="${isSubmitAnswered ==1 }">disabled</c:if> name="questhemeCheckList_${questhemeId }" value="">
		                        <div class="item-media">
		                          <span class="edit-radio-r">其他意见</span>
		                        </div>
		                      </label>
		                    </li>
		                    <textarea readonly="readonly" class="textarea_a" name="questhemeCheckListOther_${questhemeId }" id="other_${questhemeId }" >${myOtherAnswerContent }</textarea>
		                    <input class="edit-ipt-r" readonly="readonly" type="text"  />
                  		</c:if>
	                  </ul>
	                </div>
	                <input type="hidden" name="questhemeCheckList" id="${questhemeId }"/>
               </x:forEach>
                <!-- 问答题 -->
                 <x:forEach select="$doc//questhemeEssayList" var="qe" >
                 	<c:set var="liNum">${liNum+1 }</c:set>
               		<c:set var="questhemeId"><x:out select="$qe/questhemeId/text()"/></c:set>
               		<c:set var="questionnaireTitle"><x:out select="$qe/questhemeTitle/text()"/></c:set>
               		<c:set var="contents"><x:out select="$qe/contents/text()"/></c:set>
               		<c:set var="answerContent"><x:out select="$qe/answerContent/text()"/></c:set>
               		<input type="hidden" name = "essayQuesthemeId" value="${questhemeId }"/>
               		<div class="wj ques">
	                  <h3><c:if test="${answerNum !=1 }">${liNum}.${questionnaireTitle }</c:if></h3>
	                  <c:if test="${contents !='' }">
	                  	<textarea readonly="readonly">${contents }</textarea>
	                  </c:if>
	                  <textarea <c:if test="${isSubmitAnswered ==1 }">readonly="readonly"</c:if>  class="textarea_a" id="essay_${questhemeId }">${answerContent }</textarea>
	                </div>
	                <input type="hidden" name="questhemeEssayList" id="${questhemeId }"/>
               </x:forEach>
              </div>
            </article>
          </section>
          <input type="hidden" value="${questionnaireId }" name="questionnaireId" />
          </form>
          <footer id="footer-hb" class="wh-footer wh-footer-forum">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  	<c:choose>
					  	<c:when test="${isSubmitAnswered == '1' }">
					  		<div class="fl clearfix">
			                  <a href="javascript:readStatistics('${questionnaireId }');" style="height: auto;line-height: normal;display: initial;" class="fbtn-matter">查看统计</a>
			                </div>
					  	</c:when>
					  	<c:when test="${isSubmitAnswered!='1'&&(answerNum == 1 || answerNum == 0) }">
					  		<div class="fl clearfix">
			                  <a href="javascript:saveAnswer();" style="height: auto;line-height: normal;display: initial;" class="fbtn-matter">确定完成</a>
			                </div>
					  	</c:when>
					  	<c:otherwise>
					  		<div class="fl clearfix" id="zj" style="display: none">
			                  <a href="#" id="fbtn-cancel" style="height: auto;line-height: normal;display: initial;" class="panel-return-a">上一题</a>
			                  <a href="#" style="height: auto;line-height: normal;display: initial;" class="panel-send-a">下一题</a>
			                </div>
							<div class="fl clearfix" id="first" style="display: block"> 
			                  <a href="#" style="height: auto;line-height: normal;display: initial;" class="panel-send-a">下一题</a>
			                </div>
							<div class="fl clearfix" id="que" style="display: none">
							  <a href="#" style="height: auto;line-height: normal;display: initial;" id="fbtn-cancel" class="panel-return-a">上一题</a>
			                  <a href="javascript:saveAnswer();" style="height: auto;line-height: normal;display: initial;" class="fbtn-matter">确定完成</a>
			                </div>
					  	</c:otherwise>
					  </c:choose>
                  </div> 
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
  </c:if>  
  <script type="text/javascript" src="/defaultroot/clientview/frameworktemplate/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/frameworktemplate/js/plugin/zepto.js"></script>  
  <script type="text/javascript">
	 var $$ = Dom7;
    //初始化应用
    var myapp = new Framework7();
    
    //加载图片
	$(function(){
		loadImg();
	});

	//解决input输入框的问题
	if(/Android [4-6]/.test(navigator.appVersion)) {
	    window.addEventListener("resize", function() {
	        if(document.activeElement.tagName=="INPUT" || document.activeElement.tagName=="TEXTAREA") {
	            window.setTimeout(function() {
	                document.activeElement.scrollIntoViewIfNeeded();
	            },0);
	        }
	    })
	}
	document.write('<style>#footer-hb{visibility:hidden}@media(min-height:' + ($( window ).height() - 10) + 'px){#footer-hb{visibility:visible}}</style>' );
	 
	//解决input输入框的问题
  
   //设置span中的值
	function setSpanHtml(obj,selectVal){
	   	if(!selectVal){
	   		selectVal = $(obj).find("option:selected").text();
	   	}
		$(obj).parent().find('div>p').html(selectVal);
	}
	
    var currentques = 0; //默认当前的题目为1 
    var queslength = $(".ques").length;
    console.log(queslength); 
    //初始化显示第一个题目
    $(".ques").hide().eq(0).show(); 
    //点击下一题
    $(".panel-send-a").on('click', function(){
    	var flag = 0;
    	if(currentques == queslength-2){
    		flag = 1;
    		$("#zj").css("display","none");
			$("#first").css("display","none");
			$("#que").css("display","block");
    	}
      //判断是否为第一题 ， 如果是 ，则上一题按钮为灰色 如果否 则可以点击上一题。
      if(currentques == 0){
        $(".pre-ques").removeClass("fbtn-cancel").addClass("fbtn-matter");
      }
      //是否超出题目长度， 如否则当前题目+1 
      if(currentques < queslength-1){
      	if(flag != 1){
      		$("#zj").css("display","block");
			$("#first").css("display","none");
			$("#que").css("display","none");
      	}
        currentques = currentques+1;  
        $(".ques").hide().eq(currentques).show();
        console.log(currentques);
      }else{
        $(".next-ques").removeClass("fbtn-matter").addClass("fbtn-cancel");
        return false;
      }
    }) 
    //点击选择上一题
    $(".panel-return-a").on('click', function(){  
      //是否为第一题， 如否则当前题目-1 
      if(currentques > 0 ){
        currentques = currentques-1;  
        $(".ques").hide().eq(currentques).show();
        $(".next-ques").removeClass("fbtn-cancel").addClass("fbtn-matter");
      } 
		$("#zj").css("display","block");
		$("#que").css("display","none");
      //判断是否为第一题 ， 如果是 ，则上一题按钮为灰色 如果否 则可以点击上一题。
      if(currentques == 0){
		$("#zj").css("display","none");
		$("#first").css("display","block");
		$("#que").css("display","none");
        $(".pre-ques").removeClass("fbtn-matter").addClass("fbtn-cancel");
        $(".next-ques").removeClass("fbtn-cancel").addClass("fbtn-matter");
        return false;
      }    
      
    }) 
    var comflag = 1;
  //保存问卷
  	function saveAnswer() {
  		if(comflag == 0){
    		return;
    	}
    	comflag = 0;
  		var radioResArr = $("input[name=questhemeRadioList]");
  		var checkResArr = $("input[name=checkQuesthemeId]");
  		var quResArr = $("input[name=essayQuesthemeId]");
  		for(var i=0;i<radioResArr.length;i++){
  			if(radioResArr[i].value == ''){
  				myapp.alert("单选题答案不能为空！");
  				comflag = 1;
  				return;
  			}
  			if(/[@#\$%\^&\*]+/g.test(radioResArr[i].value)){
				myapp.alert('其他答案不可以包含特殊字符！');
				comflag = 1;
				return;
			}
  		}
  		for(var i=0;i<checkResArr.length;i++){
  			var other = $('#other_'+checkResArr[i].value).val();
  			if(other != undefined){
  				if($('#'+checkResArr[i].value).val() == '' && $('#other_'+checkResArr[i].value).val() == ''){
	  				myapp.alert("多选题答案不能为空！");
	  				comflag = 1;
	  				return;
  				}
  			}else{
  				if($('#'+checkResArr[i].value).val() == '' || $('#other_'+checkResArr[i].value).val()==''){
	  				myapp.alert("多选题答案不能为空！");
	  				comflag = 1;
	  				return;
  				}
  			}
  			 
  			if(/[@#\$%\^&\*]+/g.test($('#other_'+checkResArr[i].value).val())){
				myapp.alert('其他答案不可以包含特殊字符！');
				comflag = 1;
				return;
			}
  		}
  		for(var i=0;i<quResArr.length;i++){
  			if(/[@#\$%\^&\*]+/g.test($('#essay_'+quResArr[i].value).val())){
				myapp.alert('问答题不可以包含特殊字符！');
				comflag = 1;
				return;
			}
  		}
  		setAnswer();
  		$$.ajax({
	      type: "post",
	      url: "saveNaire.controller",
	      data: $('#saveForm').serialize(),
	      dataType: "text",
	      success: function(data) {
	      	var jsonData = eval("("+data+")");
	    	var commentFlag = jsonData.data0;
	    	if(commentFlag=='1'){
	    		myapp.alert('问卷保存成功!', function () {
			      	 window.location = window.location = "/defaultroot/naire/getAnswerQuestionnaireList.controller";
			      });
	    	}else{
	    		myapp.alert("问卷保存失败");
	    	}
	      }
      });
	}
	
	//答案赋值
	function setAnswer() {
		var checkArr = $("input[name=checkQuesthemeId]");
		var essayArr = $("input[name=essayQuesthemeId]");
  		var checkValue = '';
  		var essayValue = '';
  		for(var i=0;i<checkArr.length;i++){
  			var otherval = $('#other_'+checkArr[i].value).val();
  			var checkval = $('#'+checkArr[i].value).val();
  			if($('#other_'+checkArr[i].value).val() == '' || $('#other_'+checkArr[i].value).val() == undefined){
  				otherval = '!other!';
  			}
  			if($('#'+checkArr[i].value).val() == ''){
  				checkval = checkArr[i].value+'_';
  			}
  			if(otherval == '!other!' && checkval == checkArr[i].value+'_'){
  				$('#'+checkArr[i].value).val('');
  			}else{
  				checkValue = checkval +'_'+  otherval;
  				 $('#'+checkArr[i].value).val(checkValue);
  			}
  		}
  		for(var i=0;i<essayArr.length;i++){
  			var essayval = $('#essay_'+essayArr[i].value).val();
  			if($('#essay_'+essayArr[i].value).val() == ''){
  				essayval = '!other!';
  			}
  			essayValue = essayArr[i].value+'_'+essayval;
  			 $('#'+essayArr[i].value).val(essayValue);
  		}
	}
	
	//单选赋值
	function radioSel(questhemeId,themeOptionId) {
		if(themeOptionId == 'other'){
			$("#other_"+questhemeId).removeAttr("readonly");
			$('#'+questhemeId).val(questhemeId+'_'+themeOptionId);
		}else{
			if($("#other_"+questhemeId).attr("readonly") == undefined ){
				$("#other_"+questhemeId).val('');
				$("#other_"+questhemeId).attr("readonly","readonly");
			}
			$('#'+questhemeId).val(questhemeId+'_'+themeOptionId+'_!other!');
		}
	}
	
	//单选其他答案
	function radioOther(questhemeId) {
		var value = questhemeId+'__'+$('#other_'+questhemeId).val();
		$('#'+questhemeId).val(value);
	}
	//多选赋值
	function checkSel(questhemeId,themeOptionId) {
		var flagVal = $('#'+questhemeId).val();
		var checkListVal = '';
		if(flagVal == '' ){
			checkListVal = questhemeId+'_'+themeOptionId;
		}else{
			var inOf = $('#'+questhemeId).val();
			var checkVal = '';
			var chenckLength = questhemeId.length + themeOptionId.length +1;
			if(inOf.indexOf(themeOptionId)!=-1){
				if(chenckLength == inOf.length){
					checkVal = '';
				}else if(inOf.indexOf('_'+themeOptionId)!=-1){
					checkVal = inOf.replace(themeOptionId+',','');
				}else{
					checkVal = inOf.replace(','+themeOptionId,'');
				}
			}else{
				checkVal = inOf +','+themeOptionId;
			}
			checkListVal = checkVal;
		}
		$('#'+questhemeId).val(checkListVal);
	}
	//多选其他答案
	function checkOther(questhemeId) {
		if($("#other_"+questhemeId).attr("readonly") == undefined ){
			$("#other_"+questhemeId).val('');
			$("#other_"+questhemeId).attr("readonly","readonly");
		}else{
			$("#other_"+questhemeId).removeAttr("readonly");
		}
	}
	//查看统计
	function readStatistics(questionnaireId) {
		window.location = window.location = "/defaultroot/naire/questionnaireStatistics.controller?questionnaireId="+questionnaireId;
	}
	
	function loadImg(){
		$("input[name='imgNameRadio']").each( 
			function (){
				var filename = $(this).val();
				var id = filename.substring(0,25);
				if(filename == 'null'){
					$('#Radio'+id).attr("src","");
				}else{
					$.ajax({
						type : 'post',
						url : '<%=rootPath%>/download/downloadImg.controller',
						dataType : 'text',
						data : {"fileName":filename,"name":filename,"path":"quesCustAnswer/"+filename.substring(0,6)},
						success : function(data){
							$('#Radio'+id).attr("src","<%=rootPath%>"+data);
						},
						error : function (xhr,type){
							//alert('数据查询异常！');
						}
					});
				}
			}		
		);
		$("input[name='imgNameCheck']").each( 
			function (){
				var filename = $(this).val();
				var id = filename.substring(0,25);
				if(filename == 'null'){
					$('#Check'+id).attr("src","");
				}else{
					$.ajax({
						type : 'post',
						url : '<%=rootPath%>/download/downloadImg.controller',
						dataType : 'text',
						data : {"fileName":filename,"name":filename,"path":"quesCustAnswer/"+filename.substring(0,6)},
						success : function(data){
							$('#Check'+id).attr("src","<%=rootPath%>"+data);
						},
						error : function (xhr,type){
							//alert('数据查询异常！');
						}
					});
				}
			}		
		);
	}
  </script>
</body>
