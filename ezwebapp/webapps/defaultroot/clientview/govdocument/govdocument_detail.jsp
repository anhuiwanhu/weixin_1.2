<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ include file="../common/headerInit.jsp" %>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>收文详情</title>
</head>
<%
	//String recordId = request.getParameter("recordId");
	String recordId = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("recordId")));
	String documentSendFileWriteOrg ="";
	String createdTime = "";
	String title = "";
	String goldGridId ="";
	String wordType ="";
	String accessoryName ="";
	String accessorySaveName ="";
	com.whir.ezmobile.controller.GovDocController govBd=new com.whir.ezmobile.controller.GovDocController();
	if(recordId == null || "".equals(recordId)){
		recordId = request.getParameter("id");
		java.util.Map docMap=govBd.getDocReceiveDetail(recordId,request);
		documentSendFileWriteOrg = (String)docMap.get("documentSendFileWriteOrg");
		createdTime = (String)docMap.get("createdTime");
		createdTime=createdTime.substring(0,16);
		title = (String)docMap.get("documentSendFileTitle");
		goldGridId =  (String)docMap.get("goldGridId");
  		wordType =  (String)docMap.get("documentWordType");
  		accessoryName =  (String)docMap.get("accessoryName");
		accessorySaveName =  (String)docMap.get("accessorySaveName");
		
		//recordId = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("id")));//request.getParameter("id");
		//documentSendFileWriteOrg = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("writeOrg")));//request.getParameter("writeOrg");
		//createdTime = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("createdTime")));//request.getParameter("createdTime");
		//createdTime= createdTime.substring(0,16);
		//title = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("title")));//request.getParameter("title");
		//goldGridId = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("goldGridId")));//request.getParameter("goldGridId");
  		//wordType =  EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("wordType")));//request.getParameter("wordType");
  		//accessoryName =  EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("accessoryName")));//request.getParameter("accessoryName");
		//accessorySaveName =  EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("accessorySaveName")));//request.getParameter("accessorySaveName");
	}else{
		//com.whir.webplatform.manage.bd.WebAppPlatformBD wapBD=new com.whir.webplatform.manage.bd.WebAppPlatformBD();
		java.util.Map docMap=govBd.getDocReceiveDetail(recordId,request);
		documentSendFileWriteOrg = (String)docMap.get("documentSendFileWriteOrg");
		createdTime = (String)docMap.get("createdTime");
		createdTime=createdTime.substring(0,16);
		title = (String)docMap.get("documentSendFileTitle");
		goldGridId =  (String)docMap.get("goldGridId");
  		wordType =  (String)docMap.get("documentWordType");
  		accessoryName =  (String)docMap.get("accessoryName");
		accessorySaveName =  (String)docMap.get("accessorySaveName");
	}
	
%>
<body class="grey-bg">
  <div class="views" style="overflow-x: hidden;">
    <div class="view view-main" style="overflow-x: hidden;">
      <div class="pages" style="overflow-x: hidden;">
        <div class="page" data-page="page-webapp-mail-readonly" style="overflow-x: hidden;">
          <section class="wh-section wh-section-bottomfixed" style="overflow-x: hidden;">
            <div class="webapp-mail-readonly">
              <table class="wh-table-edit" style="border-collapse:separate;border-spacing: 0 8px;width:100%">
                <tr>
                  <th><div style="width: 7rem;">拟稿单位：</div></th>
                  <td><span class="edit-ipt-reslut-l"><%=documentSendFileWriteOrg%></span></td>
                </tr>
                <tr>
                  <th><div style="width: 7rem;">分发日期：</div></th>
                  <td><span class="edit-ipt-reslut-l"><%=createdTime%></span></td>
                </tr>
                <tr>
                  <th><div style="width: 7rem;">公文标题：</div></th>
                  <td>
                    <span class="edit-ipt-reslut-l"><%=title%></span>
                  </td>
                </tr>
                <tr>
                  <th><div style="width: 7rem;">公文正文：</div></th>
                  <td>
                  	<%
                  		
                  		String goldGridIdwordType =goldGridId+wordType;
						String docRealName="点击查看正文"+wordType;
						if(!"".equals(goldGridId) && goldGridId != null ){
                  	%>
                    <div class="wh-article-atta">
                        <jsp:include page="../common/include_download.jsp" flush="true">
							<jsp:param name="realFileNames"	value="<%=docRealName%>" />
							<jsp:param name="saveFileNames" value="<%=goldGridIdwordType%>" />
							<jsp:param name="realtime" value="1" />
							<jsp:param name="moduleName" value="govdocumentmanager" />
							<jsp:param name="fileType" value="pdf" />
						</jsp:include>
                    </div>
                    <%
                    	}
                    %>
                  </td>
                </tr>
                <tr>
                  <th><div style="width: 7rem;">附件：</div></th>
                  <td>
                  	<%
						if(!"".equals(accessoryName) && accessoryName != null){
                  	%>
                    <div class="wh-article-atta">
						<jsp:include page="../common/include_download.jsp" flush="true">
							<jsp:param name="realFileNames"	value="<%=accessoryName%>" />
							<jsp:param name="saveFileNames" value="<%=accessorySaveName%>" />
							<jsp:param name="moduleName" value="govdocumentmanager" />
						</jsp:include>
                    </div>
                    <%
                    	}
                    %>
                  </td>
                </tr>
              </table>
            </div>
          </section>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="<%=rootPath%>/clientview/js/subClick.js"></script>
    <script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
  <script type="text/javascript">
  var myApp = new Framework7();

  var mainView = myApp.addView('.view');

  var $$ = Dom7;

  //右下角菜单弹框
$$('#fbtn-more').on('click', function () {
    var clickedLink = this;
    myApp.popover('#fbtn-more-con', clickedLink);
    myApp.closeModal('#fbtn-more-list a')
});

  </script>
</body>
