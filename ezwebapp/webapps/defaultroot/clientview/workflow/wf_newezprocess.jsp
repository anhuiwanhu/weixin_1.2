<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ include file="/clientview/common/headerInit.jsp" %>
<%
String pageId = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("pageId"));
String processId = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("processId"));
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
String frommodule = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("frommodule"));
String menuId = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("menuId"));
String menuName = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("menuName"));
String userName = session.getAttribute("userName")==null?"":session.getAttribute("userName").toString();
Date date=new Date();//获取时间
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//转换格式
String nowDate = sdf.format(date);
%>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title><c:out value='${param.processName}' escapeXml='false'/></title>
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.style.ios.min.css" />
  <link rel="stylesheet" href="/defaultroot/clientview/template/css/template.webapp-style.min.css" />

  <script type="text/javascript" src="<%=rootPath%>/clientview/custmenu/js/custmenu.js"></script>

</head>
<body class="grey-bg">
  <div class="panel panel-right panel-reveal" style="width:22rem;"> 
	<div class="panel-title">
		<p style="text-align: center;">已选列表</p>
	</div>
	<div class="todo-list">
	   <div class="list-block">
			 <ul id="selectedPer">
			 </ul>
	  </div>
	</div>
</div>
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-form-edit">
		 <form id="sendForm" action="/defaultroot/workflow/firstezflowsend.controller" method="post">
          <section class="wh-section wh-section-bottomfixed" id="mainContent">
            <div class="webapp-form">
              <div class="form-table">
                <c:if test="${not empty docXml}">
	                <x:parse xml="${docXml}" var="doc2"/>
					<c:if test="${not empty docXml1}">
	            		<x:parse xml="${docXml1}" var="doc3"/>
	            		<c:set var="hideField"><x:out select="$doc3//hideField/text()"/></c:set>
	           		</c:if>
	           		<input  id="__sys_pageId" type="hidden"  name="__sys_pageId" value="<%=pageId%>" />
					<input  id="processId" type="hidden"  name="processId" value="<%=processId%>" />
					<input  id="frommodule" type="hidden"  name="frommodule" value="<%=frommodule%>" />
					<input id="menuId" type="hidden" name="menuId" value="<%=menuId%>" />
					<input id="menuName" type="hidden" name="menuName" value="<%=menuName%>" />
					<input  id="__main_tableName" type="hidden"  name="__main_tableName" value='<x:out select="$doc2//fieldList/tableName/text()"/>' />
	                <table style="border-collapse:separate;border-spacing: 0 10px;" id="table_form">
	                  <!--主表信息begin-->
	            	<x:forEach select="$doc2//fieldList/field" var="fd" >
	            		<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
	            		<c:set var="value"><x:out select="$fd/value/text()"/></c:set>
            			<c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
						<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
						<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
						<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
						<c:set var="id">$<x:out select="$fd/sysname/text()"/>$</c:set>
						<tr>
							<c:if test="${not empty docXml1}">
							<td><span><c:if test="${mustfilled == 1 && fn:indexOf(hideField, id) == -1}"><em>*</em></c:if><x:out select="$fd/name/text()"/>：</span></td>
							</c:if>
							<c:if test="${empty docXml1}">
							<td><span><c:if test="${mustfilled == 1}"><em>*</em></c:if><x:out select="$fd/name/text()"/>：</span></td>
							</c:if>
							<td>
								<c:choose>
									<%--单行文本 101--%>
									<c:when test="${showtype =='101' && readwrite =='1'}">
										<div>
										<c:if test="${ fieldtype == '1000000'  }">
											<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' onkeyup="mainMath(this);"/>
										</c:if>
										<c:if test="${ fieldtype == '1000001'   }">
											<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="18" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' onkeyup="mainMath(this);"/>
										</c:if>
										<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
											<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text"  name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										</c:if>
										</div>
									</c:when>
									
									<%--密码输入 102--%>
									<c:when test="${showtype =='102' && readwrite =='1'}">
										<div><input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="password" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' /></div>
									</c:when>
									
									<%--单选 103--%>
									<c:when test="${showtype =='103' && readwrite =='1'}">
										<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
										<ul class="edit-radio">
											<x:forEach select="$fd//dataList/val" var="selectvalue" >
											<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
											<li>
												<label class="label-checkbox item-content" >
													<input type="radio" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="selected"</c:if> />
													<span class="edit-radio-l"><x:out select="$selectvalue/showval/text()"/></span>
												</label>
											</li>
											</x:forEach>
										</ul>
									</c:when>
									
									<%--多选 104--%>
									<c:when test="${showtype =='104' && readwrite =='1'}">
										<c:set var="selectedvalue">,<x:out select="$fd/hiddenval/text()"/></c:set>
											<ul class="edit-radio">
												<x:forEach select="$fd//dataList/val" var="selectvalue" >
												<c:set var="curvalue">,<x:out select="$selectvalue/hiddenval/text()"/>,</c:set>
												<li class="">
													<label class="label-checkbox item-content" for='checkIput<x:out select="$fd/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>'>
														<input type="checkbox" name='_main_<x:out select="$fd/sysname/text()"/>' id='checkIput<x:out select="$fd/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>' value='<x:out select="$selectvalue/hiddenval/text()"/>,' <c:if test="${fn:indexOf(selectedvalue, curvalue) > -1}">checked="true"</c:if> />
														<span class="edit-radio-l"><x:out select="$selectvalue/showval/text()"/></span>
													</label>
												</li>
												</x:forEach>
											</ul>
									</c:when>
									
									<%--下拉框 105--%>
									<c:when test="${showtype =='105' && readwrite =='1'}">
										<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
										<div class="edit-direct">
											<div class="edit-sel-show">
												<span>请选择</span>
											</div>    
											<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
												<option value="">请选择</option>
												<x:forEach select="$fd//dataList/val" var="selectvalue" >
													<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
													<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
												</x:forEach>
											</select>
										</div>
									</c:when>
									
									<%--日期 107--%>
									<c:when test="${showtype =='107' && readwrite =='1'}">
										<x:forEach select="$fd//dataList/val" var="selectvalue" >
											<c:set var="showVal"><x:out select="$selectvalue/showval/text()"/></c:set>
										</x:forEach>
										<div class="edit-ipt-a-arrow">
											<input  class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='${showVal}' onfocus="selectDateNew(this)" placeholder="选择日期" readonly/>
											<label class="edit-ipt-label" for="scroller"></label>
										</div>
									</c:when>
	
									<%--时间 108--%>
									<c:when test="${showtype =='108' && readwrite =='1'}">
										<x:forEach select="$fd//dataList/val" var="selectvalue" >
											<c:set var="showVal"><x:out select="$selectvalue/showval/text()"/></c:set>
										</x:forEach>
										<div class="edit-ipt-a-arrow">
											<input  class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='${showVal}' onfocus="selectTimeNew(this)" placeholder="选择时间" readonly/>
											<label class="edit-ipt-label" for="scroller"></label>
										</div>
									</c:when>
	
									<%--日期 时间 109--%>
									<c:when test="${showtype =='109' && readwrite =='1'}">
										<x:forEach select="$fd//dataList/val" var="selectvalue" >
											<c:set var="showVal"><x:out select="$selectvalue/showval/text()"/></c:set>
										</x:forEach>
										<div class="edit-ipt-a-arrow">
											<input  class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='${showVal}' onfocus="selectDateTimeNew(this)" placeholder="选择日期时间" readonly/>
											<label class="edit-ipt-label" for="scroller"></label>
										</div>
									</c:when>
									
									<%--多行文本 110--%>
									<c:when test="${showtype =='110' && readwrite =='1'}">
										<div>
											<textarea name='_main_<x:out select="$fd/sysname/text()"/>' rows="4" onkeyup="$(this).next('.edit-form-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="166"><x:out select="$fd/value/text()"/></textarea>
											<span class="edit-form-num">166</span>
										</div>
									</c:when>
	
									<%--自动编号 111--%>
									<c:when test="${showtype =='111' && readwrite =='1'}">
										<div>
											<x:out select="$fd/value/text()"/>
											<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										</div>
									</c:when>
	
									<%--html编辑 113--%>
									<c:when test="${showtype =='113' && readwrite =='1'}">
										<div>
					                        <textarea class="edit-txta edit-txta-l" name='_main_<x:out select="$fd/sysname/text()"/>'  onkeyup="$(this).next('.edit-form-num').html($(this).attr('maxlength')-$(this).val().length );" maxlength="300"><x:out select="$fd/value/text()"/></textarea>
					                        <span class="edit-form-num">300</span>
					                    </div>
									</c:when>
									
									<%--附件上传 115--%>
									<c:when test="${showtype =='115'}">
									    <c:set var="attachment"><x:out select="$fd/sysname/text()"/></c:set>
									    <%
										String att =(String)pageContext.getAttribute("attachment");
										String natt = att.replace("$","");
                                        pageContext.setAttribute("attachment",natt);
										%>
										<c:if test="${readwrite =='1'}">
											<ul class="edit-upload">
					                            <li class="edit-upload-in" id='${attachment}' onclick="addImg('<x:out select="$fd/sysname/text()"/>');"><span><i class="fa fa-plus"></i></span></li>
					                        </ul>
										</c:if>
										<c:set var="values"><x:out select="$fd/value/text()"/></c:set>
										<c:if test="${not empty values}">
											<%
											String realFileNames ="";
											String saveFileNames ="";
											String moduleName ="customform";
											String aValues =(String)pageContext.getAttribute("values");
											aValues = aValues.replaceAll("&amp;", "&");
											String[] aval  = aValues.split(";");
											String[] aval0=new String[0];
											String[] aval1=new String[0];
											if(aval[0] != null && aval[0].endsWith(",")) {
												saveFileNames =aval[0].substring(0, aval[0].length() -1);
												saveFileNames =saveFileNames.replaceAll(",","|");
											}
											if(aval[1] != null && aval[1].endsWith(",")) {
												realFileNames =aval[1].substring(0, aval[1].length() -1);
												realFileNames =realFileNames.replaceAll(",","|");
											}
											%>
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
												<jsp:param name="moduleName" value="<%=moduleName%>" />
											</jsp:include>
											<input name="fileNames<x:out select="$fd/sysname/text()"/>" value="${values}" type="hidden"/>
										</c:if>
									</c:when>
	
									<%--Word编辑 116--%>
									<c:when test="${showtype =='116'}">
										<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
										<c:if test="${not empty filename}">
											<%
											String realFileNames ="";
											String saveFileNames ="";
											String moduleName ="information";
											realFileNames =(String)pageContext.getAttribute("filename")+".doc";
											saveFileNames =(String)pageContext.getAttribute("filename")+".doc";
											%>
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
												<jsp:param name="moduleName" value="<%=moduleName%>" />
											</jsp:include>
										</c:if>
										<c:if test="${empty filename && readwrite =='1'}">
											该字段暂不支持手机办理，请于电脑端操作。
										</c:if>
									</c:when>
	
									<%--Excel编辑 117--%>
									<c:when test="${showtype =='117'}">
										<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
										<c:if test="${not empty filename}">
											<%
											String realFileNames ="";
											String saveFileNames ="";
											String moduleName ="information";
											realFileNames =(String)pageContext.getAttribute("filename")+".xls";
											saveFileNames =(String)pageContext.getAttribute("filename")+".xls";
											%>
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
												<jsp:param name="moduleName" value="<%=moduleName%>" />
											</jsp:include>
										</c:if>
										<c:if test="${empty filename && readwrite =='1'}">
											该字段暂不支持手机办理，请于电脑端操作。
										</c:if>
									</c:when>
	
									<%--WPS编辑 118--%>
									<c:when test="${showtype =='118'}">
										<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
										<c:if test="${not empty filename}">
											<%
											String realFileNames ="";
											String saveFileNames ="";
											String moduleName ="information";
											realFileNames =(String)pageContext.getAttribute("filename")+".wps";
											saveFileNames =(String)pageContext.getAttribute("filename")+".wps";
											%>
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
												<jsp:param name="moduleName" value="<%=moduleName%>" />
											</jsp:include>
										</c:if>
										<c:if test="${empty filename && readwrite =='1'}">
											该字段暂不支持手机办理，请于电脑端操作。
										</c:if>
									</c:when>
	
									<%--当前日期 204--%>
									<c:when test="${showtype =='204' && readwrite =='1'}">
										<x:out select="$fd/value/text()"/>
										<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:when>
									
									<%--登录人信息 --%>
									<c:when test="${( showtype =='213' || showtype =='215'|| showtype =='406'|| showtype =='601'|| showtype =='602'|| showtype =='603'|| showtype =='604'|| showtype =='605'|| showtype =='607'|| showtype =='701'|| showtype =='702'|| showtype =='201'|| showtype =='202' || showtype =='207'  ) && readwrite =='1'}">
										<div>
											<c:choose>
											     <%--当前登录人 --%>
												<c:when test="${showtype == '202'}">
													<%=userName%>
													<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value="<%=userName%>" />
												</c:when>
												<%--最末端组织 --%> 
												<c:when test="${expressionval == 'self'}">
													<%
														String valuestr = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("value"));
														String[] values = valuestr.split("\\.");
														String valueSelf = values[values.length-1];
													%>
													<%=valueSelf %>
													<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
												</c:when>
												<%--组织长信息 --%>
												<c:when test="${expressionval == 'full'}">
													<x:out select="$fd/value/text()"/>
													<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
												</c:when>
												<%--从本单位开始至末端 --%>
												<c:when test="${expressionval == 'unit'}">
													<x:out select="$fd/value/text()"/>
													<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
												</c:when>
												<%--最末端组织向上一级 --%>
												<c:when test="${expressionval == 'parent'}">
													<%
														String valuestr = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("value"));
														String[] values = valuestr.split("\\.");
														String valueSelf = values[values.length-1];//最末端
														String valueSelfUp = values[values.length-2];//最末端向上一个
	
														String valueSelfUps = valueSelfUp + "." + valueSelf;
													%>
													<%=valueSelfUps %>
													<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
												</c:when>
											</c:choose>
										</div>
									</c:when>
	
									<%--单选人 全部 210--%>
									<c:when test="${showtype =='210' && readwrite =='1'}">
										<div>
											<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
				           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user")' placeholder="请选择"/>
										</div>
									</c:when>
	
									<%--多选人 全部 211--%>
									<c:when test="${showtype =='211' && readwrite =='1'}">
										<div>
											<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
				           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user");' placeholder="请选择"/>
										</div>
									</c:when>
	
									<%--单选组织 212--%>
									<c:when test="${showtype =='212' && readwrite =='1'}">
										<div>
											<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
				           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/> 
										</div>
									</c:when>
	
									<%--多选组织 214--%>
									<c:when test="${showtype =='214' && readwrite =='1'}">
										<div>
											<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
				           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/>
										</div>
									</c:when>

									<%--多选组织和人 216--%>
									<c:when test="${showtype =='216' && readwrite =='1'}">
										<div>
											<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
				           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","orguser");' placeholder="请选择"/>
										</div>
									</c:when>
									
									<%--金额 301--%>
									<c:when test="${showtype =='301' && readwrite =='1'}">
										<div>
											<c:if test="${fieldtype == '1000000' || fieldtype == '1000001'  }">
												<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="changeMoney('<x:out select='$fd/sysname/text()'/>');mainMath(this);" value='<x:out select="$fd/value/text()"/>' />
											</c:if>
											<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
												<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="changeMoney('<x:out select='$fd/sysname/text()'/>');mainMath(this);" value='<x:out select="$fd/value/text()"/>' />
											</c:if>
										</div>
									</c:when>
									<%--金额大写 302--%>
									<c:when test="${showtype =='302'}">
									    <c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
									    <%
										String exp =(String)pageContext.getAttribute("expressionval");
										String nexp = exp.replace("$","");
                                        pageContext.setAttribute("expressionval",nexp);
										%>
										<div>										
											<input class="edit-ipt-r" placeholder="" id="${expressionval}" type="text" maxlength="18" name='_main_<x:out select="$fd/sysname/text()"/>' readonly="readonly"/>	
										</div>
									</c:when>
									<%--批示意见 401--%>
									<c:when test="${showtype =='401' }">
										<div>
											<c:if test="${readwrite =='1' }">
												<textarea class="edit-txta edit-txta-l" placeholder="请输入" name="comment_input" id="comment_input" maxlength="50"></textarea>
												<div class="edit-direct" >
													<div class="edit-sel-show">
														<span>常用审批语</span>
													</div>    
													<select class="btn-bottom-pop" onchange="selectComment(this);">
														<option value="">常用审批语</option> 
														<option value="同意">同意</option>
														<option value="已阅">已阅</option>
													</select>
												</div>
											</c:if>
											<c:if test="${readwrite =='0' }">
												<x:forEach select="$fd//dataList/comment" var="ct" >
													<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
												</x:forEach>
											</c:if>
										</div>
									</c:when>

									<%--合计字段 606--%>            
									<c:when test="${showtype =='606'}">
									    <c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
										<%
										String exp =(String)pageContext.getAttribute("expressionval");
										String[] newexpArr = exp.split("\\.");
										String  newxp = newexpArr[2];
										String nexp = (String)newxp.substring(0,newxp.length()-1);
										//nexp = nexp.replace("$","");
                                        pageContext.setAttribute("expressionval",nexp);
										%>
										<c:if test="${readwrite == '1'}">
										<div>
											<input class="edit-ipt-r mainhj" mainsum="${expressionval}" placeholder="" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' readonly="readonly"/>
                                        </div>
										</c:if>
										<c:if test="${readwrite != '1'}">
										<div>
											<input class="edit-ipt-r mainhj" placeholder="" mainsum="${expressionval}" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' />
                                        </div>
										</c:if>
									</c:when>
									
									<%--当前日期时间 703--%>
									<c:when test="${showtype =='703' && readwrite =='1'}">
										<div>
											<x:out select="$fd/value/text()"/>
											<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										</div>
									</c:when>
	
									<%--单选人 本组织 704--%>
									<c:when test="${showtype =='704' && readwrite =='1'}">
										<div>
											<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
											<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
										</div>
									</c:when>
									
									<%--多选人 本组织 705--%>
									<c:when test="${showtype =='705' && readwrite =='1'}">
										<div>
											<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
											<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
										</div>
									</c:when>
	
									<%--流程发起人 708--%>
									<c:when test="${showtype =='708' && readwrite =='1'}">
										<div>
											该字段暂不支持手机办理，请于电脑端操作。
										</div>
									</c:when>
									<%--日期时间计算 808--%>
									<c:when test="${showtype =='808' && readwrite =='1'}">
										<div>
										该字段暂不支持手机办理，请于电脑端操作。
										</div>
									</c:when>
									<%--计算字段 203--%>
									<c:when test="${showtype =='203' && readwrite =='1'}">
										<c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
										<div>
										<input class="edit-ipt-r mainmath" readonly="readonly" mainmathfun="${expressionval}" type="text" maxlength="18" id='<x:out select="$fd/sysname/text()"/>'  name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										</div>
									</c:when>
									<c:otherwise>
										<x:out select="$fd/value/text()"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
	            	</x:forEach>
	            	<x:forEach select="$doc2//subTableList/subTable" var="st">
						<c:set var="subName" ><x:out select="$st/name/text()"/></c:set>
						<c:set var="subTableName" ><x:out select="$st/tableName/text()"/></c:set>
						<input name="subTableName" value="${subTableName}" type="hidden" />
						<input name="subName" value="${subName}" type="hidden" />
						<c:if test="${not empty subName}">
							<tr>
								<td><span>子表（${subName}）填写：</span></td>
								<td>
									<div>
										<input id="subTableInput_${subTableName}" placeholder="添加子表" type="text" class="edit-ipt-r edit-ipt-arrow" 
										value="" readonly="readonly" onclick="addSubTable('${subTableName}');"/>
									</div>
								</td>
							</tr>
						</c:if>
					</x:forEach>
	              </table>
              </c:if>
            </div>
          </section>
          <footer class="wh-footer wh-footer-forum" id="footerButton">
            <div class="wh-container">
              <div class="wh-footer-btn row">
                <div class="webapp-footer-linebtn">
                  <div class="fl clearfix">
                    <a href="javascript:sendFlow();">发送</a>
                  </div> 
                </div>
              </div>
            </div>
          </footer>
		   <jsp:include page="../common/include_workflow_subTable.jsp" flush="true">
			 <jsp:param name="docXml" value="${docXml}" />
			 <jsp:param name="orgId" value="<%=orgId %>" />
		  </jsp:include>
		  </form>
		  <section id="selectContent" style="display:none">
		  </section>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript" src="/defaultroot/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/subClick.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/common.js"></script>
