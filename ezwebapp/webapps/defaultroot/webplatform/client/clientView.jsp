<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%@ include file="/webplatform/include/headerInit.jsp"%>
</head>
<%
  String saveImgName1 = "";
  String realImgName1 = "";
%>
<body>
  <%@ include file="/webplatform/include/include_base_module.jsp"%>
  <div class="wh-mobile-container">
    <div class="wh-webapp-content">
      <div class="client-1">
        <div>
          <label> evo服务器：</label>
          <input type="text" name="evoServerIP" id="evoServerIP" value=""  readonly="readonly"/>
          <input type="text" name="evoServerPort" id="evoServerPort" value="" readonly="readonly"/>
        </div>
        <div>
          <label> mana控制台：</label>
          <input type="text" name="manaConsole" id="manaConsole" value="" style="width:280px;" readonly="readonly"/>
          <a href="javascript:openManaUrl();" class="mobile-btn-suqare">打开</a>
        </div>
        <div>
          <label> 客户端下载地址：</label>
          <input type="text" name="clientDownloadAddress" id="clientDownloadAddress" value="" style="width:280px;" readonly="readonly" />
          <a href="javascript:openDownloadUrl();" class="mobile-btn-suqare">生成二维码</a>
       <!--   <a href="javascript:QrCodeIsGenerated();" class="mobile-btn-suqare">生成二维码</a>  --> 
        </div>
      </div>
    </div>
    <div class="wh-webapp-content">
      <div class="client-2">
        <h3>横幅LOGO</h3>
        <span>图片大小勿超过10kb 格式为png</span>
		<form name="imgForm" id="imgForm" action="" method="post">
        <ul class="clearfix">
          <li>
            <div class="size">
              <p><em>安卓</em></p>
              <p><em>480*854</em></p>
              <p><strong>上传尺寸</strong></p>
              <p><strong>217*22</strong></p>
            </div>
			<jsp:include page="/webplatform/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="styleType" value="vertical" />
				<jsp:param name="onUploadSuccess" value="showIMG_1" />
				<jsp:param name="canModify" value="yes" />
				<jsp:param name="dir" value="webplatform/client" />
				<jsp:param name="uniqueId" value="client1" />
				<jsp:param name="buttonText" value="上传图片" />
				<jsp:param name="fileSizeLimit" value="10KB" />
				<jsp:param name="fileTypeExts_img" value="png" />
				<jsp:param name="uploadLimit" value="1" />
			</jsp:include>
				<input name="id1" id="id1" value="1" type="hidden"/>
			    <input name="saveImgName1" id="saveImgName1" value="" type="hidden"/>
				<input name="realImgName1" id="realImgName1" value="" type="hidden"/>
            <div class="imgupload" id="div_clientImg1" >
              <img id="clientImg1" src="<%=realpath%>/webplatform/images/ver113/webapp/pic-preview.jpg" width="160" height="100"/>
              <i class="fa fa-minus-circle" onclick="clearImg_1()"></i>
            </div>
          </li>
          <li>
            <div class="size">
              <p><em>安卓</em></p>
              <p><em>720*1280</em></p>
              <p><strong>上传尺寸</strong></p>
              <p><strong>321*34</strong></p>
            </div>
            <jsp:include page="/webplatform/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="styleType" value="vertical" />
				<jsp:param name="onUploadSuccess" value="showIMG_2" />
				<jsp:param name="canModify" value="yes" />
				<jsp:param name="dir" value="webplatform/client" />
				<jsp:param name="uniqueId" value="client2" />
				<jsp:param name="buttonText" value="上传图片" />
				<jsp:param name="fileSizeLimit" value="10KB" />
				<jsp:param name="fileTypeExts_img" value="png" />
				<jsp:param name="uploadLimit" value="1" />
			</jsp:include>
				<input name="id2" id="id2" value="2" type="hidden"/>
			    <input name="saveImgName2" id="saveImgName2" value="" type="hidden"/>
				<input name="realImgName2" id="realImgName2" value="" type="hidden"/>
            <div class="imgupload" id="div_clientImg2" >
              <img id="clientImg2" src="<%=realpath%>/webplatform/images/ver113/webapp/pic-preview.jpg" width="160" height="100"/>
              <i class="fa fa-minus-circle" onclick="clearImg_2()"></i>
            </div>
          </li>
          <li>
            <div class="size">
              <p><em>安卓</em></p>
              <p><em>1080*1920</em></p>
              <p><strong>上传尺寸</strong></p>
              <p><strong>489*52</strong></p>
            </div>
            <jsp:include page="/webplatform/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="styleType" value="vertical" />
				<jsp:param name="onUploadSuccess" value="showIMG_4" />
				<jsp:param name="canModify" value="yes" />
				<jsp:param name="dir" value="webplatform/client" />
				<jsp:param name="uniqueId" value="client4" />
				<jsp:param name="buttonText" value="上传图片" />
				<jsp:param name="fileSizeLimit" value="10KB" />
				<jsp:param name="fileTypeExts_img" value="png" />
				<jsp:param name="uploadLimit" value="1" />
			</jsp:include>
				<input name="id4" id="id4" value="4" type="hidden"/>
			    <input name="saveImgName4" id="saveImgName4" value="" type="hidden"/>
				<input name="realImgName4" id="realImgName4" value="" type="hidden"/>
            <div class="imgupload" id="div_clientImg4" >
              <img id="clientImg4" src="<%=realpath%>/webplatform/images/ver113/webapp/pic-preview.jpg" width="160" height="100"/>
              <i class="fa fa-minus-circle" onclick="clearImg_4()"></i>
            </div>
          </li>
          <li>
            <div class="size">
              <p><em>苹果</em></p>
              <p><em>750*1334</em></p>
              <p><strong>上传尺寸</strong></p>
              <p><strong>328*33</strong></p>
            </div>
            <jsp:include page="/webplatform/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="styleType" value="vertical" />
				<jsp:param name="onUploadSuccess" value="showIMG_3" />
				<jsp:param name="canModify" value="yes" />
				<jsp:param name="dir" value="webplatform/client" />
				<jsp:param name="uniqueId" value="client3" />
				<jsp:param name="buttonText" value="上传图片" />
				<jsp:param name="fileSizeLimit" value="10KB" />
				<jsp:param name="fileTypeExts_img" value="png" />
				<jsp:param name="uploadLimit" value="1" />
			</jsp:include>
				<input name="id3" id="id3" value="3" type="hidden"/>
			    <input name="saveImgName3" id="saveImgName3" value="" type="hidden"/>
				<input name="realImgName3" id="realImgName3" value="" type="hidden"/>
            <div class="imgupload" id="div_clientImg3" >
              <img id="clientImg3" src="<%=realpath%>/webplatform/images/ver113/webapp/pic-preview.jpg" width="160" height="100"/>
              <i class="fa fa-minus-circle" onclick="clearImg_3()"></i>
            </div>
          </li>
          <li>
            <div class="size">
              <p><em>苹果</em></p>
              <p><em>1242*2208</em></p>
              <p><strong>上传尺寸</strong></p>
              <p><strong>570*89</strong></p>
            </div>
            <jsp:include page="/webplatform/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="styleType" value="vertical" />
				<jsp:param name="onUploadSuccess" value="showIMG_5" />
				<jsp:param name="canModify" value="yes" />
				<jsp:param name="dir" value="webplatform/client" />
				<jsp:param name="uniqueId" value="client5" />
				<jsp:param name="buttonText" value="上传图片" />
				<jsp:param name="fileSizeLimit" value="10KB" />
				<jsp:param name="fileTypeExts_img" value="png" />
				<jsp:param name="uploadLimit" value="1" />
			</jsp:include>
				<input name="id5" id="id5" value="5" type="hidden"/>
			    <input name="saveImgName5" id="saveImgName5" value="" type="hidden"/>
				<input name="realImgName5" id="realImgName5" value="" type="hidden"/>
            <div class="imgupload" id="div_clientImg5" >
              <img id="clientImg5" src="<%=realpath%>/webplatform/images/ver113/webapp/pic-preview.jpg" width="160" height="100"/>
              <i class="fa fa-minus-circle" onclick="clearImg_5()"></i>
            </div>
          </li>
        </ul>
		</form>
        <div class="btn-div">
          <a href="javascript:restoreDefault();" class="mobile-btn-line-circle ">恢复默认</a>
          <a href="javascript:saveImg();" class="mobile-btn-line-circle ">同步上传</a>
        </div>
      </div>
    </div>
    <div class="wh-webapp-content">
      <div class="client-3">
        <h3>
          	应用管理
        </h3>
		<h3 style="float:right">
          	<p class='use-info'><a style="background: #3eaeff;padding: 7px 30px;border-radius: 5px;color: #fff;" href="javascript:void(0);" onclick="addNew()">新增</a></p>
        </h3>
        <table>
          <thead>
            <td width="15%">应用名称</td>
            <td width="30%">适用范围</td>
            <td width="10%">图标</td>
            <td width="10%">是否启用</td>
            <td width="10%">排序</td>
            <td width="25%">操作</td>
          </thead>
          <tbody id="custDataList">
            
          </tbody>
        </table>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
			  <tbody>
				<tr>
				  <td>
					<div class="page" style="display: block;">
					  <div id="pager_desc">第&nbsp;
						<font color="red">
							<span id="curpage"></span>
						</font>/<span id="pageCount"></span>&nbsp;页&nbsp;&nbsp;&nbsp;共&nbsp;
						<span id="recordCount"></span>&nbsp;条记录&nbsp;</div>
					  <div id="pagerSize">
						<select name="pageSize" id="page_size" onchange="pageClick(1);" class="pageSize">
						  <option value="15">15</option>
						  <option value="30">30</option>
						  <option value="50">50</option>
						  <option value="100">100</option>
						</select>
					  </div>
					  <div id="pager">
					  	<a id="first" class="jp-previous jp-disabled" onclick="goPage('-1');">前页</a>
					  	<span id="did"></span>
					  	<a id="next" class="jp-next" onclick="goPage('1');">后页</a>
					  </div>
					  <div id="pagebtn">
						<input id="go_start_pager" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
						<input type="button" onclick="go();" value=" Go ">
					  </div>
					</div>
				  </td>
				</tr>
			  </tbody>
			</table>
      </div>
    </div>
  </div>

  <!--生成二维码-->
  <div id="clien-download"  class="layer-modal client-info">
	<div class="client-info-div" align="center">
      <img id="twoDimenseCode" src="<%=realpath%>/webplatform/images/ver113/client/clientdownload.png">
    </div>
  </div>
  
   <!-- 版权信息 -->
  <div id="info-banquan" class="layer-modal info-app">
    <div class="hand-dd-tabs bq-tip">
        <p class="fl">&nbsp;&nbsp;<img src="../images/ver113/webapp/v.png">&nbsp;&nbsp;万户evo移动办公版权信息</p>
        <p class="fr layui-layer-close"><i class="fa fa-times"></i></p>
    </div>
    <div class="bq-content">
      <ul class="tab clearfix" style="width:468px">
       <li class="cur">evo+轻应用</li>
       <li>evo客户端</li>
     </ul>
     <div class="cont on" style="height:150px;overflow-y:auto">
       <table id="web">
         <tr>
           <td class="grey">版本号</td>
           <td class="grey">升级包</td>
           <td class="grey">升级时间</td>
         </tr>
       </table>
     </div>
     <div class="cont" style="height:150px;overflow-y:auto">
       <table id="evo">
         <tr>
           <td class="grey">版本号</td>
           <td class="grey">升级包</td>
           <td class="grey">升级时间</td>
         </tr>
       </table>
     </div>
   </div>
  </div>
  <script type="text/javascript" src="<%=realpath%>/webplatform/scripts/plugins/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="<%=realpath%>/webplatform/scripts/plugins/layer/layer.js"></script>
  <script type="text/javascript">
     var versionFlag ='0';
	 //版权信息
	 $("#version").on('click',function(){
		layer.open({
		  type: 1,
		  title : false,
		  shadeClose: false,
		  shade: 0,
		  area: ['500px', ''],
		  closeBtn : 0,
		  content: $("#info-banquan")
		});
		if(versionFlag == '0'){
			var url ='<%=realpath%>/clientlplatform/pathchInfoDataList.controller?isClient=1';
			var urlwebapp ='<%=realpath%>/clientlplatform/pathchInfoDataList.controller?isClient=0';
			loadPatchInfoDataList(url,'1');
			loadPatchInfoDataList(urlwebapp,'0');
		}
	})

    $(".bq-content .tab li").click(function(){
		$(".tab li").eq($(this).index()).addClass("cur").siblings().removeClass('cur');
		$(".cont").hide().eq($(this).index()).show();
    });
    //版权信息
	/***加载客户端配合信息**/
	$(document).ready(function(){
		loadClientData();
	});
	function loadClientData(){
		$.ajax({
			url : '<%=realpath%>/clientlplatform/loadClientData.controller',
			type : 'POST',
			dataType : 'json',
			success : function(data){
				var evoServerIP = data.evoServerIP;
				$('#evoServerIP').val(evoServerIP);
				var evoServerPort = data.evoServerPort;
				$('#evoServerPort').val(evoServerPort);
				var manaUrl = data.result.manaUrl;
				$('#manaConsole').val(manaUrl);
				var downloadUrl = data.result.downloadUrl;
				$('#clientDownloadAddress').val(downloadUrl);
			},
			error : function(data) {
				whir_alert1("提示信息","客户端配置信息获取失败!","确定");
			}
		});
	}

	//打开mana控制台
	function openManaUrl(){
		var manaUrl = $('#manaConsole').val();
		if(manaUrl != ''){
		//	window.location = manaUrl;
			window.open(manaUrl);
		}else{
			whir_alert1("提示信息","未提供正确的mana控制台链接地址！","确定");
		}
		
	}
	
	//打开客户端下载地址
	function openDownloadUrl(){
		//var downloadUrl = 'http://192.168.0.64:9090/mana/a/install';
		var downloadUrl = $('#clientDownloadAddress').val();
		if(downloadUrl != ''){
			//window.location = downloadUrl;
			window.open(downloadUrl);
		}else{
			whir_alert1("提示信息","未提供正确的客户端下载链接地址！","确定");
		}
	}

	//生成二维码
	function QrCodeIsGenerated(){
		var clientDownloadAddress = $("#clientDownloadAddress").val();
		if(clientDownloadAddress==null||clientDownloadAddress==""){
			alert("未提供正确的客户端下载链接地址!");
			return;
		}
		$.ajax({
			 url : "/defaultroot/twoDeimensionCode/getlogonimg.controller",    
			 type : "POST",    
			 dataType:"json",
			 data : { "ClientUrl": $("#clientDownloadAddress").val() },    
			 success : function(data) {
				 var timestr =data.timestr; 
				 if(timestr==null||timestr==""){
					 alert("获取二维码失败，请重新获取！");
					 return;
			     }
				 $("#twoDimenseCode").attr('src',"<%=realpath%>/upload/webplatform/"+timestr+".jpg");
				 layer.open({
						type: 1,
						title: '<i class="fa fa-tips"></i>客户端二维码',
						shadeClose: false,
						shade: 0,
						area: ['470px', ' '],
						btn: ['关闭'],
						closeBtn: 0,
						content: $("#clien-download")
					});
			 },    
			 error : function(data) {
			 }    
		 });
	/*	layer.open({
			type: 1,
			title: '<i class="fa fa-tips"></i>客户端二维码',
			shadeClose: false,
			shade: 0,
			area: ['470px', ' '],
			btn: ['关闭'],
			closeBtn: 0,
			content: $("#clien-download")
		});  */
	}

	/*********加载应用主页列表开始***********/
	var startPage = 1;
	var pageCount1 = 1;

	$(document).ready(function(){
		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		//alert(pageSize);
		var url = "<%=realpath%>/clientlplatform/clientplatformviewDataList.controller?pageSize="+pageSize;
		loadViewDataList(url);
		
	});
	
	//加载应用主页信息列表
	function loadViewDataList(url){
		$.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			success : function(data){
				var pageSize = data.pageSize;
				var currentPage = data.currentPage;
				
				var pageCount = data.pageCount;
                
				var recordCount = data.recordCount;
				
				var custDataList = data.custDataList;
				
				
				 
				startPage = currentPage;
                pageCount1 = pageCount;
				var h1 = "";
				if(custDataList.length>0){
					$(".page").css("display","block");
					$('#curpage').html(currentPage);
					$('#pageCount').html(pageCount);
					$('#recordCount').html(recordCount);
					//拼接单独显示页数
					var pg = "";
					if(pageCount > 5){
						for(var i = 1;i <= 5;i++){
							if(currentPage == i){
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class='jp-current'>"+i+"</a>";
				 			}else{
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class=''>"+i+"</a>";
				 			}
						}
						pg += "  ...  ";
						if(currentPage == pageCount){
							pg += "<a href='javascript:void(0);' onclick='pageClick("+ pageCount +");' class='jp-current'>"+pageCount+"</a>";
						}else{
							pg += "<a href='javascript:void(0);' onclick='pageClick("+ pageCount +");' class=''>"+pageCount+"</a>";
						}
						$('#did').html(pg);
					}else{
						for(var i = 1;i <= pageCount;i++){
							if(currentPage == i){
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class='jp-current'>"+i+"</a>";
				 			}else{
				 				pg += "<a href='javascript:void(0);' onclick='pageClick("+i+");' class=''>"+i+"</a>";
				 			}
						}
						$('#did').html(pg);
					}
				
					//控制 前页 的class属性
					if(currentPage > 1){
						$('#first').removeClass("jp-previous jp-disabled");
						$('#first').addClass("jp-previous");
					}else{
						$('#first').removeClass("jp-previous");
						$('#first').addClass("jp-previous jp-disabled");
					}
					//控制 后页 的class属性
					if(currentPage >= pageCount){
						$('#next').removeClass("jp-next");
						$('#next').addClass("jp-next jp-disabled");
					}else{
						$('#next').removeClass("jp-next jp-disabled");
						$('#next').addClass("jp-next");
					}
					for(var i=0;i<custDataList.length;i++){
						var custdata = custDataList[i];
						var mobileId = custdata[0];
                        var name = custdata[1];
						var scope = custdata[2];
						if(scope == null || scope == 'null'){
							scope = '';
						}
						var isUse = custdata[3];
						var sortCode = custdata[4];
						var Img1showName = custdata[5];
						var Img2showName = custdata[6];
						var Img3showName = custdata[7];
						var Img4showName = custdata[8];
						var Img5showName = custdata[9];
						var moduleType = custdata[10];
					    h1 += "<tr>";
						h1 += "<td>" + name + "</td>";
						h1 += "<td>" + scope + "</td>";
						if((Img1showName!=""&&Img1showName!=null)||(Img2showName!=""&&Img2showName!=null)||(Img3showName!=""&&Img3showName!=null)||(Img4showName!=""&&Img4showName!=null)||(Img5showName!=""&&Img5showName!=null) || moduleType=='0'){
							h1 += "<td>5/5</td>";
						}else{
							h1 += "<td>0/5</td>";
						}
						if(isUse=='1'){
							h1 += "<td>是</td>";
						}else{
							h1 += "<td>否</td>";
						}
						h1 += "<td>"+sortCode+"</td>";
						if(isUse == '1'){
							if(moduleType != '2'){
								h1 += "<td><a href='javascript:void(0);' class='use-info' onclick='hideApp("+mobileId+","+currentPage+","+isUse+")'>隐藏</a><a href='javascript:void(0);' class='info-edit' onclick='edit("+mobileId+","+currentPage+");'>编辑</a></td>";
							}else{
								h1 += "<td><a style='width:33.3%' href='javascript:void(0);' class='use-info' onclick='hideApp("+mobileId+","+currentPage+","+isUse+")'>隐藏</a><a style='width:33.3%' href='javascript:void(0);' class='info-edit' onclick='edit("+mobileId+","+currentPage+");'>编辑</a><a style='width:33.3%' href='javascript:void(0);' class='info-edit' onclick='del("+mobileId+");'>删除</a></td>";
							}
						}else{
							if(moduleType != '2'){
								h1 += "<td><a href='javascript:void(0);' class='use-info' onclick='hideApp("+mobileId+","+currentPage+","+isUse+")'>启用</a><a href='javascript:void(0);' class='info-edit' onclick='edit("+mobileId+","+currentPage+");'>编辑</a></td>";
							}else{
								h1 += "<td><a style='width:33.3%' href='javascript:void(0);' class='use-info' onclick='hideApp("+mobileId+","+currentPage+","+isUse+")'>启用</a><a style='width:33.3%' href='javascript:void(0);' class='info-edit' onclick='edit("+mobileId+","+currentPage+");'>编辑</a><a style='width:33.3%' href='javascript:void(0);' class='info-edit' onclick='del("+mobileId+");'>删除</a></td>";
							}
						}
						h1 += "<tr>";
					}
				}else{
					h1 += "<tr><td colspan='6'>未查询到相关数据！</td></tr>";
					$(".page").css("display","none");
				}
                $('#custDataList').html(h1);
			},
			error : function(data) {
				whir_alert1("提示信息","数据获取失败!","确定");
			}
		});
	}


	//翻页操作
	function goPage(p){
		var page = eval(p)+eval(startPage);
		if(page == 0 || page > pageCount1){
			return;
		}
		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		var url = "<%=realpath%>/clientlplatform/clientplatformviewDataList.controller?startPage="+page+"&pageSize="+pageSize;
		loadViewDataList(url);
	}


	//下拉框控制的页面数据显示和单独拼接的页数控制
	function pageClick(curpage){
		//默认当前页为1
		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		var url ="<%=realpath%>/clientlplatform/clientplatformviewDataList.controller?pageSize="+pageSize+"&startPage="+curpage;
		loadViewDataList(url);
	}

	//点击go触发
	function go(){
  		//获取文本框中的当前页
  		var page = $('#go_start_pager').val();
  		if(page == null || page ==''){
			return;
		}
		//获取总页数
		var pageCount = $('#pageCount').html();
  		if(eval(page) >= eval(pageCount)){
			page = pageCount;
		}
  		//每页的显示数。根据下拉选择框而定。
		var pageSize = $("#page_size option:selected").val();
		var url = "<%=realpath%>/clientlplatform/clientplatformviewDataList.controller?startPage="+page+"&pageSize="+pageSize;
		loadViewDataList(url);
		if(eval(page) >= eval(pageCount)){
			$('#go_start_pager').val(pageCount);
		}
	}
	

	//隐藏
	function hideApp(mobileId,currentPage,isUse){
		//每页的显示数。根据下拉选择框而定。
  		var pageSize = $("#page_size option:selected").val();
		if(isUse == '1'){
			whir_alert2("确认信息","您确定要隐藏吗？","确定","取消",
				
				function(){
					$.ajax({
  						url : "<%=realpath%>/clientlplatform/clientplatformhideapp.controller?mobileId="+mobileId+"&mobileMenuIsUse="+isUse,
		 				type : "POST",    
		 				dataType:"text",   
		 				success : function(data) {
  							if(data == 1){
	 							var url = "<%=realpath%>/clientlplatform/clientplatformviewDataList.controller?startPage="+currentPage+"&pageSize="+pageSize;
								loadViewDataList(url);
							}
  			 			},
  			 			error : function(data) {
  							whir_alert1("提示信息","隐藏应用失败!","确定");
  						}
  	  				});
				},function(){return;}
			);
		}else{
			whir_alert2("确认信息","您确定要启用吗？","确定","取消",
				
				function(){
					$.ajax({
  						url : "<%=realpath%>/clientlplatform/clientplatformhideapp.controller?mobileId="+mobileId+"&mobileMenuIsUse="+isUse,
		 				type : "POST",    
		 				dataType:"text",   
		 				success : function(data) {
  							if(data == 1){
	 							var url = "<%=realpath%>/clientlplatform/clientplatformviewDataList.controller?startPage="+currentPage+"&pageSize="+pageSize;
								loadViewDataList(url);
	 						}
  			 			},
  			 			error : function(data) {
  							whir_alert1("提示信息","启用应用失败!","确定");
  						}
  	  				});
				},function(){return;}
			);
		}



		
  		
	}

	//新增
	function addNew(){
		var openUrl = "<%=realpath%>/clientlplatform/clientplatformAdd.controller";
		//window.open (openUrl,"_blank","应用编辑","height=100,width=300,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no");
		window.open(openUrl,"应用新增",'width='+ (window.screen.availWidth-10)+',height='+(window.screen.availHeight-30)+ ',scrollbars=yes,resizable=yes');
	}

	//编辑
	function edit(mobileId,currentPage){
		var openUrl = "<%=realpath%>/clientlplatform/clientplatformgetDataById.controller?mobileId="+mobileId;
		//window.open (openUrl,"_blank","应用编辑","height=100,width=300,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no");
		var iWidth=window.screen.availWidth-50; //弹出窗口的宽度;  
	    var iHeight=window.screen.availHeight-50; //弹出窗口的高度;  
	    var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;  
	    var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;  
	    window.open(openUrl,"应用编辑","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft,scrollbars='yes',resizable='yes');
		//window.open(openUrl,"应用编辑",'width='+ (window.screen.availWidth-10)+',height='+(window.screen.availHeight-30)+ ',scrollbars=yes,resizable=yes');

	}

	
	function callback() {
		var curpage = $('#curpage').html();
		//每页的显示数。根据下拉选择框而定。
  		var pageSize = $("#page_size option:selected").val();
		var url = "<%=realpath%>/clientlplatform/clientplatformviewDataList.controller?startPage="+curpage+"&pageSize="+pageSize;
		loadViewDataList(url);
	}
	

	/************加载客户端logo开始***************/
	$(document).ready(function(){
		loadEvoLogo();
    });


	function loadEvoLogo(){
		$.ajax({
			url : "<%=realpath%>/clientlplatform/loadLogoImg.controller",
			type : "POST",
			dataType : "json",
			success : function(data) {
				if(data != null){
					for(var i=0;i<data.length;i++){
						if(data[i].uploadType == '480*845'){
							var saveImgName1 = "/defaultroot/upload/webplatform/client/" + data[i].imgUploadSaveName;
							if(data[i].imgUploadSaveName == ''){
								saveImgName1 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
							}
							$('#clientImg1').attr("src", saveImgName1);
						}else if(data[i].uploadType == '720*1280'){
							var saveImgName2 = "/defaultroot/upload/webplatform/client/" + data[i].imgUploadSaveName;
							if(data[i].imgUploadSaveName == ''){
								saveImgName2 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
							}
							$('#clientImg2').attr("src", saveImgName2);
						}else if(data[i].uploadType == '750*1334'){
							var saveImgName3 = "/defaultroot/upload/webplatform/client/" + data[i].imgUploadSaveName;
							if(data[i].imgUploadSaveName == ''){
								saveImgName3 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
							}
							$('#clientImg3').attr("src", saveImgName3);
						}else if(data[i].uploadType == '1080*1920'){
							var saveImgName4 = "/defaultroot/upload/webplatform/client/" + data[i].imgUploadSaveName;
							if(data[i].imgUploadSaveName == ''){
								saveImgName4 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
							}
							$('#clientImg4').attr("src", saveImgName4);
						}else if(data[i].uploadType == '1242*2208'){
							var saveImgName5 = "/defaultroot/upload/webplatform/client/" + data[i].imgUploadSaveName;
							if(data[i].imgUploadSaveName == ''){
								saveImgName5 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
							}
							$('#clientImg5').attr("src", saveImgName5);
						}
					}
				}
			},
			error : function(data) {
				whir_alert1("提示信息","加载横幅LOGO失败!","确定");
			}
		});
	}

	/***********上传成功后回调函数*********/
	function showIMG_1(json){
		var obj =  eval("("+json+")");
		var Img1saveName = obj.save_name;
		var Img1showName = obj.file_name;
		$('#saveImgName1').val(Img1saveName);
		$('#realImgName1').val(Img1showName);
		var imgFilePath1 = obj.relative_path;
		//alert(imgFilePath);
		$('#clientImg1').attr("src", imgFilePath1).load(function() {
			var fileOffsetWidth = this.width;
			var fileOffsetHeight = this.height;
			$('#div_clientImg1').show();
		});
	}

	function showIMG_2(json){
		var obj =  eval("("+json+")");
		var Img2saveName = obj.save_name;
		var Img2showName = obj.file_name;
		$('#saveImgName2').val(Img2saveName);
		$('#realImgName2').val(Img2showName);
		var imgFilePath2 = obj.relative_path;
		$('#clientImg2').attr("src", imgFilePath2).load(function() {
			var fileOffsetWidth = this.width;
			var fileOffsetHeight = this.height;
			$('#div_clientImg2').show();
		});
   }
	
	function showIMG_3(json){
		var obj =  eval("("+json+")");
		var Img3saveName = obj.save_name;
		var Img3showName = obj.file_name;
		$('#saveImgName3').val(Img3saveName);
		$('#realImgName3').val(Img3showName);
		var imgFilePath3 = obj.relative_path;
		$('#clientImg3').attr("src", imgFilePath3).load(function() {
			var fileOffsetWidth = this.width;
			var fileOffsetHeight = this.height;
			$('#div_clientImg3').show();
		});
   }

   function showIMG_4(json){
		var obj =  eval("("+json+")");
		var Img4saveName = obj.save_name;
		var Img4showName = obj.file_name;
		$('#saveImgName4').val(Img4saveName);
		$('#realImgName4').val(Img4showName);
		var imgFilePath4 = obj.relative_path;
		$('#clientImg4').attr("src", imgFilePath4).load(function() {
			var fileOffsetWidth = this.width;
			var fileOffsetHeight = this.height;
			$('#div_clientImg4').show();
		});
   }

   function showIMG_5(json){
		var obj =  eval("("+json+")");
		var Img5saveName = obj.save_name;
		var Img5showName = obj.file_name;
		$('#saveImgName5').val(Img5saveName);
		$('#realImgName5').val(Img5showName);
		var imgFilePath5 = obj.relative_path;
		$('#clientImg5').attr("src", imgFilePath5).load(function() {
			var fileOffsetWidth = this.width;
			var fileOffsetHeight = this.height;
			$('#div_clientImg5').show();
		});
   }
	
	
	/********保存图片地址到数据库********/
	function saveImg(){
		var realImgName1 = $('#realImgName1').val();
		var realImgName2 = $('#realImgName2').val();
		var realImgName3 = $('#realImgName3').val();
		var realImgName4 = $('#realImgName4').val();
		var realImgName5 = $('#realImgName5').val();
		var val1 = $('#saveImgName1').val();
		var val2 = $('#saveImgName2').val();
		var val3 = $('#saveImgName3').val();
		var val4 = $('#saveImgName4').val();
		var val5 = $('#saveImgName5').val();

		if(realImgName1==""||realImgName2==""||realImgName3==""||realImgName4==""||realImgName5==""){
			whir_alert1("提示信息","请重新上传图片","确定");
			return;
		}else{
			$.ajax({
				url : "<%=realpath%>/clientlplatform/clientplatformSaveFile.controller?val1="+val1+"&val2="+val2+"&val3="+val3+"&val4="+val4+"&val5="+val5+"&fromFlag=view",
				type : "POST",    
				dataType:"text",
				data : "",    
				success : function(data) {
					var obj =  eval("("+data+")");
					if(obj.result == '1'){
										
					}
				},
				error : function(data) {
					whir_alert1("提示信息","evo数据保存失败!","确定");
				}  
			});

			$.ajax({
				url : "<%=realpath%>/clientlplatform/updateImgName.controller",
				type : 'POST',
				dataType : "text",
				data : $( '#imgForm').serialize(),
				success : function(data) {
					if(data > 0){
						whir_alert1("提示信息","保存图片成功！","确定");
					}else{
						whir_alert1("提示信息","请先上传图片！","确定");
					}
				},
				error : function(data) {
					whir_alert1("提示信息","保存图片失败!","确定");
				}
			});
		}
	}


	/***************恢复默认*****************/
	function restoreDefault(){
		whir_alert2("确认信息","您确定要恢复默认吗？","确定","取消",
			function(){
				$.ajax({
					url : "<%=realpath%>/clientlplatform/resDefaultImg.controller",
					type : "POST",
					dataType : "json",
					success : function(data) {
						if(data != null){
							whir_alert1("提示信息","恢复默认成功！","确定");
							for(var i=0;i<data.length;i++){
								if(data[i].uploadType == '480*845'){
									var saveImgName1 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
									$('#clientImg1').attr("src", saveImgName1);
								}else if(data[i].uploadType == '720*1280'){
									var saveImgName2 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
									$('#clientImg2').attr("src", saveImgName2);
								}else if(data[i].uploadType == '750*1334'){
									var saveImgName3 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
									$('#clientImg3').attr("src", saveImgName3);
								}else if(data[i].uploadType == '1080*1920'){
									var saveImgName4 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
									$('#clientImg4').attr("src", saveImgName4);
								}else if(data[i].uploadType == '1242*2208'){
									var saveImgName5 = "/defaultroot/webplatform/images/ver113/webapp/pic-preview.jpg";
									$('#clientImg5').attr("src", saveImgName5);
								}
							}
						}else{
							whir_alert1("提示信息","恢复默认失败！","确定");
						}
					},
					error : function(data) {
						whir_alert1("提示信息","恢复默认图片出现异常！","确定");
					}
				});
			},function(){return;}
		);
	}
	
	
	
	/************删除图片************/
   function clearImg_1(){
		whir_alert2("确认信息","确定要删除吗？","确定","取消",
		   
		   function(){
              $('#div_clientImg1').hide();
			  $('#saveImgName1').val('');
			  $('#realImgName1').val('');
        	},function(){return;}
       	);
		
   }

	function clearImg_2(){
		whir_alert2("确认信息","确定要删除吗？","确定","取消",
		   
		   function(){
              $('#div_clientImg2').hide();
			  $('#saveImgName2').val('');
			  $('#realImgName2').val('');
        },function(){return;});
		
   }

   function clearImg_3(){
		whir_alert2("确认信息","确定要删除吗？","确定","取消",
		   
		   function(){
              $('#div_clientImg3').hide();
			  $('#saveImgName3').val('');
			  $('#realImgName3').val('');
        },function(){return;});
		
   }

   function clearImg_4(){
		whir_alert2("确认信息","确定要删除吗？","确定","取消",
		   
		   function(){
              $('#div_clientImg4').hide();
			  $('#saveImgName4').val('');
			  $('#realImgName4').val('');
        },function(){return;});
		
   }

   function clearImg_5(){
		whir_alert2("确认信息","确定要删除吗？","确定","取消",
		   function(){return;},
		   function(){
              $('#div_clientImg5').hide();
			  $('#saveImgName5').val('');
			  $('#realImgName5').val('');
        },function(){return;});
		
   }

   	//加载版本信息列表
	function loadPatchInfoDataList(url,pflag){
		$.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			success : function(data){
				versionFlag = '1';
				var patchDataList = data.patchDataList;
				var html ='';
				for(var i=0;i<patchDataList.length;i++){
					var patchdata = patchDataList[i];
					html +=  '<tr>'						  	
							+    '<td class="grey">'+patchdata[1]+'</td>'
							+    '<td class="grey">'+patchdata[2]+'</td>'
							+    '<td class="grey">'+patchdata[3]+'</td>'
							+  '</tr>';
												
				}
				if(pflag == '1'){
					$("#evo").append(html);
				}
				if(pflag == '0'){
					$("#web").append(html);
				}
				 
			},
			error : function(data) {
				whir_alert1("提示信息","数据获取失败!","确定");
			}
		});
	}
    
	//删除
	function del(mobileId){
		$.ajax({
			url : "<%=realpath%>/clientlplatform/clientplatformDelFile.controller?mobileId="+mobileId,
			type : "POST",    
			dataType:"text",
			data : "",    
			success : function(data) {
				var obj =  eval("("+data+")");
				if(obj.result == '1'){
									
				}
			},
			error : function(data) {
				whir_alert1("提示信息","evo数据删除失败!","确定");
			}  
		});
		$.ajax({
			url : "<%=realpath%>/clientlplatform/clientplatformDel.controller?mobileId="+mobileId,
			type : "POST",    
			dataType:"text",
			data :"",    
			success : function(data) {
				if(data == 1){
					alert('删除成功！');
					callback();
					window.close();
				}
			},
			error : function(data) {
				whir_alert1("提示信息","数据删除失败!","确定");
			}  
		});
	}
  </script>
</body>

</html>
