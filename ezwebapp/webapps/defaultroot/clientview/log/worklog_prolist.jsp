<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.whir.aop.WebAppAuth"%>
<%@ page isELIgnored ="false" %>
<section id="sectionScroll" class="infinite-scroll wh-section wh-section-bottomfixed pull-to-refresh-content" data-ptr-distance="40">
<div class="pull-to-refresh-layer">
      <div class="preloader"></div>
      <div class="pull-to-refresh-arrow"></div>
    </div>
<header id="searchBar" class="wh-search" style="padding-top: 0px;padding-bottom: 0px;">
  <div class="wh-container">
    <div class="wh-search-input">
      <form method="post" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
        <label class="fa fa-search" for="search"></label>
        <input id="searchBug" type="search" class="nomal-search" placeholder="请输入项目名称查询" />
      </form>
    </div>
  </div>
</header>
<article class="wh-article wh-article-info wh-log-prolist">
	<div class="wh-container">
		<div class="wh-article-lists">
			<c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc" />
				<ul id="proListUl">
					<x:forEach select="$doc//list" var="lt">
						<li onclick="addClassLi(<x:out select="$lt/id/text()"/>)" id="proLi_<x:out select="$lt/id/text()"/>">
							<strong class="forum-avatar"><i class="fa fa-check-circle"></i></strong>
							<div>
								<a href="#" style="color:#3eaeff">项目编号</a>
								<input type="hidden" name="id" value="<x:out select="$lt/id/text()"/>" /> 
								<span><x:out select="$lt/code/text()" /></span>
								<p><x:out select="$lt/name/text()" /></p>
							</div>
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
			</c:if>
		</div>
	</div>
</article>
</section>
<script type="text/javascript">
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

	var selProId = '';
	var selProName = '';
	var selProCode = '';
	
	function addClassLi(id) {
		$('i').css("color","");
		$('#proLi_'+id).addClass("current").siblings().removeClass("current");
		$('#proLi_'+id+' i').css("color","#3eaeff");
		selProId = id;
		selProName = $$(".wh-article-lists .current p").html();
		selProCode = $$(".wh-article-lists .current span").html();
	}

	//列表总记录
	var maxItems = '${recordCount}';
	// 每次加载添加多少条目
	var itemsPerLoad = 15;
	//当前页页数 全局变量
	var curPage = 1;
	var loading = false;
	var qText = '';
	$$(document).on('infinite', '#sectionScroll', function() {
		// 如果正在加载，则退出
		if (loading)
			return;
		loading = true;
		lastIndex = $$('#proListUl li').length;
		setTimeout(function() {
			loading = false;
			if (lastIndex >= maxItems) {
				// 加载完毕，则注销无限加载事件，以防不必要的加载
				myApp.detachInfiniteScroll($$('#sectionScroll'));
				// 删除加载提示符
				$$('.wh-load-md').hide();
				return;
			}
			if (maxItems - lastIndex > 0) {
				curPage = curPage + 1;
				nextPage(curPage);
				return;
			}
		}, 500);
	});
	
	// 下拉刷新页面
  	var ptrContent = $$('.pull-to-refresh-content');
  
  	// 添加'refresh'监听器
  	ptrContent.on('refresh', function(e) {
	  	// 模拟2s的加载过程
	    setTimeout(function() {
	    		$$('.wh-load-md').show();
				myApp.attachInfiniteScroll($$('#sectionScroll'));
	    		$$('.wh-article-lists ul').html("");
	    		curPage=1;
			    nextPage(curPage);	
	      		myApp.pullToRefreshDone();
	    }, 1000);
	});

	function nextPage(curPage) {
		var url = '/defaultroot/worklog/nextProList.controller?curpage='+ curPage;
		$$.ajax({
				type : "post",
				url : url,
				dataType : "text",
				success : function(data) {
					var jsonData = eval("(" + data + ")");
					if(jsonData.data0.length < 15){
						myApp.detachInfiniteScroll($$('#sectionScroll'));
						// 删除加载提示符
						$$('.wh-load-md').hide();
					}
					var html = '';
					if(jsonData.data0.length>0){
						for ( var i = 0; i < jsonData.data0.length; i++) {
							html += '<li onclick="addClassLi('+jsonData.data0[i].id+')" id="proLi_'+jsonData.data0[i].id+'">'
							+ '<strong class="forum-avatar">'
							+ '<i class="fa fa-check-circle"></i>'
							+ '</strong>'
							+ '<div>'
							+ '<a href="#">项目编号</a>'
							+ '<input type="hidden" name="id" value="'+jsonData.data0[i].id+'" />'
							+ '<span>' + jsonData.data0[i].code
							+ '</span>' + '<p>'
							+ jsonData.data0[i].name + '</p>'
							+'</div>' 
							+ '</li>';
						}
						$$('.wh-article-lists ul').append(html);
					}else{
						$$('.wh-article-lists ul').html('<li>系统没有查询到相关记录</li>');
					}
				},
				error : function(xhr, status) {
					$$('.wh-article-lists ul').html('<li>系统没有查询到相关记录</li>');
					$$('.wh-load-tap').hide();
					$$('.wh-load-md').hide();
				}
		});
	}

	function yesSel() {
		if(selProId==''){
			myApp.alert('项目不得为空，请选择！');
			return false;
		}
		$$('#projectId').val(selProId);
		$$('#projectCode').val(selProCode);
		$$('#projectName').val(selProName);
		$$('#protd').val(selProName);
		hiddenContent(1);
	}
	
	//绑定查询框回车事件
    $('#searchBug').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if(/[@#\$%\^&\*]+/g.test($('#searchBug').val())){
				myApp.alert('请正确填写搜索项目名称！');
				return false;
			}
			qText = $('#searchBug').val();
			//if(qText!=''){
				selProList(1,qText);
			//}
		} 
	});
	
	function selProList(curPage,qText) {
		$$('.wh-article-lists ul').html('');
		$$('.wh-load-md').show();
		var url = '/defaultroot/worklog/selProList.controller?curpage='+ curPage +'&qText='+ qText;
		$$.ajax({
				type : "post",
				url : url,
				dataType : "text",
				success : function(data) {
					var jsonData = eval("(" + data + ")");
					maxItems = jsonData.data1;
					if(maxItems < 15){
						myApp.detachInfiniteScroll($$('#sectionScroll'));
						// 删除加载提示符
						$$('.wh-load-md').hide();
					}
					var selhtml = '';
					for ( var i = 0; i < jsonData.data0.length; i++) {
						selhtml += '<li onclick="addClassLi('+jsonData.data0[i].id+')" id="proLi_'+jsonData.data0[i].id+'">'
						+ '<strong class="forum-avatar">'
						+ '<i class="fa fa-check-circle"></i>'
						+ '</strong>'
						+ '<div>'
						+ '<a href="#">项目编号</a>'
						+ '<input type="hidden" name="id" value="'+jsonData.data0[i].id+'" />'
						+ '<span>' + jsonData.data0[i].code
						+ '</span>' + '<p>'
						+ jsonData.data0[i].name + '</p>'
						+'</div>' 
						+ '</li>';
					}
					if(selhtml !=''){
						$$('.wh-article-lists ul').html(selhtml);
					}else{
						$$('.wh-article-lists ul').html('<li>系统没有查询到相关记录</li>');
						$$('.wh-load-tap').hide();
						$$('.wh-load-md').hide();
					}
				},
				error : function(xhr, status) {
					$$('.wh-article-lists ul').html('<li>系统没有查询到相关记录</li>');
					$$('.wh-load-tap').hide();
					$$('.wh-load-md').hide();
				}
		});
	}
</script>
