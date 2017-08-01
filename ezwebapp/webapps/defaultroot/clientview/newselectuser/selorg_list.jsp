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
    <section class="wh-section wh-section-bottomfixed">
      <div class="mail-todo">
        <div class="tabs">
          <!-- Tab 1, 默认激活 -->
          <div id="tab-sel1" class="tab active">
            <!-- 搜索公用 -->
              <header class="wh-search">
                  <div class="wh-container">
                      <div class="wh-search-input">
                          <form class="searchbar searchbar-init nomal-searchbar">
                              <label class="fa fa-search" for="search"></label>
                              <input id="searchBug" type="search" class="nomal-search" placeholder="请输入姓名或者拼音搜索" />
                          </form>
                      </div>
                  </div>
              </header>
              <!-- 左右滑动横条 -->
              <div class="step-todo step-select">
                  <div id="orgFlowx" class="wh-flow-x">
                      <ul id="topList">
                          <li><a href="#tab-step-over0" class="tab-link active"><span><i class="fa fa-home"></i></span><span class="sx-sle">|</span></a></li>
                      </ul>
                  </div>
                  <div class="tabs" id="orgTabs">
                      <!-- Tab 1, 默认激活 -->
                      <div id="tab-step-over0" class="tab active">
                          <div id="mainOrg" class="select-cont">
                              
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
	var selGroupId = "";//记录已选中的组织id，便于回显组织前的复选框
	var rangeSelectIds='';
	/**********进入页面就加载联系人列表数据***********/
	$(function(){
		loadParentOrgData();
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
		                	var orgDivId = "divOrg_"+orgArray[i].orgId;
		                	orgHtml +=selcHtml ='<div class="select-tree">'
                                    +'<div onclick="loadOrgUserData('+orgArray[i].orgId+',this,\'0\',\''+orgArray[i].orgName+'\',\'0\');" class="wh-cengji">'
                               		+'<span>'+orgName+'</span>'
                            		+'</div>'
                           			+ '<div id='+orgDivId+' onclick="checkSelOrg(this);" data-orgid='+orgArray[i].orgId+','+' data-orgname='+orgArray[i].orgName+','+'  class="select-check"></div>'
                      				+'</div>'
		                }
		                $("#mainOrg").html(orgHtml);
		                binNextClick();
		                setSelectVal();
	                }
        		}else{
	            }
            },
            error: function(xhr, type){
                alert('数据查询异常！');
            }
        });
	}
	
	
	//回显已勾选的数据
	function setSelectVal(){
		if(idValArray){
			for(var i=0,length=idValArray.length; i<length; i++){
				$("#divOrg_"+idValArray[i]).addClass('sel-kik');
			}
		}
	}
	
	//清空
	function clearSelect(){
		$("i.fa-check-circle-active").removeClass("fa-check-circle-active");
		selectNameVal = '';
	    selectIdVal = '';
	}
	
	//确定
	function confirmSelect(){
		$("input[id='"+selectId+"']").val(selectIdVal);
		$("input[id='"+selectName+"']").val(selectNameVal);
		if(typeof ( selectCallBack ) == "function" ){
			selectCallBack( $("input[id='"+selectName+"']"),$("input[id='"+selectId+"']") );
		}
		hiddenContent(1);
	}
	
	//组织选择事件
	function checkSelOrg(obj){
		var orgId = '';
		var orgName = '';
		//单选时选择方式
		orgId = $(obj).data('orgid');
	    orgName = $(obj).data('orgname');
    	if(selectType == '0'){//单选
    		$(obj).addClass("sel-kik");
    		$(".select-check").not(obj).removeClass("sel-kik");
        	selectIdVal = orgId;
        	selectNameVal = orgName;
    	}else if(selectType == '1'){//多选 
    		if($$(obj).hasClass("sel-kik")){
	  	        $$(obj).removeClass("sel-kik");
	  	        selectIdVal = selectIdVal.replace(orgId,'');
				selectNameVal = selectNameVal.replace(orgName,'');
	  	    }else{
	  	    	$$(obj).addClass("sel-kik");
	  	    	if(selectIdVal.indexOf(orgId) == -1){
	    			selectIdVal += orgId;
	    			selectNameVal += orgName;
		        }
	  	    }
    	}
	}
	
	//加载父组织数据
	function binNextClick(){
		$$("#orgFlowx ul li").click(function(){
			 var tabId = $$(this).find('a').attr("href"); 
			 $$("#orgTabs .tab").removeClass("active");
			 $$("#"+tabId).addClass("active");
		     $$(this).nextAll().remove();
		})
	}
	
	//加载自组织人员及组织
	function loadOrgUserData(parentOrgId,obj,nowTab,liOrgName){
    	var tabId = "tab-step-over"+parentOrgId;
		showCss = 'active';
		if(liOrgName.length > 12){
			liOrgName = liOrgName.substring(0,11)+'...';
    	}
		var li = '<li><a href='+tabId+' class="tab-link active"><span>'+liOrgName+'</span><i class="fa fa-angle-right"></i></a></li>';
		$('#topList').append(li);
		$("#tab-step-over"+nowTab).removeClass("active");
		var ulId = "orgUl_"+parentOrgId;
		$$("#orgFlowx").css('display','block');
		
		if($("#"+tabId).css("display") == "none"){
			$$("#orgTabs .tab").removeClass("active");
    		$$("#"+tabId).addClass("active");
    		setSelectVal();
    		binNextClick();
    		return;
    	}
		$.ajax({
            type: 'post',
            url: '/defaultroot/newperson/getOrgById.controller?parentOrgId='+parentOrgId+'&range='+range,
            dataType: 'text',
            success: function(data){
        		if(data){
					//用于区分页签为联系人还是组织
					detailType = "org";

        			var jsonData = eval("("+data+")");
        			var orgArray = jsonData.data0;
        			if(orgArray){
        				if(orgArray.length==0){
        					//myApp.alert('没有下级组织与人员！');
        					$('#orgTabs').append('<div id='+tabId+'  class="tab '+showCss+'"><div  style="padding: 1rem; font-size: 17px;"  class="select-cont">系统未查询到相关记录!</div></div>');
        					binNextClick();
							return;
        				}
        			}
	                var result = '<div id='+tabId+'  class="tab '+showCss+'">';
                	var orgLis = '';
                	if(orgArray){
                		orgLis = '<div class="select-cont">';
		                for(var i = 0; i < orgArray.length; i++){
		                	var orgName =  orgArray[i].orgName;
		                	if(orgName.length > 16){
		                		orgName = orgName.substring(0,15)+'...';
		                	}
		                	orgLis +='<div class="select-tree">'
                                    +'<div onclick="loadOrgUserData('+orgArray[i].orgId+',this,'+parentOrgId+',\''+orgArray[i].orgName+'\',\'0\');" class="wh-cengji">'
                               		+'<span>'+orgName+'</span>'
                            		+'</div>'
                           			+ '<div onclick="checkSelOrg(this);" data-orgid='+orgArray[i].orgId+','+' data-orgname='+orgArray[i].orgName+','+'  class="select-check"></div>';
                      				+'</div>'
		                }
		                orgLis += '</div>';
	                }
                	result += orgLis+'</div>';
                	$('#orgTabs').append(result);
                	binNextClick();
                	setSelectVal();
        		}else{
        			//TODO
	            }
            },
            error: function(xhr, type){
                alert('数据查询异常！');
            }
        });
	}
	
	
  </script>
</body>
</html>