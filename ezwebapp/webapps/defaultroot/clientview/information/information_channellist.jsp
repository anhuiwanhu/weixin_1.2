<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
	String channelFlag = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("channelFlag")));
	if(channelFlag == null){
		channelFlag = "0";
	}
%>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>
  	<c:set var="channelName">${channelName }</c:set>
  	 <%
		String channelName = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("channelName"));
		if(channelName.length()>10){
			channelName = channelName.substring(0,9)+"..."; 
		}
	 %> 
	 <%=channelName %>
  </title>
  
 </head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-infomation-column">
          <section class="wh-section infinite-scroll pull-to-refresh-content" id="sectionScroll">
          		<c:set var="channelFlag"><%=channelFlag %></c:set>
          		<div class="pull-to-refresh-layer">
	              <div class="preloader"></div>
	              <div class="pull-to-refresh-arrow"></div>
	            </div>
	            <div class="webapp-infomation-column">
	            <c:if test="${channelFlag == 1 }">
	              <div class="subtitle">
	                <a href="" onclick="javascript:history.back(-1);">
	                  <i class="fa fa-angle-left"></i>
	                  <span>
                  		<%=channelName %>
	                  </span>
	                </a>
	              </div>
	              </c:if>
	              <div class="list-block">
	              	<header id="searchBar" class="wh-search">
	                <div class="wh-container">
	                  <div class="wh-search-input">
	                    <form action="javascript:return true;" method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar" id="sendForm">
	                      <label class="fa fa-search" for="search"></label>
	                      <input id="searchBug1" type="search" class="nomal-search"placeholder="请输入信息标题查询" name="title"/>
	                      <a href="javascript:cancelSearch();" class="searchbar-cancel">取消</a>
	                    </form>
	                  </div>
	                </div>
	              </header>
	                <ul>
	                  <c:if test="${not empty docXml}">
                		<x:parse xml="${docXml}" var="doc" />
						<c:set var="recordCount" value="0" />
						<x:forEach select="$doc//informationChannel" var="n" varStatus="status">
							<c:set var="recordCount">${recordCount+1 }</c:set>
							<c:set var="curChannelName"><x:out select="$n/channelName/text()" /></c:set>
							<c:set var="curChannelId"><x:out select="$n/channelId/text()"/></c:set>
							<c:set var="hasChildChannl"><x:out select="$n/hasChildChannl/text()"/></c:set>
							<c:set var="hasInfomation"><x:out select="$n/hasInfomation/text()"/></c:set>
							<c:set var="channelNeedCheckup"><x:out select="$n/channelNeedCheckup/text()"/></c:set>
							<li class="swipeout">
								<a href="javascript:openChannel('${curChannelId }','${curChannelName }');" class="swipeout-content item-content">
								  <div class="webapp-div">
									<div class="tips">${fn:substring(curChannelName,0,1)}</div>
									<span>${curChannelName}</span>
								  </div>
								</a>
							 </li>
						</x:forEach>
						<c:if test="${recordCount==0}">
							<li>
								<a href="#" class="swipeout-content item-content">
								  <div class="webapp-div">
									<span>系统没有查询到栏目记录！</span>
								  </div>
								</a>
		                    </li>
						</c:if>
					  </c:if>
	                </ul>
	              </div>
	              <div class="info-list">
	                <div class="list-block">
	                  <ul id="infoList">
	                    
	                  </ul>
	                  <aside class="wh-load-box" style="display: block">
					     <div class="wh-load-tap">上滑加载更多</div>
					     <div id="infoLoadBox" class="wh-load-md">
					     <span></span>
					     <span></span>
					     <span></span>
					     <span></span>
					     <span></span>
					     </div>
					 </aside>
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
    var mainView = myApp.addView('.view'); 
	
	// 下拉刷新页面
	 var ptrContent = $$('.pull-to-refresh-content');
	 	
	 // 添加'refresh'监听器
	 ptrContent.on('refresh', function(e) {
	 	// 模拟2s的加载过程
	   setTimeout(function() {
	   	loadInfoList(0,0)
	     myApp.pullToRefreshDone();
	   }, 1000);
	
	 });
	
	var channelId = "";
	var channelType = "0";
	var userDefine = "";
	var infoPagerOffset = 0;
    var infoMaxItems = 0;
    var userChannelId = "";
    $$('#infoLoadBox').hide();
	var loading = false;
	$(function(){
		channelId = "${channelId}";
		userChannelId = "${userChannelId}";
		if(channelId != "0"){
			loadInfoList(0,0);
		}else{
			loading = true;
		}
		 
		//设置icon样式类
		setIconClass($$('.tips'));
	});
	
	
    $$(document).on('infinite', '#sectionScroll', function() {
		    // 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		    var infoIndex = $$('#infoList li').length;
		    setTimeout(function() {
			      if (infoIndex >= infoMaxItems) {
			        // 加载完毕，则注销无限加载事件，以防不必要的加载
			        myApp.detachInfiniteScroll($$('#sectionScroll'));
			        return;
				  }
				  if (infoMaxItems - infoIndex > 0) {
			        infoPagerOffset = infoPagerOffset+15;
			        loadInfoList(infoPagerOffset,'1');
			        return;
				  }
		    }, 500);
	  });
    
	//加载查询信息列表
    function loadInfoList(nextPagerOffset,flag,showFlag) {
      if(channelId == '' && userChannelId == ''){
     	channelType = '1';
     	userDefine = '0';
      }
      if(channelId == '' && userChannelId!= ''){
      	channelType = '1';
      	userDefine = '1';
      }
      if(flag == 0 && showFlag!=0){
      	myApp.showPreloader('加载信息列表');
      }
	  var url = '/defaultroot/information/infoList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"channelId" : channelId, "title" : $$('#searchBug1').val(), "channelType" : channelType,"userDefine" : userDefine,"pagerOffset" : nextPagerOffset,"userChannelId" : userChannelId},
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			var infoListHtml = '';
			var findTitle = $$('#searchBug').val();
			infoMaxItems = jsonData.data1;
			if(infoMaxItems>15){
				$$('#infoLoadBox').show();
			}else{
				$$('#infoLoadBox').hide();
			}
			if(jsonData.data0.length<15){
				$$('#infoLoadBox').hide();
			}
			if(jsonData.data0.length>0){
				for(var i = 0; i < jsonData.data0.length; i++){
					var titleHtml = '<strong>'+jsonData.data0[i].informationTitle+'</strong>';
					if(jsonData.data0[i].titleColor == 1){
						titleHtml = '<strong style="color:red">'+jsonData.data0[i].informationTitle+'</strong>';
					}
					infoListHtml += '<li class="swipeout" onclick="openInfoDetail('+jsonData.data0[i].informationId+','+jsonData.data0[i].informationType+',\''+jsonData.data0[i].channelId+'\',\''+jsonData.data0[i].informationCommonNum+'\');">'
					+'<a href="" class="swipeout-content item-content">'
					+'<div class="webapp-div">'
					+titleHtml
					+'<p>'
					+'<span>'+jsonData.data0[i].informationIssueTime.substring(0,16)+'</span>'
					+'<em class="skyblue" style="margin:0 0.2rem;">'+jsonData.data0[i].channelName+'</em>'
					+'<em class="gray">'+jsonData.data0[i].informationKits+'</em>'
					+'</p>'
					+'</div>'
					+'</a>'
					+'</li>';
				}
				if(flag == 0){
					$$('#infoList').html(infoListHtml);	
					myApp.hidePreloader();	
				}else{
					$$('#infoList').append(infoListHtml);
				}
				loading = false;
			}else{
				myApp.hidePreloader();
				$$('#infoList').html('<li class="swipeout"><a href="webapp-infomation-artical.html" class="swipeout-content item-content"><div class="webapp-div"><strong>系统未查询到相关记录</strong></div></a></li>');
				$$('#infoList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  },error: function(xhr, status) {
		  	$$('#infoList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
	
	 //绑定查询框回车事件
    $$('#searchBug1').keydown(function(event){
    	var searchTitle = $$('#searchBug1').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索信息标题');
			}else{
				loadInfoList(0,0,0);
			}
		} 
	});
	
	//清空选择
	function cancelSearch() {
		$("#searchBug1").val('');
		infoPagerOffset = 0;
		loadInfoList(0,0,0);
	}
	
	//打开栏目详情页
	function openChannel(curChannelId,curChannelName){
		window.location="/defaultroot/information/channelList.controller?channelFlag=1&channelId="+curChannelId+"&channelName="+curChannelName;
	}
	
	//打开信息详情页
	function openInfoDetail(infoId,informationType,channelId,informationCommonNum){
		window.location="/defaultroot/information/infoDetail.controller?infoId="+infoId+"&informationType="+informationType+"&channelId="+channelId+"&informationCommonNum="+informationCommonNum;
	}
 </script>
</body>


