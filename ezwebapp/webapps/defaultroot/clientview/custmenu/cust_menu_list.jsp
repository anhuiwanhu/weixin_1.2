<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.util.PropertyUtil"%>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<%
  String menuName = request.getParameter("menuName");
  String menuId = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("menuId")));
  //判断是否启用永中office转换附件
  String isYzOffice = PropertyUtil.getPropertyByKey("isYzOffice"); 
%>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title><%=menuName%></title>
  
</head>

<body class="theme-green">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page">
          <section class="wh-section wh-section-bottomfixed">
		  <input type="hidden"  name="menuId" value="<%=menuId%>" id="menuId"/>
            <aside class="wh-category wh-category-forum">
              <div class="wh-container">
                <div class="wh-cate-lists list-block wh-cate-planlist" id="menuContent">
                  
                </div>
              </div>
            </aside>
          </section>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript" src="<%=rootPath%>/scripts/jquery-1.8.0.min.js"></script>

  <script type="text/javascript" src="<%=rootPath%>/clientview/frameworktemplate/js/template.min.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/frameworktemplate/js/plugin/zepto.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/subClickYz.js"></script>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/common.js"></script>

  <script type="text/javascript" src="/defaultroot/clientview/template115/js/zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/clientview/template115/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
  var myApp = new Framework7({
          fastClicks: false,
  });
  var $$ = Dom7;
</script>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		loadCustMenu();
	});

    //加载菜单数据
	function loadCustMenu(){
		var menuId =$("#menuId").val();
		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/custmenu/custMenuData.controller",
			 dataType:'text',
			 data : {"menuId" : menuId},
			 success: function(data){ 
				if(!data){
        			 return;
        		}
        		var obj = eval("("+data+")");
        		if(!obj){
        			return;
        		}
             var content="";
			 if(obj.message.result=="1"){
				var groups = obj.data.menuList;
				for(var i=0;i<groups.length;i++){
				  var menuId = groups[i].menuId;
				  var menuName = groups[i].menuName;   
				  var hasacc1="";
				  if(groups[i].actionType =="1"){				   
					 hasacc1 = "downloadFile('"+groups[i].menuHtmlLink+"','"+groups[i].menuFileLink+"','"+groups[i].isftp+"');";
				   }else if(groups[i].actionType =="2"){
					 hasacc1 = "goStartFlow('"+groups[i].menuStartFlow.type+"','"+groups[i].menuStartFlow.formId+"','"+groups[i].menuStartFlow.processId+"','"+groups[i].menuStartFlow.processName+"','"+groups[i].menuId+"','"+groups[i].menuName+"');";
				   }else if(groups[i].actionType =="3"){
					 hasacc1 = "goDataList('"+groups[i].menuId+"','"+groups[i].menuName+"');";
				   }else if(groups[i].actionType =="4"){
					 hasacc1 = "goSSOLink('"+encodeURIComponent(groups[i].menuAction)+"');";
				   }
                 var con ="";//无下级菜单右边不显示展开
                 if(groups[i].child.length>0){
					 con='<a href="#" class="item-content item-link">';
				 }else{
					 con='<a href="#" class="item-content item-link notip">';
				 }
				 content += '<ul>'
                    +'<li class="accordion-item">'
                       +con
                       +'  <p>'
                         +'  <strong onclick="'+hasacc1+'">'+menuName+'</strong>'
                       +'  </p>'
                      +' </a>'
					  +createItem(groups[i].child)                  
                    +' </li>'
                  +' </ul>';

			 }
			 //alert(content);
			 $("#menuContent").append(content);
             }   

			 },error: function(xhr, type){
				 myApp.alert('数据查询异常！');
			 }

		});

	}

	function createItem(groups){
		var itemStr = '';
		if(groups != null){
			
			for(var i =0;i<groups.length;i++){			
			  var menuId = groups[i].menuId;
			  var menuName = groups[i].menuName;
			  var hasacc1="";
              if(groups[i].actionType =="1"){				 
				   hasacc1 = "downloadFile('"+groups[i].menuHtmlLink+"','"+groups[i].menuFileLink+"','"+groups[i].isftp+"');";				 
			   }else if(groups[i].actionType =="2"){
				 hasacc1 = "goStartFlow('"+groups[i].menuStartFlow.type+"','"+groups[i].menuStartFlow.formId+"','"+groups[i].menuStartFlow.processId+"','"+groups[i].menuStartFlow.processName+"','"+groups[i].menuId+"','"+groups[i].menuName+"');";
			   }else if(groups[i].actionType =="3"){
				 hasacc1 = "goDataList('"+groups[i].menuId+"','"+groups[i].menuName+"');";
			   }else if(groups[i].actionType =="4"){
				 hasacc1 = "goSSOLink('"+encodeURIComponent(groups[i].menuAction)+"');";
			   }	   
			   var con ='';
			   if(groups[i].child.length>0){
				 con='<a id="a_tmp" href="#" class="item-content item-link">';
			   }else{
				 con='<a id="a_tmp" href="#" class="item-content item-link notip">';
			   }	
			   itemStr += '<div class="accordion-item-content">'
				 +'<div class="wh-cate-lists">'
				  +'<ul>'
					 +'<li class="accordion-item">'
					 
					   +con   
						 +'<p>'
						 +'  <strong onclick="'+hasacc1+'">'+menuName+'</strong> '
						 +'</p>'
					  +' </a>'
					 + createItem(groups[i].child)
					 +'</li>'
				   +'</ul>'
				 +'</div>'
			  +' </div>';
			}
			
		}
		
		if(itemStr==''){
		     itemStr = '<div class="accordion-item-content">'
			 +'<div class="wh-cate-lists">'
			  +'<ul>'
				 +'<li class="accordion-item">'
					 +'<p>'
					 +'  <strong></strong> '
					 +'</p>'
				  +' </a>'
				 +'</li>'
			   +'</ul>'
			 +'</div>'
		  +' </div>';
		}

		return itemStr;
	}

    function downloadFile(menuHtmlLink,menuFileLink,isftp){

	  $.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/getOpenFileUrl_New.controller",
			 dataType:'json',
			 data : {"fileName": menuHtmlLink,"name":menuFileLink,"path":"customize"},
			 success: function(data){

				clickSubyz(data.url,$('#a_tmp'),menuHtmlLink,"customize",data.smartInUse,data.isEncrypt,data.tmpurl,data.apptype,false,'<%=isYzOffice%>');

			 },error: function(xhr, type){
				 myApp.alert('数据查询异常！');
			 }

		});
		
	}
	
	function goStartFlow(type,pageId,processId,processName,menuId,menuName){
	  if(type=="cmdNewStartFlow"){
		window.location = '<%=rootPath%>/workflow/newezform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&frommodule=menulist&menuId='+menuId+'&menuName='+encodeURI(menuName);
	  }else if(type=="cmdStartFlow"){
		window.location = '<%=rootPath%>/workflow/newform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&frommodule=menulist&menuId='+menuId+'&menuName='+encodeURI(menuName);
	  }
	}
	function goDataList(menuId,menuName){
	   window.location = "<%=rootPath%>/custmenu/custData.controller?menuId="+menuId+"&menuName="+encodeURI(menuName);
	}
	function goSSOLink(menuAction){
	  menuAction = decodeURIComponent(menuAction);
	  window.location=menuAction;
	}
		

</script>
</html>
