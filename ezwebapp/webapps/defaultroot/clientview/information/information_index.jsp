<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>

<%@ include file="../common/headerInit.jsp" %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>信息门户</title>
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-infomation">
          <!-- 栏目视图 -->
          <section id="indexSection" class="section-info infinite-scroll wh-section show wh-section-bottomfixed pull-to-refresh-content">
          	<div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="webapp-infomation">
            <c:if test="${not empty docXml1}">
            	<x:parse xml="${docXml1}" var="doc1"/>
            	<c:set var="headCount"><x:out select="$doc1//data/recordCount/text()"/></c:set>
            	<c:if test="${headCount !=0 }" >
              	<div class="info-img info-img-height">
                <!-- <img src="images/info-title.jpg" /> -->
                <div class="swiper-container mySwiper_info">
                  <div class="swiper-pagination"></div> 
                  <div class="swiper-wrapper">
                 	 	<x:forEach select="$doc1//infoList" var="li" varStatus="statusNew">
                 	 		<c:set var="infoId"><x:out select="$li/informationId/text()"/></c:set>
                 	 		<c:set var="infoType" ><x:out select="$li/informationType/text()"/></c:set>
                 	 		<c:set var="channelId" ><x:out select="$li/channelId/text()"/></c:set>
                 	 		<c:set var="channelName" ><x:out select="$li/channelName/text()"/></c:set>
                 	 		<c:set var="informationCommonNum" ><x:out select="$li/informationCommonNum/text()"/></c:set>
                 	 		<c:set var="imgID" ><x:out select="$li/picList/picSaveName/text()"/></c:set>
                 	 		<x:forEach select="$li//picList/picSaveName" var="pl" >
                 	 			<input type="hidden"  name="imgSaveName" value="<x:out select="$pl/text()"/>"/>
							</x:forEach>
							<c:choose>
								<c:when test="${imgID =='' }">
									<div class="swiper-slide"><img onclick="openInfoDetail('${infoId}','${infoType }','${channelId }','${informationCommonNum }');" src="<%=rootPath%>/clientview/images/info-title.jpg" /></div>
								</c:when>
								<c:otherwise>
									<div class="swiper-slide"><img id="head_${fn:substring(imgID,0,25)}" onclick="openInfoDetail('${infoId}','${infoType }','${channelId }','${informationCommonNum }');"/></div>
								</c:otherwise>
							</c:choose>
                 	 	</x:forEach>
                  </div>
                </div>
              </div>
              </c:if>
              </c:if>
            <header id="searchBar" class="wh-search">
                <div class="wh-container">
                  <div class="wh-search-input">
                    <form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar" id="sendForm">
                      <label class="fa fa-search" for="search"></label>
                      <input id="searchBug1" type="search" class="nomal-search"placeholder="请输入信息标题查询" name="title"/>
                      <a href="javascript:cancelSearch();" class="searchbar-cancel">取消</a>
                    </form>
                  </div>
                </div>
              </header>
              <div class="info-list">
                <div class="list-block">
                  <ul id="indexUl">
					
                  </ul>
                   <aside class="wh-load-box" style="display: block">
					     <div class="wh-load-tap">上滑加载更多</div>
					     <div id="indexLoadBox" class="wh-load-md">
					     <span></span>
					     <span></span>
					     <span></span>
					     <span></span>
					     <span></span>
					     </div>
					</aside>
                </div>
              </div>
            </div>
          </section>
          <!-- 栏目视图 channel-view-->
          <section class="show section-info infinite-scroll wh-section wh-section-bottomfixed pull-to-refresh-content" data-ptr-distance="40" id="sectionScroll">
            <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
			<header id="searchBar" class="wh-search">
                <div class="wh-container">
                  <div class="wh-search-input">
                    <form action="javascript:return true;" method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar" id="sendForm">
                      <label class="fa fa-search" for="search"></label>
					  <input type="hidden" name="channelType" value="1" id="channelType">
                      <input id="searchBug" type="search" class="nomal-search"placeholder="请输入信息标题查询" name="title"/>
                      <i class="fa fa-times-circle-o"  style="display:none;"  onclick="removeSearchInput()"></i>
                      <p class="fabu"><a href="javascript:openWrite();" class="button button-round active"><i class="fa fa-pencil-square-o"></i>发布</a></p>
                    </form>
                  </div>
                </div>
              </header>
            <div class="webapp-infomation-channel-view">
            
              <div class="app-tabheader-line clearfix" id = "channelView" style="display: none">
                 	<!--关联到第一个tab, 默认激活 -->
                <div class="clearfix">
                  <a href="#tab11" id="channelA1" onclick="channelYS(0);" class="tab-link">
                    <span>信息</span>
                  </a>
                  <a href="#tab12" id="channelA" onclick="channelYS(1);" class="tab-link active">
                    <span>栏目</span>
                  </a>
                </div>
              </div>
               <!-- 顶部三个按钮 -->
              <div class="swiper-container swiper-1"  id="topChannel">
                <div class="swiper-pagination"></div>
                <div class="swiper-wrapper">
                  <div id="infoManTab" class="swiper-slide active"><span onclick="openInfoMan();">信息管理</span></div>
                  <div id="cusCanTab" class="swiper-slide"><span onclick="loadCustomChannel('${userChannelId}',1)">单位主页</span></div>
            		<c:if test="${not empty chDocXml}">
            		<x:parse xml="${chDocXml}" var="chDoc"/>
            		 <x:forEach select="$chDoc//userChannel" var="ucl" >
                          <c:set var="userChannelName" ><x:out select="$ucl/userChannelName/text()"/></c:set>
                          <c:set var="userChannelId" ><x:out select="$ucl/userChannelId/text()"/></c:set>
                          <div  id="cusCanTab_${userChannelId }" class="swiper-slide"><span onclick="loadCustomChannel('${userChannelId}',2)">${userChannelName }</span></div>
                      </x:forEach>
                     </c:if>
                </div>
              </div>
              <!-- 顶部三个按钮 -->
              
              <!-- Tabs, 标签内容区容器 -->
              <div class="tabs">
                <!-- Tab 1, 默认激活 -->
                <div id="tab11" class="tab">
                  <div class="webapp-infomation-column ">
                    <div class="list-block">
                      <ul class="info-list">
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
                </div>
                <!-- Tab 2 -->
                <div id="tab12" class="tab active">
                  <div class="webapp-infomation-column">
                    <div class="list-block">
                     <ul>
                        
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <!-- @我推送 push-->
          <section class="section-info infinite-scroll pull-to-refresh-content wh-section wh-section-bottomfixed" id="sectionScrollpush">
          	 <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="webapp-infomation-push">
             	<table id="pushTable" style="border-collapse:collapse; border-spacing:0;width:100%;">
             	</table>
             	<aside class="wh-load-box" style="display: block">
				     <div class="wh-load-tap">上滑加载更多</div>
				     <div id="pushLoadBox" class="wh-load-md">
				     <span></span>
				     <span></span>
				     <span></span>
				     <span></span>
				     <span></span>
				     </div>
				 </aside>
            </div>
          </section>
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="footer-info wh-footer-btn row no-gutter">
                  <a href="javascript:openInfoIndex()"  class="fbtn-matter col-33">
                    <div><i class="fa fa-info-home"></i></div><span>信息门户</span></a>
                  <a href="javascript:openChannellist();" id="tagA1" class=" fbtn-cancle col-25">
                    <div><i class="fa fa-view-column"></i></div><span>栏目视图</span></a>
                  <a href="javascript:openPushList();" id="tagA2" class=" fbtn-cancle col-33">
                    <div><i class="fa fa-push"></i><em id="phnum">${pushNum}</em></div>
					<span>@我推送</span></a> 
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
  <script type="text/javascript">
  //var myApp = new Framework7();
   var myApp = new Framework7({
          fastClicks: false,
    });
  var $$ = Dom7;
 
  
  var loading = false;

  //栏目视图信息列表下页数据
  var infoPagerOffset = 0;
  //信息列表总条数
  var infoMaxItems = 0;
  $$('#infoLoadBox').hide();
  //是否是栏目视图自定义频道
  var findInfoIndex = 0;
  // 数据列表

  // 下拉刷新页面
  var indexPull = 0;
  var ptrContent = $$('.pull-to-refresh-content');
  
  // 添加'refresh'监听器
  ptrContent.on('refresh', function(e) {
  
  	// 模拟2s的加载过程
    setTimeout(function() {
    	if(indexPull == 0){
    		nextIndexList(0,1);
    	}else if(indexPull == 1){
    		var channelStyle = $("#channelView").attr("style");
	    	if(channelStyle.indexOf("none") > 0){
	    		loadChannel();
	    	}else{
	    		if($("#channelA").hasClass("active")){
	    			findChannel();
				}else{
					loadInfoList(0,0);
				}
	    	}
    	}else{
    		loadPushList(0,1);
    	}
      myApp.pullToRefreshDone();
    }, 1000);
  	

    // 清除搜索区域焦点bug
    function removeSearch(schElmID) {
      $$(schElmID).blur().val(""); //主动清除焦点
      $$(schElmID).next('.searchbar-cancel').hide();
    }

    // 搜索焦点时
    $$('#fbtn-save').on('click', function() {
      $$(this).next('.searchbar-cancel').show();
    })
  });

  //swipe图片切换
  var mySwiper_info = myApp.swiper('.mySwiper_info', { 
    pagination:'.mySwiper_info .swiper-pagination',
    spaceBetween: 0 //控制图片拖动是显示的空隙 无空隙为0
  });

  //底部切换
  $$(".footer-info>a").click(function() {
    var _this = $$(this);
    var index = _this.index();

    $$(".footer-info>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    $$(".section-info").hide().eq(index).show();

  });
 	//加载图片
 	$(function(){
 		var loadIndex = sessionStorage.getItem("loadIndex");
 		if(loadIndex == 2){
 			$$(".footer-info>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    	    $$(".footer-info>a").eq(1).removeClass("fbtn-cancle").addClass("fbtn-matter");
			$$(".section-info").hide().eq(1).show();
 			var chanIndex = sessionStorage.getItem("chanIndex");
 			indexPull = 1;
 			if(chanIndex == ''){
 				$$(".swiper-1 .swiper-slide").removeClass("active");
		 		$$("#cusCanTab").addClass("active");
 				loadCustomChannel(chanIndex,1)
 			}else if(chanIndex == -1 || chanIndex == null){
 				$$(".swiper-1 .swiper-slide").removeClass("active");
		 		$$("#infoManTab").addClass("active");
 				loadChannel();
 			}else {
 				$$(".swiper-1 .swiper-slide").removeClass("active");
		 		$$("#cusCanTab_"+chanIndex).addClass("active");
 				loadCustomChannel(chanIndex,2)
 			}
 		}else if(loadIndex == 3){
 			$$("#tagA2").click();
 		}else if(loadIndex == 4){
 				$$(".footer-info>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
	    	    $$(".footer-info>a").eq(1).removeClass("fbtn-cancle").addClass("fbtn-matter");
				$$(".section-info").hide().eq(1).show();
				var channelYS = sessionStorage.getItem("channelYS");
				if(channelYS == 1){
					$$("#channelA").click();
				}else{
					$$("#channelA1").click();
				}
				$("#searchBug").val(sessionStorage.getItem("searchTitle"));
				
				$$("#channelView").css("display","block");
				$$("#topChannel").css("display","none");
				$$(".fabu a").html("取消");
				
				loading = false;
				infoPagerOffset = 0;
				$$('#tab12 ul').html('');
				loadInfoList(0,0,0);
				findChannel();
 			}else{
	 			nextIndexList(0,1);
		 		var arr = $("input[name=imgSaveName]");
		 		if(arr.length != 0 && arr!=undefined){
		 			for(var i=0;i<arr.length;i++){
		 				openImg(arr[i].value,'head');
		 			}
		 		}
		 		var arrList = $("input[name=imgSaveNameList]");
		 		if(arrList.length != 0 && arrList!=undefined){
		 			for(var i=0;i<arrList.length;i++){
		 				openImg(arrList[i].value,'list');
		 			}
		 		}
 		}
 		findPhshNum();
    });
    //主页信息列表总记录数
    var indexRecordCount = 0;
    //主页分页加载
    var indexLoading = false;
    //主页当前记录数
    var indexPagerOffset = 0;
    $$(document).on('infinite', '#indexSection', function() {
    // 如果正在加载，则退出
    if (indexLoading) return;
    indexLoading = true;
    var infoIndexL = $$('#indexUl li').length;
    setTimeout(function() {
	      if (infoIndexL >= indexRecordCount) {
	        // 加载完毕，则注销无限加载事件，以防不必要的加载
	        $$('#indexLoadBox').hide();
	        myApp.detachInfiniteScroll($$('#indexSection'));
	        return;
		  }
		  if (indexRecordCount - infoIndexL > 0) {
		  	$$('#indexLoadBox').show();
	        indexPagerOffset = indexPagerOffset+15;
	        nextIndexList(indexPagerOffset);
	        return;
		  }
    }, 500);
 });
 	
 	function channelYS(flag) {
		sessionStorage.setItem("channelYS",flag);
	}
 
   //打开信息门户
   function openInfoIndex() {
   		sessionStorage.setItem("loadIndex","1");
		myApp.showPreloader('加载中...');
		myApp.attachInfiniteScroll($$('#indexSection'));
		indexPagerOffset = 0;
		document.title="信息门户"; 
		indexPull = 0;
	nextIndexList(indexPagerOffset,1);
  }
	// 搜索焦点时
    $$('#searchBug').on('click', function() {
    	 $$('.fa-times-circle-o').show();
    })
 
  //主页信息门户下一页
  function nextIndexList(nextPagerOffset,indexFlag) {
	  var url = '/defaultroot/information/nextIndex.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"pagerOffset" : nextPagerOffset, "title" : $$('#searchBug1').val()},
		  dataType: "text",
		  success: function(data) {
		  	 myApp.pullToRefreshDone();
			var jsonData = eval("("+data+")");
			var dataList = jsonData.data.infoList;
			indexRecordCount = jsonData.data.recordCount;
			if(indexRecordCount > 15){
	 			$$('#indexLoadBox').show();
	 		}else{
	 			$$('#indexLoadBox').hide();
	 		}
			var indexListHtml = '';
			var imgName = '';
			var arr = '';
			if(Array.isArray(dataList)){
				if(dataList.length>0){
					for(var i = 0; i < dataList.length; i++){
						var oneImg='';
						var manyImg='';
						if(dataList[i].picList != undefined){
							imgName = dataList[i].picList.picSaveName;
							if(Array.isArray(imgName)){
								var imgSize = 0;
								if(imgName.length > 4){
									imgSize = 4;
								}else{
									imgSize = imgName.length;
								}
								manyImg = '<div class="clearfix">'
								for(var j = 0; j < imgSize; j++){
									manyImg +='<img id="list_'+imgName[j].substring(0,25)+'"/>';
									openImg(imgName[j],'list');
								}
								manyImg += '</div>';
							}else{
								oneImg = '<img id="list_'+imgName.substring(0,25)+'"/>';
								openImg(imgName,'list');
							}
						}
						if(manyImg !=''){
							oneImg = '';
						}
						var titleHtml = '<strong>'+dataList[i].informationTitle+'</strong>';
						
						if(dataList[i].titleColor == 1){
							titleHtml = '<strong style="color:red">'+dataList[i].informationTitle+'</strong>';
						}
						indexListHtml += '<li class="swipeout" onclick="openInfoDetail('+dataList[i].informationId+','+dataList[i].informationType+','+dataList[i].channelId+','+dataList[i].informationCommonNum+');">'
						+'<a href="#" class="swipeout-content item-content">'
						+'<div class="webapp-div">'
						+oneImg
						+'<div>'
						+titleHtml
						+manyImg
						+'<p>'
						+'<span>'+dataList[i].informationIssueTime.substring(0,16)+'</span>'
						+'<em class="skyblue" style="margin:0 0.2rem;">'+dataList[i].channelName+'</em>'
						+'<em class="gray">'+dataList[i].informationKits+'</em>'
						+'</p>'
						+'</div>'
						+'</div>'
						+'</a>'
						+'</li>'
					}
					if(indexFlag == 1){
						$$('#indexUl').html(indexListHtml);
						myApp.hidePreloader();
					}else{
						$$('#indexUl').append(indexListHtml);
					}
				}else{
					myApp.hidePreloader();
					$$('#indexUl').html('<li class="swipeout"><a href="webapp-infomation-artical.html" class="swipeout-content item-content"><div class="webapp-div"><strong>系统未查询到相关记录</strong></div></a></li>');
				}
			}else if(dataList != undefined){
				var oneImg='';
				var manyImg='';
				if(dataList.picList != undefined){
					imgName = dataList.picList.picSaveName;
					if(Array.isArray(imgName)){
						var imgSize = 0;
						if(imgName.length > 4){
							imgSize = 4;
						}else{
							imgSize = imgName.length;
						}
						manyImg = '<div class="clearfix">'
						for(var j = 0; j < imgSize; j++){
							manyImg +='<img id="list_'+imgName[j].substring(0,25)+'"/>';
							openImg(imgName[j],'list');
						}
						manyImg += '</div>';
					}else{
						oneImg = '<img id="list_'+imgName.substring(0,25)+'"/>';
						openImg(imgName,'list');
					}
				}
				if(manyImg !=''){
					oneImg = '';
				}
				
				var titleHtml = '<strong>'+dataList.informationTitle+'</strong>';
						
				if(dataList.titleColor == 1){
					titleHtml = '<strong style="color:red">'+dataList.informationTitle+'</strong>';
				}
				
				indexListHtml += '<li class="swipeout" onclick="openInfoDetail('+dataList.informationId+','+dataList.informationType+','+dataList.channelId+','+dataList.informationCommonNum+');">'
				+'<a href="#" class="swipeout-content item-content">'
				+'<div class="webapp-div">'
				+oneImg
				+'<div>'
				+titleHtml
				+manyImg
				+'<p>'
				+'<span>'+dataList.informationIssueTime.substring(0,16)+'</span>'
				+'<em class="skyblue" style="margin:0 0.2rem;">'+dataList.channelName+'</em>'
				+'<em class="gray">'+dataList.informationKits+'</em>'
				+'</p>'
				+'</div>'
				+'</div>'
				+'</a>'
				+'</li>';
					if(indexFlag == 1){
						$$('#indexUl').html(indexListHtml);
						myApp.hidePreloader();
					}else{
						$$('#indexUl').append(indexListHtml);
					}
				}else{
					myApp.hidePreloader();
					$$('#indexUl').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
				}
				
				indexLoading = false;
		  },error: function(xhr, status) {
		  	myApp.hidePreloader();
		  	$$('#indexUl').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
 
  	//加载栏目视图
	function loadChannel() {
	  	  var url = '/defaultroot/information/channelListView.controller';
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType: "text",
		      success: function(data) {
		      	var jsonData = eval("("+data+")");
		      	var html = '';
				var iconClassArray = ['orange','yellow','pureblue','blue','skyblue','red'];
		      	if(jsonData.data0.length>0){
			      	for(var i = 0; i < jsonData.data0.length; i++){
						var random = Math.random();
						var index = Math.round(random * (iconClassArray.length-1));
						var iname = jsonData.data0[i].channelName.substring(0,1);
						var userChannelName = jsonData.data0[i].channelName;
						if(jsonData.data0[i].isView == 1){
				      		html +='<li onclick="goChannelList(\''+jsonData.data0[i].channelId+'\',\''+userChannelName+'\');">'
							+'<div class="webapp-div">'
		                    +'<div class="tips '+iconClassArray[index]+'">'+iname+'</div>'
		                    +'<span>'+jsonData.data0[i].channelName+'</span>'
							+'<span class="document-span">&#xf005;</span>'
		                    +'</div>'
		                    +'</li>';
	                    }
			      	}
	                $$('#tab12 ul').html(html);
					myApp.hidePreloader();
		      	}else{
		      		myApp.hidePreloader();
		      		$$('#tab12 ul').html(html);
		      	}
		      },error: function(xhr, status) {
		      		myApp.hidePreloader();
		      		$$('#tab12 ul').html(html);
		      }
	      });
		}

	//打开栏目视图
	function openChannellist() {
		$$(".swiper-1 .swiper-slide").removeClass("active");
		$$("#infoManTab").addClass("active");
		sessionStorage.setItem("loadIndex","2");
		$$(".fabu a").html('<i class="fa fa-pencil-square-o"></i>发布');
		$$("#channelView").css("display","none");
		$$('#channelA').click();
		myApp.showPreloader('加载中...');
		myApp.attachInfiniteScroll($$('#sectionScroll'));
		document.title="栏目视图"; 
		indexPull = 1;
		loadChannel();
	}
	
	 //绑定查询框回车事件
    $$('#searchBug1').keydown(function(event){
    	var searchTitle = $$('#searchBug1').val();
		if(event.keyCode == 13){ //绑定回车 
			myApp.showPreloader('搜索中，请稍后…');
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				 myApp.pullToRefreshDone();
				myApp.alert('请正确填写搜索信息标题')
			}else{
				nextIndexList(0,1);
			}
		} 
	});

	 //绑定查询框回车事件
    $$('#searchBug').keydown(function(event){
    	var searchTitle = $$('#searchBug').val();
		if(event.keyCode == 13){ //绑定回车 
			myApp.showPreloader("搜索中，请稍后…");
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.hidePreloader();
				myApp.alert('请正确填写搜索信息标题')
			}else{
				sessionStorage.setItem("loadIndex","4");
				sessionStorage.setItem("searchTitle",searchTitle);
				searchFlag = 0;
				if(findInfoIndex == 1){
					//myApp.showPreloader('加载中...');
					$$(".fabu a").html("取消");
					loadInfoList(0,0,0);
				}else{
					//myApp.showPreloader('加载中...');
					$$("#channelView a:first-child").click();
					$$("#channelView").css("display","block");
					$$("#topChannel").css("display","none");
					$$(".fabu a").html("取消");
					loading = false;
					infoPagerOffset = 0;
					$$('#tab12 ul').html('');
					loadInfoList(0,0,0);
					findChannel();
				}
				
			}
		} 
	});
	
	//栏目视图自定义频道信息列表
	var userChannelId = '';
	var userDefine = '';
	var channelType = 1;
	//查询位置，用于判断是否从自定义频道查询。
	var searchFlag = 0;
	function openInfoList(searchChannelType,searchUserDefine,searchChannelId) {
		myApp.showPreloader('加载中...');
		$$('#searchBug').val('');
		findInfoIndex = 1;
		searchFlag = 1;
		userChannelId = searchChannelId;
		userDefine = searchUserDefine;
		channelType = searchChannelType;
		$$("#channelView a:first-child").click();
		loadInfoList(0,0,1);  
	}
	
	//打开第一个页签
	function openInfoMan() {
		sessionStorage.setItem("chanIndex","-1");
		findInfoIndex = 0;
		userChannelId = '';
		userDefine = '';
		channelType = 1;
		$$('#searchBug').val('');
		loadChannel();
		//$$('#channelA').click();
	}

  //加载查询信息列表
  function loadInfoList(nextPagerOffset,flag,searchFlag) {
	  var url = '/defaultroot/information/infoList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  //data : {"title" : $$('#searchBug').val() ,"channelType" : $$('#channelType').val() ,"pagerOffset" : nextPagerOffset},
		  data : {"channelId" : "", "title" : $$('#searchBug').val(), "channelType" : channelType,"userDefine" : userDefine,"pagerOffset" : nextPagerOffset,"userChannelId" : userChannelId},
		  dataType: "text",
		  success: function(data) {
		  	myApp.hidePreloader();
			var jsonData = eval("("+data+")");
			var infoListHtml = '';
			var findTitle = $$('#searchBug').val();
			infoMaxItems = jsonData.data1;
			if(infoMaxItems>15){
				$$('#infoLoadBox').show();
			}else{
				$$('#infoLoadBox').hide();
			}
			if(jsonData.data0.length>0){
				for(var i = 0; i < jsonData.data0.length; i++){
					var orgNameInfo = jsonData.data0[i].informationIssueOrg;
					orgNameInfo = orgNameInfo.split(".")[orgNameInfo.split(".").length-1];
					var sumOrg = '';
					var findTitleHtml='';
					if(searchFlag == 0){
						findTitleHtml = '<em style="font-size: 1.3rem;">'+findTitle+'</em>';
						sumOrg = '<em class="skyblue">'+orgNameInfo+'·'+jsonData.data0[i].informationIssuer+'</em>';
					}else{
						sumOrg = '<em class="gray">'+jsonData.data0[i].informationKits+'</em>';
					}
					orgNameInfo = orgNameInfo.split(".")[orgNameInfo.split(".").length-1];
					var titleHtml = '<strong>'+jsonData.data0[i].informationTitle+findTitleHtml+'</strong>';
						
					if(jsonData.data0[i].titleColor == 1){
						titleHtml = '<strong style="color:red">'+jsonData.data0[i].informationTitle+findTitleHtml+'</strong>';
					}
					infoListHtml += '<li class="swipeout" onclick="openInfoDetail('+jsonData.data0[i].informationId+','+jsonData.data0[i].informationType+',\''+jsonData.data0[i].channelId+'\',\''+jsonData.data0[i].informationCommonNum+'\');">'
					+'<a href="" class="swipeout-content item-content">'
					+'<div class="webapp-div">'
					+titleHtml
					+'<p>'
					+'<span>'+jsonData.data0[i].informationIssueTime.substring(0,16)+'</span>'
					+'<em class="skyblue"  style="margin:0 0.2rem;">'+jsonData.data0[i].channelName+'</em>'
					+sumOrg
					+'</p>'
					+'</div>'
					+'</a>'
					+'</li>';
				}
				if(flag == 0){
					myApp.hidePreloader();
					$$('#tab11 ul').html(infoListHtml);	
				}else{
					myApp.hidePreloader();
					$$('#tab11 ul').append(infoListHtml);
				}
				loading = false;
			}else{
				myApp.hidePreloader();	
				$$('#tab11 ul').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  },error: function(xhr, status) {
		  	 myApp.hidePreloader();
		  	$$('#tab11 ul').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
	
	//信息列表分页
	$$(document).on('infinite', '#sectionScroll', function() {
			if($("#channelA").hasClass("active")) return;
		    // 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		    var infoIndex = $$('#tab11 li').length;
		    setTimeout(function() {
			      if (infoIndex >= infoMaxItems) {
			        // 加载完毕，则注销无限加载事件，以防不必要的加载
			        myApp.detachInfiniteScroll($$('#sectionScroll'));
			        $$('#infoLoadBox').hide();
			        return;
				  }
				  if (infoMaxItems - infoIndex > 0) {
			        infoPagerOffset = infoPagerOffset+15;
			        loadInfoList(infoPagerOffset,'1',searchFlag);
			        return;
				  }
		    }, 500);
	  });
	
	//打开推送视图
	function openPushList() {
		document.title="@我推送";
		myApp.showPreloader('加载中...'); 
		sessionStorage.setItem("loadIndex","3");
		indexPull = 2;
		loadPushList(0,1);
	}
	
	var pushLoading = false;
	//推送列表最大记录数
	var pushMaxItems = 0;
	var pushPagerOffset = 1;
	//推送视图下一页
	$$(document).on('infinite', '#sectionScrollpush', function() {
		    if (pushLoading) return;
		    pushLoading = true;
		    var pushIndex = $$('#pushTable tr').length;
		    setTimeout(function() {
			      if (pushIndex >= pushMaxItems) {
			        // 加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#pushLoadBox').hide();
			        myApp.detachInfiniteScroll($$('#sectionScrollpush'));
			        return;
				  }
				  if (pushMaxItems - pushIndex > 0) {
			        pushPagerOffset = pushPagerOffset+1;
			        loadPushList(1,pushPagerOffset);
			        return;
				  }
		    }, 500);
	  });
	
	//加载推送视图
  	function loadPushList(flag,currentPage) {
	  	  var url = '/defaultroot/information/loadPushList.controller?currentPage='+currentPage+'&'+Math.round(Math.random()*100);
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType:"json",
		      success: function(data) {
		      	var custDataList = data.custDataList;
		      	pushMaxItems = data.recordCount;
		      	if(custDataList.length < 15){
		      		$$('#pushLoadBox').hide();
		      	}
		      	var html = '';
		      	var head = '';
		      	var infoContent = '';
		      	if(custDataList.length>0){
			      	for(var i = 0; i < custDataList.length; i++){
			      		var fabulous = '赞';
			      		var jsonData = custDataList[i];
			      		if(jsonData[11]!='' && jsonData[11]!= null){
			      			openImg(jsonData[11],'push');
			      			var title = jsonData[9];
			      			if(jsonData[9].length>8){
				      			title = title.substring(0,18)+'...';
				      		}
			      			head = '<img id="push_'+jsonData[11].substring(0,25)+'"  /><span class="img-foot">'+title+'</span>';
			      		}else{
			      			head = '<strong>'+jsonData[9]+'</strong>';
			      		}
			      		if(jsonData[12] == '1'){
			      			fabulous = '已赞';
			      		}
			      		if(jsonData[10]){
			      		   infoContent = jsonData[10].replace(/<.*?>/ig,"");
						}
			      		if(jsonData[10] && jsonData[10].length>70){
			      			infoContent = infoContent.substring(0, 70)+'...';
			      		}
			      		var orgNameArr = jsonData[5].split(".");
			      		var readFlagHtml = '';
			      		if(jsonData[13] == '0'){
			      			readFlagHtml = '<i></i>';
			      		}
			      		html +='<tr>'
						+'<td>'
						+'<div class="push-cir">'
						+readFlagHtml
						+'</div>'
						+'</td>'
						+'<td>'
						+'<div class="puch-article">'
						+head
						//+'<img src="/clientview/images/info-title.jpg" />'
						+'<div class="push-tips clearfix">'
						+'<span>'+orgNameArr[orgNameArr.length-1]+'·'+jsonData[3]+'</span>'
						+'<div>'
						+'<span>'+jsonData[7].substring(0,16)+'</span>'
						+'<em>'+jsonData[6]+'</em>'
						+'</div>'
						+'</div>'
						+'<div class="push-content">'
						+'<p>'+infoContent+'</p>'
						+'</div>'
						+'<div class="push-footer clearfix">'
						+'<a href="##" id="idA'+jsonData[0]+'" onclick="moveFabulous('+jsonData[0]+')" class="fl">'+fabulous+'</a>'
						+'<a href="##" class="fr" onclick="openPushInfoDetail('+jsonData[8]+','+jsonData[14]+','+jsonData[0]+','+jsonData[13]+')">阅读全文</a>'
						+'</div>'
						+'</div>'
						+'</td>'
						+'</tr>';
			      	}
			      	 if(flag == 0){
			      	 	document.getElementById("pushTable").innerHTML = html;
			      	 }else{
			      	 	document.getElementById("pushTable").innerHTML += html;
			      	 }
	                myApp.hidePreloader();
		      	}else{
		      		 myApp.hidePreloader();
		      		 $$('#pushLoadBox').hide();
		      		 $$('.webapp-infomation-push table').html('<tr><td><div class="push-content"><p style="font-size:1.5rem;">暂无推送给您的信息！</p></div></td></tr>');
		      	}
		      },error: function(xhr, status) {
		      	 myApp.hidePreloader();
		      	 $$('#pushLoadBox').hide();
		      	 $$('.webapp-infomation-push table').html('<tr><td><div class="push-content"><p style="font-size:1.5rem;">暂无推送给您的信息！</p></div></td></tr>');
		      }
	      });
	}
	
	//查询栏目视图
	function findChannel() {
		var url = '/defaultroot/information/allChannelList.controller?channelName='+$$('#searchBug').val();
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType: "text",
		      success: function(data) {
		      	myApp.hidePreloader();
		      	var jsonData = eval("("+data+")");
		      	var html = '';
				var iconClassArray = ['orange','yellow','pureblue','blue','skyblue','red'];
		      	if(jsonData.data0.length>0){
			      	for(var i = 0; i < jsonData.data0.length; i++){
						var random = Math.random();
						var index = Math.round(random * (iconClassArray.length-1));
						var iname = jsonData.data0[i].channelName.substring(0,1);
			      		html +='<li onclick="openChannelFind('+jsonData.data0[i].channelId+',\''+jsonData.data0[i].channelName+'\');">'
						+'<div class="webapp-div">'
	                    +'<div class="tips '+iconClassArray[index]+'">'+iname+'</div>'
	                    +'<span>'+jsonData.data0[i].channelName+'</span>'
						+'<span class="document-span">&#xf005;</span>'
	                    +'</div>'
	                    +'</li>';
			      	}
	                $$('#tab12 ul').html(html);
					myApp.hidePreloader();
		      	}else{
		      		myApp.hidePreloader();
		      		$$('#tab12 ul').html('<li style="padding: 1rem;">系统未查询到相关记录 !</li>');
		      	}
		      },error: function(xhr, status) {
		      		myApp.hidePreloader();
		      		$$('#tab12 ul').html('<li style="padding: 1rem;">系统未查询到相关记录 !</li>');
		      }
	      });
	}
	
	//打开详情页
	function openInfoDetail(infoId,informationType,channelId,informationCommonNum){
		window.location="/defaultroot/information/infoDetail.controller?infoId="+infoId+"&informationType="+informationType+"&channelId="+channelId+"&informationCommonNum="+informationCommonNum;
	}
	//打开详情页
	function openWrite(){
		sessionStorage.setItem("loadIndex","1");
		var butfalg = $$(".fabu a").html();
		if(butfalg == '取消'){
			sessionStorage.setItem("loadIndex","2");
			$$('#channelA').click();
			$$("#topChannel").css("display","block");
			 $$(".swiper-1 .swiper-slide").removeClass("active");
			  $$("#infoManTab").addClass("active");
			$$('#searchBug').val('');
			openChannellist();
		}else{
			window.location="/defaultroot/information/create.controller";
		}
		
	}
	
	//加载图片
	function openImg(fileName,type) {
		var id = type+'_'+fileName.substring(0,25);
		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/downloadImg.controller",
			 dataType:'text',
			 data : {"fileName": fileName,"name": fileName,"path":"information/"+fileName.substring(0,6)},
			 success: function(data){
			 $('#'+id).attr("src", "<%=rootPath%>"+data);
			 },error: function(xhr, type){
			 }
		
		});
	}
	
	//推送页点赞
	function moveFabulous(id) {
		var fabulous = $$('#idA'+id).html();
		var fa = 0;
		var bul = '赞';
		if(fabulous == '赞'){
			fa = 1;
			bul = '已赞';
		}
		$.ajax({
			 type: 'post',
			 url: '/defaultroot/information/moveFabulous.controller',
			 dataType:'text',
			 data : {"id": id,"fabulous": fa},
			 success: function(data){
			 	$$('#idA'+id).html(bul);
			 },error: function(xhr, type){
				 //alert('数据查询异常！');
			 }
		});
	}
	
	function cancelSearch() {
		$("#searchBug1").val('');
		nextIndexList(0,1);
	}
	
	//清除搜索
	function removeSearchInput(){ 
    	 $$('.fa-times-circle-o').hide();
		$("#searchBug").val('');
	}
	
	   // 头部互动切换
    var mySwiper1 = myApp.swiper('.swiper-1', {
        pagination: '.swiper-1 .swiper-pagination',
        spaceBetween: 0,
        slidesPerView: 3
    });

 $$(".swiper-1 .swiper-slide").click(function(){
         $$(".swiper-1 .swiper-slide").removeClass("active");
         if($$(this).hasClass("active")){
            $$(this).removeClass("active");
        }
        else{
            $$(this).addClass("active");
        }
    })
	//跳转至栏目视图
	function goChannelList(channelId,channelName,userChannelId){ 
		window.location="/defaultroot/information/channelList.controller?channelFlag=1&channelId="+channelId+"&channelName="+channelName;
	}
	
	//打开栏目详情页
	function openChannelFind(curChannelId,curChannelName){
		window.location="/defaultroot/information/channelList.controller?channelFlag=1&channelId="+curChannelId+"&channelName="+curChannelName;
	}
	
	//打开推送详情页
	function openPushInfoDetail(infoId,informationType,id,readFlag){
		window.location="/defaultroot/information/infoDetail.controller?infoId="+infoId+"&informationType="+informationType+"&id="+id+"&readFlag="+readFlag;
	}
	//查询推送数量
	function findPhshNum() {
		$$.ajax({
		      type: "post",
		      url:  "/defaultroot/information/findPushNum.controller?"+Math.round(Math.random()*100),
		      dataType: "text",
		      success: function(data) {
		      	if(data == 0){
		      		$$("#phnum").hide();
		      	}else{
		      		$$("#phnum").html(data);
		      	}
		      }
	      });
	}
	
	//加载栏目视图
	function loadCustomChannel(channelId,channelKind) {
		  sessionStorage.setItem("chanIndex",channelId);
	  	  var url = '/defaultroot/information/loadCustomChannel.controller';
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType: "text",
		      data : {"channelType": channelId,"channelKind": channelKind},
		      success: function(data) {
		      	var jsonData = eval("("+data+")");
		      	var html = '';
				var iconClassArray = ['orange','yellow','pureblue','blue','skyblue','red'];
		      	if(jsonData.data0.length>0){
			      	for(var i = 0; i < jsonData.data0.length; i++){
						var random = Math.random();
						var index = Math.round(random * (iconClassArray.length-1));
						var iname = jsonData.data0[i].channelName.substring(0,1);
						var userChannelName = jsonData.data0[i].channelName;
						//if(jsonData.data0[i].isView == 1){
				      		html +='<li onclick="goChannelList(\''+jsonData.data0[i].channelId+'\',\''+userChannelName+'\');">'
							+'<div class="webapp-div">'
		                    +'<div class="tips '+iconClassArray[index]+'">'+iname+'</div>'
		                    +'<span>'+jsonData.data0[i].channelName+'</span>'
							+'<span class="document-span">&#xf005;</span>'
		                    +'</div>'
		                    +'</li>';
	                    //}
			      	}
	                $$('#tab12 ul').html(html);
					myApp.hidePreloader();
		      	}else{
		      		myApp.hidePreloader();
		      		$$('#tab12 ul').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		      	}
		      },error: function(xhr, status) {
		      		myApp.hidePreloader();
		      		$$('#tab12 ul').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		      }
	      });
		}
  </script>
</body>