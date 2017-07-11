<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/clientview/common/taglibs.jsp"%>

<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>汇报</title>
 
</head>

<body>
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="webapp-report">
          <section class="section-focum wh-section infinite-scroll wh-section-bottomfixed pull-to-refresh-content" id="myReportPage" style="display: block;">
          	<div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="webapp-form">
              <div class="three-tab-app clearfix">
                <div class="clearfix">
                  <a href="#tab1" id="myWeekA" class="tab-link active" onclick="toMyWeekList()">
                    <span>周报</span>
                  </a>
                  <a href="#tab2" id="myMonthA" class="tab-link " onclick="toMyMonthList()">
                    <span>月报</span>
                  </a>
                  <a href="#tab3" id="myOtherA" class="tab-link "  onclick="toMyOtherList()">
                    <!-- 切换到2个标签时增加的class "tab-link-rw" 并改变a 的宽度为50%-->
                    <span>其他</span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                <!-- Tab 1, 默认激活 -->
                <div id="tab1" class="tab active">
                  <header id="searchBar" class="wh-search">
                    <div class="wh-container">
                      <div class="wh-search-input">
                        <form  action="javascript:return true;" method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar searchbar-active">
                          <label class="fa fa-search " for="search"></label>
                          <input id="myWeekSearch" onfocus="weekShow()" type="search" class="nomal-search" placeholder="请输入汇报内容查询">
                          <i class="fa fa-times-circle-o receiveWeek"  style="display:none;"  onclick="removeMyWeek()"></i>
                          <p class="fabu"><a href="javascript:newReport('week');" class="button button-round active"><i class="fa fa-pencil-square-o"></i>新建</a></p>
                        </form>
                      </div>
                    </div>
                  </header>
                  <div class="webapp-meeting webapp-report-view">
                    <div class="meeting-notice">
                      <div class="list-block">
                        <ul class="" id="myWeekList">
                        </ul>
                        <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="myWeekLoadBox" class="wh-load-md">
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
                </div>
                <!-- Tab 2 -->
                <div id="tab2" class="tab">
                  <header id="searchBar" class="wh-search">
                    <div class="wh-container">
                      <div class="wh-search-input">
                        <form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar searchbar-active">
                          <label class="fa fa-search" for="search"></label>
                          <input id="myMonthSearch"  onfocus="monthShow()" type="search" class="nomal-search" placeholder="请输入汇报内容查询">
                          <i class="fa fa-times-circle-o receiveMonth"  style="display:none;"  onclick="removeMyMonth()"></i>
                          <p class="fabu"><a href="javascript:newReport('month');" class="button button-round active"><i class="fa fa-pencil-square-o"></i>新建</a></p>
                        </form>
                      </div>
                    </div>
                  </header>
                  <div class="webapp-meeting webapp-report-view">
                    <div class="meeting-notice">
                      <div class="list-block">
                        <ul class="" id="myMonthList">
                        </ul>
                        <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="myMonthLoadBox" class="wh-load-md">
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
                </div>
                <!-- Tab 3 -->
                <div id="tab3" class="tab">
                  <header id="searchBar" class="wh-search">
                    <div class="wh-container">
                      <div class="wh-search-input">
                        <form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar searchbar-active">
                          <label class="fa fa-search" for="search"></label>
                          <input id="myOtherSearch"  onfocus="otherShow()" type="search" class="nomal-search" placeholder="请输入汇报标题查询">
                          <i class="fa fa-times-circle-o receiveOther"  style="display:none;"  onclick="removeMyOther()"></i>
                          <p class="fabu"><a href="javascript:newReport('other');" class="button button-round active"><i class="fa fa-pencil-square-o"></i>新建</a></p>
                        </form>
                      </div>
                    </div>
                  </header>
                  <div class="webapp-meeting webapp-report-view">
                    <div class="meeting-notice">
                      <div class="list-block">
                        <ul class="" id="myOtherList">
                        </ul>
                        <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="myOtherLoadBox" class="wh-load-md">
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
                </div>
              </div>

            </div>
          </section>
          <section class="section-focum infinite-scroll wh-section wh-section-bottomfixed pull-to-refresh-content" id="subReportPage" >
          	<div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="webapp-form">
              <div class="three-tab-app clearfix">
                <div class="clearfix">
                  <a href="#tab4"  id="subWeekA" class="tab-link active" onclick="toSubWeekList()">
                    <span>周报</span>
                  </a> 
                  <a href="#tab5"  id="subMonthA" class="tab-link " onclick="toSubMonthList()">
                    <span>月报</span>
                  </a>
                  <a href="#tab6" id="subOtherA" class="tab-link " onclick="toSubOtherList()"> 
                    <!-- 切换到2个标签时增加的class "tab-link-rw" 并改变a 的宽度为50%-->
                    <span>其他</span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                <!-- Tab 1, 默认激活 -->
                <div id="tab4" class="tab active">
                  <header id="searchBar" class="wh-search">
                    <div class="wh-container">
                      <div class="wh-search-input">
                        <form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar searchbar-active">
                          <label class="fa fa-search" for="search"></label>
                          <input  onfocus="weekShow1()" id="subWeekSearch" type="search" class="nomal-search" placeholder="请输入汇报内容查询">
                          <i class="fa fa-times-circle-o receiveWeek1"  style="display:none;"  onclick="removeSubWeek()"></i>
                        </form>
                      </div>
                    </div>
                  </header>
                  <div class="webapp-meeting webapp-report-view">
                    <div class="meeting-notice">
                      <div class="list-block">
                        <ul class="" id="subWeekList">
                        	
                        </ul>
                        <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="subWeekLoadBox" class="wh-load-md">
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
                </div>
                <!-- Tab 2 -->
                <div id="tab5" class="tab">
                  <header id="searchBar" class="wh-search">
                    <div class="wh-container">
                      <div class="wh-search-input">
                        <form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar searchbar-active">
                          <label class="fa fa-search" for="search"></label>
                          <input id="subMonthSearch"  onfocus="monthShow1()" type="search" class="nomal-search" placeholder="请输入汇报内容查询">
                          <i class="fa fa-times-circle-o receiveMonth1"  style="display:none;"  onclick="removeSubMonth()"></i>
                        </form>
                      </div>
                    </div>
                  </header>
                  <div class="webapp-meeting webapp-report-view">
                    <div class="meeting-notice">
                      <div class="list-block">
                        <ul class="" id="subMonthList">
                        </ul>
                        <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="subMonthLoadBox" class="wh-load-md">
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
                </div>
                <!-- Tab 3 -->
                <div id="tab6" class="tab">
                  <header id="searchBar" class="wh-search">
                    <div class="wh-container">
                      <div class="wh-search-input">
                        <form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar searchbar-active">
                          <label  class="fa fa-search" for="search"></label>
                          <input id="subOtherSearch"  onfocus="otherShow1()" type="search" class="nomal-search" placeholder="请输入汇报标题查询">
                          <i class="fa fa-times-circle-o receiveOther1"  style="display:none;"  onclick="removeSubOther()"></i>
                        </form>
                      </div>
                    </div>
                  </header>
				  <div class="webapp-meeting webapp-report-view">
                    <div class="meeting-notice">
                      <div class="list-block">
                        <ul class="" id="subOtherList">
                        </ul>
                        <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="subOtherLoadBox" class="wh-load-md">
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
                </div>
              </div>

            </div>
          </section>
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="footer-focum wh-footer-btn row no-gutter">
                  <a href="javascript:myReport();" class="fbtn-matter col-50">
                    <div><i class="fa fa-forum-home"></i></div><span>我的汇报</span></a>
                  <a href="javascript:subReport();" class="fbtn-cancle col-50">
                    <div><i class="fa fa-view-modal"></i></div><span>下属汇报</span></a>
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
  <script type="text/javascript">
  var myApp = new Framework7();
  var $$ = Dom7;
  
  // 下拉刷新页面
  var indexPull = 0;
  var ptrContent = $$('.pull-to-refresh-content');
    
  // 添加'refresh'监听器
  ptrContent.on('refresh', function(e) {
  
  	// 模拟2s的加载过程
    setTimeout(function() {
    	if(indexPull == 0){
    		if($("#myWeekA").hasClass("active")){
    			myWeekPageSize = 1;
    			loadMyWeekList('1','0');
			}else if($("#myMonthA").hasClass("active")){
				myMonthPageSize = 1;
    			loadMyMonthList('1','0');
			}else{
				myOtherPageSize = 1;
    			loadMyOtherList('1','0');
			}
    	}else{
    		if($("#subWeekA").hasClass("active")){
    			subWeekPageSize = 1;
    			loadSubWeekList('1','0');
			}else if($("#subMonthA").hasClass("active")){
				subMonthPageSize = 1;
    			loadSubMonthList('1','0');
			}else{
				subOtherPageSize = 1;
    			loadSubOtherList('1','0');
			}
    	}
      myApp.pullToRefreshDone();
    }, 1000);
   });

  $$(".footer-focum>a").click(function(){
    var _this = $$(this);
    var index = _this.index();

    $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    $$(".section-focum").hide().eq(index).show();
  });
  
   //当前列表的位置，用于判断分页
   var myListIndex = 'myWeek';
  
   $(function(){
     var loadIndex = sessionStorage.getItem("loadIndex");
     if(loadIndex == 'mymonth'){
    	 $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
   		 $$(".footer-focum").children().eq(0).removeClass("fbtn-cancle").addClass("fbtn-matter");
   		 $$("#myReportPage").css("display","block");
   		 $$("#subReportPage").css("display","none");
     	$$("#myMonthA").click();
     }else if(loadIndex == 'myother'){
    	 $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
   		 $$(".footer-focum").children().eq(0).removeClass("fbtn-cancle").addClass("fbtn-matter");
   		 $$("#myReportPage").css("display","block");
   		 $$("#subReportPage").css("display","none");
     	$$("#myOtherA").click();
     }else if(loadIndex == 'subweek'){
         $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
   		 $$(".footer-focum").children().eq(1).removeClass("fbtn-cancle").addClass("fbtn-matter");
   		 $$("#myReportPage").css("display","none");
   		 $$("#subReportPage").css("display","block");
     	 $$("#subWeekA").click();
     }else if(loadIndex == 'submonth'){
    	 $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
   		 $$(".footer-focum").children().eq(1).removeClass("fbtn-cancle").addClass("fbtn-matter");
   		 $$("#myReportPage").css("display","none");
   		 $$("#subReportPage").css("display","block");
     	$$("#subMonthA").click();
     }else if(loadIndex == 'subother'){
         $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
   		 $$(".footer-focum").children().eq(1).removeClass("fbtn-cancle").addClass("fbtn-matter");
   		 $$("#myReportPage").css("display","none");
   		 $$("#subReportPage").css("display","block");
     	 $$("#subOtherA").click();
     }else{
     	 $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
   		 $$(".footer-focum").children().eq(0).removeClass("fbtn-cancle").addClass("fbtn-matter");
   		 $$("#myReportPage").css("display","block");
   		 $$("#subReportPage").css("display","none");
     	 loadMyWeekList('1','0');
     }
   });
   
    function weekShow() {
		 $$('.receiveWeek').show();
	}

	//清除搜索
	function removeMyWeek(){ 
    	$$('.receiveWeek').hide();
		$('#myWeekSearch').val('');
		loadMyWeekList('1','0');
	}
	
	// 搜索焦点时
    function monthShow() {
    	 $$('.receiveMonth').show();
    }

	//清除搜索
	function removeMyMonth(){ 
    	$$('.receiveMonth').hide();
		$('#myMonthSearch').val('');
		loadMyMonthList('1','0');
	}
	
	// 搜索焦点时
   function otherShow() {
    	 $$('.receiveOther').show();
    }

	//清除搜索
	function removeMyOther(){ 
    	$$('.receiveOther').hide();
		$('#myOtherSearch').val('');
		loadMyOtherList('1','0');
	}
	
	
	// 搜索焦点时
   function weekShow1() {
    	 $$('.receiveWeek1').show();
    }

	//清除搜索
	function removeSubWeek(){ 
    	$$('.receiveWeek1').hide();
		$('#subWeekSearch').val('');
		loadSubWeekList('1','0');
	}
	
	// 搜索焦点时
   function monthShow1() {
    	 $$('.receiveMonth1').show();
    }

	//清除搜索
	function removeSubMonth(){ 
    	$$('.receiveMonth1').hide();
		$('#subMonthSearch').val('');
		loadSubMonthList('1','0');
	}
	
	// 搜索焦点时
   function otherShow1() {
    	 $$('.receiveOther1').show();
    }

	//清除搜索
	function removeSubOther(){ 
    	$$('.receiveOther1').hide();
		$('#subOtherSearch').val('');
		loadSubOtherList('1','0');
	}
   
   function toMyWeekList() {
        sessionStorage.setItem("loadIndex","myweek");
   		myLoading = false;
   		myWeekPageSize = 1;
   		myApp.attachInfiniteScroll($$('#myReportPage'));
   		myListIndex = 'myWeek';
		loadMyWeekList('1','0');
   }
   
   function toMyMonthList() {
   		sessionStorage.setItem("loadIndex","mymonth");
   		myLoading = false;	
    	myMonthPageSize = 1;
   		myApp.attachInfiniteScroll($$('#myReportPage'));
   		myListIndex = 'myMonth';
		loadMyMonthList('1','0');
   }
   
   function toMyOtherList() {
        sessionStorage.setItem("loadIndex","myother");
   		myLoading = false;
    	myOtherPageSize = 1;
   		myApp.attachInfiniteScroll($$('#myReportPage'));
   		myListIndex = 'myOther';
		loadMyOtherList('1','0');
   }
  
    //我的周报列表
    function loadMyWeekList(curpage,flag) {
	  var url = '/defaultroot/report/getMyWeekReportList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"curpage" : curpage, "queryText" : $$('#myWeekSearch').val()},
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			var myWeekList = jsonData.data0;
			myWeekRecordCount = jsonData.data1;
			if(myWeekRecordCount-$$('#myWeekList li').length<=15){
				 $$('#myWeekLoadBox').hide();
			}
			if(myWeekList.length>0){
				var myWeekHtml = '';
				for(var i = 0; i < myWeekList.length; i++){
					myWeekHtml += '<li class="swipeout" onclick="loadMyReport('+myWeekList[i].id+','+myWeekList[i].sendType+','+myWeekList[i].hadRead+',\'week\')">'
							   + '<a href="webapp-meeting-info.html" class="swipeout-content item-content">'
                               + '<div><strong class="forum-avatar m-tag-had">周</strong>'
                               + '<p>工作周报<span>&nbsp;&nbsp;'+myWeekList[i].reportCourse+'<br>'+myWeekList[i].reportTime.substring(0,16)+'</span></p>' 
                               + '</div></a></li>' ;
				}
				if(flag == "0"){
					$$('#myWeekList').html(myWeekHtml);
				}else{
					$$('#myWeekList').append(myWeekHtml);
				}
				myLoading = false;
			}else{
				myApp.hidePreloader();
				$$('#myWeekList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  },error: function(xhr, status) {
		  	$$('#myWeekList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
	
	//绑定我的周报查询框回车事件
    $$('#myWeekSearch').keydown(function(event){
    	var searchTitle = $$('#myWeekSearch').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索标题');
			}else{
				loadMyWeekList('1','0');
			}
		} 
	});
	
	//我的月报列表
    function loadMyMonthList(curpage,flag) {
	  var url = '/defaultroot/report/getMyMonthReportList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"curpage" : curpage, "queryText" : $$('#myMonthSearch').val()},
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			var myMonthList = jsonData.data0;
			myMonthRecordCount = jsonData.data1;
			if(myMonthRecordCount-$$('#myMonthList li').length<=15){
				 $$('#myMonthLoadBox').hide();
			}
			if(myMonthList.length>0){
				var myMonthHtml = '';
				for(var i = 0; i < myMonthList.length; i++){
					myMonthHtml += '<li class="swipeout"  onclick="loadMyReport('+myMonthList[i].id+','+myMonthList[i].sendType+','+myMonthList[i].hadRead+',\'month\')">'
							   + '<a href="webapp-meeting-info.html" class="swipeout-content item-content">'
                               + '<div><strong class="forum-avatar m-tag-had">月</strong>'
                               + '<p>工作月报<span>&nbsp;&nbsp;'+myMonthList[i].reportCourse+'<br>'+myMonthList[i].reportTime.substring(0,16)+'</span></p>' 
                               + '</div></a></li>' ;
				}
				if(flag == '0'){
					$$('#myMonthList').html(myMonthHtml);
				}else{
					$$('#myMonthList').append(myMonthHtml);
				}
				myLoading = false;
			}else{
				myApp.hidePreloader();
				$$('#myMonthList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  },error: function(xhr, status) {
		  	$$('#myMonthList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
	
	//绑定我的月报查询框回车事件
    $$('#myMonthSearch').keydown(function(event){
    	var searchTitle = $$('#myMonthSearch').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索标题');
			}else{
				loadMyMonthList('1','0');
			}
		} 
	});
	
	//我的其他列表
    function loadMyOtherList(curpage,flag) {
	  var url = '/defaultroot/report/getMyOtherReportList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"curpage" : curpage, "queryText" : $$('#myOtherSearch').val()},
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			var myOtherList = jsonData.data0;
			myOtherRecordCount = jsonData.data1;
			if(myOtherRecordCount-$$('#myOtherList li').length<=15){
				 $$('#myOtherLoadBox').hide();
			}
			if(myOtherList.length>0){
				var myOtherHtml = '';
				for(var i = 0; i < myOtherList.length; i++){
					myOtherHtml += '<li class="swipeout"  onclick="loadMyReport('+myOtherList[i].id+','+myOtherList[i].sendType+','+myOtherList[i].hadRead+',\'other\')">'
							   + '<a href="webapp-meeting-info.html" class="swipeout-content item-content">'
                               + '<div><strong class="forum-avatar m-tag-had">其</strong>'
                               + '<p>'+myOtherList[i].reportTitle+'<span>&nbsp;&nbsp;'+myOtherList[i].reportCourse+'<br>'+myOtherList[i].reportTime.substring(0,16)+'</span></p>' 
                               + '</div></a></li>' ;
				}
				if(flag == '0'){
					$$('#myOtherList').html(myOtherHtml);
				}else{
					$$('#myOtherList').append(myOtherHtml);
				}
				myLoading = false;
			}else{
				myApp.hidePreloader();
				$$('#myOtherList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  },error: function(xhr, status) {
		  	$$('#myOtherList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
	
	//绑定我的其他查询框回车事件
    $$('#myOtherSearch').keydown(function(event){
    	var searchTitle = $$('#myOtherSearch').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索标题');
			}else{
				loadMyOtherList('1','0');
			}
		} 
	});
	
	//我的周列表总记录
    var myWeekRecordCount = 0;
    var myMonthRecordCount = 0;
    var myOtherRecordCount = 0;
	//主页分页加载
    var myLoading = false;
    //主页当前记录数
    var myWeekPageSize = 1;
    var myMonthPageSize = 1;
    var myOtherPageSize = 1;
    
    $$(document).on('infinite', '#myReportPage', function() {
	    // 如果正在加载，则退出
	    if (myLoading) return;
	    myLoading = true;
	    //判断分页位置
	    if(myListIndex == 'myWeek'){
	    	var myWeekIndexL = $$('#myWeekList li').length;
		    setTimeout(function() {
			      if (myWeekIndexL >= myWeekRecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#myWeekLoadBox').hide();
			        myApp.detachInfiniteScroll($$('#myReportPage'));
			        return;
				  }
				  if (myWeekRecordCount - myWeekIndexL > 0) {
				  	$$('#myWeekLoadBox').show();
			        myWeekPageSize = myWeekPageSize+1;
			        loadMyWeekList(myWeekPageSize,'1');
			        return;
				  }
		    }, 500);
	    }
	    
	    //判断分页位置
	    if(myListIndex == 'myMonth'){
	    	var myMonthIndexL = $$('#myMonthList li').length;
		    setTimeout(function() {
			      if (myMonthIndexL >= myMonthRecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#myMonthLoadBox').hide();
			        myApp.detachInfiniteScroll($$('#myReportPage'));
			        return;
				  }
				  if (myMonthRecordCount - myMonthIndexL > 0) {
				  	$$('#myMonthLoadBox').show();
			        myMonthPageSize = myMonthPageSize+1;
			        loadMyMonthList(myMonthPageSize,'1');
			        return;
				  }
		    }, 500);
	    }
	    
	    //判断分页位置
	    if(myListIndex == 'myOther'){
	    	var myOtherIndexL = $$('#myOtherList li').length;
		    setTimeout(function() {
			      if (myOtherIndexL >= myOtherRecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#myOtherLoadBox').hide();
			        myApp.detachInfiniteScroll($$('#myReportPage'));
			        return;
				  }
				  if (myOtherRecordCount - myOtherIndexL > 0) {
				  	$$('#myOtherLoadBox').show();
			        myOtherPageSize = myOtherPageSize+1;
			        loadMyOtherList(myOtherPageSize,'1');
			        return;
				  }
		    }, 500);
	    }
	    
	 });
	 
	 function loadMyReport(sendRecordId,sendType,hadRead,cmdFlag) {
		//打开推送详情页
		window.location="/defaultroot/report/getMyReportDetail.controller?sendRecordId="+sendRecordId+"&cmdFlag="+cmdFlag+"&sendType="+sendType+"&hadRead="+hadRead;
	 }
	 
	 function newReport(cmdFlag) {
		//打开推送详情页
		window.location="/defaultroot/report/newReport.controller?cmdFlag="+cmdFlag;
	 }
	
	/********************************************************分割**********************************************************************/
	
	//当前列表的位置，用于判断分页
   var subListIndex = 'subMonth';
   function toSubWeekList() {
   		sessionStorage.setItem("loadIndex","subweek");
   		subLoading = false;
   		subWeekPageSize = 1;
   		myApp.attachInfiniteScroll($$('#subReportPage'));
   		subListIndex = 'subWeek';
		loadSubWeekList('1','0');
   }
   
   function toSubMonthList() {
   		sessionStorage.setItem("loadIndex","submonth");
   		subLoading = false;	
    	subMonthPageSize = 1;
   		myApp.attachInfiniteScroll($$('#subReportPage'));
   		subListIndex = 'subMonth';
		loadSubMonthList('1','0');
   }
   
   function toSubOtherList() {
        sessionStorage.setItem("loadIndex","subother");
   		subLoading = false;
    	subOtherPageSize = 1;
   		myApp.attachInfiniteScroll($$('#subReportPage'));
   		subListIndex = 'subOther';
		loadSubOtherList('1','0');
   }
   
   function myReport(){
   		sessionStorage.setItem("loadIndex","myweek");
		indexPull = 0;
		loadMyWeekList('1','0');
	}
	
	function subReport(){
	    sessionStorage.setItem("loadIndex","subweek");
		indexPull = 1;
		loadSubWeekList('1','0');
	}
	
	//我的周列表总记录
    var subWeekRecordCount = 0;
    var subMonthRecordCount = 0;
    var subOtherRecordCount = 0;
	//主页分页加载
    var subLoading = false;
    //主页当前记录数
    var subWeekPageSize = 1;
    var subMonthPageSize = 1;
    var subOtherPageSize = 1;
    
    $$(document).on('infinite', '#subReportPage', function() {
	    // 如果正在加载，则退出
	    if (subLoading) return;
	    subLoading = true;
	    //判断分页位置
	    if(subListIndex == 'subWeek'){
	    	var subWeekIndexL = $$('#subWeekList li').length;
		    setTimeout(function() {
			      if (subWeekIndexL >= subWeekRecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#subWeekLoadBox').hide();
			        myApp.detachInfiniteScroll($$('#subReportPage'));
			        return;
				  }
				  if (subWeekRecordCount - subWeekIndexL > 0) {
				  	$$('#subWeekLoadBox').show();
			        subWeekPageSize = subWeekPageSize+1;
			        loadSubWeekList(subWeekPageSize,'1');
			        return;
				  }
		    }, 500);
	    }
	    
	    //判断分页位置
	    if(subListIndex == 'subMonth'){
	    	var subMonthIndexL = $$('#subMonthList li').length;
		    setTimeout(function() {
			      if (subMonthIndexL >= subMonthRecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#subMonthLoadBox').hide();
			        myApp.detachInfiniteScroll($$('#subReportPage'));
			        return;
				  }
				  if (subMonthRecordCount - subMonthIndexL > 0) {
				  	$$('#subMonthLoadBox').show();
			        subMonthPageSize = subMonthPageSize+1;
			        loadSubMonthList(subMonthPageSize,'1');
			        return;
				  }
		    }, 500);
	    }
	    
	    //判断分页位置
	    if(subListIndex == 'subOther'){
	    	var subOtherIndexL = $$('#subOtherList li').length;
		    setTimeout(function() {
			      if (subOtherIndexL >= subOtherRecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#subOtherLoadBox').hide();
			        myApp.detachInfiniteScroll($$('#subReportPage'));
			        return;
				  }
				  if (subOtherRecordCount - subOtherIndexL > 0) {
				  	$$('#subOtherLoadBox').show();
			        subOtherPageSize = subOtherPageSize+1;
			        loadSubOtherList(subOtherPageSize,'1');
			        return;
				  }
		    }, 500);
	    }
	    
	 });
	
	 //下属周报列表
    function loadSubWeekList(curpage,flag) {
	  var url = '/defaultroot/report/getSubWeekReportList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"curpage" : curpage, "queryText" : $$('#subWeekSearch').val()},
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			var subWeekList = jsonData.data0;
			subWeekRecordCount = jsonData.data1;
			if(subWeekRecordCount-$$('#subWeekList li').length<=15){
				 $$('#subWeekLoadBox').hide();
			}
			if(subWeekList.length>0){
				var subWeekHtml = '';
				for(var i = 0; i < subWeekList.length; i++){
					if(subWeekList[i].empLivingPhoto && 'null' != subWeekList[i].empLivingPhoto){
			    		var arr = subWeekList[i].empLivingPhoto.split('.');
			    		var fileName = subWeekList[i].empLivingPhoto;
			    		var id = arr[0];
			    		loadImg(fileName,id);
						empLivingPhoto = "<img name='"+id+"'>";
			    	}else{
			    		empLivingPhoto = "<img src='/defaultroot/clientview/images/user3.png'/>";
			    	}
			    	var hadRead = '';
			    	if(subWeekList[i].hadRead == 0){
			    		hadRead = '<span class="report-wait"></span>';
			    	}
					subWeekHtml += '<li class="swipeout" onclick="loadSubReport('+subWeekList[i].id+',\'week\')">'
							   + '<a href="webapp-meeting-info.html" class="swipeout-content item-content">'
                               + '<div>'
                               +hadRead
                               + empLivingPhoto
                               + '<p>'+subWeekList[i].reportEmpName+'&nbsp;&nbsp;工作周报<span>&nbsp;&nbsp;'+subWeekList[i].reportCourse+'<br>'+subWeekList[i].reportTime.substring(0,16)+'</span></p>' 
                               + '</div></a></li>' ;
				}
				if(flag=='0'){
					$$('#subWeekList').html(subWeekHtml);
				}else{
					$$('#subWeekList').append(subWeekHtml);
				}
				subLoading = false;
			}else{
				myApp.hidePreloader();
				$$('#subWeekList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  },error: function(xhr, status) {
		  	$$('#subWeekList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
	
	//绑定下属周报查询框回车事件
    $$('#subWeekSearch').keydown(function(event){
    	var searchTitle = $$('#subWeekSearch').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索标题');
			}else{
				loadSubWeekList('1','0');
			}
		} 
	});
	
	//下属月报列表
    function loadSubMonthList(curpage,flag) {
	  var url = '/defaultroot/report/getSubMonthReportList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"curpage" : curpage, "queryText" : $$('#subMonthSearch').val()},
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			var subMonthList = jsonData.data0;
			subMonthRecordCount = jsonData.data1;
			if(subMonthRecordCount-$$('#subMonthList li').length<=15){
				 $$('#subMonthLoadBox').hide();
			}
			if(subMonthList.length>0){
				var subMonthHtml = '';
				for(var i = 0; i < subMonthList.length; i++){
					var empLivingPhoto = '';
					if(subMonthList[i].empLivingPhoto && 'null' != subMonthList[i].empLivingPhoto){
			    		var arr = subMonthList[i].empLivingPhoto.split('.');
			    		var fileName = subMonthList[i].empLivingPhoto;
			    		var id = arr[0];
			    		loadImg(fileName,id);
						empLivingPhoto = "<img name='"+id+"' >";
			    	}else{
			    		empLivingPhoto = "<img src='/defaultroot/clientview/images/user3.png'/>";
			    	}
			    	var hadRead = '';
			    	if(subMonthList[i].hadRead == 0){
			    		hadRead = '<span class="report-wait"></span>';
			    	}
					subMonthHtml += '<li class="swipeout" onclick="loadSubReport('+subMonthList[i].id+',\'month\')">'
							   + '<a href="webapp-meeting-info.html" class="swipeout-content item-content">'
                               + '<div>'
                               +hadRead
                               + empLivingPhoto
                               + '<p>'+subMonthList[i].reportEmpName+'&nbsp;&nbsp;工作月报<span>&nbsp;&nbsp;'+subMonthList[i].reportCourse
                               +'<br>'+subMonthList[i].reportTime.substring(0,16)+'</span></p>' 
                               + '</div></a></li>' ;
				}
				if(flag == '0'){
					$$('#subMonthList').html(subMonthHtml);
				}else{
					$$('#subMonthList').append(subMonthHtml);
				}
				subLoading = false;
			}else{
				myApp.hidePreloader();
				$$('#subMonthList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  },error: function(xhr, status) {
		  	$$('#subMonthList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
	
	//绑定下属月报查询框回车事件
    $$('#subMonthSearch').keydown(function(event){
    	var searchTitle = $$('#subMonthSearch').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索标题');
			}else{
				loadSubMonthList('1','0');
			}
		} 
	});
	
	//下属其他列表
    function loadSubOtherList(curpage,flag) {
	  var url = '/defaultroot/report/getSubOtherReportList.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"curpage" : curpage, "queryText" : $$('#subOtherSearch').val()},
		  dataType: "text",
		  success: function(data) {
			var jsonData = eval("("+data+")");
			var subOtherList = jsonData.data0;
			subOtherRecordCount = jsonData.data1;
			if(subOtherRecordCount-$$('#subOtherList li').length<=15){
				 $$('#subOtherLoadBox').hide();
			}
			if(subOtherList.length>0){
				var subOtherHtml = '';
				for(var i = 0; i < subOtherList.length; i++){
					if(subOtherList[i].empLivingPhoto && 'null' != subOtherList[i].empLivingPhoto){
			    		var arr = subOtherList[i].empLivingPhoto.split('.');
			    		var fileName = subOtherList[i].empLivingPhoto;
			    		var id = arr[0];
			    		loadImg(fileName,id);
						empLivingPhoto = "<img name='"+id+"'>";
			    	}else{
			    		empLivingPhoto = "<img src='/defaultroot/clientview/images/user3.png'/>";
			    	}
			    	var hadRead = '';
			    	if(subOtherList[i].hadRead == 0){
			    		hadRead = '<span class="report-wait"></span>';
			    	}
					subOtherHtml += '<li class="swipeout" onclick="loadSubReport('+subOtherList[i].id+',\'other\')">'
							   + '<a href="webapp-meeting-info.html" class="swipeout-content item-content">'
                               + '<div>'
                               +hadRead
                               +empLivingPhoto
                               + '<p>'+subOtherList[i].reportEmpName+'&nbsp;&nbsp;'+subOtherList[i].reportTitle+'<span>&nbsp;&nbsp;'+subOtherList[i].reportCourse+'<br>'+subOtherList[i].reportTime.substring(0,16)+'</span></p>' 
                               + '</div></a></li>' ;
				}
				if(flag == '0'){
					$$('#subOtherList').html(subOtherHtml);
				}else{
					$$('#subOtherList').append(subOtherHtml);
				}
				subLoading = false;
			}else{
				myApp.hidePreloader();
				$$('#subOtherList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  },error: function(xhr, status) {
		  	$$('#subOtherList').html('<li style="padding: 1rem;" class="swipeout">系统未查询到相关记录 !</li>');
		  }
	  });
	}
	
	//绑定下属其他查询框回车事件
    $$('#subOtherSearch').keydown(function(event){
    	var searchTitle = $$('#subOtherSearch').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				myApp.alert('请正确填写搜索标题');
			}else{
				loadSubOtherList('1','0');
			}
		} 
	});
	
		//循环加载全部选人页面头像
	function openImg(){
		$("input[name='empLivingPhoto']").each(function (){
			var filename = $(this).val();
			var id = filename.substring(0,25);
			loadImg(filename,id);
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
	
	 function loadSubReport(receiveRecordId,cmdFlag) {
		//打开推送详情页
		window.location="/defaultroot/report/getSubReportDetail.controller?receiveRecordId="+receiveRecordId+"&cmdFlag="+cmdFlag;
	 }
	
  </script>
</body>
</html>