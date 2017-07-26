<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/headerInit.jsp" %>
<%@ page import="com.whir.component.security.crypto.*" %>
<c:if test="${not empty docXml3}">
	<x:parse xml="${docXml3}" var="doc3"/>  
	<c:set var="notFlow" ><x:out select="$doc3//notFlow/text()"/></c:set>
</c:if>
<head lang="en">
<%
	String userId = session.getAttribute("userId").toString();
	userId = "*" + userId + "*";
	String curClassId = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("curClassId")));
	if(curClassId == null){
		curClassId = "";
	}
%>
<c:set var="userId"><%= userId%></c:set>
<c:set var="curClassId"><%= curClassId%></c:set>

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>论坛</title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" /> 
</head>

<body class="grey-bg">
<c:choose>
<c:when test="${recordCount > 0}">
  <div class="views">
    <div class="view">
      <div class="pages" >
        <div class="page" data-page="page-webapp-focum">
          <section id="sectionScroll" class="section-focum section-focum-a infinite-scroll wh-section show wh-section-bottomfixed" style="padding-bottom: 4.5rem;">
		  	<c:set var="forumClassName">${forumClassName}</c:set>
			<%
          	//处理论坛版块名称过长
          	String forumClassName_new = (String)pageContext.getAttribute("forumClassName");
          	//System.out.print("forumClassName------->"+forumClassName_new);
          	if(forumClassName_new == null){
          		forumClassName_new = "";
          	}else{
          		if(forumClassName_new.length() > 6){
          			forumClassName_new = forumClassName_new.substring(0,6) + "...";
          		}
          	}
          	
           %>
		   <c:set var="forumClassName_new"><%=forumClassName_new %></c:set>
            <div class="focum-a">
                 <div class="detail">
                      <h3 class="detail-title"><strong>${topicForumTitle}</strong></h3>
                       <p class="detail-p"><a href="javascript:goForum();">${forumClassName_new}</a> <span>点击 ${topicForumKits}</span> <em>回复 ${topicForumReverts}</em></p>
                       <div class="follow" id="postList">
					       <x:parse xml="${docXml}" var="doc"/>
						<c:set var="recordCount"><x:out select="$doc//recordCount/text()" /></c:set>
						<x:forEach select="$doc//list" var="n"  varStatus="status">
							<c:set var="forumType" ><x:out select="$n/forumType/text()"/></c:set>
							<c:set var="id" ><x:out select="$n/id/text()"/></c:set>
							<c:set var="anonymous" ><x:out select="$n/anonymous/text()"/></c:set>
							<c:set var="curName">匿名</c:set>
							<c:if test="${anonymous == '0'}">
								<c:set var="curName" ><x:out select="$n/empName/text()"/></c:set>
							</c:if>       
							<c:if test="${anonymous == '2'}">
								<c:set var="curName" ><x:out select="$n/nickName/text()"/></c:set> 
							</c:if>
							<c:set var="authorPhoto"><c:out value="${authorPhotoArr[status.index]}"/></c:set>
							<%  
								String pic=(String)pageContext.getAttribute("authorPhoto");
								String photoPath = "";
								if(null != pic && !pic.equals("") && !"null".equals(pic)){
									photoPath = "/defaultroot/upload/peopleinfo/"+pic;
								}else{
									photoPath = "/defaultroot/clientview/images/user3.png";
								}
								if("1".equals((String)pageContext.getAttribute("anonymous"))) {
									photoPath = "/defaultroot/clientview/images/user3.png";
								} 
							%>
							<c:set var="floor" >${(status.index+1)+(offset-1)*15}</c:set>
							<c:set var="floorName" >${floor-1}楼</c:set>
							<c:if test="${floor == 1}">
								<c:set var="floorName" >楼主</c:set>
							</c:if>
							<c:set var="time" ><x:out select="$n/forumIssueTime/text()"/></c:set>
							<c:if test="${fn:indexOf(time,'.') > 0}">
								<c:set var="time">${fn:substringBefore(time,".")}</c:set>
							</c:if> 
							<c:set var="forumAuthorOrg" ><x:out select="$n/forumAuthorOrg/text()"/></c:set>
							<c:if test="${anonymous == '1'}">
								<c:set var="forumAuthorOrg" ></c:set>
							</c:if>       
							<c:set var="content" ><x:out select="$n/forumContent/text()"/></c:set>
							<%
								String aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("content"));
								//String aContent = (String) pageContext.getAttribute("content");
								aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
								aContent = com.whir.util.StringUtils.resizeImgSize(aContent, "200", "");
								aContent=com.whir.util.RegularUtils.replaceAllImages(aContent);
								aContent=com.whir.util.RegularUtils.candownloadHtmlfile(aContent);
							%>     
							<c:set var="newContent" value="<%=aContent%>" />

							<c:set var="sign" ><x:out select="$n/forumSign/text()"/></c:set>
							<%
								
								//String sign = (String) pageContext.getAttribute("sign");
								String sign = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("sign"));
								if(sign.equals("null")){
									sign = "";
								}
								//System.out.println("sign---------------->"+sign);
								sign = com.whir.util.RegularUtils.replaceAllImages(sign);
								sign = com.whir.util.RegularUtils.candownloadHtmlfile(sign);
								
								//sign = HtmlUtils.htmlUnescape(sign);
							%>
							<c:set var="newSign" value="<%=sign%>" />
							
							<c:set var="forumClassName">${forumClassName}</c:set>
							
							<!-- 区分楼主与其他用户的区别 -->
                           <div class="follow-list">
                                <div class="top clearfix">
                                <img src="<%=photoPath%>" class="fl">
								<%
									String forumAuthorOrg = (String)pageContext.getAttribute("forumAuthorOrg");
									String authorOrg = "";
									if(!"".equals(forumAuthorOrg) && forumAuthorOrg != null){
										authorOrg = forumAuthorOrg.substring(forumAuthorOrg.lastIndexOf(".")+1, forumAuthorOrg.length());
									}
			                     %>
                                <div class="fl">
                                     <p><%=authorOrg%>·${curName}</p>
                                     <em>${floorName} ${fn:substring(time,0,16)}</em>
                                </div>
								<c:if test="${notFlow != '1' && forumType != '2'}">
                                <a class="fr" href="javascript:toReply('toReplyForm_${id}');">引用</a>
								</c:if>
							   </div>
							   <div class="con">
								   <h2>${newContent}</h2>
								   <c:if test="${newSign != ''}">
                  					<p style="color: #3eaeff;">签名档：</p>${newSign }
                  				   </c:if>
								   <x:if select="$n/forumAttachName">
                  					<c:set var="names" ><x:out select="$n/forumAttachName/text()"/></c:set>
									<c:set var="savenames" ><x:out select="$n/forumAttachSave/text()"/></c:set>
									<%
										String savenames = (String)pageContext.getAttribute("savenames");
										//System.out.println("cs0---"+savenames);
										String[] snames = savenames.split("\\|");
										for(int i = 0; i < snames.length; i++){
											if(snames[i] != null && !snames[i].equals("")){
											//System.out.println("cs---"+snames[i]);
												String fileType  = snames[i].substring(snames[i].lastIndexOf("."));
	    										fileType = fileType .toLowerCase();
												if(".jpg".equals(fileType.toLowerCase()) || ".png".equals(fileType.toLowerCase()) || ".jpeg".equals(fileType.toLowerCase()) || ".bmp".equals(fileType.toLowerCase())){
									%>													
														<input type="hidden" name="fileImgName" value="<%=snames[i] %>" />
														<a name="<%=snames[i].split("\\.")[0] %>">
															<img src="" name="<%=snames[i].split("\\.")[0] %>"/>
														</a>													
									<%
												}
											}  
										}
									%>
                  				</x:if>
							   </div>
								<x:if select="$n/forumAttachName">
									<c:set var="names" ><x:out select="$n/forumAttachName/text()"/></c:set>
									<c:set var="savenames" ><x:out select="$n/forumAttachSave/text()"/></c:set>
									<c:if test="${ not empty names}">
										<%
											String names = (String)pageContext.getAttribute("names");
											names = names.replace("||", "|");
											if(names.substring(0, 1).equals("|")){
												names = names.substring(1, names.length());
											}
											
											String savenames = (String)pageContext.getAttribute("savenames");
											savenames = savenames.replace("||", "|");
											if(savenames.substring(0, 1).equals("|")){
												savenames = savenames.substring(1, savenames.length());
											}
										%>
										
										<jsp:include page="../common/include_download.jsp" flush="true">
											<jsp:param name="realFileNames"	value="<%=names%>" />
											<jsp:param name="saveFileNames" value="<%=savenames%>" />
											<jsp:param name="moduleName" value="forum" />
										</jsp:include>
									 </c:if>
								</x:if>
                           </div>
						   <form action="/defaultroot/post/reply.controller" id="toReplyForm_${id}" method="post">
								<input type="hidden" value="${postId}" name="postId"/>
								<input type="hidden" value="${content}" name="content"/>
								<input type="hidden" value="${floor}" name="forumFloor"/>
								<input type="hidden" value="${curName}" name="forumUserName"/>
								<input type="hidden" value="${time}" name="forumIssueTime"/>
								<input type="hidden" value="${id}" name="forumId"/>
							</form>
						   </x:forEach>
                       </div>
                       
                 </div>
            </div>
          
          </section>
		  <c:if test="${notFlow != '1' && topicForumType != '2'}">
          <footer class="wh-footer wh-footer-forum">
              <div class="wh-container">
                  <div class="wh-footer-btn row">
                      <div class="webapp-footer-linebtn">
                          <div class="fl clearfix">
                              <a href="javascript:goReply('${postId}','1');" class="panel-return-a" >回复该帖</a>
                          </div>
                          <!-- <a id="fbtn-form-more" data-popover=".popover-links" class="fr fbtn-more link open-popover "><span>更多</span></a> -->
                      </div>
                  </div>
              </div>
          </footer>
          </c:if>
        </div>
      </div>
    </div>
  </div>
   </c:when>
  <c:otherwise>
  	<script>
 		$(function(){
 			myApp.alert('抱歉，此页面不存在或被删除！', function () {
        		window.history.back();
    		});
 			
 		});
 	</script> 
  </c:otherwise>
