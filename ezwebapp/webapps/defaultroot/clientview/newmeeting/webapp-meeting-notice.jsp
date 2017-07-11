<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title id="tit">会议通知列表</title>
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.webapp-style.min.css" />
</head>
<%
Date ndate = new Date();
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
String nowDate = df.format(ndate).toString();
String starD = nowDate+" 09:00";
String endD = nowDate+" 18:00";
%>
<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-leaderdat">
          <section class="section-focum wh-section show infinite-scroll wh-section-bottomfixed pull-to-refresh-content pull-to-refresh-no-navbar" id="sectionScroll">
            <!-- 下拉刷新 -->
            <div class="pull-to-refresh-layer">
               <div class="preloader"></div>
               <div class="pull-to-refresh-arrow"></div>
            </div>
            <!-- 下拉刷新 -->
            <div class="mail-todo">
              <div class="app-tabheader-line clearfix">
                <!-- 关联到第一个tab, 默认激活 -->
                <div class="clearfix">
                  <a href="#tab-mail-todo1" class="tab-link active" id="noMeet" onclick="change('0');">
                    <span>未处理</span>
                  </a>
                  <a href="#tab-mail-todo2" class="tab-link" id="gerMeet" onclick="change('1');">
                    <span>已处理</span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                <!-- Tab 1, 默认激活 -->
                <div id="tab-mail-todo1" class="tab active">
                  <header id="searchBar" class="wh-search">
		              <div class="wh-container">
		                <div class="wh-search-input">
		                  <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
		                    <label class="fa fa-search" for="search"></label>
		                    <input id="searchMeet" type="search" class="nomal-search" placeholder="请输入会议主题查询" />
		                    <a href="#" class="searchbar-cancel" onclick="removeSearch(this);loadMeetNotice('/defaultroot/newmeeting/meetingNoticeListData.controller?curpage=1',0);">取消</a>
		                  </form>
		                </div>
		              </div>
		           </header>
                  <div class="webapp-meeting">
                    <div class="meeting-notice">
                      <div class="list-block">
                        <ul id="meetNoticeInfo">
                    
                  		</ul>
                  		<aside class="wh-load-box" style="display:block">
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
                    </div>
                  </div>
                </div>
                <!-- Tab 2 -->
                <div id="tab-mail-todo2" class="tab">
                  <header id="searchBar" class="wh-search">
		              <div class="wh-container">
		                <div class="wh-search-input">
		                  <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
		                    <label class="fa fa-search" for="search"></label>
		                    <input id="searchhasMeet" type="search" class="nomal-search" placeholder="请输入会议主题查询" />
		                    <a href="#" class="searchbar-cancel" onclick="removeSearch(this);loadHasNotice('/defaultroot/newmeeting/meetingNoticeListData.controller?curpage=1',0);">取消</a>
		                  </form>
		                </div>
		              </div>
		           </header>
                  <div class="webapp-meeting">
                    <div class="meeting-notice">
                      <div class="list-block">
                        <ul id="hasNoticeInfo">
                    
                  		</ul>
                  		<aside class="wh-load-box" style="display:block">
						     <div class="wh-load-tap">上滑加载更多</div>
						     <div id="hasLoadBox" class="wh-load-md">
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
          <section class="section-focum wh-section infinite-scroll wh-section-bottomfixed" id="sectionApply">
            <div class="mail-todo">
              <div class="tabs">
                <!-- Tab 1, 默认激活 -->
                <div id="tab-mail-todo3" class="tab active">
                  <div class="meeting-head">
                    <div class="seclect-time clearfix">
                      <span>选择时间：</span>
                      <div class="time-ipt clearfix">
                        <input class="edit-ipt-r edit-ipt-arrow" type="text" id="startTime" value="<%=starD%>" onfocus="selectDateTimeNew(this)" placeholder="选择时间" readonly/>
                        <input class="edit-ipt-r edit-ipt-arrow" type="text" id="endTime" value="<%=endD%>" onfocus="selectDateTimeNew(this)" placeholder="选择时间" readonly/>
                      </div>
                    </div>
                    <div class="time clearfix">
                      <span>选择人数：</span>
                      <input type="text" name="gerPernum" id="gerPernum">
                      <span style="color: #333" class="person">人</span>
                    </div>
                    <div class="sure">
                        <a href="" onclick="serachRoom('startTime','endTime','startDate','endDate');">搜索</a>
                     </div>
					<input type="hidden" name="startDate" value="<%=starD%>" id="startDate"/>
					<input type="hidden" name="endDate" value="<%=endD%>" id="endDate"/>
                  </div>
                  <div class="meeting-ul">
                    <ul id="meetRoomInfo">
                  		
                	</ul>
                	<aside class="wh-load-box" style="display: block">
						 <div class="wh-load-tap">上滑加载更多</div>
						 <div class="wh-load-md" id="generalM">
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
          </section>
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-wrapper">
              <div class="wh-container">
                <div class="footer-focum wh-footer-btn row no-gutter">
                  <a href="##" class="fbtn-matter col-50" id="meetNot" onclick="change('0');changetitle('1')">
                    <div><i class="fa fa-training-mana"></i></div><span>会议通知</span></a>
                  <a href="##" class="fbtn-cancle col-50" id="roomYu" onclick="change('2');changetitle('2')">
                    <div><i class="fa fa-personnel-pos"></i></div><span>会议室预定</span></a>
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
 <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
 <script type="text/javascript" src="/defaultroot/clientview/template/js/plugin/zepto.js"></script>
 <script type="text/javascript" src="/defaultroot/clientview/template/js/plugin/simplecalendar.js"></script>
 <script type="text/javascript" src="/defaultroot/clientview/custmenu/js/custmenu.js"></script>
  <script type="text/javascript">
    var myApp = new Framework7({
      fastClicks: false,
  	});
  	var $$ = Dom7;
  //底部切换
  $$(".footer-info>a").click(function() {
    var _this = $$(this);
    var index = _this.index();

    $$(".footer-info>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    $$(".section-info").hide().eq(index).show();

  });
  $$(".footer-focum>a").click(function(){
    var _this = $$(this);
    var index = _this.index();

    $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    $$(".section-focum").hide().eq(index).show();
  });
  
  	/********进入页面开始加载会议通知********/
  	$(document).ready(function(){
		var meetFlg = sessionStorage.getItem("meetFlg");
		if(meetFlg=='1'){
			$$("#meetNot").click();
			$$("#gerMeet").click();
		}else if(meetFlg=='2'){
			$$("#roomYu").click();
			$$("#puRoom").click();
		}else{
			$$("#meetNot").click();
			$$("#noMeet").click();
		}
		var url = "/defaultroot/newmeeting/meetingNoticeListData.controller?curpage=1";
		loadMeetNotice(url,0);
		loadHasNotice(url,0);
		loadMeetRoom("/defaultroot/newmeeting/meetingRoomListData.controller?curpage=1",0);
	});
	 	
 	// 清除搜索区域焦点bug
   function removeSearch(schElmID) {
     $$(schElmID).prev('.nomal-search').val('');
     $$(schElmID).blur().val(""); //主动清除焦点
     $$(schElmID).next('.searchbar-cancel').hide();
   }
	
	//绑定查询框回车事件
	$('#searchMeet').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			var url = "/defaultroot/newmeeting/meetingNoticeListData.controller?curpage=1";
			loadMeetNotice(url,0);
		} 
	 });
	
	//未处理的
	//当前页页数 全局变量
	var curPage = "1";
	//总数目
	var count = '';
	function loadMeetNotice(url,loadFlag){
		$.ajax({
			type: 'post',
	        url: url,
			dataType:'text',
			data : {'title' : $('#searchMeet').val(),'meetType' : '1'},
	           success: function(data){
				if(!data){
	       			return;
	       		}
	       		var jsonData = eval("("+data+")");
	       		if(!jsonData){
	       			return;
	       		}
				//当前页
	       		curPage = jsonData.data2;
				count = jsonData.data3;
				if(count>15){
					$('#pushLoadBox').show();
				}else{
					$('#pushLoadBox').hide();
				}
				if(jsonData.data0.length<15){
					$('#pushLoadBox').hide();
				}
				var result = '';
				if(jsonData.data0.length > 0){
					for(var i = 0; i < jsonData.data0.length; i++){
						var status = jsonData.data0[i].status;//参会状态
						var noticeId = jsonData.data0[i].noticeId;//主键Id
						var meetingDate = jsonData.data0[i].meetingDate;//会议日期
						var meetingMotif = jsonData.data0[i].meetingMotif;//会议主题
						var startTime = jsonData.data0[i].startTime;//开始时间
						var endTime = jsonData.data0[i].endTime;//结束时间
						var meetingAddress = jsonData.data0[i].meetingAddress;//会议地点
						var completeDate = jsonData.data0[i].completeDate;//完成时间
						var islook = jsonData.data0[i].islook ;//是否查看过
						var start_hour = parseInt(parseInt(startTime)/3600)+"";
						var start_min = parseInt(parseInt(startTime)%3600)/60==0?"00":parseInt(parseInt(startTime)%3600)/60+"";
						if(start_hour.length==1){
							start_hour = "0"+start_hour;
						}
						if(start_min.length==1){
							start_min = "0"+start_min;
						}
						var end_hour = parseInt(parseInt(endTime)/3600)+"";
						var end_min = parseInt(parseInt(endTime)%3600)/60==0?"00":parseInt(parseInt(endTime)%3600)/60+"";
						
						if(end_hour.length==1){
							end_hour = "0"+end_hour;
						}
						if(end_min.length==1){
							end_min = "0"+end_min;
						}
						
						meetingDate = meetingDate.substring(0,10);
						var time = meetingDate + " " + start_hour + ":" + start_min + "-" + end_hour + ":" + end_min ;
						
						if(completeDate !=''){
							completeDate = "["+completeDate.substring(0,16)+"]";
						}
						//0 不参加 1 参加 2 转发 3已过期 4 已发布 5 未处理 6 未开会
						var statuName ='';
						var cla ='';
						if(status=='0'){
							statuName ='不参加';
							cla ='forum-avatar m-tag-not';
						}else if(status=='1'){
							statuName ='已参加 ';
							cla ='forum-avatar green';
						}else if(status=='2'){
							statuName ='已转发';
							cla ='forum-avatar green';
						}else if(status=='3'){
							statuName ='已过期';
							cla ='forum-avatar m-tag-not';
						}else if(status=='4'){
							statuName ='已发布';
							cla ='forum-avatar m-tag-not';
						}else if(status=='5'){
							statuName ='未处理';
							cla ='forum-avatar m-tag-ny';
						}else if(status=='6'){
							statuName ='未开会';
							cla ='forum-avatar m-tag-had';
						}
						var haslook = '<p>';
						/*if(islook =='0'){
							haslook = '<p style="font-weight: bold;">';
						}*/
						result += "<li class='swipeout'>";
						result += "<a href='javascript:void(0)' onclick='openInfoDetail("+noticeId+",\"0\")' class='swipeout-content item-content'>";
						result += "<div><strong class='"+cla+"'>"+statuName+"</strong>";
						result += haslook +time+"在"+meetingAddress+"召开的"+meetingMotif+"需要您的参加！<span>"+completeDate+"</span></p></div></a>";
						result += "</li>";
					}
				}else{
					$(".wh-load-md").css("display","none");
					if(count =='0'){
						result += '<li><p style="margin-left:0;"><a>系统没有查询到相关记录！</a></p></li>';
					}
				}
				if(loadFlag == '1'){
	                $('#meetNoticeInfo').append(result);
	               }else{
					$('#meetNoticeInfo').html(result);
	               }
			},
			error: function(xhr, type){
				$('#meetNoticeInfo').html('<li><p><a>查询数据异常！</a></p></li>');
			}
		});
	}
	
	//绑定查询框回车事件
	$('#searchhasMeet').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			var url = "/defaultroot/newmeeting/meetingNoticeListData.controller?curpage=1";
			loadHasNotice(url,0);
		} 
	 });
	//已处理的
	//当前页页数 全局变量
	var hascurPage = "1";
	//总数目
	var hascount = '';
	function loadHasNotice(url,loadFlag){
		$.ajax({
			type: 'post',
	        url: url,
			dataType:'text',
			data : {'title' : $('#searchhasMeet').val(),'meetType' : '0'},
	           success: function(data){
				if(!data){
	       			return;
	       		}
	       		var jsonData = eval("("+data+")");
	       		if(!jsonData){
	       			return;
	       		}
				//当前页
	       		hascurPage = jsonData.data2;
				hascount = jsonData.data3;
				if(hascount>15){
					$('#hasLoadBox').show();
				}else{
					$('#hasLoadBox').hide();
				}
				if(jsonData.data0.length<15){
					$('#hasLoadBox').hide();
				}
				var result = '';
				if(jsonData.data0.length > 0){
					for(var i = 0; i < jsonData.data0.length; i++){
						var status = jsonData.data0[i].status;//参会状态
						var noticeId = jsonData.data0[i].noticeId;//主键Id
						var meetingDate = jsonData.data0[i].meetingDate;//会议日期
						var meetingMotif = jsonData.data0[i].meetingMotif;//会议主题
						var startTime = jsonData.data0[i].startTime;//开始时间
						var endTime = jsonData.data0[i].endTime;//结束时间
						var meetingAddress = jsonData.data0[i].meetingAddress;//会议地点
						var completeDate = jsonData.data0[i].completeDate;//完成时间
						
						var start_hour = parseInt(parseInt(startTime)/3600)+"";
						var start_min = parseInt(parseInt(startTime)%3600)/60==0?"00":parseInt(parseInt(startTime)%3600)/60+"";
						if(start_hour.length==1){
							start_hour = "0"+start_hour;
						}
						if(start_min.length==1){
							start_min = "0"+start_min;
						}
						var end_hour = parseInt(parseInt(endTime)/3600)+"";
						var end_min = parseInt(parseInt(endTime)%3600)/60==0?"00":parseInt(parseInt(endTime)%3600)/60+"";
						
						if(end_hour.length==1){
							end_hour = "0"+end_hour;
						}
						if(end_min.length==1){
							end_min = "0"+end_min;
						}
						
						meetingDate = meetingDate.substring(0,10);
						var time = meetingDate + " " + start_hour + ":" + start_min + "-" + end_hour + ":" + end_min ;
						
						if(completeDate !=''){
							completeDate = "["+completeDate.substring(0,16)+"]";
						}
						//0 不参加 1 参加 2 转发 3已过期 4 已发布 5 未处理 6 未开会
						var statuName ='';
						var cla ='';
						if(status=='0'){
							statuName ='不参加';
							cla ='forum-avatar m-tag-not';
						}else if(status=='1'){
							statuName ='已参加 ';
							cla ='forum-avatar green';
						}else if(status=='2'){
							statuName ='已转发';
							cla ='forum-avatar green';
						}else if(status=='3'){
							statuName ='已过期';
							cla ='forum-avatar m-tag-not';
						}else if(status=='4'){
							statuName ='已发布';
							cla ='forum-avatar m-tag-not';
						}else if(status=='5'){
							statuName ='未处理';
							cla ='forum-avatar m-tag-ny';
						}else if(status=='6'){
							statuName ='未开会';
							cla ='forum-avatar m-tag-had';
						}
						result += "<li class='swipeout'>";
						result += "<a href='javascript:void(0)' onclick='openInfoDetail("+noticeId+",\"1\")' class='swipeout-content item-content'>";
						result += "<div><strong class='"+cla+"'>"+statuName+"</strong>";
						result += "<p>"+time+"在"+meetingAddress+"召开的"+meetingMotif+"需要您的参加！<span>"+completeDate+"</span></p></div></a>";
						result += "</li>";
					}
				}else{
					$(".wh-load-md").css("display","none");
					if(hascount =='0'){
						result += '<li><p style="margin-left:0;"><a>系统没有查询到相关记录！</a></p></li>';
					}
				}
				if(loadFlag == '1'){
	                $('#hasNoticeInfo').append(result);
	               }else{
					$('#hasNoticeInfo').html(result);
	               }
			},
			error: function(xhr, type){
				$('#hasNoticeInfo').html('<li><p><a>查询数据异常！</a></p></li>');
			}
		});
	}
	
	//打开详情页
	function openInfoDetail(noticeId,status){
		window.location="/defaultroot/newmeeting/meetingNoticeDetail.controller?noticeId="+noticeId+"&listStatus="+status+"&pushFlag="+1;
	}
	var loading = false;
	var hasloading = false;
	$$(document).on('infinite', '#sectionScroll', function() {
		if(dealFlag == '0'){
			// 如果正在加载，则退出
			if (loading) return;
			loading = true;
			var lastIndex = $$('#meetNoticeInfo li').length;
			setTimeout(function() {
				loading = false;
				if (lastIndex >= count) {
					// 加载完毕，则注销无限加载事件，以防不必要的加载
					//myApp.detachInfiniteScroll($$('#sectionScroll'));
					// 删除加载提示符
					$('#pushLoadBox').hide();
					return;
				}
				if (count - lastIndex > 0) {
					$(".wh-load-box").css("display","block");
					var url = "meetingNoticeListData.controller?curpage="+curPage;
					loadMeetNotice(url,'1');
					return;
				}
			}, 500);
		}else if(dealFlag == '1'){
			// 如果正在加载，则退出
			if (hasloading) return;
			hasloading = true;
			var lastIndex = $$('#hasNoticeInfo li').length;
			setTimeout(function() {
				hasloading = false;
				if (lastIndex >= hascount) {
					// 加载完毕，则注销无限加载事件，以防不必要的加载
					//myApp.detachInfiniteScroll($$('#sectionScroll'));
					// 删除加载提示符
					$('#hasLoadBox').hide();
					return;
				}
				if (hascount - lastIndex > 0) {
					$(".wh-load-box").css("display","block");
					var url = "meetingNoticeListData.controller?curpage="+hascurPage;
					loadHasNotice(url,'1');
					return;
				}
			}, 500);
		}	
	});
	
	   // 下拉刷新页面
	var ssmContent = $$('#sectionScroll');
	// 添加'refresh'监听器
	ssmContent.on('refresh', function(e) {
	 		// 模拟2s的加载过程
		setTimeout(function() {
	   		var url = "/defaultroot/newmeeting/meetingNoticeListData.controller?curpage=1";
			if(dealFlag == '0'){
				loadMeetNotice(url,0);
			}else if(dealFlag == '1'){
				loadHasNotice(url,0);
			}
			myApp.pullToRefreshDone();
		}, 1000);
	});
