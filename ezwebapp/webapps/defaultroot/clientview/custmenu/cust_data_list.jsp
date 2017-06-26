<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>
<%@ include file="../common/taglibs.jsp" %>
<%
  String menuName = EncryptUtil.htmlcode(request.getParameter("menuName"));
  String menuId = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("menuId")));
%>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title><%=menuName%></title>
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="<%=rootPath%>/clientview/template/css/template.webapp-style.min.css" /> 
</head>

<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-document">
          <section id="sectionScroll" class="wh-section infinite-scroll wh-section-bottomfixed"">
		    <input type="hidden"  name="menuId" value="<%=menuId%>" id="menuId"/>
			<input type="hidden"  name="menuName" value="<%=menuName%>" id="menuName"/>
			<input type="hidden"  name="cust_queryField" value="${cust_queryField}" id="cust_queryField"/>
			<input type="hidden"  name="cust_queryText" value="${cust_queryText}" id="cust_queryText"/>
            <header id="searchBar" class="wh-search">
              <div class="wh-container">
                <div class="wh-search-input" id="serchDiv">
                  <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init searchbar-active">
                    <label class="fa fa-search" for="search"></label>
                    <input id="searchBug" type="search"  placeholder="搜索信息标题" onfocus="searchList()" style="text-indent: 2rem;" >
                    <a href="#" class="searchbar-cancel">取消</a>
                  </form>
                </div>
              </div>
            </header>
			<section class="" id="searchType">
			  
		    </section>
            <div class="webapp-document">
              <div class="doc-list">
                <div class="list-block" >
                  <ul class="webapplist" id="listul">
                    
                  </ul>
				  
                </div>
              </div>
            </div>
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
          </section>
          <footer class="wh-footer wh-footer-forum">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix" style="float: none;" id="but_cmdAdd">
                    <a href="#" data-panel="right" class="open-panel panel-return" id="cmdAdd">新增</a>
                  </div> 
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div> 
  <script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
  <script>
  var myApp = new Framework7();

  var $$ = Dom7;

  // 清除搜索区域焦点bug
  $$(document).on('touchmove', function() {
    if ($$("#searchBug").is(":focus")) {
      $$("#searchBug").blur(); //主动清除焦点
      $$("#searchBug").val("");
    }
  });

  // 搜索焦点时
  $$('#searchBug').on('click', function() {
    if ($$('#list-con li').hasClass('hidden-by-searchbar')) {
      $$('.wh-load-md').hide();
      $$('.wh-load-tap').hide();
    }
  });

  function searchList(){
	var menuId =$("#menuId").val();
	var menuName =$("#menuName").val();

	window.location = "<%=rootPath%>/custmenu/custDataSearchList.controller?menuId="+menuId+"&menuName="+encodeURI(menuName);
  }

  $(document).ready(function(){
	  $("#searchDiv").hide();
	  $("#but_cmdAdd").hide();
	  loadDataList(1);
  
  });

  var maxItems ="";
  var loading = false;
  //当前页页数 全局变量
  var curPage = 1;

  //获取页面数据
  function loadDataList(curPage){
	  var url = '<%=rootPath%>/custmenu/getCustDataList.controller?curpage='+curPage;
	  var menuId =$("#menuId").val();
      var cust_queryField = document.getElementById("cust_queryField").value;
	  var cust_queryText = document.getElementById("cust_queryText").value;
	  if(cust_queryText != '' &&　curPage == '1'){
		  var htmlcon ='';
		  var arr = cust_queryText.substring(0,cust_queryText.length-1).split('|');
		  var showval ='';
		  for(var a=0;a<arr.length;a++){		
			var _tmp = arr[a].split(";;");////下拉框取;;后面的显示值
			if(_tmp.length == 1){
			  showval =_tmp[0];
			}else{
			  showval =_tmp[1];   
			}
			htmlcon+='<span style="height: 2rem;line-height: 2rem;border: 1px solid #ccc;padding: 0 1rem;font-size: 1.3rem;margin-right: 1rem;">'+showval+'</span>';
		  }
		 
		  htmlcon+='<p>查询结果如下：</p>';
		  $("#searchType").attr("class","wh-plan-head");
		  $("#searchType").append(htmlcon);
	  }
	  $$.ajax({
		  type: "post",
		  url: url,
		  dataType: "text",
		  data : {"menuid" : menuId,"cust_queryField" : cust_queryField,"cust_queryText" : cust_queryText},
		  success: function(data) {
			var obj = eval("("+data+")");
			 if(obj.message.result=="1"){
				 maxItems = obj.data.recordCount;
                 if(obj.data.middlButton.button){
			       var type = obj.data.middlButton.button.type;
			       var formId = obj.data.middlButton.button.formId;
			       if(type=='cmdAdd'){
			       		$('#cmdAdd').click(function(){ 
							go_CmdAdd('0',formId);
						});
			            $('#but_cmdAdd').show();
			       }else if(type=='cmdNewAdd'){
			            var formCode = obj.data.middlButton.button.formCode;
                        $('#cmdAdd').click(function(){ 
							go_newCmdAdd('new',formId,formCode);
					    });
			            $('#but_cmdAdd').show();

			       }else if(type=='cmdStartFlow'){
					 var fid = formId;
			         var processId = obj.data.middlButton.button.processId;
			         var processName = obj.data.middlButton.button.processName;
					 $('#cmdAdd').click(function(){ 
						go_CmdFlow(fid.replace("new\\$",""),processId,processName);
					 });
			         $('#but_cmdAdd').show();
			       }else if(type=='cmdNewStartFlow'){
					 var fid = formId;
			         var processId = obj.data.middlButton.button.processId;
			         var processName = obj.data.middlButton.button.processName;
					 $('#cmdAdd').click(function(){ 
						go_CmdNewFlow(fid.replace("new\\$",""),processId,processName);
					 });
			         $('#but_cmdAdd').show();
			       }
			       
			     }
			     if(obj.data.searchFields&&
			        obj.data.searchFields!=""&&
			        obj.data.searchFields!=" "&&
			        obj.data.searchFields!="[]"&&
			        obj.message.result=="1"&&
			        obj.data.datalist){
                    $("#searchDiv").show();
			     }
				 var htmlContent ="";
				 if(obj.message.result=="1"&&
			        obj.data.datalist != null){
			        var formId = obj.data.viewButton.formId;
			        var pageCount = obj.data.pageCount;
                    var groups = obj.data.datalist;
                    if(groups instanceof Array){
	                    for(var i=0;i<groups.length;i++){
				            var infoId=groups[i][0];
				            var title="";
				            for(var j=1;j<groups[i].length;j++){
								var t1 = groups[i][j].replace(/\&/g,'&amp;');
						        t1 = t1.replace(/\</g,'&lt;');
				                title += "<p>"+t1+"</p>";
				            }
				            htmlContent +=  '<li class="swipeout" onclick="go_viewForm(\''+formId+'\',\''+infoId+'\');">'+title+ '</li>';

				        }
						htmlContent = htmlContent.replace('/&amp;','').replace('nbsp;','').replace('amp;','');
						$("#listul").append(htmlContent);
                    }else if(groups instanceof Object){
						var infoId=groups.list[0];
						var title="";
						for(var j=1;j<groups.list.length;j++){
							var t1 = groups.list[j].replace(/\&/g,'&amp;');
						    t1 = t1.replace(/\</g,'&lt;');
						    title += "<p>"+t1+"</p>";
						}
						
						htmlContent +=  '<li class="swipeout" onclick="go_viewForm(\''+formId+'\',\''+infoId+'\');">'+title+ '</li>';
                        htmlContent = htmlContent.replace('/&amp;','').replace('nbsp;','').replace('amp;','');
						$("#listul").append(htmlContent);
                    }
					$$('.wh-load-md').hide();
					
			     }else{
					htmlContent = '<li class="swipeout"><p>搜索不到匹配的记录</p></li>';
					$("#listul").append(htmlContent);
					$$('.wh-load-md').hide();
			     }

			 }

		  },error: function(xhr, status) {
			myApp.alert('数据查询异常！');
		  }
	  });
  
  }

    $$(document).on('infinite', '#sectionScroll', function() {
		   // 如果正在加载，则退出
		    if (loading) return;
		    loading = true;
		    lastIndex = $$('#listul li').length;
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
				    	//alert(curPage);
				        curPage = curPage+1;
						$$('.wh-load-md').show();
				        loadDataList(curPage);
						
				        return;
				    }
		    }, 500);
	 });

	 function go_viewForm(formId,infoId) {
		window.location = "<%=rootPath%>/custmenu/getCusDataView.controller?formId="+formId+"&infoId="+infoId;
	 }

	 function searchList(){
        var menuId =$("#menuId").val();
		var menuName =$("#menuName").val();

		window.location = "<%=rootPath%>/custmenu/custDataSearchList.controller?menuId="+menuId+"&menuName="+encodeURI(menuName);
	 }
     //新增表单
     function go_CmdAdd(formtype,formId){
		var menuId =$("#menuId").val();
		var menuName =$("#menuName").val();
		window.location = "<%=rootPath%>/custmenu/custDataAdd.controller?pageId="+formId+"&cust_formType="+formtype+"&menuId="+menuId+"&menuName="+encodeURI(menuName)+"&processId=''";
	 }
    
	//新表单新增
	function go_newCmdAdd(formtype,formId,formCode) {	
	   var menuId =$("#menuId").val();
	   var menuName =$("#menuName").val();
	   window.location = "<%=rootPath%>/custmenu/custDataAdd.controller?pageId="+formId+"&cust_formType="+formtype+"&menuId="+menuId+"&menuName="+menuName+"&cust_formCode="+formCode+"&processId=''";
	}
	 //老流程
	function go_CmdFlow(pageId,processId,processName) {
		var menuId =$("#menuId").val();
		var menuName =$("#menuName").val();
	   window.location = '<%=rootPath%>/workflow/newform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&frommodule=datalist&menuId='+menuId+'&menuName='+encodeURI(menuName);
	}
	//新流程
	function go_CmdNewFlow(pageId,processId,processName) {
		var menuId =$("#menuId").val();
		var menuName =$("#menuName").val();
	   window.location = '<%=rootPath%>/workflow/newezform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&frommodule=datalist&menuId='+menuId+'&menuName='+encodeURI(menuName);
	}

  </script>
</body>
