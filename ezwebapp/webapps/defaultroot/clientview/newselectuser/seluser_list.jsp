<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
	String selectType = EncryptUtil.htmlcode(EncryptUtil.sqlcode(request.getParameter("selectType")));
	String selectName = EncryptUtil.htmlcode(EncryptUtil.sqlcode(request.getParameter("selectName")));
	String selectId = EncryptUtil.htmlcode(EncryptUtil.sqlcode(request.getParameter("selectId")));
	String selectNameVal = EncryptUtil.htmlcode(EncryptUtil.sqlcode(request.getParameter("selectNameVal")));
	String selectIdVal = EncryptUtil.htmlcode(EncryptUtil.sqlcode(request.getParameter("selectIdVal")));
	String range = EncryptUtil.htmlcode(EncryptUtil.sqlcode(request.getParameter("range")));
%>
<!DOCTYPE html>
<html>
  <div class="page" data-page="page-webapp-mail">
    <section id="sectionScroll" class="wh-section infinite-scroll wh-section-bottomfixed">
      <div class="mail-todo">
      <c:if  test="${qzRes != 2}">
        <div class="app-tabheader-line clearfix">
          <!-- 关联到第一个tab, 默认激活 -->
          <div class="clearfix">
            <a href="#tab-sel1" class="tab-link active">
              <span>组织视图</span>
            </a>
            <a href="#tab-sel2" onclick="loadGroup();" class="tab-link ">
              <span>群组</span>
            </a>
          </div>
        </div>
        </c:if>
        <div class="tabs">
          <!-- Tab 1, 默认激活 -->
          <div id="tab-sel1" class="tab active">
            <!-- 搜索公用 -->
              <header id="searchBar" class="wh-search">
                 <div class="wh-container">
                   <div class="wh-search-input">
                     <form method="get" data-search-list=".list-container" data-search-in=".item-title" class="searchbar searchbar-init nomal-searchbar">
                       <label class="fa fa-search" for="search"></label>
                       <input id="queryCondition" type="search" class="nomal-search" placeholder="请输入姓名或简码查询" />
                     	<a href="#" class="searchbar-cancel"  onclick="removeSearch(this)">取消</a>
                     </form>
                   </div>
                 </div>
               </header>
              <!-- 左右滑动横条 -->
              <div class="step-todo step-select">
                  <div id="orgFlowx" class="wh-flow-x">
                      <ul id="topList">
                          <li><a href="#tab-step-over0" class="tab-link active"><span>${orgName }</span><i class="fa fa-angle-right"></i></a></li>
                      </ul>
                  </div>
                  <div class="tabs" id="orgTabs">
                      <!-- Tab 1, 默认激活 -->
                      <div id="tab-step-over0" class="tab active">
                          <div class="select-top">
                              <div onclick="homeSelect(this);" class="select-home">
                                  <span>我的部门</span>
                                  <span class="bold">·</span>
                                  <span>${orgName }</span>
                              </div>
                              <div class="my-part-tree list-block" id="myUserLi">
                                  <ul>
                                  	<c:if test="${not empty docXml}">
                                  	<x:parse xml="${docXml}" var="personDoc"/>
                                  	  <c:set var="recordcount"><x:out select="$personDoc//result/text()" /></c:set>
										<c:if test="${recordcount==0}">
											<li>系统没有查询到任何记录！</li> 
										</c:if>
										<x:forEach select="$personDoc//list" var="n" varStatus="status">
											<c:set var="empId"><x:out select="$n/userId/text()"/></c:set>
											<c:set var="empLivingPhoto"><x:out select="$n/empLivingPhoto/text()"/></c:set>
											<c:set var="empName"><x:out select="$n/userName/text()"/></c:set>
											<c:set var="orgName"><x:out select="$n/orgNameString/text()"/></c:set>
											<c:set var="sex"><x:out select="$n/sex/text()"/></c:set>
											<li id="userLi_${empId }" data-empid="${empId }," data-empname="${empName }," <c:if test="${sex==0 || sex ==-1}">class="man userLi_${empId }"</c:if> <c:if test="${sex==1}">class="lady userLi_${empId }"</c:if>>
	                                          <a href="">
	                                              <span>${empName }</span>
	                                          </a>
	                                      </li>
										</x:forEach>
                                       </c:if>
                                  </ul>
                              </div>
                          </div>
                          <div id="mainOrg" class="select-cont">
                              
                          </div>
                      </div>
                      
                      <!-- Tab 2 -->
                      <div id="userList" class="tab">
                          <div class="select-top">
                              <div class="my-part-tree list-block my-part-treeo">
                                  <ul id="userListLi">
                                  </ul>
                                  <aside class="wh-load-box" style="display: block">
					     			<div class="wh-load-tap">上滑加载更多</div>
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
                      
                  </div>
              </div>
              <!-- 左右滑动横条 -->
          </div>
          <!-- Tab 2 -->
          <div id="tab-sel2" class="tab">
            <!-- 搜索公用 
              <header class="wh-search">
                  <div class="wh-container">
                      <div class="wh-search-input">
                          <form class="searchbar searchbar-init nomal-searchbar">
                              <label class="fa fa-search" for="search"></label>
                              <input id="searchBug" type="search" class="nomal-search" placeholder="请输入姓名或者拼音搜索" />
                          </form>
                      </div>
                  </div>
              </header>-->
              <!-- 左右滑动横条 -->
              <div id="groupFlowx" class="step-todo step-select">
                 <div class="wh-flow-x">
                      <ul id="topListGroup">
                          <li><a href="#groupTab0" class="tab-link active"><span><i class="fa fa-home"></i></span><span class="sx-sle">|</span></a></li>
                          
                      </ul>
                  </div>
                  <div id="groupTabs"  class="tabs">
                      <!-- Tab 1, 默认激活 -->
                      <div id="groupTab0" class="tab active">
                          <div id="mainGroup" class="select-cont">
                             
                          </div>
                      </div>
                  </div>
              </div>
              <!-- 左右滑动横条 -->
          </div>
        </div>
      </div>
    </section> 
    <footer class="wh-footer wh-footer-forum">
      <div class="wh-container">
        <div class="wh-footer-btn row">
          <div class="webapp-footer-linebtn">
            <div class="fl clearfix">
              <a href="javascript:clearSelect();" class="sel-per">清空</a>
              <a href="javascript:confirmSelect();" class="sel-per">确定</a>
            </div>
            <div class="fr clearfix">
            <a href="javascript:Selected();" class="sel-per open-popover"  id="selectedNum">已选 0</a>
            </div>
          </div>
        </div>
      </div>
    </footer>
    <input type="hidden" value="<%=range %>" id="range"/>
	<input type="hidden" value="<%=selectType %>" id="selectType"/>
	<input type="hidden" value="<%=selectName %>" id="selectName"/>
	<input type="hidden" value="<%=selectId %>" id="selectId"/>
	<input type="hidden" value="<%=selectNameVal %>" id="selectNameVal"/>
	<input type="hidden" value="<%=selectIdVal %>" id="selectIdVal"/>
  </div>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript">
	//Export DOM7 to local variable to make it easy accessable
	var myApp = new Framework7({
	          fastClicks: false,
	    });
	var $$ = Dom7;
	// 点击第一个页签隐藏头部
	$$("#orgFlowx ul li").eq(0).click(function(){
		 bindEmpSelect();
	     $$("#orgFlowx").css('display','none' );
	     
	})
	
	// 点击第一个页签隐藏头部
	$$("#groupFlowx ul li").eq(0).click(function(){
	     $$("#groupFlowx .wh-flow-x").css('display','none' );
	})
	
	//选择表单id值的id
	var selectId = $('#selectId').val();
	//选择表单name值的id
	var selectName = $('#selectName').val();
	//单选/多选标识 0：单选，1：多选
	var selectType = $('#selectType').val();
	//已选择的用户名
	var selectNameVal = $("#selectNameVal").val();
	//已选择的用户id
	var selectIdVal = $("#selectIdVal").val();
	var idValArray = selectIdVal.split(',');
	var range = $("#range").val();
	var selectedNum = idValArray.length-1;
	var selGroupOrgId = "";//记录已选中的组织id，便于回显组织前的复选框
	var rangeSelectIds='';
	var curpage = 0;
	$(function(){
		for(var i=0,length=idValArray.length; i<length; i++){
			if(idValArray[i]){
				rangeSelectIds += "$"+idValArray[i]+"$";
			}
		}
		
		var groupOrgFlag = sessionStorage.getItem("selGroupOrgId_"+selectId);
		if(groupOrgFlag != null &&　groupOrgFlag　!=""){
			selGroupOrgId = groupOrgFlag;
		}
		
		if(range!="*0*"){
			$$(".app-tabheader-line").hide();
			clearMainCss();
			loadPersonData(0);
		}else{
			bindEmpSelect();
			loadParentOrgData();
		}
		//bindEmpSelect();
	});
	
	//打开已选择人员列表
	function Selected(){
		$("#selectedPer").empty();
		loadSelectedPer(rangeSelectIds);
    	myApp.openPanel('right');
	}
	
	//加载已选数据
	function loadSelectedPer(rangeSelectIds){
		var url = '/defaultroot/newperson/getPersonList.controller?range='+rangeSelectIds;
	        $.ajax({
	            type: 'post',
	            url: url,
	            dataType: 'text',
	            success: function(data){
					var jsonData;
	               	if(data){
	              	 	jsonData = eval("("+data+")");
	              	 	var personArray = jsonData.data0;
		                var result = '';
		                if(personArray){
		                	var empLivingPhoto = '';
						    for(var i = 0; i < personArray.length; i++){
						    	if(personArray[i].empLivingPhoto && 'null' != personArray[i].empLivingPhoto){
						    		var arr = personArray[i].empLivingPhoto.split('.');
						    		var fileName = personArray[i].empLivingPhoto;
						    		var id = arr[0];
						    		loadImg(fileName,id);
									empLivingPhoto = "<div class='select_img'><img name='"+id+"'></div>";
						    	}else{
						    		empLivingPhoto = "<div class='select_img'><img src='/defaultroot/clientview/images/user3.png'/></div>";
						    	}
								result += "<li onclick='checkYxUser(this,"+personArray[i].userId+",\""+personArray[i].userName+"\");' class='swipeout my-part-tree'><i class='fa fa-check-circle fa-check-circle-active' name="+personArray[i].userId+","+"></i>";
								result += "<a href='###' class='swipeout-content item-content'>";
								result += "<div>"+empLivingPhoto;
								result += "<span class='people-name' style='font-size: 1rem;'>"+personArray[i].userName+"</span><span style='font-size: 1rem;'>"+personArray[i].orgNameString+"</span>";
								result += "</div></a></li>";
						  	}
		                }
		                if(!result){
							result = '';
						}
						$("#selectedPer").append(result);
	               	}else{
	               	}
	            },
	            error: function(xhr, type){
	                $(".wh-load-tap").html("加载失败！");
	            }
	        });
	}
	
	function checkYxUser(obj,empId,empName){
		var empId1 = empId+",";
		var empName1 = empName+",";
		var thisObj = $(obj).find("i");
		if($(thisObj).hasClass('fa-check-circle-active')){
			selectedNum--;
			selectIdVal = selectIdVal.replace(empId1,'');
			selectNameVal = selectNameVal.replace(empName1,'');
			rangeSelectIds = rangeSelectIds.replace("$"+empId1.substring(0,empId1.length-1)+"$",'');
			$(thisObj).removeClass('fa-check-circle-active');
			$(".userLi_"+empId).removeClass('checked');
		}else{
			selectedNum++;
			selectIdVal += empId1;
			selectNameVal += empName1;
			rangeSelectIds += "$"+empId1.substring(0,empId1.length-1)+"$";
			$(".userLi_"+empId).addClass('checked');
			$(thisObj).addClass('fa-check-circle-active');
		}
		$("#selectedNum").html("已选"+selectedNum);
	}
	
	//关闭已选列表
	$$('.views').on('click', function (e) {
		$("#selectedPer").empty();
    	myApp.closePanel();
    	bindEmpSelect();
  	});
	
	//加载父组织数据
	function loadParentOrgData(){
		$.ajax({
            type: 'post',
            url: '/defaultroot/newperson/getParentOrg.controller',
            dataType: 'text',
            success: function(data){
        		if(data){
        			var jsonData=eval("("+data+")");
        			var orgArray = jsonData.data0;
	                if(orgArray){
	                	var orgHtml = '';
		                for(var i = 0; i < orgArray.length; i++){
		                	var orgName =  orgArray[i].orgName;
		                	if(orgName.length > 16){
		                		orgName = orgName.substring(0,15)+'...';
		                	}
		                	//群组对应id用于勾选后反选
		                	var orgSelId = 'orgSel'+orgArray[i].orgId;
		                	var checkHtml = '<div id='+orgSelId+' onclick="checkSelOrg(this,'+orgArray[i].orgId+',\'0\',\''+orgArray[i].orgName+'\');"  class="select-check"></div>';
		                	var selcHtml ='<div class="select-tree">';
		                	if(selectType == '0'){//单选
		                		checkHtml = '<div class="select-check"></div>';
		                		selcHtml ='<div class="select-tree no-r-icon">';
		                	}
		                	orgHtml +=selcHtml
                                    +'<div onclick="loadOrgUserData('+orgArray[i].orgId+',this,\'0\',\''+orgArray[i].orgName+'\',\'0\');" class="wh-cengji">'
                               		+'<span>'+orgName+'</span>'
                            		+'</div>'
                           			+ checkHtml
                      				+'</div>'
		                }
		                $("#mainOrg").html(orgHtml);
		                binNextClick();
		                setCheckBox();
	                }
        		}else{
	            }
            },
            error: function(xhr, type){
                alert('数据查询异常！');
            }
        });
	}
	
	//绑定用户选择点击事件
	function bindEmpSelect(){
		var empId = '';
		var empName = '';
		// 主页面顶部勾选事件
		$(".my-part-tree ul li").unbind('click');
		$(".my-part-tree ul li").click(function(){
		      if($$(this).hasClass("checked")){
		    	  selectedNum--;
		          //$$(this).removeClass("checked");
		      }else{
		    	  selectedNum++;
		          //$$(this).addClass("checked");
		      }
		      $("#selectedNum").html("已选"+selectedNum);
		      empId = $(this).data('empid');
	    	  empName = $(this).data('empname');
	    	  //单选时选择方式
	    	  if(selectType == '0'){//单选
	    		  if($$(this).hasClass("checked")){
	    			  $('.my-part-tree ul li').removeClass('checked');
	    			  selectIdVal = '';
		        	  selectNameVal = '';
		        	  rangeSelectIds = '';
	    			  $("#selectedNum").html("已选"+0);
	    		  }else{
	    			  $('.my-part-tree ul li').removeClass('checked');
	    			  $$(this).addClass("checked");
		        	  selectIdVal = empId;
		        	  selectNameVal = empName;
		        	  rangeSelectIds = "$"+empId.substring(0,empId.length-1)+"$";
		        	  selectedNum=1;
		        	  $("#selectedNum").html("已选"+selectedNum);
	    		  }
	    	}else if(selectType == '1'){//多选 
	    		if($$(this).hasClass("checked")){
	    			$(this).removeClass('checked');
	    			var val = $("#hide_"+empId.substring(0,empId.length-1)).val();
	    			var zzId ="orgSel"+val;
	    			$("#"+zzId).removeClass("sel-kik");
	    			selectIdVal = selectIdVal.replace(empId,'');
	    			selectNameVal = selectNameVal.replace(empName,'');
	    			rangeSelectIds = rangeSelectIds.replace("$"+empId.substring(0,empId.length-1)+"$",'');
	    		}else{
	    			$$(this).addClass("checked");
			        if(selectIdVal.indexOf(empId) == -1){
		    			selectIdVal += empId;
		    			selectNameVal += empName;
		    			rangeSelectIds += "$"+empId.substring(0,empId.length-1)+"$";
			        }
	    		}
	    	}
		})
		//回显已勾选的数据
		setSelectVal();
	}
	
	//我的部门显示隐藏
	function homeSelect(obj){
		// 主页面顶部下拉事件
	    if($$(obj).hasClass("open")){
	       $$(obj).removeClass("open");
	      $$('#myUserLi').css('display','none' );
	    }else{
	       $$(obj).addClass("open");
	       $$('#myUserLi').css('display','block' );
	    }
	}
	
	//回显已勾选的数据
	function setSelectVal(){
		idValArray = selectIdVal.split(',');
		if(idValArray){
			for(var i=0,length=idValArray.length; i<length; i++){
				$(".userLi_"+idValArray[i]).addClass('checked');
			}
		}
		$("#selectedNum").html("已选"+selectedNum);
	}
	
	//清空选人
	function clearSelect(){
		$(":checkbox").removeAttr("checked");
		$(".my-part-tree ul li").removeClass("checked");
		$("#orgTabs .select-check").removeClass("sel-kik");
		$("#tab-sel2 .select-check").removeClass("sel-kik");
		selectedNum = 0;
		selectNameVal = '';
	    selectIdVal = '';
	    rangeSelectIds = '';
	    idValArray = '';
	    selGroupOrgId = '';
	    $("#selectedNum").html("已选"+selectedNum);
	}
	
	//确定
	function confirmSelect(){
		$("input[id='"+selectId+"']").val(selectIdVal);
		$("input[id='"+selectName+"']").val(selectNameVal);
		sessionStorage.setItem("selGroupOrgId_"+selectId,selGroupOrgId);
		if(typeof ( selectCallBack ) == "function" ){
			selectCallBack( $("input[id='"+selectName+"']"),$("input[id='"+selectId+"']") );
		}
		hiddenContent(1);
	}
	
	//组织选择事件
	function checkSelOrg(obj,parentOrgId,nowTab,liOrgName){
		if($$(obj).hasClass("sel-kik")){
			  var repId = 'orgSel'+parentOrgId+ ",";
			  selGroupOrgId = selGroupOrgId.replace(repId,'');
			  loadOrgUserData(parentOrgId,obj,nowTab,liOrgName,2);
	          $$(obj).removeClass("sel-kik");
	      }else{
	    	  selGroupOrgId += 'orgSel'+parentOrgId+ ",";
	    	  loadOrgUserData(parentOrgId,obj,nowTab,liOrgName,1);
	          $$(obj).addClass("sel-kik");
	      }
	}
	
	//加载父组织数据
	function binNextClick(){
		// 主页面下面的勾选事件
		/*$$(".select-cont .select-check").click(function(event){
		    if($$(this).hasClass("sel-kik")){
		          $$(this).removeClass("sel-kik");
		      }else{
		          $$(this).addClass("sel-kik");
		      }
		})*/
		
		$$("#orgFlowx ul li").click(function(){
			 var tabId = $$(this).find('a').attr("href"); 
			 $$("#orgTabs .tab").removeClass("active");
			 $$("#"+tabId).addClass("active");
		     $$(this).nextAll().remove();
		})
		
	}
	
	//加载自组织人员及组织
	function loadOrgUserData(parentOrgId,obj,nowTab,liOrgName,showFlag){
    	var showCss = '';
    	var tabId = "tab-step-over"+parentOrgId;
    	if(showFlag == 0){
			showCss = 'active';
			if(liOrgName.length > 12){
				liOrgName = liOrgName.substring(0,11)+'...';
	    	}
			var li = '<li><a href='+tabId+' class="tab-link active"><span>'+liOrgName+'</span><i class="fa fa-angle-right"></i></a></li>';
			$('#topList').append(li);
			$("#tab-step-over"+nowTab).removeClass("active");
		}
		var ulId = "orgUl_"+parentOrgId;
		if(nowTab == 0 && showCss=='active'){
			$$("#orgFlowx").css('display','block');
		}
		if($("#"+tabId).css("display") == "none"){
			loadUserFlag = false;
			if(showFlag == 0){
				$$("#orgTabs .tab").removeClass("active");
	    		$$("#"+tabId).addClass("active");
	    		bindEmpSelect();
	    		 binNextClick();
			}else{
				loopSel(ulId,showFlag);
			}
    		return;
    	}
		$.ajax({
            type: 'post',
            url: '/defaultroot/newperson/getOrgAndPersonByOrgId.controller?parentOrgId='+parentOrgId+'&range='+range,
            dataType: 'text',
            success: function(data){
        		if(data){
					//用于区分页签为联系人还是组织
					detailType = "org";

        			var jsonData = eval("("+data+")");
        			var orgArray = jsonData.data0;
        			var personArray = jsonData.data1;
        			if(orgArray && personArray){
        				if(orgArray.length==0 && personArray.length==0){
        					//myApp.alert('没有下级组织与人员！');
        					$('#orgTabs').append('<div id='+tabId+'  class="tab '+showCss+'"><div  style="padding: 1rem; font-size: 17px;"  class="select-cont">系统未查询到相关记录!</div></div>');
        					binNextClick();
							return;
        				}
        			}
	                var result = '<div id='+tabId+'  class="tab '+showCss+'">';
	                var personLis = '';
                	if(personArray){
                		personLis = '<div class="select-top"><div class="my-part-tree list-block my-part-treeo"><ul id='+ulId+'>';
				        for(var j=0,length=personArray.length;j<length;j++){
				        	//id='userLi_'+personArray[j].userId
				        	if(showFlag == 1){
	    						empId = personArray[j].userId+',';
	    						empName = personArray[j].userName+',';
	    						if(selectIdVal.indexOf(empId) == -1){
	    							selectedNum = selectedNum + 1;
	    							selectIdVal += empId;
	    							selectNameVal += empName;
	    							rangeSelectIds += "$"+empId.substring(0,empId.length-1)+"$";
	    						}
	    					}else if(showFlag == 2){
	    						empId = personArray[j].userId+',';
	    						empName = personArray[j].userName+',';
	    						if(selectIdVal.indexOf(empId) >= 0){
	    							selectedNum = selectedNum -1;
	    							selectIdVal = selectIdVal.replace(empId,'');
	    			    			selectNameVal = selectNameVal.replace(empName,'');
	    			    			rangeSelectIds = rangeSelectIds.replace("$"+empId.substring(0,empId.length-1)+"$",'');
	    						}
	    					}
				        	loadUserFlag = false;
				        	var liId = "userLi_"+personArray[j].userId;
				        	var sexClass = "man";
				        	if(personArray[j].sex == 1){
				        		sexClass = "lady";
				        	}
				        	var hideId = "hide_"+personArray[j].userId;
				        	personLis +='<li id='+liId+'  data-empid='+personArray[j].userId+","+' data-empname='+personArray[j].userName+','+'  class="'+sexClass+' '+liId+'">'
				        			  +'<input type="hidden" name='+hideId+' id='+hideId+' value='+parentOrgId+'>'
	                           		  +'<a href="">'
	                              	  +'<span>'+personArray[j].userName+'</span>'
	                           		  +'</a>'
	                      			  +'</li>';
				        }
				        personLis += '</ul></div></div>';
				    }
                	var orgLis = '';
                	if(orgArray){
                		orgLis = '<div class="select-cont">';
		                for(var i = 0; i < orgArray.length; i++){
		                	var orgName =  orgArray[i].orgName;
		                	if(orgName.length > 16){
		                		orgName = orgName.substring(0,15)+'...';
		                	}
		                	//群组对应id用于勾选后反选
		                	var orgSelId = 'orgSel'+orgArray[i].orgId;
		                	var checkHtml = '<div id='+orgSelId+' onclick="checkSelOrg(this,'+orgArray[i].orgId+','+parentOrgId+',\''+orgArray[i].orgName+'\');" class="select-check"></div>';
		                	var selcHtml ='<div class="select-tree">';
		                	if(selectType == '0'){//单选
		                		checkHtml = '<div class="select-check"></div>';
		                		selcHtml ='<div class="select-tree no-r-icon">';
		                	}
		                	orgLis +=selcHtml
                                    +'<div onclick="loadOrgUserData('+orgArray[i].orgId+',this,'+parentOrgId+',\''+orgArray[i].orgName+'\',\'0\');" class="wh-cengji">'
                               		+'<span>'+orgName+'</span>'
                            		+'</div>'
                           			+ checkHtml
                      				+'</div>'
		                }
		                orgLis += '</div>';
	                }
                	result +=personLis + orgLis+'</div>';
                	$('#orgTabs').append(result);
                	binNextClick();
                	setCheckBox();
					bindEmpSelect();
        		}else{
        			//TODO
	            }
            },
            error: function(xhr, type){
                alert('数据查询异常！');
            }
        });
	}
	
	//打开群组页签
	function loadGroup() {
		loadGruopClassData();
	}
	
	//加载群组分类数据
	function loadGruopClassData(){
		$.ajax({
            type: 'post',
            url: '/defaultroot/newperson/getGoupList.controller',
            dataType: 'text',
            success: function(data){
        		var jsonData = eval("("+data+")");
    			var classArray = jsonData.data0;
    			if(classArray.length>0){
    				var classHtml = ''
    				for(var i = 0; i < classArray.length; i++){
    					var className =  classArray[i].className;
	                	if(className.length > 16){
	                		className = orgName.substring(0,15)+'...';
	                	}
	                	classHtml +='<div class="select-tree no-r-icon">'
                                +'<div onclick="loadGruopData('+classArray[i].classId+',this,\'0\',\''+classArray[i].className+'\');" class="wh-cengji">'
                           		+'<span>'+className+'</span>'
                        		+'</div>'
                       			+ '<div class="select-check"></div>'
                  				+'</div>'
    				}
    				$('#mainGroup').html(classHtml);
    			}
            },
            error: function(xhr, type){
                $(".wh-load-tap").html("加载失败！");
            }
        });
	}
	
	//加载分类下的群组
	function loadGruopData(classId,obj,nowTab,liGroupName){
    	if(liGroupName.length > 12){
    		liGroupName = liGroupName.substring(0,11)+'...';
    	}
		var tabId = "groupTabcl"+classId;
		var li = '<li><a href='+tabId+' class="tab-link"><span>'+liGroupName+'</span><span class="sx-sle">|</span></a></li>';
		$('#topListGroup').append(li);
		$$("#groupFlowx .wh-flow-x").css('display','block');
		if($("#"+tabId).css("display") == "none"){
			$$("#groupTabs .tab").removeClass("active");
    		$$("#"+tabId).addClass("active");
    		binNextGruupClick();
    		return;
    	}	
		$("#groupTab"+nowTab).removeClass("active");
		$.ajax({
            type: 'post',
            url: '/defaultroot/newperson/getGoupByClassId.controller?classId='+classId,
            dataType: 'text',
            success: function(data){
        		var jsonData = eval("("+data+")");
    			var groupArray = jsonData.data0;
    			if(groupArray.length>0){
    				var groupHtml = '<div id='+tabId+' class="tab active"><div class="select-cont">';
    				for(var i = 0; i < groupArray.length; i++){
    					var groupName =  groupArray[i].groupName;
	                	if(groupName.length > 16){
	                		groupName = groupName.substring(0,15)+'...';
	                	}
	                	var clId = "cl"+classId;
	                	//群组对应id用于勾选后反选
	                	var groupSelId = 'groupSel'+groupArray[i].groupId;
	                	var checkHtml = '<div id='+groupSelId+' onclick="checkSelGroup(this,'+groupArray[i].groupId+',\''+clId+'\',\''+groupArray[i].groupName+'\');" class="select-check"></div>';
	                	var selcHtml ='<div class="select-tree">';
	                	if(selectType == '0'){//单选
	                		checkHtml = '<div class="select-check"></div>';
	                		selcHtml ='<div class="select-tree no-r-icon">';
	                	}
	                	groupHtml +=selcHtml
                                +'<div onclick="loadGruopPeopleData('+groupArray[i].groupId+',this,\''+clId+'\',\''+groupArray[i].groupName+'\',\'0\');" class="wh-cengji">'
                           		+'<span>'+groupName+'</span>'
                        		+'</div>'
                        		+checkHtml
                  				+'</div>'
    				}
    				groupHtml += '</div></div>';
    				$('#groupTabs').append(groupHtml);
    				setCheckBox();
    			}
    			binNextGruupClick();
    			//bindEmpSelectGroup();
            },
            error: function(xhr, type){
            	nomore = '';
                $(".wh-load-tap").html("加载失败！");
            }
        });
	}
	
	//群组选择事件
	function checkSelGroup(obj,groupId,nowTab,liGroupName){
		if($$(obj).hasClass("sel-kik")){
			  var repId = 'groupSel'+groupId+ ",";
			  selGroupOrgId = selGroupOrgId.replace(repId,'');
			  loadGruopPeopleData(groupId,obj,nowTab,liGroupName,2);
	          $$(obj).removeClass("sel-kik");
	      }else{
	    	  selGroupOrgId += 'groupSel'+groupId+ ",";
	    	  loadGruopPeopleData(groupId,obj,nowTab,liGroupName,1);
	          $$(obj).addClass("sel-kik");
	      }
	}
	
	//加载群组下的 人
	function loadGruopPeopleData(groupId,obj,nowTab,liGroupName,showFlag){
		//判断是否勾选操作，勾选不展示下级
		var showCss = '';
		var tabId = "groupTabgr"+groupId;
		if(showFlag == 0){
			showCss = 'active';
			if(liGroupName.length > 12){
	    		liGroupName = liGroupName.substring(0,11)+'...';
	    	}
			var li = '<li><a href='+tabId+' class="tab-link"><span>'+liGroupName+'</span><span class="sx-sle">|</span></a></li>';
			$('#topListGroup').append(li);
			$("#groupTab"+nowTab).removeClass("active");
		}
		var ulId =  "groupUl_"+groupId;
		$$("#groupFlowx .wh-flow-x").css('display','block');
		if($("#"+tabId).css("display") == "none"){
			if(showFlag == 0){
				$$("#groupTabs .tab").removeClass("active");
	    		$$("#"+tabId).addClass("active");
	    		bindEmpSelect();
	    		binNextGruupClick();
			}else{
				loopSel(tabId,showFlag);
				
			}
    		return;
    	}
		$.ajax({
            type: 'post',
            url: '/defaultroot/newperson/getGroupUsersByGroupId.controller?groupId='+groupId,
            dataType: 'text',
            success: function(data){
        		var jsonData = eval("("+data+")");
    			var userArray = jsonData.data0;
    			if(userArray.length>0){
    				var empLivingPhoto = "";
    				var userHtml = '<div id='+tabId+' class="tab '+showCss+'"><div class="select-top"><div class="my-part-tree my-part-treeo list-block"><ul id='+ulId+'>';
    				for(var i = 0; i < userArray.length; i++){
    					if(showFlag == 1){
    						empId = userArray[i].userId+',';
    						empName = userArray[i].userName+',';
    						if(selectIdVal.indexOf(empId) == -1){
    							selectedNum = selectedNum + 1;
    							selectIdVal += empId;
    							selectNameVal += empName;
    							rangeSelectIds += "$"+empId.substring(0,empId.length-1)+"$";
    						}
    					}else if(showFlag == 2){
    						empId = userArray[i].userId+',';
    						empName = userArray[i].userName+',';
    						if(selectIdVal.indexOf(empId) >= 0){
    							selectedNum = selectedNum -1;
    							selectIdVal = selectIdVal.replace(empId,'');
    			    			selectNameVal = selectNameVal.replace(empName,'');
    			    			rangeSelectIds = rangeSelectIds.replace("$"+empId.substring(0,empId.length-1)+"$",'');
    						}
    					}
    					//id='userLi_'+personArray[j].userId
			        	var liId = "userLi_"+userArray[i].userId;
			        	var sexClass = "man";
			        	if(userArray[i].sex == 1){
			        		sexClass = "lady";
			        	}
			        	userHtml +='<li id='+liId+'  data-empid='+userArray[i].userId+","+' data-empname='+userArray[i].userName+','+'   class="'+sexClass+' '+liId+'">'
                           		  +'<a href="">'
                              	  +'<span>'+userArray[i].userName+'</span>'
                           		  +'</a>'
                      			  +'</li>';
    				}
    				userHtml +='</ul></div></div></div>';
    				$('#groupTabs').append(userHtml);
    			}else{
    				$('#groupTabs').append('<div id='+tabId+' class="tab '+showCss+'"><div  style="padding: 1rem; font-size: 17px;"  class="select-cont">系统未查询到相关记录!</div></div>');
    			}
    			bindEmpSelect();
    			
            },
            error: function(xhr, type){
            	$('#groupTabs').append('<div id='+tabId+' class="tab '+showCss+'""><div  style="padding: 1rem; font-size: 17px;"  class="select-cont">系统未查询到相关记录!</div></div>');
            }
        });
	}

	
	//加载父组织数据
	function binNextGruupClick(){
		$$("#groupFlowx .wh-flow-x ul li").click(function(){
			 var tabId = $$(this).find('a').attr("href"); 
			 $$("#groupTabs .tab").removeClass("active");
			 $$("#"+tabId).addClass("active");
		     $$(this).nextAll().remove();
		})
		
	}
	
	//群组全选
	function loopSel(ulId,showFlag){
		 $("#"+ulId+" li").each(function(){
			  if(showFlag == 1){
				  empId = $(this).data('empid');
	    	   	  empName = $(this).data('empname');
	    	   	  $(this).addClass("checked");
	    	   	  $(".userLi_"+(empId.substring(0,empId.length-1))).addClass('checked');
				  if(selectIdVal.indexOf(empId) == -1){
					selectedNum = selectedNum + 1;
					selectIdVal += empId;
					selectNameVal += empName;
					rangeSelectIds += "$"+empId.substring(0,empId.length-1)+"$";
				  }
			  }else{
				  empId = $(this).data('empid');
	    	   	  empName = $(this).data('empname');
	    	      $(this).removeClass("checked");
	    	      $(".userLi_"+(empId.substring(0,empId.length-1))).removeClass('checked');
				  if(selectIdVal.indexOf(empId) >= 0){
					 selectedNum = selectedNum -1;
					 selectIdVal = selectIdVal.replace(empId,'');
	    			 selectNameVal = selectNameVal.replace(empName,'');
	    			 rangeSelectIds = rangeSelectIds.replace("$"+empId.substring(0,empId.length-1)+"$",'');
				  }
			  }
			    
		 });
		 $("#selectedNum").html("已选"+selectedNum);
		// setSelectVal();
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
	var curpage = '0';
	var nomore = 'true';
	
	//绑定查询框回车事件
    $(document).keydown(function(event){
		var queryCondition = $('#queryCondition').val();
		if(event.keyCode == 13){ //绑定回车
			if((queryCondition.length > 0 && !(queryCondition.trim())) || /[@#\$%\^&\*]+/g.test(queryCondition)){
				myApp.alert('请正确填写搜索姓名！');
				return;
			}
			clearMainCss();
			curpage = 0;
			loadPersonData(0);
		} 
	});
	
    var loadFlag = '0';
    var maxItems = 0;
    /*********加载联系人数据搜索用**********/
	function loadPersonData(flag){
		if(loadFlag == '1'){
    		return false;
    	}
    	loadFlag = '1';
	    var url = '/defaultroot/newperson/personPageList.controller?curpage='+curpage+'&range='+range;
    	var queryCondition = $('#queryCondition').val();
		$.ajax({
	            type: 'post',
	            url: url,
	            dataType: 'text',
	            data : {'linkManName' : queryCondition},
	            success: function(data){
	            	 loadingSelPeople = false;
					 var jsonData=eval("("+data+")");
					 var personArray = jsonData.data0;
					 nomore = jsonData.data1;
					//alert("nomore----->"+nomore);
	                curpage = jsonData.data2;
					//alert("curpage---->"+curpage);
					maxItems = jsonData.data3;
					if(personArray.length>0){
                		var personLis = '';
				        for(var j=0,length=personArray.length;j<length;j++){
				        	var liId = "userLi_"+personArray[j].userId;
				        	var sexClass = "man";
				        	if(personArray[j].sex == 1){
				        		sexClass = "lady";
				        	}
				        	var ussp = '<span>'+personArray[j].userName+'</span>';
				        	if(range != "*0*"){
				        		var orgNameStr =  personArray[j].orgNameString;
				        		orgNameStr =  orgNameStr.substring(orgNameStr.lastIndexOf('.') + 1);
				        		if(orgNameStr.length > 8){
				        			orgNameStr = orgNameStr.substring(0,8)+'...';
				            	}
				        		ussp = '<span>'+personArray[j].userName+'['+orgNameStr+']</span>';
				        	}
				        	personLis +='<li id='+liId+'  data-empid='+personArray[j].userId+","+' data-empname='+personArray[j].userName+','+'   class="'+sexClass+' '+liId+'">'
	                           		  +'<a href="">'
	                              	  +ussp
	                           		  +'</a>'
	                      			  +'</li>';
				        }
				        if(flag == 0){
				        	$("#userListLi").html(personLis);
				        }else{
				        	$("#userListLi").append(personLis);
				        }
				        if(nomore){
							$(".wh-load-tap").html("上滑加载更多");
							$(".wh-load-box").css("display","block");
							$(".wh-load-md").css("display","none");
						}else{
							$(".wh-load-box").css("display","none");
						}
				    }else{
	               		$(".wh-load-box").css("display","none");
	               		$("#userListLi").html('<div  style="padding: 1rem; font-size: 17px;"  class="select-cont">系统未查询到相关记录!</div>');
	               		nomore = '';
	               	}
					bindEmpSelect();
	               	loadFlag = '0';
	            },
	            error: function(xhr, type){
	            	nomore = '';
	                $(".wh-load-tap").html("加载失败！");
	            }
	        });
		
	}
    
	//加载标志
	 var loadingSelPeople = false;
	//下滑加载
	$$(document).on('infinite', '#sectionScroll', function() {
		    // 如果正在加载，则退出
		    if (loadingSelPeople){
				return
			};
			loadingSelPeople = true;
			//alert("detailType------>"+detailType);
			var lastIndex = $$('#userListLi li').length;
			setTimeout(function() {
				if(maxItems - lastIndex > 0){
					$$('.wh-load-md').show();
					loadPersonData(1);
					return;
				}else{
					$$('.wh-load-md').hide();
			        return;
				}
			}, 500);
	  });
	// 清除搜索区域焦点bug
    function removeSearch(schElmID) {
      $('#queryCondition').val("");
      $$(schElmID).blur().val(""); //主动清除焦点
      $$(schElmID).next('.searchbar-cancel').hide();
      if(range!="*0*"){
    	curpage = 0;
		loadPersonData(0);
		$$(".app-tabheader-line").hide();
	  }else{
		  $$("#orgTabs .tab").removeClass("active");
	   	  $$("#orgTabs #tab-step-over0").addClass("active");
	   	bindEmpSelect();
	  }
    }
	
 // 清除搜索区域焦点bug
    function clearMainCss() {
		$$("#orgFlowx").css('display','none' );
    	$$("#orgTabs .tab").removeClass("active");
    	$$("#orgTabs #userList").addClass("active");
    	$$("#orgFlowx ul li").eq(0).nextAll().remove();
    }
 	
 	//反选组织群组
    function setCheckBox(){
		if(selGroupOrgId != null && selGroupOrgId != ""){
			var groupIdValArray = selGroupOrgId.split(',');
			if(groupIdValArray){
				for(var i=0; i<groupIdValArray.length; i++){
					$("#"+groupIdValArray[i]).addClass("sel-kik");
				}
			}
		}
	}
	
  </script>
</body>
</html>;