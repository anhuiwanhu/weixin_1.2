<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<%@ page import="com.whir.component.security.crypto.*" %>
<%
	String classId = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("classId")));
	if(classId == null){
		classId = "";
	}
%>
<c:set var="classId"><%= classId%></c:set>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>论坛</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" /> 
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-focum">
          <section id="sectionScroll" class="section-focum infinite-scroll section-focum-a wh-section show wh-section-bottomfixed pull-to-refresh-content" data-ptr-distance="40">
		    <input type="hidden" id="classId" name="classId" value="${classId}"/>
            <div class="pull-to-refresh-layer">
              <div class="preloader"></div>
              <div class="pull-to-refresh-arrow"></div>
            </div> 
            <div class="focum-a">
                <div class="three-tab-app clearfix">
                    <div class="clearfix">
                        <a href="#tab11" class="tab-link active" id="hrf0" onclick="change('0')">
                            <span>最后回复</span>
                        </a>
                        <a href="#tab12" class="tab-link " id="hrf1" onclick="change('1')">
                            <span>最新发布</span>
                        </a>
                        <a href="#tab13" class="tab-link " id="hrf2" onclick="change('2')">
                            <span>精华帖子</span>
                        </a>
                    </div>
                </div>
   
                <div class="tabs">
                     <div id="tab11" class="tab active">
                          <header id="searchBar" class="wh-search">
							<div class="wh-container">
							  <div class="wh-search-input">
								<form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar" id="sendForm">
								  <label class="fa fa-search" for="search"></label>
								  <input id="searchTitle1" type="search" class="nomal-search"placeholder="请输入信息标题查询" name="title"/>
								  <a href="javascript:cancelSearch1();" class="searchbar-cancel">取消</a>
								</form>
							  </div>
							</div>
						  </header>

                           <div class="list-block focum-list-a">
								<ul class="focum-ban-ul">
									<c:if test="${not empty docXml}">
										<x:parse xml="${docXml}" var="doc" />
										<x:forEach select="$doc//list" var="n" varStatus="status">
											<c:set var="className"><x:out select="$n/className/text()" /></c:set>
											<c:set var="id"><x:out select="$n/id/text()"/></c:set>
											<c:set var="hasForumCount"><x:out select="$n/hasForumCount/text()"/></c:set>
											<c:set var="classHasJunior"><x:out select="$n/classHasJunior/text()"/></c:set>
											<c:set var="haveRightFlag"><x:out select="$n/haveRightFlag/text()"/></c:set>
											<c:if test="${haveRightFlag eq '1' || classHasJunior eq '1' }">
												<li>
													<c:choose>
														<c:when test="${hasForumCount ne '0' || classHasJunior ne '0'}">
															<a class="swipeout-content item-content" style="" href="javascript:openForumSection('${id}','${className}','${haveRightFlag}');">
														</c:when>
														<c:when test="${hasForumCount eq '0' && classHasJunior eq '0'}">
															<a class="swipeout-content item-content" style="">
														</c:when>
													</c:choose>
													<div class="webapp-div">
														<div class="tips">${fn:substring(className,0,1)}</div>
														<span>${className }</span>
														<span class="document-span"> </span>
													</div>
													</a>
													<!--  <div class="swipeout-actions-right"><a href="#" class="swipeout-more" style="transform: translate3d(0px, 0px, 0px);">更多</a></div>-->
												</li>
											 </c:if>
										</x:forEach>
								    </c:if>
								</ul>
					      </div>
                          <div class="focum-a-list" id="postList">
                          </div>
                           <aside class="wh-load-box" style="display: block">
								<div class="wh-load-tap">上滑加载更多</div>
								<div class="wh-load-md" id="noteLast">
									<span></span>
									<span></span>
									<span></span>
									<span></span>
									<span></span>
								</div>
							</aside>
                      </div>

                      <div id="tab12" class="tab ">
						<header id="searchBar" class="wh-search">
							<div class="wh-container">
							  <div class="wh-search-input">
								<form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar" id="sendForm">
								  <label class="fa fa-search" for="search"></label>
								  <input id="searchTitle2" type="search" class="nomal-search"placeholder="请输入信息标题查询" name="title"/>
								  <a href="javascript:cancelSearch2();" class="searchbar-cancel">取消</a>
								</form>
							  </div>
							</div>
						</header>
                            <div class="list-block focum-list-a">
								<ul class="focum-ban-ul">
									<c:if test="${not empty docXml}">
										<x:parse xml="${docXml}" var="doc" />
										<x:forEach select="$doc//list" var="n" varStatus="status">
											<c:set var="className"><x:out select="$n/className/text()" /></c:set>
											<c:set var="id"><x:out select="$n/id/text()"/></c:set>
											<c:set var="hasForumCount"><x:out select="$n/hasForumCount/text()"/></c:set>
											<c:set var="classHasJunior"><x:out select="$n/classHasJunior/text()"/></c:set>
											<c:set var="haveRightFlag"><x:out select="$n/haveRightFlag/text()"/></c:set>
											<c:if test="${haveRightFlag eq '1' || classHasJunior eq '1' }">
												<li>
													<c:choose>
														<c:when test="${hasForumCount ne '0' || classHasJunior ne '0'}">
															<a class="swipeout-content item-content" style="" href="javascript:openForumSection('${id}','${className}','${haveRightFlag}');">
														</c:when>
														<c:when test="${hasForumCount eq '0' && classHasJunior eq '0'}">
															<a class="swipeout-content item-content" style="">
														</c:when>
													</c:choose>
													<div class="webapp-div">
														<div class="tips">${fn:substring(className,0,1)}</div>
														<span>${className }</span>
														<span class="document-span"> </span>
													</div>
													</a>
													<!--  <div class="swipeout-actions-right"><a href="#" class="swipeout-more" style="transform: translate3d(0px, 0px, 0px);">更多</a></div>-->
												</li>
											 </c:if>
										</x:forEach>
								    </c:if>
								</ul>
					      </div>
                          <div class="focum-a-list" id="postListNew">
                          </div>
						  <aside class="wh-load-box" style="display: block">
								<div class="wh-load-tap">上滑加载更多</div>
								<div class="wh-load-md" id="noteNew">
									<span></span>
									<span></span>
									<span></span>
									<span></span>
									<span></span>
								</div>
							</aside>
					  </div>
                      <div id="tab13" class="tab ">
						 <header id="searchBar" class="wh-search">
							<div class="wh-container">
							  <div class="wh-search-input">
								<form  action="javascript:return true;"  method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar" id="sendForm">
								  <label class="fa fa-search" for="search"></label>
								  <input id="searchTitle3" type="search" class="nomal-search"placeholder="请输入信息标题查询" name="title"/>
								  <a href="javascript:cancelSearch3();" class="searchbar-cancel">取消</a>
								</form>
							  </div>
							</div>
						</header>
                           <div class="list-block focum-list-a">
								<ul class="focum-ban-ul">
									<c:if test="${not empty docXml}">
										<x:parse xml="${docXml}" var="doc" />
										<x:forEach select="$doc//list" var="n" varStatus="status">
											<c:set var="className"><x:out select="$n/className/text()" /></c:set>
											<c:set var="id"><x:out select="$n/id/text()"/></c:set>
											<c:set var="hasForumCount"><x:out select="$n/hasForumCount/text()"/></c:set>
											<c:set var="classHasJunior"><x:out select="$n/classHasJunior/text()"/></c:set>
											<c:set var="haveRightFlag"><x:out select="$n/haveRightFlag/text()"/></c:set>
											<c:if test="${haveRightFlag eq '1' || classHasJunior eq '1' }">
												<li>
													<c:choose>
														<c:when test="${hasForumCount ne '0' || classHasJunior ne '0'}">
															<a class="swipeout-content item-content" style="" href="javascript:openForumSection('${id}','${className}','${haveRightFlag}');">
														</c:when>
														<c:when test="${hasForumCount eq '0' && classHasJunior eq '0'}">
															<a class="swipeout-content item-content" style="">
														</c:when>
													</c:choose>
													<div class="webapp-div">
														<div class="tips">${fn:substring(className,0,1)}</div>
														<span>${className }</span>
														<span class="document-span"> </span>
													</div>
													</a>
													<!--  <div class="swipeout-actions-right"><a href="#" class="swipeout-more" style="transform: translate3d(0px, 0px, 0px);">更多</a></div>-->
												</li>
											 </c:if>
										</x:forEach>
								    </c:if>
								</ul>
					      </div>
                          <div class="focum-a-list" id="postListCream">
                          </div>
						  <aside class="wh-load-box" style="display: block">
								<div class="wh-load-tap">上滑加载更多</div>
								<div class="wh-load-md" id="noteCream">
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
  <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script src="<%=rootPath%>/clientview/js/common.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7();
  var $$ = Dom7;
  //设置icon样式类
  setIconClass($$('.tips'));
  $$(".footer-focum>a").click(function(){
    var _this = $$(this);
    var index = _this.index();

    $$(".footer-focum>a").removeClass("fbtn-matter").addClass("fbtn-cancle");
    _this.removeClass("fbtn-cancle").addClass("fbtn-matter");
    $$(".section-focum").hide().eq(index).show();
	if(index == 1){
		loadSelectColumn();
	}
  });
    var classId = "";
   //进入页面开始加载论坛帖子列表数据
	$(function(){
		classId = "${classId}";
		var setFlag = '1';//查询标识
		loadNextPage(setFlag);
		loadNextPageNew(setFlag);
		loadNextPageCream(setFlag);
	});
    //页签标记
	var tabFlag = 'tabLast';
	//最后回复帖子列表
	var recordCount ;
	var curPage = '1';
	var nomore = '';
	var loadflag = '0';
	//加载下一页内容
	function loadNextPage(setFlag){
		//alert(curPage);
		if(loadflag == '1'){
			return;
		}
		loadflag = '1';
		var searchTitle = $('#searchTitle1').val();//标题
		var url = '/defaultroot/post/classList.controller?curPage='+curPage+'&orderType=1';//分页查询的链接
		//myApp.showPreloader('正在加载中...');//加载提示语
		$.ajax({
			type: 'post',
			url: url,
			dataType: 'text',
			data : {'queryTitle' : searchTitle,'classId' : classId},
		    success: function(data){
				//alert("1111111111111");
				var jsonData = eval("("+data+")");
				//alert("222222222222222");
				var postList = jsonData.data0;
						
				nomore = jsonData.data1;
				//alert("nomore------->"+nomore);
				curPage = jsonData.data2;
				//alert("curPage------->"+curPage);
				recordCount = jsonData.data3;
				if(recordCount > 15){
					$$('#noteLast').show();
				}else{
					$$('#noteLast').hide();
				}
				if(postList.length < 15){
					$$('#noteLast').hide();
				}
				var result = '';
				if(postList){
					var empLivingPhoto = '';
					for(var i = 0; i < postList.length; i++){
						if(postList[i].empLivingPhoto && 'null' != postList[i].empLivingPhoto){
							var arr = postList[i].empLivingPhoto.split('.');
							var fileName = postList[i].empLivingPhoto;
							var id = arr[0];
							loadImg2(fileName,id);
							empLivingPhoto = "<img name='"+id+"'>";
						}else{
							empLivingPhoto = "<img src='/defaultroot/clientview/images/user3.png'/>";
						}
						var userName = '';
						var anonymous = postList[i].anonymous;
						var nickName = postList[i].nickName;
						if(anonymous == '1'){
							userName = '匿名';
						}else if(nickName != ""){
							userName = nickName;
						}else{
							userName = postList[i].forumAuthor;
						}
						var time = postList[i].forumIssueTime.split(".")[0];
						var classParentName = postList[i].classParentName;
						if(classParentName.length > 6){
							classParentName = classParentName.substring(0,6) + "...";
						}
						if(postList[i].forumTopOrder != '0'){
							result +='<div class="ztop">'
							result +=		 '<table cellspacing="0" cellpadding="0" width="100%">'
							result +=			 '<tr>'
							result +=				 '<td><span>置顶</span></td>'
							result +=				  '<td>'
							result += '<a href="javascript:void(0);" onclick="openForum(\''+postList[i].id+'\',\''+postList[i].classid+'\');">';
							result +=					  '<p>'+postList[i].forumTitle+'</p></a>'
							result +=				  '</td>'
							result +=			  '</tr>'
							result +=		  '</table>'
							result +=   '</div>'
					    }else{
							result +=      '<div class="list-item">'
							result += '<a href="javascript:void(0);" onclick="openForum(\''+postList[i].id+'\',\''+postList[i].classid+'\');">';
							result +=          '<p class="person clearfix">'+empLivingPhoto
							result +=              '<span>'+postList[i].orgName+'.'+userName+'</span>'
							result +=              '<em>'+time+'</em>'
							result +=          '</p>'
							result +=          '<strong>'+postList[i].contentSummary+'</strong></a>'
						if(postList[i].forumAttachSave != ''){
							var attstr = postList[i].forumAttachSave.substring(0,(postList[i].forumAttachSave).length-1);
							var arr1 = attstr.split('|');				
							result +=          '<ul class="img-list clearfix">'
							for(var j=0 ; j<arr1.length;j++){
								if(arr1[j].split(".")[1] == 'jpg' || arr1[j].split(".")[1] == 'png' || arr1[j].split(".")[1] == 'gif' || arr1[j].split(".")[1] == 'jpeg' || arr1[j].split(".")[1] == 'bmp'){//图片附件
									var picid = arr1[j].split(".")[0];
									loadImgList(arr1[j],picid);
									result +=                '<li>'
									result +=                    '<img name="'+picid+'">'
									result +=                '</li>'
								}
							}
							result +=          '</ul>'
                        }
							result +=          '<p class="pp1">'
						if(postList[i].forumIsSoul == '1'){
							result +=              '<span class="orange">精华</span>'
						}
							result +=              '<span>'+classParentName+'</span>'
							result +=              '<span class="fr">'+postList[i].forumRevertNum+'跟帖</span>'
							result +=          '</p>'
							result +=      '</div>'
                        }
					}
				}
				if(!result){
					result = '<li class="swipeout" style="background-color: #fff;font-size: 17px;margin-top: .5rem;text-indent: .2rem;padding:1rem;">系统未查询到相关记录！</li>';
				}
				if(setFlag == '1'){
					$('#postList').html(result);
				}else{
					$('#postList').append(result);
				}	
				loadflag = '0';
				//myApp.hidePreloader();
			},
			error: function(xhr, type){
				nomore = '';
				$(".wh-load-tap").html("加载失败！");
			}
		});
	}
    
	//最新发布
	var recordCountNew ;
	var curPageNew = '1';
	var nomoreNew = '';
	var loadflagNew = '0';
	//加载下一页内容
	function loadNextPageNew(setFlag){
		//alert(curPage);
		if(loadflagNew == '1'){
			return;
		}
		loadflagNew = '1';
		var searchTitle = $('#searchTitle2').val();//标题
		var url = '/defaultroot/post/classList.controller?curPage='+curPageNew+'&orderType=2';//分页查询的链接
		//myApp.showPreloader('正在加载中...');//加载提示语
		$.ajax({
			type: 'post',
			url: url,
			dataType: 'text',
			data : {'queryTitle' : searchTitle,'classId' : classId},
		    success: function(data){
				//alert("1111111111111");
				var jsonData = eval("("+data+")");
				//alert("222222222222222");
				var postList = jsonData.data0;
						
				nomoreNew = jsonData.data1;
				//alert("nomore------->"+nomore);
				curPageNew = jsonData.data2;
				//alert("curPage------->"+curPage);
				recordCountNew = jsonData.data3;
				if(recordCountNew > 15){
					$$('#noteNew').show();
				}else{
					$$('#noteNew').hide();
				}
				if(postList.length < 15){
					$$('#noteNew').hide();
				}
				var result = '';
				if(postList){
					var empLivingPhoto = '';
					for(var i = 0; i < postList.length; i++){
						if(postList[i].empLivingPhoto && 'null' != postList[i].empLivingPhoto){
							var arr = postList[i].empLivingPhoto.split('.');
							var fileName = postList[i].empLivingPhoto;
							var id = arr[0];
							loadImg2(fileName,id);
							empLivingPhoto = "<img name='"+id+"'>";
						}else{
							empLivingPhoto = "<img src='/defaultroot/clientview/images/user3.png'/>";
						}
						var userName = '';
						var anonymous = postList[i].anonymous;
						var nickName = postList[i].nickName;
						if(anonymous == '1'){
							userName = '匿名';
						}else if(nickName != ""){
							userName = nickName;
						}else{
							userName = postList[i].forumAuthor;
						}
						var time = postList[i].forumIssueTime.split(".")[0];
						var classParentName = postList[i].classParentName;
						if(classParentName.length > 6){
							classParentName = classParentName.substring(0,6) + "...";
						}
						if(postList[i].forumTopOrder != '0'){
							result +='<div class="ztop">'
							result +=		 '<table cellspacing="0" cellpadding="0" width="100%">'
							result +=			 '<tr>'
							result +=				 '<td><span>置顶</span></td>'
							result +=				  '<td>'
							result += '<a href="javascript:void(0);" onclick="openForum(\''+postList[i].id+'\',\''+postList[i].classid+'\');">';
							result +=					  '<p>'+postList[i].forumTitle+'</p></a>'
							result +=				  '</td>'
							result +=			  '</tr>'
							result +=		  '</table>'
							result +=   '</div>'
					    }else{
							result +=      '<div class="list-item">'
							result += '<a href="javascript:void(0);" onclick="openForum(\''+postList[i].id+'\',\''+postList[i].classid+'\');">';
							result +=          '<p class="person clearfix">'+empLivingPhoto
							result +=              '<span>'+postList[i].orgName+'.'+userName+'</span>'
							result +=              '<em>'+time+'</em>'
							result +=          '</p>'
							result +=          '<strong>'+postList[i].contentSummary+'</strong></a>'
						if(postList[i].forumAttachSave != ''){
							var attstr = postList[i].forumAttachSave.substring(0,(postList[i].forumAttachSave).length-1);
							var arr1 = attstr.split('|');				
							result +=          '<ul class="img-list clearfix">'
							for(var j=0 ; j<arr1.length;j++){
								if(arr1[j].split(".")[1] == 'jpg' || arr1[j].split(".")[1] == 'png' || arr1[j].split(".")[1] == 'gif' || arr1[j].split(".")[1] == 'jpeg' || arr1[j].split(".")[1] == 'bmp'){//图片附件
									var picid = arr1[j].split(".")[0];
									loadImgList(arr1[j],picid);
									result +=                '<li>'
									result +=                    '<img name="'+picid+'">'
									result +=                '</li>'
								}
							}
							result +=          '</ul>'
                        }
							result +=          '<p class="pp1">'
						if(postList[i].forumIsSoul == '1'){
							result +=              '<span class="orange">精华</span>'
						}
							result +=              '<span>'+classParentName+'</span>'
							result +=              '<span class="fr">'+postList[i].forumRevertNum+'跟帖</span>'
							result +=          '</p>'
							result +=      '</div>'
                        }
					}
				}
				if(!result){
					result = '<li class="swipeout" style="background-color: #fff;font-size: 17px;margin-top: .5rem;text-indent: .2rem;padding:1rem;">系统未查询到相关记录！</li>';
				}
				if(setFlag == '1'){
					$('#postListNew').html(result);
				}else{
					$('#postListNew').append(result);
				}	
				loadflagNew = '0';
				//myApp.hidePreloader();
			},
			error: function(xhr, type){
				nomoreNew = '';
				$(".wh-load-tap").html("加载失败！");
			}
		});
	}

    //精华帖子
	var recordCountCream  ;
	var curPageCream = '1';
	var nomoreCream = '';
	var loadflagCream = '0';
	//加载下一页内容
	function loadNextPageCream(setFlag){
		//alert(curPage);
		if(loadflagCream == '1'){
			return;
		}
		loadflagCream = '1';
		var searchTitle = $('#searchTitle3').val();//标题
		var url = '/defaultroot/post/classList.controller?curPage='+curPageCream;//分页查询的链接
		//myApp.showPreloader('正在加载中...');//加载提示语
		$.ajax({
			type: 'post',
			url: url,
			dataType: 'text',
			data : {'queryTitle' : searchTitle,'classId' : classId,'queryForumType' : '1'},
		    success: function(data){
				//alert("1111111111111");
				var jsonData = eval("("+data+")");
				//alert("222222222222222");
				var postList = jsonData.data0;
						
				nomoreCream = jsonData.data1;
				//alert("nomore------->"+nomore);
				curPageCream = jsonData.data2;
				//alert("curPage------->"+curPage);
				recordCountCream = jsonData.data3;
				if(recordCountCream > 15){
					$$('#noteCream').show();
				}else{
					$$('#noteCream').hide();
				}
				if(postList.length < 15){
					$$('#noteCream').hide();
				}
				var result = '';
				if(postList){
					var empLivingPhoto = '';
					for(var i = 0; i < postList.length; i++){
						if(postList[i].empLivingPhoto && 'null' != postList[i].empLivingPhoto){
							var arr = postList[i].empLivingPhoto.split('.');
							var fileName = postList[i].empLivingPhoto;
							var id = arr[0];
							loadImg2(fileName,id);
							empLivingPhoto = "<img name='"+id+"'>";
						}else{
							empLivingPhoto = "<img src='/defaultroot/clientview/images/user3.png'/>";
						}
						var userName = '';
						var anonymous = postList[i].anonymous;
						var nickName = postList[i].nickName;
						if(anonymous == '1'){
							userName = '匿名';
						}else if(nickName != ""){
							userName = nickName;
						}else{
							userName = postList[i].forumAuthor;
						}
						var time = postList[i].forumIssueTime.split(".")[0];
						var classParentName = postList[i].classParentName;
						if(classParentName.length > 6){
							classParentName = classParentName.substring(0,6) + "...";
						}
	
						if(postList[i].forumTopOrder != '0'){
							result +='<div class="ztop">'
							result +=		 '<table cellspacing="0" cellpadding="0" width="100%">'
							result +=			 '<tr>'
							result +=				 '<td><span>置顶</span></td>'
							result +=				  '<td>'
							result += '<a href="javascript:void(0);" onclick="openForum(\''+postList[i].id+'\',\''+postList[i].classid+'\');">';
							result +=					  '<p>'+postList[i].forumTitle+'</p></a>'
							result +=				  '</td>'
							result +=			  '</tr>'
							result +=		  '</table>'
							result +=   '</div>'
						}else{
							result +=      '<div class="list-item">'
							result += '<a href="javascript:void(0);" onclick="openForum(\''+postList[i].id+'\',\''+postList[i].classid+'\');">';
							result +=          '<p class="person clearfix">'+empLivingPhoto
							result +=              '<span>'+postList[i].orgName+'.'+userName+'</span>'
							result +=              '<em>'+time+'</em>'
							result +=          '</p>'
							result +=          '<strong>'+postList[i].contentSummary+'</strong></a>'
						if(postList[i].forumAttachSave != ''){
							var attstr = postList[i].forumAttachSave.substring(0,(postList[i].forumAttachSave).length-1);
							var arr1 = attstr.split('|');				
							result +=          '<ul class="img-list clearfix">'
							for(var j=0 ; j<arr1.length;j++){
								if(arr1[j].split(".")[1] == 'jpg' || arr1[j].split(".")[1] == 'png' || arr1[j].split(".")[1] == 'gif' || arr1[j].split(".")[1] == 'jpeg' || arr1[j].split(".")[1] == 'bmp'){//图片附件
									var picid = arr1[j].split(".")[0];
									loadImgList(arr1[j],picid);
									result +=                '<li>'
									result +=                    '<img name="'+picid+'">'
									result +=                '</li>'
								}
							}
							result +=          '</ul>'
						}
							result +=          '<p class="pp1">'
							result +=              '<span class="orange">精华</span>'
							result +=              '<span>'+classParentName+'</span>'
							result +=              '<span class="fr">'+postList[i].forumRevertNum+'跟帖</span>'
							result +=          '</p>'
							result +=      '</div>'
						}
					
					}
				}
				if(!result){
					result = '<li class="swipeout" style="background-color: #fff;font-size: 17px;margin-top: .5rem;text-indent: .2rem;padding:1rem;">系统未查询到相关记录！</li>';
				}
				if(setFlag == '1'){
					$('#postListCream').html(result);
				}else{
					$('#postListCream').append(result);
				}	
				loadflagCream = '0';
				//myApp.hidePreloader();
			},
			error: function(xhr, type){
				nomoreCream = '';
				$(".wh-load-tap").html("加载失败！");
			}
		});
	}
	//ajax返回的数据
		function loadImg2(filename,id){
			$.ajax({
				type : 'post',
				url : '/defaultroot/download/downloadImg.controller',
				dataType : 'text',
				data : {"fileName":filename,"name":filename,"path":"peopleinfo"},
				success : function(data){
					//alert(data);
					//$('#'+id).attr("src","/defaultroot/"+data);
					$('img[name='+id+']').attr("src","/defaultroot/"+data);
				},
				error : function (xhr,type){
					//alert('数据查询异常！');
				}
			});
		}

		function loadImgList(filename,id){
			$.ajax({
				type : 'post',
				url : '/defaultroot/download/downloadImg.controller',
				dataType : 'text',
				data : {"fileName":filename,"name":filename,"path":"forum"},
				success : function(data){
					//alert(data);
					//$('#'+id).attr("src","/defaultroot/"+data);
					$('img[name='+id+']').attr("src","/defaultroot"+data);
				},
				error : function (xhr,type){
					//alert('数据查询异常！');
				}
			});
		}
      
     //加载人物图像
		$(function(){
			loadImg();
		});

		//页面开始是xml返回的数据
		function loadImg(){
			$("input[name='imgName']").each(
				function (){
					var filename = $(this).val();
					var id = filename.substring(0,25);
					if(filename == 'null'){
						//alert("1111"+filename);
						//$('#'+id).attr("src","/defaultroot/clientview/images/user3.png");
					}else{
						//alert("2222--------->"+filename);
						$.ajax({
							type : 'post',
							url : '<%=rootPath%>/download/downloadImg.controller',
							dataType : 'text',
							data : {"fileName":filename,"name":filename,"path":"peopleinfo"},
							success : function(data){
								//$('#'+id).attr("src","<%=rootPath%>"+data);
							},
							error : function (xhr,type){
								//alert('数据查询异常！');
							}
						});
					}
				}
			);
		}
      
	  //下滑加载 
		var loadingLast = false;
		var loadingNew = false;
		var loadingCream = false;
  		$$(document).on('infinite', '#sectionScroll', function() {
		if(tabFlag == 'tabLast'){
			// 如果正在加载，则退出
			if (loadingLast){ 
				return; 
			}
			loadingLast = true;
			setTimeout(function() {
				loadingLast = false;
				if(nomore){
					$$('#noteLast').show();
					loadNextPage('0');
				}else{
					$$('#noteLast').hide();
				    return;
				}
			}, 500);
		}else if(tabFlag == 'tabNew'){
		    // 如果正在加载，则退出
			if (loadingNew){ 
				return; 
			}
			loadingNew = true;
			setTimeout(function() {
				loadingNew = false;
				if(nomoreNew){
					$$('#noteNew').show();
					loadNextPageNew('0');
				}else{
					$$('#noteNew').hide();
				    return;
				}
			}, 500);
		}else if(tabFlag == 'tabCream'){
		    // 如果正在加载，则退出
			if (loadingCream){ 
				return; 
			}
			loadingCream = true;
			setTimeout(function() {
				loadingCream = false;
				if(nomoreCream){
					$$('#noteCream').show();
					loadNextPageCream('0');
				}else{
					$$('#noteCream').hide();
				    return;
				}
			}, 500);
		}
		});

		//改变页签标记
		function change(val){
			if(val == '0'){
			   tabFlag = 'tabLast';
			   sessionStorage.setItem("flg","0");
			}else if(val == '1'){
			   tabFlag = 'tabNew';
			   sessionStorage.setItem("flg","1");
			}else if(val == '2'){
			   tabFlag = 'tabCream';
			   sessionStorage.setItem("flg","2");
			}
		}


		//打开帖子详细页面
		function openForum(postId,curClassId){
			window.location = "/defaultroot/post/info.controller?postId="+postId+"&curClassId="+curClassId;
		}

		//发帖
		function newFocum(){
			var url = "/defaultroot/post/new.controller";
			window.location = url;
		}
        
		//加载板块试图
  		function loadSelectColumn(){
  	  		var userName = '${userName}';
  	  		//alert(userName);
  			var url = "/defaultroot/post/select.controller";
  			$.ajax({
				url : url,
				type : "post",
				dataType: "text",
				success : function(data){
					if(!data){
        				return;
        			}
        			var jsonData = eval("("+data+")");
        			if(!jsonData){
        				return;
        			}
        			var dataList = jsonData.data0;
        			var postList = new Array();
        			//将具有查看权限的保存到新建的数组中（具有可查看权限或者版主为自己）
        			for(var i = 0; i < dataList.length; i++){
        				var haveRightFlag = dataList[i].haveRightFlag;//可查看权限
        				var classOwnerName = dataList[i].classOwnerName;//版主
        				if(haveRightFlag == '1' || classOwnerName == userName){
        					postList.push(dataList[i]);
            			}
            		}
            		//alert(postList.length);
        			var result = '';
					//alert(jsonData.data0[0].className);
					var iconClassArray = ['c1','c2','c3','c4','c5','c6','c7','c8'];
        			if(jsonData.data0.length > 0){
        				for(var i = 0; i < postList.length; i++){
							//alert(i);
							var random = Math.random();
							var index = Math.round(random * (iconClassArray.length-1));
							var id = postList[i].id;//栏目ID
        					var className = postList[i].className;//栏目名称
        					var classOwnerName = postList[i].classOwnerName;//版主
							var haveRightFlag = postList[i].haveRightFlag;//0：不能查看或发帖 1:能查看或发帖（view时候查看 add时候为发帖） 
							var classHasJunior = postList[i].classHasJunior;//是否有下级栏目【0：没有；1：有】
							var hasForumCount = postList[i].hasForumCount;//该栏目下帖子的数目
							
							var a = "";
							var em = "";
							if(haveRightFlag == '1' || classHasJunior == '1'){
								if(hasForumCount != '0' || classHasJunior != '0'){
									a = "<a href='javascript:openForumSection("+id+",\""+className+"\",\""+haveRightFlag+"\");'>";
								}else if(hasForumCount == '0' && classHasJunior == '0'){
									a = "";
								}
								if(hasForumCount == '0'){
									em = "<em></em>";
								}else{
									em = "<em>"+hasForumCount+"&nbsp;条主题帖</em>";
								}
							}
							i = i+1;
							if(i < postList.length){
								var random1 = Math.random();
								var index1 = Math.round(random * (iconClassArray.length-1));
								var id1 = postList[i].id;//栏目ID
        						var className1 = postList[i].className;//栏目名称
								var haveRightFlag1 = postList[i].haveRightFlag;//0：不能查看或发帖 1:能查看或发帖（view时候查看 add时候为发帖） 
								var classHasJunior1 = postList[i].classHasJunior;//是否有下级栏目【0：没有；1：有】
								var hasForumCount1 = postList[i].hasForumCount;//该栏目下帖子的数目

							
								var a1 = "";
								var em1 = "";
								if(haveRightFlag1 == '1' || classHasJunior1 == '1'){
									if(hasForumCount1 != '0' || classHasJunior1 != '0'){
									a1 = "<a href='javascript:openForumSection("+id1+",\""+className1+"\",\""+haveRightFlag1+"\");'>";
									}else if(hasForumCount1 == '0' && classHasJunior1 == '0'){
										a1 = "";
									}
							
									if(hasForumCount1 == '0'){
										em1 = "<em></em>";
									}else{
										em1 = "<em>"+hasForumCount1+"&nbsp;条主题帖</em>";
									}
								}
							}
							result += "<tr><td><div>"+a+"<div class="+iconClassArray[index]+"><i class='fa fa-forum'></i></div>";
							result += "<div><span>"+className+"</span>"+em+"</div></a></div></td>";
							if(i < postList.length){
								result += "<td><div>"+a1+"<div class="+iconClassArray[index1]+"><i class='fa fa-forum'></i></div>";
								result += "<div><span>"+className1+"</span>"+em1+"</div></a></div></td></tr>";
							}
        				}
        				$("#tbody1").html(result);
        			}else{
        				$("#tbody1").html('<tr>未获取到数据</tr>');
        			}
				},
				error:function(data){
					$(".wh-load-box").html("加载失败");
				}
			});
  		}
        
		//打开指定板块的帖子列表
		function openForumSection(classId, className, haveRightFlag) {
			window.location = "/defaultroot/post/list.controller?classId=" + classId + "&className=" + className + "&haveRightFlag=" + haveRightFlag;
		}

       

	 //绑定查询框回车事件
     $('#searchTitle1').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if(($('#searchTitle1').val()).indexOf('<')>-1 || ($('#searchTitle1').val()).indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
			}else{
			    curPage = '1';
				var setFlag = '1';//查询标识
				loadNextPage(setFlag);
			}
		} 
	 });

	 //绑定查询框回车事件
     $('#searchTitle2').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if(($('#searchTitle2').val()).indexOf('<')>-1 || ($('#searchTitle2').val()).indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
			}else{
			    curPageNew = '1';
				var setFlag = '1';//查询标识
				loadNextPageNew(setFlag);
			}
		} 
	 });

	 //绑定查询框回车事件
     $('#searchTitle3').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if(($('#searchTitle3').val()).indexOf('<')>-1 || ($('#searchTitle3').val()).indexOf('>')>-1){
				myApp.alert('搜索值不能为特殊字符，请重新输入！');
			}else{
			    curPageCream = '1';
				var setFlag = '1';//查询标识
				loadNextPageCream(setFlag);
			}
		} 
	 });
     //搜索框取消
	 function cancelSearch1(){
		$('#searchTitle1').val('');
		curPage = '1';
		var setFlag = '1';//查询标识
		loadNextPage(setFlag);
	 }

	 function cancelSearch2(){
		$('#searchTitle2').val('');
		curPageNew = '1';
		var setFlag = '1';//查询标识
		loadNextPageNew(setFlag);
	 }

	 function cancelSearch3(){
		$('#searchTitle3').val('');
		curPageCream = '1';
		var setFlag = '1';//查询标识
		loadNextPageCream(setFlag);
	 }

	// 下拉刷新页面
	var ssContent = $$('#sectionScroll');
	// 添加'refresh'监听器
	ssContent.on('refresh', function(e) {
  		// 模拟2s的加载过程
		setTimeout(function() {
			var setFlag = '1';//查询标识			
    		if(tabFlag == 'tabLast'){
				curPage='1';
				loadNextPage(setFlag);
			}else if(tabFlag == 'tabNew'){
				curPageNew = '1';
				loadNextPageNew(setFlag);
			}else if(tabFlag == 'tabCream'){
				curPageCream = '1';
				loadNextPageCream(setFlag); 
			}
			myApp.pullToRefreshDone();
		}, 1000);
	});
  </script>
</body>
