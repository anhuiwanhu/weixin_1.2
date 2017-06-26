<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/clientview/common/taglibs.jsp"%>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>公文</title>
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-document">
          <section class="wh-section infinite-scroll pull-to-refresh-content" data-ptr-distance="40" id="sectionScroll">
           	<div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div>
            <div class="webapp-document">
              <div class="webapp-div doc-title">
                <p>我的收文</p>
              </div>
              <header id="searchBar" class="wh-search">
                      <div class="wh-container">
                        <div class="wh-search-input">
                          <form method="post" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                            <label class="fa fa-search" for="search"></label>
                            <input id="searchTitle" type="search" class="nomal-search" placeholder="请输入公文标题查询" />
                          	<a href="#" class="searchbar-cancel" onfocus="removeSearch(this)" onclick="viewData();">取消</a>
                          </form>
                        </div>
                      </div>
                    </header>
              <div class="doc-list">
                <div class="list-block">
                  <ul class="webapplist">
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
            </div>
          </section>
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
	    
	    function viewData(){
	    	offset=0;
		    nextPage(0,'0',"");
	    }
	
	    // 搜索焦点时
	    $$('#fbtn-save').on('click', function() {
	      $$(this).next('.searchbar-cancel').show();
	    })
		//列表总记录
		var maxItems = '${recordCount}';
		//列表记录偏移量
		var offset = 0;
		var qText='';
		var loading = false;
		window.onload=myfun;
		function myfun() {
			/*var index = $$('.webapplist li').length;
			if(index < 15){
				$$('.wh-load-md').hide();
			}else{
				$$('.wh-load-md').show();
			}
			if(index == 0){
				$$('.webapplist').html('<li clas="swipeout">系统没有查询到相关记录！</li>');
			}*/
			nextPage(0,'0', $('#searchTitle').val());
		}
		
		//绑定查询框回车事件
	    $('#searchTitle').keydown(function(event){ 
			if(event.keyCode == 13){ //绑定回车 
				if(/[@#\$%\^&\*]+/g.test($('#searchTitle').val())){
					myApp.alert('请正确填写搜索项目名称！');
					return false;
				}
				qText = $('#searchTitle').val();
				offset = 0;
				nextPage(offset,'0',qText);
			} 
		});
		
		// 下拉刷新页面
	  	var ptrContent = $$('.pull-to-refresh-content');
	  
	  	// 添加'refresh'监听器
	  	ptrContent.on('refresh', function(e) {
		  	// 模拟2s的加载过程
		    setTimeout(function() {
		    		offset=0;
		    		qText = $('#searchTitle').val();
				    nextPage(0,'0',qText);	
		      		myApp.pullToRefreshDone();
		    }, 1000);
		});
		$$(document).on('infinite', '#sectionScroll', function() {
		    // 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		    lastIndex = $$('.webapplist li').length;
		     setTimeout(function() {
			      if (lastIndex >= maxItems) {
				        // 加载完毕，则注销无限加载事件，以防不必要的加载
				        myApp.detachInfiniteScroll($$('#sectionScroll'));
				        // 删除加载提示符
				        $$('.wh-load-md').hide();
				        return;
				    }
				    if (maxItems - lastIndex > 0) {
				    	//alert(curPage);
				        offset = offset+15;
				        qText = $('#searchTitle').val();
				        nextPage(offset,'1',qText);
				        return;
				    }
		    }, 500);
		});
		function nextPage(offset,loadFlag,searchTitle) {
	  	  var url = '/defaultroot/doc/nextReceiveFileList.controller?offset='+offset+'&title='+searchTitle;
		  $$.ajax({
		      type: "post",
		      url: url,
		      dataType: "text",
		      success: function(data) {
		      	var jsonData = eval("("+data+")");
		      	var html ='';
		      	var userIsReaded = '';
		      	var type = '';
		      	maxItems = jsonData.data1;
		      	if(maxItems<=15){
					// 加载完毕，则注销无限加载事件，以防不必要的加载
			        myApp.detachInfiniteScroll($$('#sectionScroll'));
			        // 删除加载提示符
			        $$('.wh-load-md').hide();
				}//如果查询总记录数大于15，则加载无线滚动事件
				if(maxItems > 15){
					$$('.wh-load-md').show();
					myApp.attachInfiniteScroll($$('#sectionScroll'));
				}
		      	if(jsonData.data0.length>0){
			      	for(var i = 0; i < jsonData.data0.length; i++){
			      		userIsReaded = jsonData.data0[i].userIsReaded;	
			      		if(userIsReaded == '0'){
			      			type = '<i class="point"></i>';
			      		}else{
			      			type = '';
			      		}
						
						html +='<li class="swipeout"  onclick="openDetail(this);" >'+
									'<a href="#" class="swipeout-content item-content">'+
										'<div>'+
										  type+
										  '<p>'+jsonData.data0[i].title+'</p>'+
										  '<em class="grey">'+jsonData.data0[i].createdTime.substring(0,16)+'</em>'+
										  '<em class="yellow">'+jsonData.data0[i].byteNumber+'</em>'+
										  '<em class="skyblue">'+jsonData.data0[i].writeOrg+'</em>'+
										'</div>'+
										'<div class="item-after"><i class="fa fa-angle-right"></i></div>'+
									'</a>'+
									'<form>'+
									  '<input type="hidden" name="writeOrg" value="'+jsonData.data0[i].writeOrg+'"/>'+
									  '<input type="hidden" name="createdTime" value="'+jsonData.data0[i].createdTime+'"/>'+
									  '<input type="hidden" name="title" value="'+jsonData.data0[i].title+'"/>'+
									  '<input type="hidden" name="accessoryName" value="'+jsonData.data0[i].accessoryName+'"/>'+
									  '<input type="hidden" name="accessorySaveName" value="'+jsonData.data0[i].accessorySaveName+'"/>'+
									  '<input type="hidden" name="goldGridId" value="'+jsonData.data0[i].goldGridId+'"/>'+
									  '<input type="hidden" name="wordType" value="'+jsonData.data0[i].wordType+'"/>'+
									  '<input type="hidden" name="id" value="'+jsonData.data0[i].id+'"/>'+
								  '</form>'+
								'</li>';				
			      	}
			      	if(loadFlag == '1'){
	                 	$('.webapplist').append(html);
	                }else{
		                $('.webapplist').html(html);
	                }
	                loading = false;
		      	}else{
		      		$$('.wh-load-md').hide();
		      		$$('.webapplist').html('<li class="swipeout">系统没有查询到相关记录！</li>');
		      	}
		      },error: function(xhr, status) {
		        $$('.webapplist').append('<li class="swipeout">系统没有查询到相关记录！</li>');
		        $$('.wh-load-tap').hide();
		        $$('.wh-load-md').hide();
		      }
	      });
		}
		
		//打开收文详情
		function openDetail(obj){
			$(obj).find('form').attr('action','openReceiveDetail.controller').attr('method','get').submit();
		}

	    $$('.swipeout-more').on('click', function() {
		    myApp.alert('there is more to do ');
		});
   
  </script>
</body>