<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>发帖</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" /> 
  <style type="text/css">
  	.focum-a .focum-replies .replies-top{background:#fff;}  
  	footer.wh-footer{position:fixed !important;}
  </style>
</head>
<%
	String userId = session.getAttribute("userId").toString();
	userId = "*" + userId + "*";
 %>
 <c:set var="userId"><%= userId%></c:set>
 
<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-focum">
          <section class="section-focum section-focum-replies wh-section show wh-section-bottomfixed" id="mainContent">
		  <form id="sendForm">
            <div class="focum-a">
                <div class="select-top select-top-width clearfix">
                    <a class="fl" href="javascript:selColumn();" id="classShowName">请选择模块</a>
					<input type="hidden" name="classId" id="classId" value="0"/>
					<input type="hidden" name="className" id="className" />
                    <a class="fr" href="javascript:sendPost();">发帖</a>
                </div>
                <p class="replies-title"><input type="" id="title" name="title" placeholder="请填写发帖标题"></p>    
                <div class="replies-con">
                    <div class="textareabox" id="content" contenteditable="true">
                        
                    </div>
                    <textarea id="realContent" name="content" placeholder="请填写回帖内容"></textarea>
                </div>

                <div class="smile">
                    <div class="tab-title">
                       <a href="#tab1" class="tab-link"><i class="fa  fa-smile-o"></i></a>
                       <a href="#tab2" class="tab-link"><i class="fa  fa-camera"></i><span id="num" style="display:none">0</span></a>
                    </div>
                    <div class="tabs">
                         <div id="tab1" class="tab active">
                             <div class="smlie-list clearfix">
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/1.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/2.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/3.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/4.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/5.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/6.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/7.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/8.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/9.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/10.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/11.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/12.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/13.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/14.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/15.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/16.gif" />
								<img src="/defaultroot/modules/comm/forum/images/QQ_New/17.gif" />
                             </div>
                         </div>
                          <div id="tab2" class="tab">
                                <ul class="edit-upload">
                                    <li class="edit-upload-in" onclick="addImg();"><span><i class="fa fa-plus"></i></span></li>
                              </ul>
                         </div>
                    </div>
                </div>
				 <div class="footr-d-select">
                     <ul class="edit-radio clearfix">
							<li data-val="0" class="on">
								<label class="label-checkbox item-content">
									  <span class="edit-radio-l">实名</span>
								</label>
							</li>
							<li data-val="1" id="niming">
								<label class="label-checkbox item-content">									
									  <span class="edit-radio-l">匿名</span>
								</label>
							</li>
							<li data-val="2" <c:if test="${hasNick eq '0'}">style="display:none;"</c:if>>
								<label class="label-checkbox item-content">								 
									  <span class="edit-radio-l">昵称</span>
								</label>
							</li>
							<input type="hidden" name="type" id="type" value="0"/>
					 </ul>
                </div>                 
            </div>
			</form>
          </section>

		  <!-- 选择板块页面 -->
			<section id="selectContent" class="wh-section" style="display:none">
				<div class="webapp-infomation-channel">
					<!-- 搜索公用 -->
					<header id="searchBar" class="wh-search">
						<div class="wh-container">
							<div class="wh-search-input">
								<form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
									<label class="fa fa-search" for="search"></label>
									<input id="searchBug" name="searchChannelName" type="search" class="nomal-search" placeholder="请输入栏目标题" />
									<i class="fa fa-times-circle-o"  style="display:none;"  onclick="removeSearchInput()"></i>
								</form>
							</div>
						</div>
					</header>
					<div>
						<div class="tabs">
							<div class="list-block list-laber-block">
								<ul class="webapplist edit-radio" style="padding-bottom: 0rem;">
								
								</ul>
							</div>
						</div>
					</div>
				</div>
			</section>
			<footer class="wh-footer wh-footer-forum" id="footerButton" style="position: fixed;display:none">
				<div class="wh-container">
					<div class="wh-footer-btn row">
						<div class="webapp-footer-linebtn">
							<div class="fl clearfix" id="comButton">
								<a href="javascript:clearSelect();" class="panel-return-a">清空</a>
								<a href="javascript:confirmSelect();" class="panel-send-a">确定</a>
							</div>
						</div>
					</div>
				</div>
			</footer>
        </div>
      </div>
    </div>
  </div>

  
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/scripts/jquery-1.8.0.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/ajaxfileupload.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/uploadPreview.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7({
	fastClicks: false,
  });
  var $$ = Dom7;

	var userId = '${userId}';

  	//  点击显示表情
  	$$(".section-focum-replies .smile .tab").css({"height":"0"});//开始默认表情框高度为0
  	$$(".smile .tab-title a").click(function(){
  		if($(".tab-title").hasClass("intro")){
  			$(".tab-title").removeClass("intro");
  			$$(".section-focum-replies .smile .tab").css({"height":"0"});
  		}else{
  			$(".tab-title").addClass("intro");
  			$$(".section-focum-replies .smile .tab").css({"height":"9.5rem"});
  		}
  		
  	});
   
   //底部 实名 匿名单选按钮
   $$(".footr-d-select ul li").click(function(){
         $$(".footr-d-select ul li").removeClass("on");
        $$(this).addClass("on");

    })
   var selFLag = 0;
   var selftFlag = 0; //第一次点击选模块标识
	//打开选择板块页面
	function selColumn(){
		//alert("1111");
		//myApp.showPreloader('加载板块中...');
		var selectClassId = $$("#classId").val();//已选择栏目id
		var searchClassName = $$("#searchBug").val();//查询的栏目名称
		var classNameSel = $$("#className").val();//已选择栏目名称
		//if(selftFlag == 0){
		//	$("#footerButton").attr("style","position: fixed;display:inline-block");
		//}
		selftFlag = 1; 
		$.ajax({
			url : '/defaultroot/post/selectcolumn.controller',
			type : "post",
			data : {"selectClassId" : selectClassId,"searchClassName" : searchClassName},
			success : function(data){
				var jsonData = eval("("+data+")");
				if(jsonData.data0.length == 0 && selFLag == 0){
		      		myApp.hidePreloader();
		      		myApp.alert('没有可选择的板块');
		      		return false;
		      	}
		      	//alert("2222");
		      	var html = '';
		      	var write = '';
				var loadSubSec = '';
		      	var next = '';
		      	var selColumn = '';
				if(jsonData.data0.length>0){
					for(var i = 0; i < jsonData.data0.length; i++){
						var id = jsonData.data0[i].id;//栏目id
						var className = jsonData.data0[i].className;//栏目名称
						var hasForumCount = jsonData.data0[i].hasForumCount;//该栏目下帖子的数目
						var classHasJunior = jsonData.data0[i].classHasJunior;//是否有下级栏目【0：没有；1：有】
						var haveRightFlag = jsonData.data0[i].haveRightFlag;//0：不能查看或发帖 1:能查看或发帖
						var classUserName = jsonData.data0[i].classUserName;//
						var estopAnonymity = jsonData.data0[i].estopAnonymity;//允许匿名 0是 1否
						//判断单选按钮的显示
						if(haveRightFlag == '1'){
							write = '<span class="edit-radio-l"></span>';
						}else{
							write = '<span class="edit-radio-l" style="opacity: 0;"></span>';
						}
						//判断是否有下级版块
						if(classHasJunior != '0'){
							loadSubSec = '<p style="font-weight: 700;" onclick="loadSubSection('+id+',this)" data-click="0">'+className+'</p>';
							next = '<p style="font-size: 1.2rem;color: #909090;">下级版块</p>';
						}else{
							loadSubSec = '<p style="font-weight: 700;">'+className+'</p>';
							next = '';
						}
						//让已选择的版块再次选中
						if(classNameSel == className){
							selColumn = '<input type="radio" name="channelRadio" checked="checked" value="'+id+','+className+','+estopAnonymity+'">';
						}else{
							selColumn = '<input type="radio" name="channelRadio" value="'+id+','+className+','+estopAnonymity+'">';
						}
						html +='<li class="swipeout">'
						+ '<div id="'+id+'">'
						+ '<label class="label-radio item-content">'
						+ selColumn
						+ write
						+ '</label>'
						+ '<a href="##" class="swipeout-content item-content">'
						+ '<div>'
						+ '<div class="tips">'+className.substring(0,1)+'</div>'
						+ loadSubSec
						+ next
						+ '</div>'
						+ '</a>'
						+ '</div>'
						+ '</li>';
					}
					$$("#selectContent ul").html(html);
					hiddenContent(0);
					selFLag = 1;
					setIconClass($$('.tips'));
					//myApp.hidePreloader();
				}else{
					$$("#selectContent ul").html('<li class="swipeout" style="padding:0rem;margin:0.5rem 0.2rem 0 1.2rem;"><label class="label-radio item-content"><span>系统未查询到相关记录！</span></label></li>');
		      		//myApp.hidePreloader();
				}
			},
			error: function(xhr, status) {
		    	$$("#selectContent ul").html('<li class="swipeout" style="padding:0rem;margin:0.5rem 0.2rem 0 1.2rem;"><label class="label-radio item-content"><span>系统未查询到相关记录！</span></label></li>');
		      	//myApp.hidePreloader();	 
			}
		});
	}


	//加载父板块下面的子版块
	function loadSubSection(parentClassId,obj){
		//alert(11111);
		//判断下级版块是否加载
		var clickFlag = $(obj).data("click");
		$(obj).data("click","1");
		var ul = $("ul[name='"+parentClassId+"']");
		if(ul.length > 0){
			if(ul.css("display") != "none"){
				ul.hide();
			}else{
				ul.show();
			}
			return;
		}

		if(clickFlag == '0'){
			var classNameSel = $$("#className").val();
			$.ajax({
				url : '/defaultroot/post/selectcolumn.controller',
				type : "post",
				data : {"classId" : parentClassId,"searchClassName" : ''},
				success : function(data){
					var jsonData = eval("("+data+")");
					if(jsonData.data0.length>0){
						//alert(jsonData.data0.length);
						var html = '';
				      	var write = '';
						var loadSubSec = '';
				      	var next = '';
				      	var selColumn = '';
						for(var i = 0; i < jsonData.data0.length; i++){
							var id = jsonData.data0[i].id;//栏目id
							var className = jsonData.data0[i].className;//栏目名称
							var hasForumCount = jsonData.data0[i].hasForumCount;//该栏目下帖子的数目
							var classHasJunior = jsonData.data0[i].classHasJunior;//是否有下级栏目【0：没有；1：有】
							var haveRightFlag = jsonData.data0[i].haveRightFlag;//0：不能查看或发帖 1:能查看或发帖
							var classUserName = jsonData.data0[i].classUserName;//
							var estopAnonymity = jsonData.data0[i].estopAnonymity;//允许匿名 0是 1否
							//判断单选按钮的显示
							if(haveRightFlag == '1'){
								write = '<span class="edit-radio-l"></span>';
							}else{
								write = '<span class="edit-radio-l" style="opacity: 0;"></span>';
							}
							//判断是否有下级版块
							if(classHasJunior != '0'){
								loadSubSec = '<p style="font-weight: 700;" onclick="loadSubSection('+id+',this)" data-click="0">'+className+'</p>';
								next = '<p style="font-size: 1.2rem;color: #909090;">下级版块</p>';
							}else{
								loadSubSec = '<p style="font-weight: 700;">'+className+'</p>';
								next = '';
							}
							//让已选择的版块再次选中
							if(classNameSel == className){
								selColumn = '<input type="radio" name="channelRadio" checked="checked" value="'+id+','+className+','+estopAnonymity+'">';
							}else{
								selColumn = '<input type="radio" name="channelRadio" value="'+id+','+className+','+estopAnonymity+'">';
							}
							html +='<li class="swipeout">'
							+ '<div id="'+id+'">'
							+ '<label class="label-radio item-content">'
							+ selColumn
							+ write
							+ '</label>'
							+ '<a href="##" class="swipeout-content item-content">'
							+ '<div>'
							+ '<div class="tips">'+className.substring(0,1)+'</div>'
							+ loadSubSec
							+ next
							+ '</div>'
							+ '</a>'
							+ '</div>'
							+ '</li>';
						}
						$('#'+parentClassId).append('<ul name="'+parentClassId+'">'+html+'</ul>');
						setIconClass($$('.tips'));
					}
				},
				error: function(xhr, status) {
			    	myApp.alert("加载子版块出现异常！"); 
				}
			});	
		}
	}

	
	//通过选择板块名 让 单选按钮选中
	function selchannelRadio(id,haveRightFlag,className,estopAnonymity){
		//alert(id+",,,,,,"+className);
		if(haveRightFlag == '1'){
			if($("input:radio[value='"+id+","+className+","+estopAnonymity+"']").is(':checked') == true){
				//alert("取消选中");
				$("input:radio[value='"+id+","+className+","+estopAnonymity+"']").attr('checked',false);
			}else{
				//alert("选中");
				$("input:radio[value='"+id+","+className+","+estopAnonymity+"']").attr('checked','true');
			}
		}else{
			return;
		}
		
	}
	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag==0){
			$$("#mainContent").css("display","none");
			//$$("#criteButton").css("display","none");
			$$("#footerButton").css("display","block");
			$$("#selectContent").css("display","block");
		}else if(flag==1){
			$$("#selectContent").css("display","none");
			$$("#mainContent").css("display","block");
			//$$("#criteButton").css("display","block");
			$$("#footerButton").css("display","none");
		}
	}

	//清空已选择的栏目
	function clearSelect(){
		$("input[type='radio']").removeAttr('checked');
	}
	
	//确定选择的版块
	function confirmSelect(){
		//$("#footerButton").attr("style","position: fixed;display:none");
		var channelRadio = $$("input[type='radio']:checked").val();
		if(channelRadio == undefined ){
			myApp.alert('论坛版块不能为空，请选择');
			return false;
		}
		var arr = channelRadio.split(',');
		$$("#classId").val(arr[0]);//板块id
		$$("#className").val(arr[1]);//板块名称
		if(arr[1].length > 6){
			//alert(arr[1].length);
			$$("#classShowName").html(arr[1].substring(0,6) + "...");//板块名称
		}else{
			//alert(arr[1].length);
			$$("#classShowName").html(arr[1]);//板块名称
		}
		
		
		var estopAnonymity = arr[2];//板块是否允许匿名   
		if(estopAnonymity == '1'){//不允许
			$("#niming").css("display","none");
		}else{
			$("#niming").css("display","inline-block");
		}
		hiddenContent(1);
	}

	$(function(){
		//单选
        var radioList = $(".edit-radio li");
        radioList.click(function(){
        	$("#type").val($(this).data("val"));
        });
        $('.face-ico-btn').click(function(){
            $('.face-ico-all').toggle();
        })
        //绑定点击图标事件 
        $('.smlie-list img').bind('click',function(){
		    var src = this.src;
		    if(src.indexOf("/modules/comm/forum/images/")!=-1){
		        src = src.substring(src.indexOf("/defaultroot/modules/comm/forum/images/"));
		    }
			$("#content").append("<IMG SRC='" + src + "'/>");
        });
    });

	//图片数标记
    var index = 0;
    var imgnum = 0;
    //添加图片
    function addImg(){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="imgName"/>'+
		       '<input type="hidden" id="img_save_name_'+index+'" name="imgSaveName"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
   
	//删除缩略图
    function removeImg(indexinput){
	   $("#imgli_"+indexinput).remove();
	   $("#up_img_"+indexinput).remove();
	   $("#num").html($("#num").html()-1);
	   if($("#num").html() == 0){
		   $("#num").attr("style","display:none");
	   }
	   imgnum = imgnum -1;
    }
	
	//回调函数上传图片
	function callBackFun(upImgId,imgliId){
		myApp.showPreloader('正在上传...');
		$("#img_name_"+(index-1)).val($("#"+upImgId).val());
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=forum', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				imgnum++;
				$("#img_save_name_"+(index-1)).val(msg.data);
				$("#img_name_"+(index-1)).val(fileShowName);
				$("#"+imgliId).show();
				$("#num").attr("style","display:inline-block");
				$("#num").html(imgnum);
				myApp.hidePreloader();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				myApp.alert("文件上传失败！");
			}
		});
	}

	//发送帖子
	function sendPost(){
		$("#realContent").val($("#content").html());
		if(checkForm()){
			$.ajax({
				url : "/defaultroot/post/saveforum.controller",
				data : $("#sendForm").serialize(),
				type : "post",
				success : function(data){
					var jsonData = eval("("+data+")");
					if(jsonData.result == 'success'){
						var classOwnerIds = jsonData.data1;
						var checkExamin = jsonData.data2;
						if(checkExamin == '1'){//需要审核的版块
							if(classOwnerIds == userId){
								myApp.alert('发帖成功！', function () {
				      				window.history.back();
				      			});	
							}else{
								myApp.alert('发帖成功，但您发的帖子需要版主进行审核！', function () {
				      				window.history.back();
				      			});	
							}
						}else{//不需要审核的版块
							myApp.alert('发帖成功！', function () {
				      			window.history.back();
				      		});	
						}
						//location.href="/defaultroot/post/index.controller";
					}else if(jsonData.result == 'fail'){
						myApp.alert("发送失败！");
					}
				},
				error : function(){
					myApp.alert("发送异常！");
				}
			});
		}
	}

	//验证表单数据
	function checkForm(){
		var classId = $("#classId").val();
		var title = $("#title").val();
		var type = $("#type").val();
		var content = $('#realContent').val();
		if(classId == null || classId == '0'){
			myApp.alert("请选择版块名！");
			return false;
		}
		if(!(title.trim()) || /[@#\$%\^&\*]+/g.test(title)){
			myApp.alert("请正确填写帖子标题！");
			return false;
		}
		if(title.length > 50){
			myApp.alert("帖子标题不得超过50字！");
			return false;
		}
		
		return true;
	}

	//绑定查询框回车事件
    $$('#searchBug').keydown(function(event){
    	var searchTitle = $$('#searchBug').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索论坛版块标题')
			}else{
				selColumn();
			}
			
		} 
	});


 	// 搜索焦点时
    $$('#searchBug').on('click', function() {
    	 $$('.fa-times-circle-o').show();
    })

	//清除搜索
	function removeSearchInput(){ 
    	$$('.fa-times-circle-o').hide();
		$("#searchBug").val('');
		selColumn();
	}

  </script>

</body>