<script type="text/javascript" src="/defaultroot/clientview/js/ajaxfileupload.js"></script>

<script type="text/javascript">
  var myApp = new Framework7({
      fastClicks: false,
  });
  var $$ = Dom7;
</script>

<script type="text/javascript">
  var mainView = myApp.addView('.view');
  //右下角菜单弹框
  $$('#fbtn-more').on('click', function () {
    var clickedLink = this;
    myApp.popover('#fbtn-more-con', clickedLink);
    myApp.closeModal('#fbtn-more-list a')
  });
  
  	//解决input输入框的问题
	document.write( '<style>#footerButton{visibility:hidden}@media(min-height:' + ($( window ).height() - 10) + 'px){#footerButton{visibility:visible}}</style>' );
	if(/Android [4-6]/.test(navigator.appVersion)) {
	    window.addEventListener("resize", function() {
	        if(document.activeElement.tagName=="INPUT" || document.activeElement.tagName=="TEXTAREA") {
	            window.setTimeout(function() {
	                document.activeElement.scrollIntoViewIfNeeded();
	            },0);
	        }
	    })
	}
	//解决input输入框的问题
  
    function pageLoaded(){
        if (document.readyState == "complete") {
            setTimeout(function(){
                myApp.hidePreloader();
            },500);
        }
    }

    $(function(){
		$$("ul.edit-radio li").click(function(){
		     if($$(this).hasClass("radio-active")){
		        $$(this).removeClass("radio-active");
		     }else{
		        $$(this).addClass("radio-active");
		     }
		  });
		$("textarea").each(function(){
			$(this).change(function(){ 
				$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );
			});
		});
    });
    
    //金额大写
	function changeMoney(id,name){
		var val =document.getElementById(id).value;
		if(isNaN(val)){
			document.getElementById(id).value="";
			myApp.alert("请输入数字");
			return false;
		}
		var cid = id.replace("$","");
        var valRmb = changeNumMoneyToChinese(val);
		if($("#" + cid).val() != 'undefined'){
			$("#" + cid).val(valRmb);				
		}
	}
    
    //保存草稿
    function saveDraft(){
    	myApp.alert("功能暂无......");
	}

    //发送
    var sendFlag = '0';
	function sendFlow(){
		if(confirmForm()){
			if(sendFlag == '1'){
				return;
			}
			sendFlag = '1';
			$('#sendForm').submit();
		}
	}
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range,listType){ 
		myApp.showPreloader('页面加载中...');
		var selectIdVal = $('input[id="'+selectId+'"]').val();
		if(listType=='orguser'){
			if(selectIdVal.indexOf(";") > 0 ){
				var selectIdArray = selectIdVal.split(';');
				selectIdVal = selectIdArray[1];
			}
			
			if(selectIdVal){
				selectIdVal = selectIdVal.replace(/\\$\\$/g,'$,$').replace(/\*\*/g,'*,*').replace(/\*\\$/g,'*,$').replace(/\\$\*/g,'$,*');
			}
		}else{
			if( selectIdVal.indexOf(";") > 0 ){
				var selectIdArray = selectIdVal.split(';');
				selectIdVal = selectIdArray[1];
			}
			if(selectIdVal.indexOf('$') != -1){
				var selectIdArray = selectIdVal.split('$');
				if(selectIdArray){
					selectIdVal = '';
					for(var i=0,length=selectIdArray.length;i<length;i++){
						if(selectIdArray[i]){
							selectIdVal += selectIdArray[i] + ',';
						}
					}
				}
			}
		}
		var postUrl = '';
		if(listType == 'org'){
			postUrl = '/defaultroot/newperson/orgList.controller';
		}else if(listType=='user'){
			postUrl = '/defaultroot/newperson/personList.controller';
		}else if(listType=='orguser'){
			postUrl = '/defaultroot/newperson/personOrgList.controller';
		}
		$.ajax({
			url : postUrl,
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('input[id="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$("#selectContent").append(data);
				hiddenContent(0);
				myApp.hidePreloader();
			}
		});
	}
    	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag == 0){
			addCssByLink('/defaultroot/clientview/template/css/template.style.ios.min.css');
		    addCssByLink('/defaultroot/clientview/template/css/template.webapp-style.min.css');
			removejscssfile('/defaultroot/clientview/template115/css/template.reset.css','css');
	        removejscssfile('/defaultroot/clientview/template115/css/template.icon.css','css');
			removejscssfile('/defaultroot/clientview/template115/css/template.fa.css','css');
			removejscssfile('/defaultroot/clientview/template115/css/template.style.css','css');
			removejscssfile('/defaultroot/clientview/template115/css/alert/template.alert.css','css');
			removejscssfile('/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.icons.css','css');
		    removejscssfile('/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.scroller.css','css');
		    removejscssfile('/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.scroller.ios7.css','css');
		    removejscssfile('/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.animation.css','css');
			removejscssfile('/defaultroot/clientview/template115/css/template.swiper.css','css');
			if($('#mainContent').is(':hidden')){
				$('[id="subHeader_'+subTableName+'"]').hide();
				$('[id="subSection_'+subTableName+'"]').hide();
				$('[id="subFooter_'+subTableName+'"]').hide();
				$('[id="subHeader_'+subTableName+'"]').data('hide','1');
			}else{
				$("#mainContent").css("display","none");
				$("#footerButton").css("display","none");
			}
			$("#selectContent").css("display","block");
		}else if(flag == 1){
			if($('[id="subHeader_'+subTableName+'"]') && $('[id="subSection_'+subTableName+'"]').is(':hidden') 
					&& $('[id="subHeader_'+subTableName+'"]').data('hide') == '1'){
				removejscssfile('/defaultroot/clientview/template/css/template.style.ios.min.css', 'css');
		     	removejscssfile('/defaultroot/clientview/template/css/template.webapp-style.min.css', 'css');
		        addCssByLink('/defaultroot/clientview/template115/css/template.reset.css');
		        addCssByLink('/defaultroot/clientview/template115/css/template.icon.css');
				addCssByLink('/defaultroot/clientview/template115/css/template.fa.css');
				addCssByLink('/defaultroot/clientview/template115/css/template.style.css');
				addCssByLink('/defaultroot/clientview/template115/css/alert/template.alert.css');
				addCssByLink('/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.icons.css');
			    addCssByLink('/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.scroller.css');
			    addCssByLink('/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.scroller.ios7.css');
			    addCssByLink('/defaultroot/clientview/template115/css/mobiscroll/mobiscroll.animation.css');
				addCssByLink('/defaultroot/clientview/template115/css/template.swiper.css');
				$('[id="subHeader_'+subTableName+'"]').data('hide','0');
				$('#selectContent').hide();
				$('[id="subHeader_'+subTableName+'"]').show();
				$('[id="subSection_'+subTableName+'"]').show();
				$('[id="subFooter_'+subTableName+'"]').show();
			}else{
				$("#selectContent").css("display","none");
				$("#mainContent").css("display","block");
				$("#footerButton").css("display","block");
			}
			$("#selectContent").empty();
		}
	}

	  //图片数标记
    var index = 0;
   
    //添加图片
    function addImg(name){
	   var newName = name.replace("$","");
	   $("#"+newName).before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="_mainfile_'+name+'"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
   
	//删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove();
	   $("#up_img_"+index).remove();
    }
	
	//回调函数上传图片
	function callBackFun(upImgId,imgliId){
		myApp.showPreloader('正在上传...');
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=customform', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#img_name_"+(index-1)).val(msg.data+"|"+fileShowName);
				$("#"+imgliId).show();
				myApp.hidePreloader();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				myApp.alert("文件上传失败！");
			}
		});
	}

    function selectCallBack(obj1,obj2){
		if(obj1.val()=='' && obj2.val()==''){
			obj2.val('');
		}else{
			obj2.val( obj1.val() + ";" + obj2.val());
		}
	}
    
    //选择批示意见
    function selectComment(obj){
    	var $selectObj = $(obj);
    	var selectVal = $selectObj.val();
    	var $textarea = $selectObj.parent().parent().siblings();
    	setSpanHtml(obj,selectVal);
    	$textarea.val($textarea.val() + selectVal);
    }
    
    //设置span中的值
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	} 
    
	//主表计算字段
	function mainMath(obj){
		var id=obj.id;
		var objval =document.getElementById(id).value;
        if(isNaN(objval)){
			document.getElementById(id).value="";
			alert("请输入数字");
			return false;
		}
		var val = $('.edit-ipt-r.mainmath').attr("mainmathfun");//合计字段的公式
		//alert("val----->"+val);
		var mathId = $('.edit-ipt-r.mainmath').attr("id");
		var str = val.replace(/\*/g, '|').replace(/\+/g, '|').replace(/\-/g, '|').replace(/\//g, '|').replace(/\(/g, '|').replace(/\)/g, '|');
		str = str.replace("||", "|");
		var strArr = str.split("|");
		var sa="";//公式id;
		var mval="";//公式id对应的值
		for(var i=0;i<strArr.length;i++){
			sa = strArr[i];
			if(sa !=null && sa!=''){
				mval = document.getElementById(sa).value;
				if(mval == ""){
					val=val.replace(sa,0);
				}else{
					val=val.replace(sa,mval);
				}
				
			}			
		}
		//alert("val------>"+val);
        document.getElementById(mathId).value=eval(val);
		changeMoneyMath(mathId,eval(val));
	}
    
    //计算金额大写
	function changeMoneyMath(id,val){
		if(isNaN(val)){
			document.getElementById(id).value="";
			myApp.alert("请输入数字");
			return false;
		}
		var cid = id.replace("$","");
        var valRmb = changeNumMoneyToChinese(val);
		if($("#" + cid).val() != 'undefined'){
			$("#" + cid).val(valRmb);				
		}
	}

</script>
</body>