</c:choose>
</body>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="/defaultroot/webplatform/scripts/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/template115/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
	var myApp = new Framework7();
	var $$ = Dom7;

	var nomore = "";
	var offset = "";
	var recordCount = '${recordCount}';
	var loading = false;
	var classOwnerIds = '${classOwnerIds}';//版主id
	var userId = '${userId}';//当前登录人id
	$(function(){
		
		//回复引用后返回该页面做出是否需要审核判断
		var checkexamin = '${param.checkexamin}';
		if(checkexamin == '1'){
			if(classOwnerIds == userId){
				return;
			}else{
				myApp.alert("回复或引用后的帖子需要版主审核！");
			}
		}
		
		
		nomore = $("#nomore").val();
		offset = $("#offset").val();
		if(nomore){
			$(".wh-load-box").css("display","block");
		}else{
			$(".wh-load-box").css("display","none");
		}
	});
	
	
	//打开附件
	function downFile(menuHtmlLink,menuFileLink,aId) {
		var path = 'information';
	  	if(aId == undefined){
	  		aId = menuHtmlLink.split('.')[0];
	  		path = 'html';
	  	}
	  		
	  	$.ajax({
			type: 'post',
			url: "<%=rootPath%>/download/getOpenFileUrl_New.controller",
			dataType:'text',
			data : {"fileName": menuHtmlLink,"name": menuFileLink,"path":path},
			success: function(data){
				var jsonData = eval("("+data+")");
				clickSub(jsonData.url,$('#'+aId),menuHtmlLink,"information",jsonData.smartInUse,jsonData.isEncrypt,jsonData.tmpurl,jsonData.apptype);
			},error: function(xhr, type){
				//alert('数据查询异常！');
			}
		});
	  		
	}




	//下拉加载数据
	$$(document).on('infinite', '#sectionScroll', function() {
		//alert("下滑加载开始");
		// 如果正在加载，则退出
		if (loading){ 
			return; 
		}
		loading = true;
		var postList = $$('#postList div').length;
		//alert(postList+",,,,,"+recordCount);
		setTimeout(function() {
			loading = false;
			if (postList >= recordCount) {
				// 加载完毕，则注销无限加载事件，以防不必要的加载
				myApp.detachInfiniteScroll($$('#sectionScroll'));
				// 删除加载提示符
				$$('.wh-load-md').hide();
				return;
			}
			if (recordCount - postList > 0) {
				//curpage = curpage + 1;
				loadNextPage();
			}
		}, 500);
	});


	//加载下一页内容
	function loadNextPage(){
		var $postList = $('#postList');
		if($postList.data('loadflag') == '1'){
			return;
		}
		$postList.data('loadflag','1');
		if(nomore){
			offset = parseInt(offset) + 1 + "";
			var nextPageUrl = "/defaultroot/post/pageInfo.controller?pageSize="+offset+"&postId=${postId}";
			$(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
			$.ajax({
				url : nextPageUrl,
				type : "post",
				success : function(data){
					//alert(data);
					nomore = $($(data)[25]).val();
					offset = $($(data)[23]).val();
					//alert(nomore+",,,,,,,,,,"+offset);
					if(nomore){
						$(".wh-load-tap").html("上滑加载更多");
						$(".wh-load-box").css("display","block");
						$(".wh-load-md").css("display","none");
					}else{
						$(".wh-load-box").css("display","none");
					}
					$("#postList").append($("li",data));
					//$content.data('loadflag','0');
				},
				error:function(data){
					$(".wh-load-box").html("加载失败！");
				}
			});
		}
	}


	//回复页面跳转
	function goReply(postId,forumFloor){
		window.location = "/defaultroot/post/reply.controller?forumFloor="+forumFloor+"&postId=${postId}";
	}

	//引用
	function toReply(id){
		$("#"+id).submit();
	}

	//点击版块名称跳转
	function goForum(){
		window.location = "/defaultroot/post/list.controller?classId=${curClassId}&className=${forumClassName}";
	}

	
	$(function(){
		loadFileImg();
	});
	function loadFileImg(){
		$("input[name='fileImgName']").each(function (){
			var filename = $(this).val();
			var id = filename.split(".")[0];
			if(filename != 'null'){
				$.ajax({
					type : 'post',
					url : '<%=rootPath%>/download/downloadImg.controller',
					dataType : 'text',
					data : {"fileName":filename,"name":filename,"path":"forum"},
					success : function(data){
						$('img[name='+id+']').attr("src","/defaultroot"+data);
						$('img[name='+id+']').attr("width","100%");
						$('img[name='+id+']').attr("height","20%");
						//$('a[name='+id+']').attr("href","/defaultroot"+data);
						$('img[name='+id+']').attr("onclick","window.open('/defaultroot"+data+"')");
						
					},
					error : function (xhr,type){
						//alert('数据查询异常！');
					}
				});
			}
		});
	}
	

</script>

