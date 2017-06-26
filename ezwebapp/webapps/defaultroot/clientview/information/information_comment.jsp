<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>

<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>评论</title>
  
 </head>

<body class="grey-bg">
    <div class="views">
        <div class="view">
            <div class="pages" style="background:#f6f6f6">
                <div class="page" data-page="page-webapp-focum">
                    <section class="section-focum section-focum-replies wh-section  show" style="background:#f6f6f6 !important">
                        <div class="focum-a new-infomation">
                            <div class="whitebg">
                                <div class="select-top clearfix">
                                    <a href="javascript:saveComment();" class="fr">发布评论</a>
                                </div>
                                <form id="saveForm">
	                                <div class="replies-con infomation-pl">
	                                    <textarea  maxlength="500"  name="commentContent" id="commentContent" placeholder="请输入评论内容"></textarea>
	                                     <input type="hidden" name="informationId" id="informationId" value="${informationId }"/>
	                                     <input type="hidden" name="channelId" id="channelId" value="${channelId }"/>
	                                </div>
                                 </form>
                            </div>
                           
                                <div id="comList" class="pl-follow-listbox">
                                    
                                </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/zepto.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/plugin/simplecalendar.js"></script>
    <script src="<%=rootPath%>/clientview/js/common.js"></script>
    <script type="text/javascript">
    var myApp = new Framework7();
    var $$ = Dom7;
	
	$(function(){
  		loadCommentListt();
    });
	
	//加载查询信息列表
    function loadCommentListt() {
	  var url = '/defaultroot/information/commentList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"informationId" : '${informationId}'},
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			if(jsonData.data0.length>0){
				var comHtml = '';
				for(var i = 0; i < jsonData.data0.length; i++){
					var arr = jsonData.data0[i].empLivingPhoto.split('.');
		    		if(jsonData.data0[i].empLivingPhoto && 'null' != jsonData.data0[i].empLivingPhoto){
			    		var arr = jsonData.data0[i].empLivingPhoto.split('.');
			    		var fileName = jsonData.data0[i].empLivingPhoto;
			    		var id = arr[0];
			    		loadImg(fileName,id);
						empLivingPhoto = "<img name='"+id+"'  class='fl'>";
			    	}else{
			    		empLivingPhoto = "<img src='/defaultroot/clientview/images/user3.png'  class='fl'/>";
			    	}
			    	var commentContent=jsonData.data0[i].commentContent;
			    	commentContent=commentContent.replace(/\n|\r|(\r\n)|(\u0085)|(\u2028)|(\u2029)/g, "<br>");
					comHtml += '<div class="pl-follow-list">'
                             + '<div class="top clearfix">'
                             + empLivingPhoto
                             + '<div class="fl">'
                             + '<p>'+jsonData.data0[i].commentIssuerName
                             + '<span>&nbsp;&nbsp;'+jsonData.data0[i].commentIssuerOrg+'</span>'
                             + '</p>'
                             + '</div>'
                             + '<span class="fr">'+jsonData.data0[i].commentIssueTime.substring(0,16)+'</span>'
                             + '</div>'
                             + '<div class="con">'
                             + '<h2>'+commentContent+'</h2>'
                             + '</div>'
                             + '</div>';
				}
				$$('#comList').html(comHtml);	
			}else{
				myApp.hidePreloader();
				$$('#comList').html('<div  style="padding: 1rem; font-size: 17px;"  class="follow-list">系统未查询到相关记录 !</div>');
			}
		  },error: function(xhr, status) {
		  	$$('#infoList').html('<div  style="padding: 1rem; font-size: 17px;"  class="follow-list">系统未查询到相关记录 !</div>');
		  }
	  });
	}
	
	//保存评论
 	var comflag = 1;
	function saveComment(){
		var cont = removeAllSpace($$('#commentContent').val());
		if( cont == ''){
			myApp.alert('内容不能为空!');
			return;
		}
		$$.ajax({
			url : "/defaultroot/information/saveComment.controller",
			data : $("#saveForm").serialize(),
			type : "post",
			success : function(data){
				var jsonData = eval("("+data+")");
				if(jsonData.result == 'success'){
					comflag = 0;
					myApp.alert('评论成功！', function () {
				      	location.reload();			      	
				      });
				}else if(jsonData.result == 'fail'){
					myApp.alert("评论失败！");
				}
			},
			error : function(){
				myApp.alert("评论异常！");
			}
		});
	}
	
	//加载联系人的同时加载头像
	function loadImg(filename,id){
		$.ajax({
			type : 'post',
			url : '/defaultroot/download/downloadImg.controller',
			dataType : 'text',
			data : {"fileName":filename,"name":filename,"path":"peopleinfo"},
			success : function(data){
				//alert(data);
				$('img[name='+id+']').attr("src","/defaultroot/"+data);
			},
			error : function (xhr,type){
				//alert('数据查询异常！');
			}
		});
	}
	
	function removeAllSpace(str) {
		return str.replace(/\s+/g, "");
	}
 </script>
</body>