/********会议通知的内容结束********/
	//改变页签标记 0：未处理，1：已处理,2:普通会议，3：视频会议
	var dealFlag = '0';
	function change(val){
		dealFlag = val;
		sessionStorage.setItem("meetFlg",val);
	}
/********会议室预定内容开始********/
	function gerMeetList(){
		loadMeetRoom("/defaultroot/newmeeting/meetingRoomListData.controller?curpage=1",0);
	}

     //当前页页数 全局变量
     var gerPage = "1";
     //总数目
     var gerCount = "";
     function loadMeetRoom(loadUrl,loadFlag){
     	var personNum =$("#gerPernum").val();
		var startDate =$("#startDate").val();
		var endDate =$("#endDate").val();
		var result ='';
		$.ajax({
			type: 'post',
            url: loadUrl,
			dataType:'text',
		    data : {"startDate" : startDate, "endDate" : endDate, "personNum" : personNum},
			success: function(data){
				if(!data){
        			return;
        		}
        		var jsonData = eval("("+data+")");
        		if(!jsonData){
        			return;
        		}
        		gerPage = jsonData.data2;
				gerCount = jsonData.data3;
				var noMore = jsonData.data1;
        		if(noMore){
					$('#generalM').show();
				}else{
					$('#generalM').hide();
				}
        		var person = '';
        		for(var i = 0; i < jsonData.data0.length; i++){
        			var boardroomId = jsonData.data0[i].boardroomId;//会议室id
					var boardroomName = jsonData.data0[i].boardroomName;//会议室名称
					var locationArea = jsonData.data0[i].location;//位置
					var capacitance = jsonData.data0[i].capacitance;//可容纳人数
					if(capacitance != "" && capacitance != null && capacitance != 0 && capacitance != 'null'){
						person = '<span>-可容纳</span><span>'+capacitance+'</span><span>人</span>';
					}else{
						person = '<span>-可容纳人数未设置！</span>';
					}
					result += '<li>';
					result += '<p>'+boardroomName+'</p><p class="grey"><span>'+locationArea+'</span>'+person+'</p>';
					result += '<a class="yuding" onclick="applyRoom(\''+boardroomId+'\',\''+boardroomName+'\');">预定</a>';
					result += '</li>';
        		}
        		//查询数据为空时页面展示信息
                if(jsonData.data0.length == 0){
                	if(gerCount =='0'){
						result += '<li><p><a>系统没有查询到相关记录！</a></p></li>';
					}
                }
                $(".wh-load-md").css("display","none");
                if(loadFlag == '1'){
	            	$('#meetRoomInfo').append(result);
                }else{
	            	$('#meetRoomInfo').html(result);
                }
			},
			error: function(xhr, type){
            	alert('加载中请勿频繁操作！'); 
            }
		});
     }
	
	var gerloading = false;
	$$(document).on('infinite', '#sectionApply', function() {
		// 如果正在加载，则退出
		if (gerloading) return;
		gerloading = true;
		var lastIndex = $$('#meetRoomInfo li').length;
		setTimeout(function() {
			gerloading = false;
			if (lastIndex >= gerCount) {
				// 加载完毕，则注销无限加载事件，以防不必要的加载
				//myApp.detachInfiniteScroll($$('#sectionApply'));
				// 删除加载提示符
				$('#generalM').hide();
				return;
			}
			if (gerCount - lastIndex > 0) {
				$('#generalM').show();
				var url = "/defaultroot/newmeeting/meetingRoomListData.controller?curpage="+gerPage;
				loadMeetRoom(url,'1');
				return;
			}
		}, 500);
	});

	//预定
	function applyRoom(mid,mname){
		var personNum =$("#gerPernum").val();
		var startDate =$("#startDate").val();
		var endDate =$("#endDate").val();
		window.location="/defaultroot/newmeeting/meetingWorkFlowList.controller?meetRoomId="+mid+"&meetRoomName="+mname+"&personNum="+personNum+"&startDate="+startDate+"&endDate="+endDate;
	}

	function serachRoom(id1,id2,id3,id4){
		checkForm(id1,id2,id3,id4);
		loadMeetRoom("/defaultroot/newmeeting/meetingRoomListData.controller?curpage=1",0);
	}
	
	function checkForm(id1,id2,id3,id4){
		var st = $$('#'+id1).val();
		var et = $$('#'+id2).val();
		if(st == ''){
			myApp.alert('开始时间不能为空！');
			return false;
		}
		if(et == ''){
			myApp.alert('结束时间不能为空！');
			return false;
		}
	    st = st.replace(","," ");
	    et = et.replace(","," ");
	    var st1 = st+':59';
	    var et1 = et+':59';
		var bd = new Date(st1.replace(/\-/g, "\/"));  
 		var ed = new Date(et1.replace(/\-/g, "\/"));
 		if(bd >= ed){
 			myApp.alert('开始时间不能大于等于结束时间！');
 			return false;
 		}
 		var now = new Date().valueOf();
 		if(now > bd){
 			myApp.alert('开始时间不能早于当前时间！');
 			return false;
 		}
 		$$('#'+id3).val(st);
		$$('#'+id4).val(et);
		return true;
	}

	//改变页面标题
	function changetitle(val){
		if(val == '1'){
		   $("#tit").html('会议通知列表');
		}else if(val == '2'){
		   $("#tit").html('会议室预定');
		}
	}
	
/********会议室预定内容结束********/
</script>
</body>
