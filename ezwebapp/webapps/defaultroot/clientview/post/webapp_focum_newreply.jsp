<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>论坛</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" /> 
  <style type="text/css">.focum-a .focum-replies .replies-top{background:#fff}</style>
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-focum">
          <section class="section-focum section-focum-replies wh-section show wh-section-bottomfixed">
		  <form id="myForm" action="/defaultroot/post/save.controller" method="post">
		  <c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc" />
			<x:forEach select="$doc//list" var="n" varStatus="status">
				<c:if test="${status.index + 1 == forumFloor}">
				<input type="hidden" name="postId" value="${postId}" />
				<input type="hidden" name="forumId" value="${forumId}" />
				<input type="hidden" name="classId" value="<x:out select="$n/classid/text()"/>" />
				<input type="hidden" name="forumSign" value="<x:out select="$n/forumSign/text()"/>" />
				<input type="hidden" name="forumFloor" value="${forumFloor }" />
				<input type="hidden" name="forumUserName" value="${forumUserName }" />
				<input type="hidden" name="forumIssueTime" value="${forumIssueTime }" />
				<input type="hidden"  value="Re:<x:out select='$n/forumTitle/text()'/>" name="title" id="title"/>
            <div class="focum-a">
                <div class="select-top clearfix">
                    <a class="fr" href="javascript:sendReply();">回帖</a>
                </div>
				<c:if test="${not empty forumUserName}">
					<c:if test="${forumFloor != '1'}">
						<p class="yy">引用 <span>@${forumUserName}</span> <span>${forumFloor-1}楼</span>内容</p> 
					</c:if>
					<c:if test="${forumFloor == '1'}">
						<p class="yy">引用 <span>@${forumUserName}</span> <span>楼主</span>内容</p> 
					</c:if>
				</c:if>
				
                <div class="replies-con">
                    <div class="textareabox" id="content" contenteditable="true">
                        
                    </div>
                    <textarea id="realContent" name="realContent" placeholder="请填写回帖内容"></textarea>
                </div>
                <div class="smile niming">
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
            </div>
			</c:if>
			</x:forEach>
			</c:if>
			</form>
          </section>
        </div>
      </div>
    </div>
  </div>

   
  <script type="text/javascript" src="/defaultroot/scripts/jquery-1.8.0.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/ajaxfileupload.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/uploadPreview.min.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7({
	fastClicks: false,
  });
  var $$ = Dom7;

  //  点击显示表情
   $$(".section-focum-replies .smile .tab").css({"height":"0"})
   $$(".smile .tab-title a").click(function(){
   $$(".section-focum-replies .smile .tab").css({"height":"9.5rem"})
   });

   function clear(){
	$("#replycontent").html("");
   }
   
    $(function(){
        //绑定点击图标事件 
        $('.smlie-list img').bind('click',function(){
		    var src = this.src;
		    if(src.indexOf("/modules/comm/forum/images/")!=-1){
		        src = src.substring(src.indexOf("/defaultroot/modules/comm/forum/images/"));
		    }
			$("#content").append("<IMG SRC='" + src + "'/>");
        });
    });

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
		       '<input type="hidden" id="img_save_name_'+index+'" name="imgSaveName" data-filesize="0"/>'+
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
				//alert(1);
				imgnum++;
				$("#img_save_name_"+(index-1)).val(msg.data);
				$("#img_save_name_"+(index-1)).data("filesize",msg.fileSize);
				$("#img_name_"+(index-1)).val(fileShowName);
				$("#"+imgliId).show();
				$("#num").attr("style","display:inline-block");
				$("#num").html(imgnum);
				myApp.hidePreloader();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				//alert(2);
				myApp.alert("文件上传失败！");
			}
		});
	}

	//发送回复
	function sendReply(){		
		$("#realContent").val($("#content").html());
		//return false;
		var content = $("#realContent").val();
		//if(!(content.trim()) || /[@#\$%\^&\*]+/g.test(content)){
		if(/[@#\$%\^&\*]+/g.test(content)){
			myApp.alert('请正确填写帖子正文！');
			return;
		}
		$("#myForm").submit();
	}
  </script>

</body>
