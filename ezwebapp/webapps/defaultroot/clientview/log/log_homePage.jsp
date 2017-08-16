<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1">
  <title>日志</title> 
</head>
<%
	if(session.getAttribute("userId")!=null){
%>

<body class="grey-bg">
<c:if test="${not empty empIddocXml}">
<x:parse xml="${empIddocXml}" var="empIddoc"/>
 <x:forEach select="$empIddoc//list" var="empIdlt" >
	<c:set var="empId"><x:out select="$empIdlt/empId/text()"/></c:set>
	<input type="hidden" name="empId" id="empId" value="${empId }"/>
 </x:forEach>
</c:if>
  <div class="views">
    <div class="view view-main">
      <div class="pages">
        <div class="page" data-page="page-webapp-log">
          <section id="sectionScroll" class="section-log wh-section infinite-scroll wh-section-bottomfixed show">
            <div class="webapp-log">
              <div class="app-tabheader clearfix">
                <!-- 关联到第一个tab, 默认激活 -->
                <div>
                  <a href="javascript:void(0)" onclick="newLog(0);" class="tab-link">
                    <div>
                      <i class="fa fa-log"></i>
                    </div>
                    <span>全天日志</span>
                  </a>
                </div>
                <div>
                  <!-- 关联到第二个tab -->
                  <a href="javascript:void(0)" onclick="newLog(1);" onclick="" class="tab-link">
                    <div>
                      <i class="fa fa-attendance-mana"></i>
                    </div>
                    <span>分时段日志</span>
                  </a>
                </div>
              </div>
              <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="post" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchTitle" type="search" class="nomal-search" placeholder="请输入日志内容查询" />
                         	<a href="#" class="searchbar-cancel" onfocus="removeSearch(this)" onclick="viewData();">取消</a>
                          </form>
                        </div>
                      </div>
                    </header>
              <!-- Tabs, 标签内容区容器 -->
              <div class="tabs">
			    <c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
                <div id="tab-log1" class="tab active ">
                  <div class="list-block">
                    <ul class="webapplist">
						<x:forEach select="$doc//list" var="lt" >
							<c:set var="id"><x:out select="$lt/id/text()"/></c:set>
							<c:set var="logDate"><x:out select="$lt/date/text()"/></c:set>
							<c:set var="logType"><x:out select="$lt/type/text()"/></c:set>
							<c:set var="sTime"><x:out select="$lt/sTime/text()"/></c:set>
							<c:set var="eTime"><x:out select="$lt/eTime/text()"/></c:set>
							<c:set var="logProName"><x:out select="$lt/logProName/text()"/></c:set>
							<li class="swipeout">
							  <a href="javascript:void(0)" onclick="openMyWorkLog('${id}');" class="swipeout-content item-content">
								<div>
								  <c:choose>
									<c:when test="${logType == '0' }">
										<p>全天日志 ${logProName }</p>
									</c:when>
									<c:otherwise>
										<p>${sTime }-${eTime } ${logProName }</p>
									</c:otherwise>
								  </c:choose>
								    <span>${logDate } </span>
								</div>
								<div class="item-after"><i class="fa fa-angle-right"></i></div>
							  </a>
							  <!-- <div class="swipeout-actions-right"><a href="#" class="swipeout-delete">删除</a></div> -->
							</li>
						</x:forEach>
                    </ul>
					<!-- 下拉刷新动画 -->
					<aside class="wh-load-box infinite-scroll-top" style="display: block">
						<div class="wh-load-tap" style="display:none">没有更多数据了</div>
						<div class="wh-load-md">
							<span></span>
							<span></span>
							<span></span>
							<span></span>
							<span></span>
		                </div>
		           </aside>
                  </div>
                </div>
				</c:if>
              </div>
            </div>
          </section>
          <section id="sectionScroll" class="section-log infinite-scroll wh-section wh-section-bottomfixed pull-to-refresh-content" data-ptr-distance="40">
            <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="webapp-log-under">
              <header >
              <div class="list-block">
                <ul>
                  <li>
                    <a href="#" data-open-in="popup" class="item-link smart-select" data-back-on-select="true" data-popup-close-text="返回">
                      <select name="fruits" onchange="sel(this);">
                        <option value="apple" selected>请选择</option>
                        <x:forEach select="$empIddoc//list" var="empIdlt" >
					     	<option value="<x:out select="$empIdlt/empId/text()"/>"><x:out select="$empIdlt/empName/text()"/></option>
						 </x:forEach>
                      </select>
                      <div class="item-content">
                        <div class="item-inner">
                          <div class="item-title">下属员工</div>
                        </div>
                      </div>
                    </a>
                  </li>
                </ul>
              </div>
            </header>
              <article>
                <div class="webapp-list-div">
                  <div class="list-block">
                    <ul id="list-container">           
                    </ul>
					<!-- 下拉刷新动画 -->
					<aside class="wh-load-box infinite-scroll-top" style="display: block">
						<div class="wh-load-tap" style="display:none">没有更多数据了</div>
						<div class="wh-load-md">
							<span></span>
							<span></span>
							<span></span>
							<span></span>
							<span></span>
		                </div>
		           </aside>
                  </div>
                </div>
              </article>
            </div>
          </section>
          <!-- 底部导航 -->
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="footer-log wh-footer-btn row no-gutter footer-info">
                <a href="##" class="fbtn-matter col-50"><div><i class="fa fa-my-log"></i></div><span>我的日志</span></a>
                  <a id="subLogId" href="##" href="#tab2" class=" fbtn-cancle col-50"><div class="push-num"><i class="fa fa-under-log"></i>
                  	<em id="unReadNum">
	                  	<c:choose>
							<c:when test="${unReadNum =='0'}">
							</c:when>
							<c:otherwise>
									${unReadNum}
							</c:otherwise>
						</c:choose>
					</em></div><span>下属日志</span></a> 
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
  <script>
    var myApp = new Framework7();

    var $$ = Dom7;
 	// 清除搜索区域焦点bug
    function removeSearch(schElmID) {
      $$(schElmID).blur().val(""); //主动清除焦点
      $$(schElmID).next('.searchbar-cancel').hide();
    }

    // 搜索焦点时
    $$('#fbtn-save').on('click', function() {
      $$(this).next('.searchbar-cancel').show();
    })
	//列表总记录(我的日志)
    var myLogmaxItems = '${recordCount}';
	//列表总记录(下属日志)
    var subLogmaxItems = '';
	// 每次加载添加多少条目
	var itemsPerLoad = 15;
    //当前页页数 全局变量(我的日志)
    var myLogcurPage = 1;
	//当前页页数 全局变量(下属日志)
    var subLogcurPage = 1;
    var queryDate = '';
    var myLogloading = false;
	var subLogloading = false;
	//0:我的日志页面；1：下属日志页面
	var loadLogtype='';
	//下属员工id
	var empIds = '';
    window.onload=myfun;
    function myfun() {
    	loadSubLogList();
		loadLogtype ='0';
    	var index = $$('.webapplist li').length;//我的日志
    	if(index < 15){
    		 $$('.wh-load-md').hide();
    	}else{
    		 $$('.wh-load-md').show();
    	}
    	if(index == 0){
    		$$('.webapplist').html('<li class="swipeout">系统没有查询到相关记录</li>');
    	}
	}

  	//取消
    function viewData(){
    	myLogcurPage = 1;
    	$('#searchTitle').val("");
    	nextPage(myLogcurPage,'0',queryDate);
    }

  	//绑定查询框回车事件
    $('#searchTitle').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if(/[@#\$%\^&\*]+/g.test($('#searchTitle').val())){
				myApp.alert('请正确填写搜索日志内容！');
				return false;
			}
			myLogcurPage = 1;
			nextPage(myLogcurPage,'0',queryDate);
		} 
	});
	
	// 下拉刷新页面
  	var ptrContent = $$('.pull-to-refresh-content');
  
  	// 添加'refresh'监听器
  	ptrContent.on('refresh', function(e) {
	  	// 模拟2s的加载过程
	    setTimeout(function() {
			    loadSubLogList();	
	      		myApp.pullToRefreshDone();
	    }, 1000);
	});
	$$(document).on('infinite', '#sectionScroll', function() {
			if(loadLogtype == '0'){
				// 如果正在加载，则退出
				if (myLogloading) return;
				myLogloading = true;
				var lastIndex = $$('.webapplist li').length;
				setTimeout(function() {
					myLogloading = false;
					if (lastIndex >= myLogmaxItems) {
						// 加载完毕，则注销无限加载事件，以防不必要的加载
						myApp.detachInfiniteScroll($$('#sectionScroll'));
						// 删除加载提示符
						$$('.wh-load-md').hide(); 
						 return;
					}
					if (myLogmaxItems - lastIndex > 0) {
						myLogcurPage = myLogcurPage+1;
						nextPage(myLogcurPage,'1',queryDate);
						 return;
					}
				}, 500);
			}else{
				// 如果正在加载，则退出
				if (subLogloading) return;
				subLogloading = true;
				var lastIndex = $$('#list-container li').length;
				setTimeout(function() {
					subLogloading = false;
					if (lastIndex >= subLogmaxItems) {
					    // 加载完毕，则注销无限加载事件，以防不必要的加载
						myApp.detachInfiniteScroll($$('#sectionScroll'));
						// 删除加载提示符
						$$('.wh-load-md').hide();
						return;
					}
					if (subLogmaxItems - lastIndex > 0) {
						subLogcurPage = subLogcurPage+1;
						addItems(empIds,subLogcurPage,'1');
						return;
					}
				}, 500);
			}
	  });
	  
	  function nextPage(curPage,loadFlag,queryDate) {
		  var qText=$('#searchTitle').val();
	  	  var url = '/defaultroot/worklog/nextLogList.controller?curpage='+curPage+'&queryDate='+queryDate+'&logContent='+qText;
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType: "text",
		      success: function(data) {
		      	var jsonData = eval("("+data+")");
		      	var html ='';
		      	var hadread = '';
		      	var logType = '';
		      	var type = '';
		      	if(jsonData.data1<= 15){
		      		$$('.wh-load-md').hide();
		      		// 加载完毕，则注销无限加载事件，以防不必要的加载
				    myApp.detachInfiniteScroll($$('#sectionScroll'));
		      	}
		      	if(jsonData.data1> 15){
		      		$$('.wh-load-md').show();
					myApp.attachInfiniteScroll($$('#sectionScroll'));
		      	}
		      	if(jsonData.data0.length>0){
			      	for(var i = 0; i < jsonData.data0.length; i++){
			      		logType = jsonData.data0[i].type;	
			      		if(logType == '0'){
			      			type = '<p>全天日志 '+jsonData.data0[i].logProName+'</p>';
			      		}else{
			      			type = '<p>'+jsonData.data0[i].sTime+'-'+jsonData.data0[i].eTime+' '+jsonData.data0[i].logProName+'</p>';
			      		}
						
						html +='<li class="swipeout"><a href="javascript:void(0)" onclick="openMyWorkLog('+jsonData.data0[i].id+');"  class="swipeout-content item-content"><div>'
								 + type
								 +'<span>'+jsonData.data0[i].date+'</span>'
								 +'</div>'
								 +'<div class="item-after"><i class="fa fa-angle-right"></i></div>'
								 +'</a>'
								 +'</li>';
			      	}
			      	if(loadFlag == '1'){
	                 	$('.webapplist').append(html);
	                }else{
		                $('.webapplist').html(html);
	                }
		      	}else{
		      		$$('.wh-load-md').hide();
		      		$$('.webapplist').html('<li class="swipeout">系统没有查询到相关记录</li>');
		      	}
		      },error: function(xhr, status) {
		        $$('.webapplist').append('<li class="swipeout">没有更多记录</li>');
		        $$('.wh-load-tap').hide();
		        $$('.wh-load-md').hide();
		      }
	      });
		}
	
	   //打开我的日志详情
    function openMyWorkLog(id) {
		window.location = "/defaultroot/worklog/loadWorkLog.controller?workLogId="+id+"&logFlag=0";
	}
	
	//打开下属日志详情
    function openSubWorkLog(id) {
		window.location = "/defaultroot/worklog/loadWorkLog.controller?workLogId="+id+"&logFlag=1";
	}
	
	//新建日志
    function newLog(logType) {
		window.location = "/defaultroot/worklog/writeLog.controller?logType="+logType+"&loadFlag=1";
	}
	
	function loadSubLogList(){
		loadLogtype='1';
		empIds ='';
		subLogloading = false;
		subLogcurPage=1;
		var arr = $$("input[name=empId]");
		if(arr.length>0){
			for(var i=0;i<arr.length;i++){
				empIds += '$'+arr[i].value+'$';
			}
			addItems(empIds,subLogcurPage,'0');
		}else{
			$$('.wh-load-md').hide();
			$$('#list-container').html('<li class="swipeout">系统没有查询到相关记录！</li>');
		}
	}
	
	function addItems(empId,curPage,loadFlag) {
		if(loadFlag == '0'){
			myApp.showPreloader('列表加载中...');
		}
	  	var url = '/defaultroot/worklog/getUnderlingWorkLogList.controller?queryEmpIds='+empId+'&curpage='+curPage;
	    $$.ajax({
		    type: "post",
		    url: url,
		    dataType: "text",
		    success: function(data) {
					var jsonData = eval("("+data+")");
					var html ='';
					var hadread = '';
					var readFlag = '';
					var logType = '';
					var type = '';
					subLogmaxItems = jsonData.data1;
					var unReadNum = jsonData.data2;
					if(unReadNum != '0'){
						$$("#unReadNum").html(unReadNum);
					}else{
						$$("#unReadNum").html('');
					}
					if(subLogmaxItems<=15){
						$$('.wh-load-md').hide();
						myApp.detachInfiniteScroll($$('#sectionScroll'));
					}//如果查询总记录数大于15，则加载无线滚动事件
					if(subLogmaxItems > 15){
						$$('.wh-load-md').show();
						myApp.attachInfiniteScroll($$('#sectionScroll'));
					}
					if(jsonData.data0.length>0){
						for(var i = 0; i < jsonData.data0.length; i++){
							hadread = jsonData.data0[i].hadread;
							logType = jsonData.data0[i].type;
							if(hadread == '0' || hadread == ''){
								readFlag = '<i></i>';
							}else{
								readFlag = '';
							}
							if(logType == '0'){
								type = '<span>'+jsonData.data0[i].date+'  '+'全天日志</span>';
							}else{
								type = '<span>'+jsonData.data0[i].date+'  '+jsonData.data0[i].sTime+'-'+jsonData.data0[i].eTime+'</span>';
							}
							html +='<li class="swipeout"><a href="javascript:void(0)" onclick="openSubWorkLog('+jsonData.data0[i].id+');"  class="swipeout-content item-content"><div>'
								 + readFlag
								 +'<em>'+jsonData.data0[i].empName+'</em>'
								 + type
								 +'<span>  '+jsonData.data0[i].logProName+'</span>'
								 +'</div></a>'
								 +'</li>';
						}
						myApp.hidePreloader();
						if(loadFlag == '1'){
							$$('#list-container').append(html);
						}else{
							$$('#list-container').html(html);
						}
					}else{
						myApp.hidePreloader();
						$$('#list-container').html('<li class="swipeout">系统没有查询到相关记录！</li>');
					}
				  },error: function(xhr, status) {
					myApp.hidePreloader();
					$$('#list-container').html('<li class="swipeout">系统没有查询到相关记录！</li>');
					$$('.wh-load-tap').hide();
					$$('.wh-load-md').hide();
				  }
	  });
	}
	
	function sel(obj) {
		if($(obj).val() == 'apple'){
			var arr = $$("input[name=empId]");
			var selEmpId = '';
		 	if(arr.length>0){
		 		for(var i=0;i<arr.length;i++){
			 		selEmpId += '$'+arr[i].value+'$';
		 		}
		 	}
		 	empIds = selEmpId;
		}else{
			empIds = "$"+$(obj).val()+"$";
		}
    	addItems(empIds,1,'0');
	}

    $$(".footer-log>a").click(function(){
      var _this = $$(this);
      var index = _this.index();

      $$(".footer-log>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
      _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
      $$(".section-log").hide().eq(index).show();
	  if(index==1){
		  if(subLogmaxItems<15){
			  $$('.wh-load-md').hide();
		  }else{
			  $$('.wh-load-md').show();
		  }
	  }
	  if(index==0){
		  if(myLogmaxItems>15){
			  $$('.wh-load-md').show();
		  }else{
			  $$('.wh-load-md').hide();
		  }
	  }
    });  
 

  </script>
</body>
<%} %>
</html>
