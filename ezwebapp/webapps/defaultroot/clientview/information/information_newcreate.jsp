<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>新建信息</title>
 </head>

<body class="grey-bg">
	<!-- 选人界面的div开始 -->
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
	<!-- 选人界面的div结束 -->
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-focum">
          <section  id="mainContent" class="section-focum section-focum-replies wh-section new-infomation-section show">
            <div class="focum-a new-infomation">
            	<form id="saveForm">
                <div class="whitebg">
                      <div class="select-top clearfix">
                          <a id="selchannelName" href="javascript:selectChannel();" class="fl">请选择栏目</a>
                          <input type="hidden" name="channelName" id="channelName"/>
						  <input type="hidden" name="channelId" id="channelId"/>
                          <a href="javascript:saveInfo();" class="fr">发布信息</a>
                      </div>
                      <p class="replies-title">
                      <input type="text" name="title" id="title" placeholder="请输入信息标题" maxlength="150">
                      </p>    
                      <div class="replies-con">
                          <textarea placeholder="请输入信息内容" name="content" id="content"></textarea>
                      </div>
                </div>
                <div class="pic-list">
                      <ul class="edit-upload clearfix">
                        <li class="edit-upload-in" onclick="addImg();"><span><i class="fa fa-plus"></i></span></li>
                      </ul>
                </div>
                <div class="fbxx">
                     <p>发布选项</p>
                     <ul class="edit-radio clearfix">
                            <li class="">
                              <input type="hidden" name="displayTitle" id="displayTitle" value="1"/>
                              <label class="label-checkbox item-content">
                              <input type="checkbox" name="displayTitleCheck" value="0">
                              <span class="edit-radio-l">细览不显示</span>
                              </label>
                            </li>
                            <li class="fr">
                              <input type="hidden" name="titleColor" id="titleColor" value="0"/>
                              <label class="label-checkbox item-content">
                                <input type="checkbox" name="titleColorCheck" value="1">
                                <span class="edit-radio-l">首页显示标题红色</span>
                              </label>
                            </li>
                      </ul>
                </div>
                <div class="fb-fanwei">
                    <div class="select-top clearfix">
                          <a href="javascript:selectUser('1','readRangeName','readRange','*0*','orguser');" class="fl">请选择发布范围</a>
                          <input type="hidden" name="readRange" id="readRange" />
                          <input type="hidden" name="readRangeName" id="readRangeName"/>
                      </div>
                      <div id="disName" class="fanwei-list clearfix">
                          
                      </div>
                </div>
                </form>
            </div>
          </section>
          <section id="selectContentInfo" class="wh-section" style="display:none">
         	<div class="webapp-infomation-channel">
			  <!-- 搜索公用 -->
			 <header id="searchBar" class="wh-search">
			   <div class="wh-container">
			     <div class="wh-search-input">
			       <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
			         <label class="fa fa-search" for="search"></label>
			         <input id="searchBug" name="searchChannelName" type="search" class="nomal-search"placeholder="请输入栏目标题" />
			         <i class="fa fa-times-circle-o"  style="display:none;"  onclick="removeSearchInput()"></i>
			       </form>
			     </div>
			   </div>
			 </header>
			 <div>
			  <div class="tabs">
			     <div class="list-block list-laber-block">
			      <ul class="webapplist edit-radio" >
			       </ul>
			     </div>
			   </div>
			 </div>
			</div>
         </section>
         <section id="selectContent" style="display:none">
		  
		  </section>
         <footer  style="display:none" class="wh-footer wh-footer-forum" id="comButton">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix" id="11">
                    <a href="javascript:clearSelectChan();" class="panel-return-a">清空</a>
                    <a href="javascript:confirmSelectChan();" class="panel-send-a">确定</a>
                  </div>
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/simplecalendar.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/uploadPreview.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/ajaxfileupload.js"></script>
  <script src="<%=rootPath%>/clientview/js/common.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7({
         fastClicks: false,
    });
  var $$ = Dom7;

  $$(".footer-focum>a").click(function(){
    var _this = $$(this);
    var index = _this.index();

    $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    $$(".section-focum").hide().eq(index).show();
  });
  
 // 搜索焦点时
   $$('#searchBug').on('click', function() {
   	 $$('.fa-times-circle-o').show();
   })
 
 var selFLag = 0;
 //加载选择栏目
 function selectChannel(flag) {
 	  if(flag != 1 ){
 	  	 myApp.showPreloader('加载栏目列表...');
 	  }
	  var selectChannelId = $$("#channelId").val();
	  var searchChannelName = $$("#searchBug").val();
	  $$.ajax({
	      type: "post",
	      url: '/defaultroot/information/canIssueChannels.controller',
	      data : {"selectChannelId":selectChannelId,"searchChannelName":searchChannelName},
	      dataType: "text",
	      success: function(data) {
	      	var jsonData = eval("("+data+")");
	      	var html = '';
	      	var head = '';
	      	var fabulous = '赞';
	      	if(jsonData.data0.length == 0 && selFLag == 0){
	      		myApp.hidePreloader();
	      		myApp.alert('没有可选择的栏目');
	      		return false;
	      	}
	      	if(jsonData.data0.length>0){
		      	for(var i = 0; i < jsonData.data0.length; i++){
		      		var channelName = jsonData.data0[i].channelName;
		      		var channelId = jsonData.data0[i].channelId;
		      		var inhtml = '<input type="radio" onclick="checkRadio(this)" name="channelRadio" value="'+channelId+','+channelName+'">';
		      		if(selectChannelId == channelId){
		      			inhtml = '<input type="radio" onclick="checkRadio(this)" name="channelRadio" checked value="'+channelId+','+channelName+'">';
		      		}
		      		html +='<li class="swipeout" >'
					+'<label class="label-radio item-content">'
					+inhtml
					+'<span class="edit-radio-l"></span>'
					+'</label>'
					+'<a href="##" onclick="checkCl(this)" class="swipeout-content item-content">'
					+'<div>'
					+'<div class="tips">'+channelName.substring(0,1)+'</div>'
					+'<span>'+channelName+'</span>'
					+'</div>'
					+'</a>'
					+'</li>';
		      	}
		      	html+='<br><br><br>';
		      	$$("#selectContentInfo ul").html(html);
				hiddenContentInfo(0);
				selFLag = 1;
				setIconClass($$('.tips'));
				myApp.hidePreloader();	 
	      	}else{
	      		$$('#selectContentInfo ul').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
	      		myApp.hidePreloader();	 
	      	}
	      },error: function(xhr, status) {
	      	$$('#selectContentInfo ul').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
	      	myApp.hidePreloader();	 
	      }
      });
}
 
 //选栏目开始
 function hiddenContentInfo(flag){
	if(flag==0){
		document.title="选择栏目"; 
		$$("#mainContent").css("display","none");
		$$("#criteButton").css("display","none");
		$$("#comButton").css("display","block");
		$$("#selectContentInfo").css("display","block");
	}else if(flag==1){
		document.title="新建信息"; 
		$$("#selectContentInfo").css("display","none");
		$$("#mainContent").css("display","block");
		$$("#criteButton").css("display","block");
		$$("#comButton").css("display","none");
	}
 }
 
  //确定选择的栏目
  function confirmSelectChan(){
	var channelRadio = $$("input[type='radio']:checked").val();
	if(channelRadio == undefined ){
		myApp.alert('栏目不能为空，请选择');
		return false;
	}
	var arr = channelRadio.split(',');
	$$("#channelId").val(arr[0]);
	$$("#channelName").val(arr[1]);
	$$("#selchannelName").html(arr[1]);
	$$("#searchBug").val("");
	hiddenContentInfo(1);
  }
  //图片数标记
    var index = 0;
   
    //添加图片
    function addImg(){
        var uploadHtml = '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>';
		var ua = navigator.userAgent.toLowerCase();	
		if (/android/.test(ua)) {
			uploadHtml = '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"  accept="image/*" capture="camera" />';
		}
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile" />'+
		       '<input type="hidden" id="fileName_'+index+'" name="fileName"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
   
	//删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove();
	   $("#up_img_"+index).remove();
    }
	
	//回调函数上传图片
	function callBackFun(upImgId,imgliId){
		myApp.showPreloader('正在上传...');
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=information', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				myApp.hidePreloader();
				$("#fileName_"+(index-1)).val(fileShowName+"|"+msg.data);
				$("#"+imgliId).show();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				alert("文件上传失败！");
			}
		});
	}
    
    //保存信息
 	var comflag = 1;
	function saveInfo(){
		if($("input[name='displayTitleCheck']:checked").val() == '0'){
			$('#displayTitle').val('0');
		}else{
			$('#displayTitle').val('1');
		}
		if($("input[name='titleColorCheck']:checked").val() == '1'){
			$('#titleColor').val('1');
		}else{
			$('#titleColor').val('0');
		}
		var val=$('input:radio[name="sex"]:checked').val();
		if(comflag == 0){
    		return;
    	}
		if($$('#channelName').val() == ''){
			myApp.alert('所属栏目不能为空');
			return;
		}
		if($$('#title').val() == ''){
			myApp.alert('信息标题不能为空');
			return;
		}
		if(/[\\\/?#&'"]+/g.test($$('#title').val())){
			myApp.alert('标题不可以包含特殊字符！');
			return;
		}
		if($$('#content').val() == ''){
			myApp.alert('信息内容不能为空');
			return;
		}
		comflag = 0;
		$$.ajax({
			url : "/defaultroot/information/save.controller",
			data : $("#saveForm").serialize(),
			type : "post",
			success : function(data){
				var jsonData = eval("("+data+")");
				if(jsonData.result == 'success'){
					myApp.alert('发布成功！', function () {
				      	//location.href="/defaultroot/information/index.controller";
				      	<%
						  String apptype1= new WebAppAuth().getAppType(request);
						  //是否是个人中心打开
						  String fromPage = request.getParameter("fromPage");
						  //微信
						  if ("evo".equals(apptype1)&&"evo".equals(fromPage)) {
						%>
							$imag.exec('closeEvoPage()');
						<%
						  }else{
						%>	
							window.history.back();
						<%
						   }
						%>			      	
				      });
				}else if(jsonData.result == 'fail'){
					myApp.alert("发布失败！");
				}
			},
			error : function(){
				myApp.alert("发布异常！");
			}
		});
	}
	
	//清空已选择的栏目
	function clearSelectChan(){
		$("input[type='radio']").removeAttr('checked');
	}
	
	//清除搜索
	function removeSearchInput(){ 
    	 $$('.fa-times-circle-o').hide();
		 $("#searchBug").val('');
		 selectChannel(1);
	}
	
	//绑定查询框回车事件
    $$('#searchBug').keydown(function(event){
    	var searchTitle = $$('#searchBug').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索栏目标题')
			}else{
				selectChannel(1);
			}
			
		} 
	});
	
	function checkCl(obj) {
		checkIndex = checkIndex+1;
		if($(obj).prev().find("input:radio").attr("checked") == undefined){
			$(obj).prev().find("input:radio").attr("checked",true);
		}else{
			$("input[type='radio']").removeAttr('checked');
		}
		 
	}
	
	var checkIndex = 0;
	function checkRadio(obj) {
		checkIndex = checkIndex+1;
		if(checkIndex % 2 == 0){
			$("input[type='radio']").removeAttr('checked');
		}
	}
	
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range,listType){ 
		myApp.showPreloader('页面加载中...');
		var selectIdVal = $('input[id="'+selectId+'"]').val();
		if(listType=='orguser'){
			if(selectIdVal.indexOf(";") > 0 ){
				var selectIdArray = selectIdVal.split(';');
				selectIdVal = selectIdArray[1];
			}
			
			if(selectIdVal){
				selectIdVal = selectIdVal.replace(/\\$\\$/g,'$,$').replace(/\*\*/g,'*,*').replace(/\*\\$/g,'*,$').replace(/\\$\*/g,'$,*');
			}
		}else{
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
		}
		var postUrl = '';
		if(listType == 'org'){
			postUrl = '/defaultroot/newperson/orgList.controller';
		}else if(listType=='user'){
			postUrl = '/defaultroot/newperson/personList.controller';
		}else if(listType=='orguser'){
			postUrl = '/defaultroot/newperson/personOrgList.controller';
		}
		$.ajax({
			url : postUrl,
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('input[id="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
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
			$("#selectContent").css("display","block");
		}else if(flag==1){
			var rrName = $("#readRangeName").val();
			if(rrName != '' && rrName != 'null' && rrName !=null){
				var rrArr = rrName.split(',');
				var rrHtml = '';
				for(var i = 0; i < rrArr.length-1; i++){
					rrHtml+='<a href="#">'+rrArr[i]+'</a>'
				}
				$("#disName").html(rrHtml);
			}else{
				$("#disName").html("");
			}
			$("#selectContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#selectContent").empty();
		}
	}
	
	function removeAllSpace(str) {
		return str.replace(/\s+/g, "");
	}
  
  </script>

</body>

