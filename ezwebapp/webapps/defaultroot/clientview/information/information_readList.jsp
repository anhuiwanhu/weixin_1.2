<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>

<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>阅读情况</title>
  
 </head>

<body>
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-focum">
          <section class="section-focum  infinite-scroll section-focum-a wh-section show  pull-to-refresh-content" id="section1"  data-ptr-distance="40">
            <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div> 
            <div class="focum-a">
                <div class="three-tab-app clearfix">
                    <div class="clearfix">
                        <a id="tag1" href="#tab11" onclick="openQBlist()" class="tab-link active">
                            <span>全部情况</span>
                        </a>
                        <a id="tag2" href="#tab12" onclick="openYDlist()" class="tab-link ">
                            <span>只看已读</span>
                        </a>
                        <a id="tag3" href="#tab13" onclick="openWDlist()" class="tab-link ">
                            <span>只看未读</span>
                        </a>
                    </div>
                </div>
                <header id="searchBar" class="wh-search">
	                <div class="wh-container">
	                  <div class="wh-search-input">
	                    <form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar" id="sendForm">
	                      <label class="fa fa-search" for="search"></label>
	                      <input id="searchName" type="search" class="nomal-search"placeholder="请输入阅读人姓名查询" name="searchName"/>
	                      <a href="javascript:cancelSearch();" class="searchbar-cancel">取消</a>
	                    </form>
	                  </div>
	                </div>
	              </header>
                <div class="tabs">
                     <div id="tab11" class="list-block tab active">
                          <ul id="list1" class="info-list1">
                            
                          </ul>
                          <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div class="wh-load-md"></div>
						     <div id="list1LoadBox" class="wh-load-md">
						     <span></span>
						     <span></span>
						     <span></span>
						     <span></span>
						     <span></span>
						     </div>
						</aside>
                      </div>

                      <div id="tab12" class="list-block tab ">
                           <ul id="list2"  class="info-list1">
                             
                          </ul>
                          <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="list2LoadBox" class="wh-load-md">
						     <span></span>
						     <span></span>
						     <span></span>
						     <span></span>
						     <span></span>
						     </div>
						</aside>
                      </div>
                      <div id="tab13" class="list-block tab ">
                           <ul id="list3" class="info-list1">
       
                          </ul>
                          <aside class="wh-load-box" style="display: block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="list3LoadBox" class="wh-load-md">
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
    
    // 下拉刷新页面
  var ptrContent = $$('.pull-to-refresh-content');
    
  // 添加'refresh'监听器
  ptrContent.on('refresh', function(e) {
  
  	// 模拟2s的加载过程
    setTimeout(function() {
   		if($("#tag1").hasClass("active")){
   			list1pager = 0;
   			loadReadListt(0,0,0);
		}else if($("#tag2").hasClass("active")){
			list2pager = 1;
   			loadReadListt(0,1,0);
		}else{
			list3pager = 1;
   			loadReadListt(0,2,0);
		}
      myApp.pullToRefreshDone();
    }, 1000);
   });
    
	$(function(){
  		loadReadListt(0,0,0);
    });
	
	//加载查询信息列表
    function loadReadListt(flag,type,pager_offset) {
	  var url = '/defaultroot/information/getBrowser.controller';
	  $$.ajax({
		  type: "post",
		  url: url,
		  data : {"infoId" : '${infoId}',"type" : type,"pagerOffset" : pager_offset,"name" : $$('#searchName').val()},
		  dataType: "text",
		  success: function(data) {
		  	myApp.hidePreloader();
		  	loading = false;
			var jsonData = eval("("+data+")");
			list1RecordCount = jsonData.data1;
			if(list1RecordCount == undefined || list1RecordCount<15){
				$$('#list1LoadBox').hide();
				$$('#list2LoadBox').hide();
				$$('#list3LoadBox').hide();
			}
			if(jsonData.data0.length>0){
				var readhtml = '';
				for(var i = 0; i < jsonData.data0.length; i++){
					var readFlag = jsonData.data0[i].flag;
					var readEm = '未读';
					if(readFlag == 1){
						readEm = '已读';
					}
					var orgName = jsonData.data0[i].org;
                	if(orgName.length > 12){
                		orgName = orgName.substring(0,12)+'...';
                	}
					readhtml += '<li><a>'
                             + '<span class="fl">'+jsonData.data0[i].name+'['+orgName+']</span>'
                             + '<i class="done fr">'+readEm+'</i>'
                             + ' <em class="fr">'+jsonData.data0[i].time.substring(0,16)+'</em>'
                             + ' </a></li>';
				}
				if(flag == 0){
					if(type == 0){
						$$('#list1').html(readhtml);
					}else if(type ==1){
						$$('#list2').html(readhtml);
					}else{
						$$('#list3').html(readhtml);
					}
				}else{
					if(type == 0){
						$$('#list1').append(readhtml);
					}else if(type ==1){
						$$('#list2').append(readhtml);
					}else{
						$$('#list3').append(readhtml);
					}
				}
			}else{
				myApp.hidePreloader();
				if(type == 0){
					$$('#list1').html('<li style="padding: 1rem; font-size: 17px;"  class="swipeout">系统未查询到相关记录 !</li>');
				}else if(type ==1){
					$$('#list2').html('<li style="padding: 1rem; font-size: 17px;"  class="swipeout">系统未查询到相关记录 !</li>');
				}else{
					$$('#list3').html('<li style="padding: 1rem; font-size: 17px;"  class="swipeout">系统未查询到相关记录 !</li>');
				}
			}
		  },error: function(xhr, status) {
		  	myApp.hidePreloader();
		  	if(type == 0){
				$$('#list1').html('<li style="padding: 1rem; font-size: 17px;"  class="swipeout">系统未查询到相关记录 !</li>');
			}else if(type ==1){
				$$('#list2').html('<li style="padding: 1rem; font-size: 17px;" class="swipeout">系统未查询到相关记录 !</li>');
			}else{
				$$('#list3').html('<li style="padding: 1rem; font-size: 17px;" class="swipeout">系统未查询到相关记录 !</li>');
			}
		  }
	  });
	}
	
	 //全部列表总记录数
     var list1RecordCount = 0;
     var list1pager = 0;
     var list2pager = 0;
     var list3pager = 0;
     var loading = false;
     var readType = 0;
	 $$(document).on('infinite', '#section1', function() {
	    // 如果正在加载，则退出
	    if (loading) return;
	    loading = true;
	    //判断分页位置
	    if(readType == 0){
	    	var list1IndexL = $$('#list1 li').length;
		    setTimeout(function() {
			      if (list1IndexL >= list1RecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#list1LoadBox').hide();
			        //myApp.detachInfiniteScroll($$('#section1'));
			        return;
				  }
				  if (list1RecordCount - list1IndexL > 0) {
				  	$$('#list1LoadBox').show();
			        list1pager = list1pager+20;
			        loadReadListt(1,0,list1pager);
			        return;
				  }
		    }, 500);
	    }else if(readType == 1){
	    	var list2IndexL = $$('#list2 li').length;
		    setTimeout(function() {
			      if (list2IndexL >= list1RecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#list2LoadBox').hide();
			        //myApp.detachInfiniteScroll($$('#section1'));
			        return;
				  }
				  if (list1RecordCount - list2IndexL > 0) {
				  	$$('#list2LoadBox').show();
			        list2pager = list2pager+20;
			        loadReadListt(1,1,list2pager);
			        return;
				  }
		    }, 500);
	    }else{
	    	var list3IndexL = $$('#list3 li').length;
		    setTimeout(function() {
			      if (list3IndexL >= list1RecordCount) {
			        //加载完毕，则注销无限加载事件，以防不必要的加载
			        $$('#list3LoadBox').hide();
			        //myApp.detachInfiniteScroll($$('#section1'));
			        return;
				  }
				  if (list1RecordCount - list3IndexL > 0) {
				  	$$('#list3LoadBox').show();
			        list3pager = list3pager+20;
			        loadReadListt(1,2,list3pager);
			        return;
				  }
		    }, 500);
	    }
	    
	 });
	 
	 function openQBlist() {
	 	$$('#searchName').val('');
	 	readType = 0;
		loadReadListt(0,0,0);
	 }
	 
	 function openYDlist() {
	 	$$('#searchName').val('');
	 	readType = 1;
		loadReadListt(0,1,0);
	 }
	 
	 function openWDlist() {
	 	$$('#searchName').val('');
	 	readType = 2;
		loadReadListt(0,2,0);
	 }
	 
	 //绑定查询框回车事件
    $$('#searchName').keydown(function(event){
    	var searchName = $$('#searchName').val();
		if(event.keyCode == 13){ //绑定回车 
			myApp.showPreloader('搜索中，请稍后…');
			if((searchName.length > 0 && !(searchName.trim())) || /[@#\$%\^&\*]+/g.test(searchName)){
				 myApp.pullToRefreshDone();
				myApp.alert('请正确填写搜索标题')
			}else{
				if($("#tag1").hasClass("active")){
		   			list1pager = 0;
		   			loadReadListt(0,0,0);
				}else if($("#tag2").hasClass("active")){
					list2pager = 0;
		   			loadReadListt(0,1,0);
				}else{
					list3pager = 0;
		   			loadReadListt(0,2,0);
				}
			}
		} 
	});
	
	function cancelSearch() {
		if($("#tag1").hasClass("active")){
   			list1pager = 0;
   			loadReadListt(0,0,0);
		}else if($("#tag2").hasClass("active")){
			list2pager = 0;
   			loadReadListt(0,1,0);
		}else{
			list3pager = 0;
   			loadReadListt(0,2,0);
		}
	}
 </script>
</body>


