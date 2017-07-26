<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ page import="org.springframework.web.util.HtmlUtils"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport">
	<link rel="stylesheet" href="/defaultroot/clientview/template115/css/template.reset.css" />
<style>
p{line-height:none}
</style>
</head>
<body id="body1" style="word-wrap:break-word;font-size: 1.3rem;overflow-y:scroll;">
	<c:set var="mailcontent">${mailcontent}</c:set>
	<c:set var="gnome">${gnome}</c:set>
	<c:set var="infoId">${infoId}</c:set>
	<c:set var="infoType">${infoType}</c:set>
	<c:set var="channelId">${channelId}</c:set>
	<c:set var="boardroomApplyId">${boardroomApplyId}</c:set>
	<c:set var="wfWorkId">${wfWorkId}</c:set>
	<%
	    String content = (String)pageContext.getAttribute("mailcontent");
	    //content = com.whir.util.StringUtils.resizeImgSize(content, "240", "50%");//增加图片长宽，并赋予点击展开效果(暂时取消此方法)
	    String infoId = (String)pageContext.getAttribute("infoId");
	    String infoType = (String)pageContext.getAttribute("infoType");
	    String channelId = (String)pageContext.getAttribute("channelId");
		String boardroomApplyId = (String)pageContext.getAttribute("boardroomApplyId");
		String wfWorkId = (String)pageContext.getAttribute("wfWorkId");
		String rep ="";
		
		if(infoId != null && !"".equals(infoId)){
			rep = "<a target='_top' href='/defaultroot/information/infoDetail.controller?infoId="+infoId+"&informationType="+infoType+"&channelId="+channelId+"&informationCommonNum=0'>";
			content = content.replaceAll("<a href[^>]*>",rep);
		}else if(boardroomApplyId != null && !"".equals(boardroomApplyId)){
			if("boardroomApplyId".equals(boardroomApplyId)){
				rep = "<a target='_top' href='javascript:meetingApply()'>";
				content = content.replaceAll("<a href[^>]*>",rep);
			}else{
				rep = "<a target='_top' href='/defaultroot/newmeeting/meetingNoticeDetail.controller?noticeId="+boardroomApplyId+"'>";
				content = content.replaceAll("<a href[^>]*>",rep);
			}
		    
		}else if(wfWorkId != null && !"".equals(wfWorkId)){
		    rep = "<a target='_top' href='/defaultroot/dealfile/process.controller?workStatus=0&workId="+wfWorkId+"'>";
			content = content.replaceAll("<a href[^>]*>",rep);
		}
    	String gnome = HtmlUtils.htmlUnescape((String)pageContext.getAttribute("gnome"));
	%>
	<c:out value="<%=content%>"  escapeXml="false" />
	<%=gnome %>
</body>
</html>
<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
<script type="text/javascript">
	

	$(function(){
		$("#body1 p").css("line-height","");
		loadImg();
	});

	function loadImg(){
		$("input[name='pictureName']").each( 
			function (){
				var filename = $(this).val();
				//alert(filename);
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
							$('#'+id).attr("width","100%");
							$('#'+id).attr("height","100%");
							$('#'+id).attr("onclick","window.open('<%=rootPath%>"+data+"')");//给图片增加一个点击展示图片效果
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
	function downFile(menuHtmlLink,menuFileLink,aId) {
	  	var path = 'information';
	  	if(aId == undefined){
	  		aId = menuHtmlLink.split('.')[0];
	  		path = 'html';
	  	}
	  		
	  	$.ajax({
			type: 'post',
			url: "<%=rootPath%>/download/getOpenFileUrl_New.controller",
			dataType:'text',
			data : {"fileName": menuHtmlLink,"name": menuFileLink,"path":path},
			success: function(data){
				var jsonData = eval("("+data+")");
				clickSub(jsonData.url,$('#'+aId),menuHtmlLink,"information",jsonData.smartInUse,jsonData.isEncrypt,jsonData.tmpurl,jsonData.apptype);
			},error: function(xhr, type){
				alert('数据查询异常！');
			}
		});
	  		
	}


	function meetingApply(){
		alert("该功能移动端暂未开放，请于pc端查看。");
	}
	
</script>