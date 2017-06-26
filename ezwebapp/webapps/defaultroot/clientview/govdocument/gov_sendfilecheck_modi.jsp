<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>
<%
String workId = EncryptUtil.sqlcode(EncryptUtil.htmlcode(request.getParameter("workId")));//request.getParameter("workId");
String orgId = session.getAttribute("orgId").toString();
String userName = session.getAttribute("userName")==null?"":session.getAttribute("userName").toString();
Date date=new Date();
DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
String thisdate=format.format(date);
String fromFlag = com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("fromFlag"));
%>
<%@ include file="../common/headerInit.jsp" %>


<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>文件办理</title>
  
 </head>
<body class="grey-bg">
  <div class="views">
    <div class="view">
      <div class="pages">
        <div class="page" data-page="page-webapp-form">
          <section class="page-content wh-section wh-section-bottomfixed" id="mainContent">
            <div class="webapp-form">
              <div class="app-tabheader-line clearfix">
                <div class="clearfix">
                  <a href="#tab11" class="tab-link active" style="width:50%">
                    <span>流程表单</span>
                  </a>
                  <a href="#tab13" onclick="openWorkFlowGetLog();" class="tab-link tab-link-rw" style="width:50%">
                    <span>流程记录</span>
                  </a>
                </div>
              </div>
              <div class="tabs">
                <!-- 流程表单 -->
				<c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
				<c:set var="hasbackbutton"><x:out select="$doc//workInfo/havebackbutton/text()"/></c:set>
				<c:set var="modibutton"><x:out select="$doc//workInfo/modibutton/text()"/></c:set>
				<c:set var="wfworkId"><x:out select="$doc//wf_work_id/text()"/></c:set>
				<c:set var="workcurstep"><x:out select="$doc//workInfo/workcurstep/text()"/></c:set>
				<c:set var="worktitle"><x:out select="$doc//workInfo/worktitle/text()"/></c:set>
				<c:set var="worksubmittime"><x:out select="$doc//workInfo/worksubmittime/text()"/></c:set>
				<c:set var="commentmustnonull_isTrue"><x:out select="$doc//workInfo/commentmustnonull/text()"/></c:set>
				<c:set var="wfsmsRight"><x:out select="$doc//smsRight/text()"/></c:set>
				<c:set var="EmpLivingPhoto"><x:out select="$doc//workInfo/empLivingPhoto/text()"/></c:set>
				<c:set var="trantype"><x:out select="$doc//workInfo/trantype/text()"/></c:set>
				<c:set var="flowgraphurl"><x:out select="$doc//workInfo/flowgraphurl/text()"/></c:set>
				<c:set var="dealTipsContent" ><x:out select="$doc//dealTipsContent/text()" escapeXml="false" /></c:set>
				<c:set var="wfcommentType" ><x:out select="$doc//commentType/text()" escapeXml="false" /></c:set>
				<c:set var="commentFieldShowSignature"><x:out select="$doc//workInfo/commentFieldShowSignature/text()"/></c:set>
				<c:set var="isDossier"><x:out select="$doc//workInfo/isDossier/text()"/></c:set>
				<c:set var="ezflow_activityTip"><x:out select="$doc//workInfo/ezflow_activityTip/text()"/></c:set>
		        <c:set var="ezflow_activityTipCotent"><x:out select="$doc//workInfo/ezflow_activityTipCotent/text()"/></c:set>
		        <c:set var="ezflow_activityTipTitle"><x:out select="$doc//workInfo/ezflow_activityTipTitle/text()"/></c:set>
				<div id="dealTipsContent" style="display:none">${dealTipsContent}</div>
                <div id="tab11" class="tab active">
                  <div class="form-table">
					<form id="sendForm" action="/defaultroot/workflow/sendnew.controller?modibutton=<%=(String)pageContext.getAttribute("modibutton") %>&isDossier=<%=(String)pageContext.getAttribute("isDossier") %>&govType=sendfilecheck" method="post">						
							<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
							<table style="border-collapse:separate;border-spacing: 0 10px;">
								<%
									List govDocFormList = new ArrayList();
									govDocFormList  = (List)request.getAttribute("govDocFormList");
									for(int i=0;i<govDocFormList.size();i++){
										Map _map = (Map) govDocFormList.get(i);
										//System.out.println("----keyId-"+_map.get("keyId")+"-name-"+_map.get("name")+"-text-"+_map.get("text"));

										if("sendFileCheckComeUnit".equals(_map.get("keyId"))){    //来文单位
                                            if("true".equals(_map.get("canEdit"))){
							    %>	
												<tr>
													<td><span><%if("1".equals(_map.get("fieldIsNull"))){out.print("<em>*</em>");}%><%=_map.get("name")%></span></td>
													<td>
													  <div>
                                                       <input placeholder="请输入" class="edit-ipt-r" type="text" id='sys_<%=_map.get("keyId")%>' name='sys_<%=_map.get("keyId")%>' value='<%=_map.get("text")==null?"":_map.get("text")%>' />
													  </div>
													</td>
												</tr>
							<%
											}else{
							%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
												</tr>
							<%
											}
							            }else  if("sendFileCheckTitle".equals(_map.get("keyId"))){    //标题
                                            if("true".equals(_map.get("canEdit"))){
							    %>	
												<tr>
													<td><span><%if("1".equals(_map.get("fieldIsNull"))){out.print("<em>*</em>");}%><%=_map.get("name")%></span></td>
													<td>
													  <div>
                                                       <input placeholder="请输入" class="edit-ipt-r" type="text" id='sys_<%=_map.get("keyId")%>' name='sys_<%=_map.get("keyId")%>' value='<%=_map.get("text")==null?"":_map.get("text")%>' />
													  </div>
													</td>
												</tr>
							<%
											}else{
							%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
												</tr>
							<%
											}
							            }else  if("field10".equals(_map.get("keyId"))||
											       "field9".equals(_map.get("keyId"))||
											       "field8".equals(_map.get("keyId"))||
											       "field7".equals(_map.get("keyId"))||
											       "field6".equals(_map.get("keyId"))||
											       "field5".equals(_map.get("keyId"))||
											       "field4".equals(_map.get("keyId"))||
											       "field3".equals(_map.get("keyId"))||
											       "field2".equals(_map.get("keyId"))){    //备用字段10、备用字段9、备用字段8、备用字段7、备用字段6、备用字段5、备用字段4、备用字段3、备用字段2、备用字段1
                                            if("truea".equals(_map.get("canEdit"))){
							    %>	
												<tr>
													<td><span><%if("1".equals(_map.get("fieldIsNull"))){out.print("<em>*</em>");}%><%=_map.get("name")%></span></td>
													<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
												</tr>
							<%
											}else{
							%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
												</tr>
							<%
											}
							            }else  if("field1".equals(_map.get("keyId"))){    //备用字段1改为正文
							            	String fileName = (_map.get("text")==null?"":_map.get("text")).toString();
							            	if(!"".equals(fileName)){
							            		fileName = fileName+".doc";
							    %>	
												<tr>
													<td><span>正文</span></td>
													<td>
														<jsp:include page="../common/include_download.jsp" flush="true">
														<jsp:param name="realFileNames"	value="正文.doc" />
														<jsp:param name="saveFileNames" value="<%=fileName%>" />
														<jsp:param name="moduleName" value="govdocumentmanager" />
													</jsp:include>
													</td>
												</tr>
							<%
											}
							            }else  if("sendFileCheckComeUnit".equals(_map.get("keyId"))){    //来文单位
                                            if("true".equals(_map.get("canEdit"))){
							    %>	
												<tr>
													<td><span><%if("1".equals(_map.get("fieldIsNull"))){out.print("<em>*</em>");}%><%=_map.get("name")%></span></td>
													<td>
													  <div>
                                                       <input placeholder="请输入" class="edit-ipt-r" type="text" id='sys_<%=_map.get("keyId")%>' name='sys_<%=_map.get("keyId")%>' value='<%=_map.get("text")==null?"":_map.get("text")%>' />
													  </div>
													</td>
												</tr>
							<%
											}else{
							%>	
												<tr>
													<td><span><%=_map.get("name")%></span></td>
													<td><p><%=_map.get("text")==null?"":_map.get("text")%></p></td>
												</tr>
							<%
											}
										}else if("commentList".equals(_map.get("keyId"))){

										
										//批示意见
                                        }else if("custemFieldList".equals(_map.get("keyId"))){
                                           
										   List custemFieldList = (List)_map.get("custemFieldList");
										   if(custemFieldList!=null){
											     String fieldname = "";
												 String content = "";
												 String displayType = "";
												 String name = "";
												 String mustfilled = "";
												 String readwrite = "";
												 String fieldtype = "";
										      for(int k=0;k<custemFieldList.size();k++){
											     Map custemFieldMap = (Map) custemFieldList.get(k);

												 fieldname = custemFieldMap.get("fieldname")+"";
												 content = custemFieldMap.get("content")+"";
												 displayType = custemFieldMap.get("displayType")+"";
												 name = custemFieldMap.get("name")+"";
												 mustfilled = custemFieldMap.get("mustfilled")+"";
												 readwrite = custemFieldMap.get("readwrite")+"";

												 if(content==null||"[]".equals(content)||"null".equals(content)){content = "";}

												 //System.out.println("----name-"+name);

                                                 //单行文本 101
												 if("101".equals(displayType)&&"1".equals(readwrite)){
                                                     
													 fieldtype = custemFieldMap.get("fieldtype")+"";
													 if("1000000".equals(fieldtype)){
							%>
                                <tr>
									<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
									<td>
									  <div>
                                       <input placeholder="请输入" class="edit-ipt-r" type="number" maxlength="9" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=content%>' />
									  </div>
									</td>
								</tr>
							<%
													 }else if("1000001".equals(fieldtype)){
							%>
                                <tr>
									<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
									<td>
									  <div>
                                       <input placeholder="请输入" class="edit-ipt-r" type="number" maxlength="18" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=content%>' />
									  </div>
									</td>
								</tr>
							<%
													 }else if("1000002".equals(fieldtype)){
													 //自定义备用字段
							%>
							<%
													 }else{
							%>
                                <tr>
									<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
									<td>
									  <div>
                                       <input placeholder="请输入" class="edit-ipt-r" type="text" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=content%>' />
									  </div>
									</td>
								</tr>
							<%
													 }
                                                 //密码输入 102
							                     }else if("102".equals(displayType)&&"1".equals(readwrite)){
							%>
                                <tr>
									<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
									<td>
									  <div>
                                       <input placeholder="请输入" class="edit-ipt-r" type="password" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=content%>' />
									  </div>
									</td>
								</tr>
							<% 
							                     //单选 103
							                     }else if("103".equals(displayType)&&"1".equals(readwrite)){

													 List dataList = (List)custemFieldMap.get("dataList");
                            %>
                                 <tr>
									<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
									<td>
                                       <div class="edit-direct">
											<div class="edit-sel-show">
												<span>请选择</span>
											</div>    
											<select onchange="setSpanHtml(this);" class="btn-bottom-pop" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' prompt='<%=content%>'>
												<option value="">请选择</option>
												<%
												  if(dataList!=null){
													 Map  dataListMap = null;
													 String selected = "";
													 String hiddenval = "";
													 String showval = "";
													 for(int kk=0;kk<dataList.size();kk++){
														 dataListMap = (Map)dataList.get(kk);
														 hiddenval = dataListMap.get("hiddenval")+"";
														 showval = dataListMap.get("showval")+"";

														 selected = "";
														 if(content!=null&&!"".equals(content)){
															 String[] contents = content.split(";");
															 //System.out.println("--hiddenval-"+hiddenval+"--contents[0]-"+contents[0]);
															 if(contents.length>0){
																if(hiddenval.equals(contents[0])) selected = " selected='true' ";
															 }

														 }
														 out.print("<option value='"+hiddenval+"' "+selected+">"+showval+"</option>");
													 }
												  }
												%>
											</select>
										</div>
									</td>
								</tr>
							<% 
												 //多选 104
							                     }else if("104".equals(displayType)&&"1".equals(readwrite)){

													 List dataList = (List)custemFieldMap.get("dataList");

                             %>
                                <tr>
									<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
									<td>
                                       <ul class="edit-radio">
										
											<%
											  if(dataList!=null){
												 Map  dataListMap = null;
												 String selected = "";
												 String hiddenval = "";
												 String showval = "";
												 //System.out.println("dataList:"+dataList);
												 for(int kk=0;kk<dataList.size();kk++){
													 dataListMap = (Map)dataList.get(kk);
													 hiddenval = dataListMap.get("hiddenval")+"";
													 showval = dataListMap.get("showval")+"";
													 selected = "";
													 if(content!=null&&!"".equals(content)){
														 String[] contents = content.split(",");
														 if(contents.length>0){
														    for(int kkk=0;kkk<contents.length;kkk++){
																
															   if(hiddenval.equals(contents[kkk])) selected = " checked='true' ";
															}
														 }

													 }
													 
													 out.print("<li class=''><label class='label-checkbox item-content' for='checkIput"+fieldname+hiddenval+"'>");
													 out.print("<input type='checkbox' name='cust_"+fieldname+"' id='checkIput"+fieldname+hiddenval+"' value='"+hiddenval+",'  "+selected+" />");

													 out.print("<span class='edit-radio-l'>"+showval+"</span>");

													 out.print("</label></li>");
												 }
											  }
											%>
										</ul>
									</td>
								</tr>
							<% 
												  //下拉框 105
							                     }else if("105".equals(displayType)){
                                                   
													List dataList = (List)custemFieldMap.get("dataList");

													if("1".equals(readwrite)){

                             %>
                                  <tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										    <div class="edit-direct">
											<div class="edit-sel-show">
												<span>请选择</span>
											</div>    
												<select onchange='setSpanHtml(this);' class="btn-bottom-pop" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' prompt='<%=content%>'>
													<option value="">请选择</option>
													<%
													  if(dataList!=null){
								                         Map  dataListMap = null;
														 String selected = "";
														 String hiddenval = "";
														 String showval = "";
														 //System.out.println("--content-"+content);
							                             for(int kk=0;kk<dataList.size();kk++){
                                                             dataListMap = (Map)dataList.get(kk);
															 hiddenval = dataListMap.get("hiddenval")+"";
															 showval = dataListMap.get("showval")+"";
															 
															 selected = "";
															 if(content!=null&&!"".equals(content)){
																 String[] contents = content.split(";");
																 //System.out.println("--hiddenval-"+hiddenval+"--contents[0]-"+contents[0]);
																 if(contents.length>0){
																	if(hiddenval.equals(contents[0])) selected = " selected='true' ";
																 }

															 }
													         out.print("<option value='"+hiddenval+"' "+selected+">"+showval+"</option>");
														 }
													  }
													%>
												</select>
											</div>
										</td>
									</tr>
							 <% 
							                          }else{

                                                         if(content!=null&&!"".equals(content)){
															 String[] contents = content.split(";");
															 if(contents.length>1){
																content = contents[1];
															 }

														 }
							 %>

							        <tr>
										<td><span><%=name%></span></td>
										<td><p><%=content%></p></td>
									</tr>

							<%
													  }
							                     //日期 107
							                     }else if("107".equals(displayType)&&"1".equals(readwrite)){
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										    <div class="edit-ipt-a-arrow">
												<input placeholder="选择日期"  class="edit-ipt-r edit-ipt-arrow" type="text" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=content%>' onfocus="selectDateNew(this)" readonly/>
												<label class="edit-ipt-label" for="scroller"></label>
											</div>

										</td>
									</tr>
							  <% 
							                     //时间 108
							                     }else if("108".equals(displayType)&&"1".equals(readwrite)){
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										    <div class="edit-ipt-a-arrow">
												<input placeholder="选择时间"  class="edit-ipt-r edit-ipt-arrow" type="text" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=content%>' onfocus="selectTimeNew(this)" readonly/>
												<label class="edit-ipt-label" for="scroller"></label>
											</div>

										</td>
									</tr>
							  <% 
							                     //日期 时间 109
							                     }else if("109".equals(displayType)&&"1".equals(readwrite)){
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										    <div class="edit-ipt-a-arrow">
												<input placeholder="选择日期 时间"  class="edit-ipt-r edit-ipt-arrow" type="text" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=content%>' onfocus="selectDateTimeNew(this)" readonly/>
												<label class="edit-ipt-label" for="scroller"></label>
											</div>

										</td>
									</tr>
							 <% 
							                     //多行文本 110
							                     }else if("110".equals(displayType)&&"1".equals(readwrite)){
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <div>
											<textarea name='cust_<%=fieldname%>' id='cust_<%=fieldname.replaceAll("\\$", "")%>' rows="4" onkeyup="$(this).next('.edit-form-num').html($(this).attr('maxlength')-$(this).val().length);" class="edit-txta edit-txta-l" maxlength="500"><%=content%></textarea>
											<span class="edit-form-num"><script>document.write(500-$('#cust_<%=fieldname.replaceAll("\\$", "")%>').val().length);</script></span>
										  </div>
										</td>
									</tr>
							  <% 
							                     //自动编号 111
							                     }else if("111".equals(displayType)&&"1".equals(readwrite)){
							  %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										    <input id='cust_<%=fieldname%>' type="hidden" name='cust_<%=fieldname%>' value='<%=content%>' />
										</td>
									</tr>

							  <% 
							                     //html编辑 113
							                     }else if("113".equals(displayType)&&"1".equals(readwrite)){
							  %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <div>
										    <textarea id='cust_<%=fieldname.replaceAll("\\$", "")%>' name='cust_<%=fieldname%>' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="300"><%=content%></textarea>
									        <span class="edit-txta-num"><script>document.write(300-$('#cust_<%=fieldname.replaceAll("\\$", "")%>').val().length);</script></span>
										  </div>
										</td>
									</tr>
							  <% 
							                     //附件上传 115
							                     }else if("115".equals(displayType)){
													 
							  %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <%
										    if("1".equals(readwrite)){
											   out.print("<ul class='edit-upload'>");
											   out.print("<li class='edit-upload-in' onclick='addImgCust(\"cust_"+fieldname+"\");'><span><i class='fa fa-plus'></i></span></li>");
											   out.print("</ul>");
											}
											if(content!=null&&!"".equals(content)&&!"null".equals(content)){
											    String realFileNames ="";
												String saveFileNames ="";
												String moduleName ="customform";
												String aValues = content;
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
											<input name="fileNames<%=fieldname%>" value="<%=content%>" type="hidden"/>
										  <%}%>
										</td>
									</tr>
							  <% 
							                     //Word编辑 116
							                     }else if("116".equals(displayType)){
													 

							  %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <%
										     if(content!=null&&!"".equals(content)&&!"null".equals(content)){
                                                String realFileNames ="";
												String saveFileNames ="";
												String moduleName ="information";
												realFileNames ="查看正文.doc";
												saveFileNames = content+".doc";
										   %>
										   <jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
												<jsp:param name="moduleName" value="<%=moduleName%>" />
											</jsp:include>

										   <%
							                 }else if("1".equals(readwrite)){
							              %>
                                            该字段暂不支持手机办理，请于电脑端操作。
										  <%}%>
										</td>
									</tr>
							  <% 
							                     //Excel编辑 117
							                     }else if("117".equals(displayType)){
													 
							  %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <%
										     if(content!=null&&!"".equals(content)&&!"null".equals(content)){
                                                String realFileNames ="";
												String saveFileNames ="";
												String moduleName ="information";
												realFileNames = content+".xls";
												saveFileNames = content+".xls";
										   %>
										    <jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
												<jsp:param name="moduleName" value="<%=moduleName%>" />
											</jsp:include>

										   <%
							                 }else if("1".equals(readwrite)){
							              %>
                                            该字段暂不支持手机办理，请于电脑端操作。
										  <%}%>
										</td>
									</tr>
							  <% 
							                     //WPS编辑 118
							                     }else if("118".equals(displayType)){
													 
							  %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <%
										     if(content!=null&&!"".equals(content)&&!"null".equals(content)){
                                                String realFileNames ="";
												String saveFileNames ="";
												String moduleName ="information";
												realFileNames = content+".wps";
												saveFileNames = content+".wps";
										   %>
										    <jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
												<jsp:param name="moduleName" value="<%=moduleName%>" />
											</jsp:include>

										   <%
							                 }else if("1".equals(readwrite)){
							              %>
                                            该字段暂不支持手机办理，请于电脑端操作。
										  <%}%>
										</td>
									</tr>

							  <% 
							                     //当前登录人 202
							                     }else if("202".equals(displayType)){
													 
							  %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <%=userName%>
										  <input id='<%=fieldname%>' type="hidden" name='<%=fieldname%>'  value="<%=userName%>" />
										</td>
									</tr>

							  <% 
							                     }else if(("213".equals(displayType)||"215".equals(displayType)||"406".equals(displayType)||"601".equals(displayType)||"602".equals(displayType)||"603".equals(displayType)||"604".equals(displayType)||"605".equals(displayType)||"607".equals(displayType)||"701".equals(displayType)||"201".equals(displayType)||"207".equals(displayType))&&"1".equals(readwrite)){

							  %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										    <%=content%>
										    <input id='<%=fieldname%>' type="hidden" name='<%=fieldname%>' value='<%=content%>' />
										</td>
									</tr>

							  <% 
							                     }else if("702".equals(displayType)){
                                                     
							 %>
									<tr>
										<td><span><%=name%></span></td>
										<td>
										  <div>
											<%=userName%>
										    <input id='<%=fieldname.replaceAll("\\$", "")%>' type="text" value="<%=thisdate%>" />
										  </div>
										</td>
									</tr>

							  <% 
							                     //单选人 全部 210
							                     }else if("210".equals(displayType)){

													if("1a".equals(readwrite)){
                                                     
													 String contentId = "";
													 String contentName = "";
													 if(content!=null && content.indexOf(";")>-1){
													    String[] contents = content.split(";");
														if(contents.length>0){
														  contentName = contents[0];
														  contentId = contents[1];
														}
														
													 }
													 if(contentName.endsWith(",")){contentName=contentName.substring(0,contentName.length()-1);}
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <div>
											<input type="hidden" readonly="readonly" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=contentId%>' />
											<input type="text"   readonly="readonly" id='custShow_<%=fieldname%>' name='custShow_<%=fieldname%>' value='<%=contentName%>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","custShow_<%=fieldname%>","cust_<%=fieldname%>","*0*","user")' placeholder="请选择"/>
										  </div>
										</td>
									</tr>

							  <% 
							                         }else{

                                                         if(content!=null&&!"".equals(content)){
															 String[] contents = content.split(";");
															 if(contents.length>1){
																content = contents[0];
															 }

														 }
														 if(";".equals(content)){content="";}
							 %>

							        <tr>
										<td><span><%=name%></span></td>
										<td><p><%=content%></p></td>
									</tr>

							<%
													  }
							                     //多选人 全部 211
							                     }else if("211".equals(displayType)){

													if("1a".equals(readwrite)){
													 String contentId = "";
													 String contentName = "";
													 if(content!=null && content.indexOf(";")>-1){
													    String[] contents = content.split(";");
														if(contents.length>0){
														  contentName = contents[0];
														  contentId = contents[1];
														}
														
													 }
													 if(contentName.endsWith(",")){contentName=contentName.substring(0,contentName.length()-1);}
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <div>
											<input type="hidden" readonly="readonly" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=contentId%>' />
											<input type="text"   readonly="readonly" id='custShow_<%=fieldname%>'  name='custShow_<%=fieldname%>' value='<%=contentName%>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","custShow_<%=fieldname%>","cust_<%=fieldname%>","*0*","user");' placeholder="请选择"/>
										  </div>
										</td>
									</tr>

							 <% 
							                         }else{

                                                         if(content!=null&&!"".equals(content)){
															 String[] contents = content.split(";");
															 if(contents.length>1){
																content = contents[0];
															 }

														 }
														 if(";".equals(content)){content="";}
							 %>

							        <tr>
										<td><span><%=name%></span></td>
										<td><p><%=content%></p></td>
									</tr>

							<%
													  }
							                     //单选组织 212
							                     }else if("212".equals(displayType)){

													if("1a".equals(readwrite)){

													 String contentId = "";
													 String contentName = "";
													 if(content!=null && content.indexOf(";")>-1){
													    String[] contents = content.split(";");
														if(contents.length>0){
														  contentName = contents[0];
														  contentId = contents[1];
														}
														
													 }
													 if(contentName.endsWith(",")){contentName=contentName.substring(0,contentName.length()-1);}
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <div>
											<input type="hidden" readonly="readonly" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=contentId%>' />
											<input type="text"   readonly="readonly" id='custShow_<%=fieldname%>'  name='custShow_<%=fieldname%>' value='<%=contentName%>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","custShow_<%=fieldname%>","cust_<%=fieldname%>","*0*","org");' placeholder="请选择"/>
										  </div> 
										</td>
									</tr>
							  <% 
													 }else{

                                                         if(content!=null&&!"".equals(content)){
															 String[] contents = content.split(";");
															 if(contents.length>1){
																content = contents[0];
															 }

														 }
														 if(";".equals(content)){content="";}
							 %>

							        <tr>
										<td><span><%=name%></span></td>
										<td><p><%=content%></p></td>
									</tr>

							<%
													  }
							                     //多选组织 214
							                     }else if("214".equals(displayType)){

												   if("1a".equals(readwrite)){

													 String contentId = "";
													 String contentName = "";
													 if(content!=null && content.indexOf(";")>-1){
													    String[] contents = content.split(";");
														if(contents.length>0){
														  contentName = contents[0];
														  contentId = contents[1];
														}
														
													 }
													 if(contentName.endsWith(",")){contentName=contentName.substring(0,contentName.length()-1);}
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <div>
											<input type="hidden" readonly="readonly" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=contentId%>' />
											<input type="text"   readonly="readonly" id='custShow_<%=fieldname%>'  name='custShow_<%=fieldname%>' value='<%=contentName%>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","custShow_<%=fieldname%>","cust_<%=fieldname%>","*0*","org");' placeholder="请选择"/>
										  </div>
										</td>
									</tr>
							  <% 
							                      }else{

                                                         if(content!=null&&!"".equals(content)){
															 String[] contents = content.split(";");
															 if(contents.length>1){
																content = contents[0];
															 }

														 }
														 if(";".equals(content)){content="";}
							 %>

							        <tr>
										<td><span><%=name%></span></td>
										<td><p><%=content%></p></td>
									</tr>

							<%
													  }
							                     //多选组织和人 216
							                     }else if("216".equals(displayType)){
							 %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										   <%
										     if("1a".equals(readwrite)){
							                         String contentId = "";
													 String contentName = "";
													 if(content!=null && content.indexOf(";")>-1){
													    String[] contents = content.split(";");
														if(contents.length>0){
														  contentName = contents[0];
														  contentId = contents[1];
														}
														
													 }
													 if(contentName.endsWith(",")){contentName=contentName.substring(0,contentName.length()-1);}
											%>
                                              <div>
												<input type="hidden" readonly="readonly" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=contentId%>' />
												<input type="text"   readonly="readonly" id='custShow_<%=fieldname%>'  name='custShow_<%=fieldname%>' value='<%=contentName%>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","custShow_<%=fieldname%>","cust_<%=fieldname%>","*0*","orguser");' placeholder="请选择"/>
											  </div>
											<%
							                 }else{
                                                String newoap = "";
												if(content!=null && content.indexOf(";")>-1){
                                                    newoap = content.split(";")[0];
													out.print(newoap);
												}
											 }
							               %>
										</td>
									</tr>
							 <% 
							                     //金额 301
							                     }else if("301".equals(displayType)&&"1".equals(readwrite)){

													 fieldtype = custemFieldMap.get("fieldtype")+"";
													 
							  %>
							         <tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										   <%
										      if("1000000".equals(fieldtype)||"1000001".equals(fieldtype)){
								                 out.print("<input class='edit-ipt-r' id='cust_"+fieldname+"' type='number' name='cust_"+fieldname+"' value='"+content+"' />");
											  }else{
												 out.print("<input class='edit-ipt-r' id='cust_"+fieldname+"' type='text' name='cust_"+fieldname+"' value='"+content+"' />");
											  }
										   %>
										</td>
									</tr>
                             <%
							 			         //批示意见 401
							                     }else if("401".equals(displayType)){
                             %>
									<tr>
										<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
										<td>
										  <div>
											<textarea name='cust_<%=fieldname%>' id='cust_<%=fieldname.replaceAll("\\$", "")%>' rows="4" onkeyup="$(this).next('.edit-form-num').html($(this).attr('maxlength')-$(this).val().length);" class="edit-txta edit-txta-l" maxlength="500"><%=content%></textarea>
											<span class="edit-form-num"><script>document.write(500-$('#cust_<%=fieldname.replaceAll("\\$", "")%>').val().length);</script></span>
										  </div>
										</td>
									</tr>
							  <% 
												 
												 //合计字段 606
							                     }else if("606".equals(displayType)){
                                 %>
										<tr>
											<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
											<td>
											   该字段暂不支持手机办理，请于电脑端操作。
											</td>
										</tr>
								  <%
											     
												 //单选人 本组织 704
							                     }else if("704".equals(displayType)){

												   if("1a".equals(readwrite)){

													 String contentId = "";
													 String contentName = "";
													 if(content!=null && content.indexOf(";")>-1){
													    String[] contents = content.split(";");
														if(contents.length>0){
														  contentName = contents[0];
														  contentId = contents[1];
														}
														
													 }
													 if(contentName.endsWith(",")){contentName=contentName.substring(0,contentName.length()-1);}
									%>
										<tr>
											<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
											<td>
											   <div>
													<input type="hidden" readonly="readonly" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=contentId%>' />
													<input type="text"   readonly="readonly" id='custShow_<%=fieldname%>' name='custShow_<%=fieldname%>' value='<%=contentName%>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("0","custShow_<%=fieldname%>","cust_<%=fieldname%>","*<%=orgId%>*","user");'/>
												</div>
											</td>
										</tr>
								  <%
								                  }else{

                                                         if(content!=null&&!"".equals(content)){
															 String[] contents = content.split(";");
															 if(contents.length>1){
																content = contents[0];
															 }

														 }
														 if(";".equals(content)){content="";}
							 %>

							        <tr>
										<td><span><%=name%></span></td>
										<td><p><%=content%></p></td>
									</tr>

							<%
													  }

												 //多选人 本组织 705
							                     }else if("705".equals(displayType)){

													if("1a".equals(readwrite)){

													 String contentId = "";
													 String contentName = "";
													 if(content!=null && content.indexOf(";")>-1){
													    String[] contents = content.split(";");
														if(contents.length>0){
														  contentName = contents[0];
														  contentId = contents[1];
														}
														
													 }
													 if(contentName.endsWith(",")){contentName=contentName.substring(0,contentName.length()-1);}
								  %>
										<tr>
											<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
											<td>
											   <div>
												<input type="hidden" readonly="readonly" id='cust_<%=fieldname%>' name='cust_<%=fieldname%>' value='<%=contentId%>' />
												<input type="text"   readonly="readonly" id='custShow_<%=fieldname%>'  name='custShow_<%=fieldname%>' value='<%=contentName%>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("1","custShow_<%=fieldname%>","cust_<%=fieldname%>","*<%=orgId%>*","user");'/>
											   </div>
											</td>
										</tr>
								  <%
								                   }else{

                                                         if(content!=null&&!"".equals(content)){
															 String[] contents = content.split(";");
															 if(contents.length>1){
																content = contents[0];
															 }

														 }
														 if(";".equals(content)){content="";}
							 %>

							        <tr>
										<td><span><%=name%></span></td>
										<td><p><%=content%></p></td>
									</tr>

							<%
													  }

												 //流程发起人 708
							                     }else if("708".equals(displayType)&&"1".equals(readwrite)){
                                  %>
										<tr>
											<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
											<td>
											   <div>
											    <%=content%>
												<input id='cust_<%=fieldname%>' type="hidden" name='cust_<%=fieldname%>'  value='<%=content%>' />
											   </div>
											</td>
										</tr>
								  <%
											     //日期时间计算 808
							                     }else if("808".equals(displayType)&&"1".equals(readwrite)){
                                  %>
										<tr>
											<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
											<td>
											   该字段暂不支持手机办理，请于电脑端操作。
											</td>
										</tr>
								  <%
												 //计算字段 203
							                     }else if("203".equals(displayType)&&"1".equals(readwrite)){
                                   %>
										<tr>
											<td><span><%if("1".equals(mustfilled)){out.print("<em>*</em>");}%><%=name%></span></td>
											<td>
											   该字段暂不支持手机办理，请于电脑端操作。
											</td>
										</tr>
								  <%
													 
							                     }else{
							  %>
									<tr>
										<td><span><%=name%></span></td>
										<td><p><%=content%></p></td>
									</tr>
							  <%
												 }
												 
											  }
										   }
                                          
										}

									}
								%>
								
								<c:if test="${not empty govDocXml}">
								<x:parse xml="${govDocXml}" var="govDoc"/>
								<c:set var="goldGridId"><x:out select="$govDoc//goldGridId/text()"/></c:set>
								<c:set var="wordType"><x:out select="$govDoc//wordType/text()"/></c:set>
								
								<x:if select="$govDoc//docSaveFile">
									<tr>
										<td><span>查看正文</span></td>
										<td><p>
											<%
											StringBuilder docSaveFiles = new StringBuilder();
											StringBuilder docRealFiles = new StringBuilder();
											%>
											<x:forEach select="$govDoc//docSaveFile/file" var="file" >
												<c:set var="saveFile" ><x:out select="$file/text()" /></c:set>
												<%
												docSaveFiles.append(pageContext.getAttribute("saveFile").toString()).append("|");
												%>
											</x:forEach>
											<x:forEach select="$govDoc//docRealFile/file" var="file" >
												<c:set var="realFile" ><x:out select="$file/text()" /></c:set>
												<%
												docRealFiles.append(pageContext.getAttribute("realFile").toString()).append("|");
												%>
											</x:forEach>
											<c:if test="${saveFile!='' &&  saveFile != null}">
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=docRealFiles.toString() %>" />
												<jsp:param name="saveFileNames" value="<%=docSaveFiles.toString() %>" />
												<jsp:param name="realtime" value="1" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>
											</c:if>
											</p>
										</td>
									</tr>
								</x:if>
								<x:if select="$govDoc//realFile">
									<tr>
										<td><span>附件</span></td>
										<td><p>
											<%
											StringBuilder saveFiles = new StringBuilder();
											StringBuilder realFiles = new StringBuilder();
											%>
											<x:forEach select="$govDoc//saveFile/file" var="file" >
												<c:set var="saveFile" ><x:out select="$file/text()" /></c:set>
												<%
												saveFiles.append(pageContext.getAttribute("saveFile").toString()).append("|");
												%>
											</x:forEach>
											<x:forEach select="$govDoc//realFile/file" var="file" >
												<c:set var="realFile" ><x:out select="$file/text()" /></c:set>
												<%
												realFiles.append(pageContext.getAttribute("realFile").toString()).append("|");
												%>
											</x:forEach>
											<c:if test="${saveFile!='' &&  saveFile != null}">
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFiles.toString() %>" />
												<jsp:param name="saveFileNames" value="<%=saveFiles.toString() %>" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>
											</c:if>
											</p>
										</td>
									</tr>
								</x:if>
								
								<!-- 批示意见内容 -->
								<c:set var="commentField"><x:out select="$doc//workInfo/commentField/text()"/></c:set>
								<c:set var="commentFieldName"><x:out select="$doc//workInfo/commentFieldName/text()"/></c:set>
								<c:set var="g_step"></c:set>
								<c:set var="g_content"></c:set>
								<x:forEach select="$doc//commentList/comment" var="ct" >
									<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
									<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
									<c:set var="commentstatus"><x:out select="$ct//commentstatus/text()"/></c:set>
									<c:set var="commentstep"><x:out select="$ct//step/text()"/></c:set>
									<c:if test="${commentstatus =='1'}">
									<tr>
										<td>
											<span><x:out select="$ct//step/text()"/></span>
										</td>
										<td><p>					
											<c:if test="${commentType =='0'}">
												<c:set var="commentDate"><x:out select="$ct//date/text()"/></c:set>
												<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/><c:if test="${not empty commentDate}">(${fn:substring(commentDate,0,16)})</c:if></br>	
											</c:if>	
											<c:if test="${commentType =='1'}">
												<c:set var="commentDate"><x:out select="$ct//date/text()"/></c:set>
												<img  width="100%" class="lazy lazy-fadeIn" id="${commentContent}" ><x:out select="$ct//person/text()"/><c:if test="${not empty commentDate}">(${fn:substring(commentDate,0,16)})</c:if><br/>
												<input type="hidden" name="imgNames" value="${commentContent}" />
											</c:if>		
											<%
												StringBuilder saveNames = new StringBuilder();
												StringBuilder showNames = new StringBuilder();
											%>
											<c:set var="fileNum" value="0"/>
											<x:forEach select="$ct/attachments/file" var="file">
												<c:set var="saveName" ><x:out select="$file/saveName/text()" /></c:set>
												<c:set var="showName" ><x:out select="$file/showName/text()" /></c:set>
												<c:set var="fileNum" value="${fileNum+1}"/>
												<%
												saveNames.append(pageContext.getAttribute("saveName").toString()).append("|");
												showNames.append(pageContext.getAttribute("showName").toString()).append("|");
												%>
											</x:forEach>
											<c:if test="${fileNum > 0}">
												<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="<%=showNames.toString() %>" />
													<jsp:param name="saveFileNames" value="<%=saveNames.toString() %>" />
													<jsp:param name="moduleName" value="workflow_acc" />
												</jsp:include>
											</c:if>
											</p>										
										</td>
									</tr>
									</c:if>
									<c:if test="${commentstatus =='0'}">
										<% 
										pageContext.setAttribute("g_step",pageContext.getAttribute("commentstep").toString());
										pageContext.setAttribute("g_content",pageContext.getAttribute("commentContent").toString());
										%>
									</c:if>
								</x:forEach>
								<c:choose>
									<c:when test="${not empty commentFieldName && not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
										<tr>
											<td>
												<span>${commentFieldName}</span>
											</td>
											<td>
												<c:if test="${wfcommentType == '1'}">
													暂不支持手写，如您需要手写请于PC端处理！
												</c:if>
												<c:if test="${wfcommentType == '0'}">
													<c:if test="${commentFieldShowSignature !='true' && commentFieldShowSignature !=true}">
														<div class="edit-direct2" style="text-align:right;">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000"></textarea>					
															<div class="edit-direct">
																<div class="edit-sel-show">
																	<span style="color: #ccc;">请选择常用语：&nbsp;&nbsp;&nbsp;</span>
																</div>
																<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
																	<option value="0">请选择常用语：&nbsp;&nbsp;&nbsp;&nbsp;</option> 
																	<x:forEach select="$doc//officelist" var="selectvalue" >
																		<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
																	</x:forEach>
																</select>
															</div>
														</div>
													</c:if>
													<c:if test="${commentFieldShowSignature =='true' || commentFieldShowSignature ==true}">										
													</c:if>
												</c:if>
												<!-- 直接显示批示意见 -->
												<div class="edit-direct2" style="text-align:right;">
														<c:if test="${g_step == commentFieldName}">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000" >${g_content}</textarea>
														</c:if>
														<c:if test="${g_step != commentFieldName}">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000"></textarea>
														</c:if>
														<div class="edit-direct edit-direct-none">
															<div class="edit-sel-show">
																<span style="color: #ccc;">请选择常用语：&nbsp;&nbsp;&nbsp;</span>
															</div>
															<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
																<option value="0">请选择常用语：&nbsp;&nbsp;&nbsp;&nbsp;</option> 
																<x:forEach select="$doc//officelist" var="selectvalue" >
																	<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
																</x:forEach>
															</select>
														</div>
														
												</div>
											</td>
										</tr>
									</c:when>
									<c:when test="${empty commentFieldName && not empty workcurstep && not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
										<tr>
											<td>
												<span>${workcurstep}</span>
											</td>
											<td>
												<c:if test="${wfcommentType == '1'}">
													暂不支持手写，如您需要手写请于PC端处理！
												</c:if>
												<c:if test="${wfcommentType == '0'}">
													<c:if test="${commentFieldShowSignature !='true' && commentFieldShowSignature !=true}">
														<div class="edit-direct2" style="text-align:right;">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000"></textarea>					
															<div class="edit-direct">
																<div class="edit-sel-show">
																	<span style="color: #ccc;">请选择常用语：&nbsp;&nbsp;&nbsp;</span>
																</div>
																<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
																	<option value="0">请选择常用语：&nbsp;&nbsp;&nbsp;&nbsp;</option> 
																	<x:forEach select="$doc//officelist" var="selectvalue" >
																		<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
																	</x:forEach>
																</select>
															</div>
														</div>
													</c:if>
													<c:if test="${commentFieldShowSignature =='true' || commentFieldShowSignature ==true}">										
													</c:if>
												</c:if>
												<!-- 直接显示批示意见 -->
												<div class="edit-direct2" style="text-align:right;">
														<c:if test="${g_step == commentFieldName}">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000" >${g_content}</textarea>
														</c:if>
														<c:if test="${g_step != commentFieldName}">
															<textarea  placeholder="请输入文字" name="comment_input" rows="4" id="comment_input" maxlength="1000"></textarea>
														</c:if>
														<div class="edit-direct edit-direct-none">
															<div class="edit-sel-show">
																<span style="color: #ccc;">请选择常用语：&nbsp;&nbsp;&nbsp;</span>
															</div>
															<select onchange="selectComment(this);" class="btn-bottom-pop"  prompt="">
																<option value="0">请选择常用语：&nbsp;&nbsp;&nbsp;&nbsp;</option> 
																<x:forEach select="$doc//officelist" var="selectvalue" >
																	<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
																</x:forEach>
															</select>
														</div>
														
												</div>
											</td>
										</tr>
									</c:when>
									<c:when test="${param.workStatus == '2'}">
										<c:set var="passRoundCommField" ><x:out select="$doc//workInfo/passRoundCommField/text()"/></c:set>
										<c:set var="passRoundCommFieldType" ><x:out select="$doc//workInfo/passRoundCommFieldType/text()"/></c:set>
										<c:if test="${passRoundCommField == 'autoCommentField'}">
										<tr>
											<td>审批意见：
											</td>
											<td>
												<div class="edit-direct2" style="text-align:right;">
														<textarea  placeholder="请输入文字" name="comment_input" id="comment_input" rows="4" maxlength="1000"></textarea>
												</div>
						                    </td>
										</tr>
										</c:if>
									</c:when>
								</c:choose>	
								
								
							 	<x:if select="$doc//backComment/text() != ''" >
							 		<c:set var="content" ><x:out select="$doc//backComment/text()" /></c:set>
							 		<c:if test="${content!= 'back'}" >
									<tr>
										<td>
											<span>退回意见</span>
										</td>
										<td><p>
											<%
											   String aContent =(String)pageContext.getAttribute("content");
											   aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
											   aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
											   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
											   String newcontent = aContent;
												newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
												newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
												newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
												int blankpos = newcontent.lastIndexOf("    ");
												if(blankpos > 0){
													newcontent = newcontent.substring(0,blankpos)+"\n<br/>"+newcontent.substring(blankpos+4);
												}
											  %>   
											<c:set var="uname" value="<%=newcontent%>" /> 
											${uname }</p>
									   </td>
									</tr>
									</c:if>
								 </x:if>   
									<!--退回意见end-->
							</table>
						</c:if>
						<input type="hidden" name="tableId" value="<%=workId%>" />
						<input type="hidden" name="recordId" value="<x:out select="$doc//workInfo/workrecord_id/text()"/>" />
						<input type="hidden" name="activityId" value="<x:out select="$doc//workInfo/initactivity/text()"/>" />
						<input type="hidden" name="workId" value="<x:out select="$doc//workInfo/wf_work_id/text()"/>" />
						<input type="hidden" name="stepCount" value="<x:out select="$doc//workInfo/workstepcount/text()"/>" />
						<input type="hidden" name="isForkTask" value="<x:out select="$doc//isForkTask/text()"/>" />
						<input type="hidden" name="forkStepCount" value="<x:out select="$doc//forkStepCount/text()"/>" />
						<input type="hidden" name="forkId" value="<x:out select="$doc//forkId/text()"/>" />
						<input type="hidden" name="activityclass" value="<x:out select="$doc//activityClass/text()"/>" />
						<input type="hidden" name="commentType" value="0" />
						<input type="hidden" name="pass_title" value=""  />
						<input type="hidden" name="pass_time" value="" />
						<input type="hidden" name="pass_person" value="" />
						<input type="hidden" name="__sys_operateType" value="2" />
						<input type="hidden" name="__sys_infoId" value='<x:out select="$doc//paramList/workrecord_id/text()"/>' />
						<input type="hidden" name="__sys_pageId" value='<x:out select="$doc//paramList/worktable_id/text()"/>' />
						<input type="hidden" name="__sys_formType" value='<x:out select="$doc//paramList/formType/text()"/>' />	
						<input type="hidden" name="__main_tableName" value='<x:out select="$doc//fieldList/tableName/text()"/>' />	
						<input type="hidden" name="actiCommFieldType" value='<x:out select="$doc//workInfo/actiCommFieldType/text()"/>' />
						<input type="hidden" name="curCommField" value='<x:out select="$doc//workInfo/commentField/text()"/>' />
						<input type="hidden" name="trantype" value='<x:out select="$doc//workInfo/trantype/text()"/>' />
						<x:if select="$doc//workInfo/commentmustnonull" var="commentmustnonull">
							<input type="hidden" name="commentmustnonull" value='<x:out select="$doc//workInfo/commentmustnonull/text()"/>' />
						</x:if>
						<x:if select="$doc//workInfo/backnocomment" var="backnocomment">
							<input type="hidden" name="backnocomment" value='<x:out select="$doc//workInfo/backnocomment/text()"/>' />
						</x:if>
						<x:if select="$doc//workInfo/backMailRange" var="backMailRange">
							<input type="hidden" name="backMailRange" value='<x:out select="$doc//workInfo/backMailRange/text()"/>' />
						</x:if>
						<x:if select="$doc//workInfo/smsRight" var="smsRight">
							<input type="hidden" name="smsRight" value='<x:out select="$doc//workInfo/smsRight/text()"/>' />
						</x:if>
						<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
						<input type="hidden" name="worktitle" value="${worktitle}">
						<input type="hidden" name="workcurstep" value="${workcurstep}">
						<input type="hidden" name="worksubmittime" value="${worksubmittime}">
						<input type="hidden" name="workStatus" value="0">
					</form>
                  </div>
                </div>
				<form id="sendFormAgain" action="/defaultroot/dealfile/pressInfo.controller?workId=${wfworkId}&amp;smsRight=${wfsmsRight }" method="post">
					<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
					<input type="hidden" name="worktitle" value="${worktitle}">
					<input type="hidden" name="workcurstep" value="${workcurstep}">
					<input type="hidden" name="worksubmittime" value="${worksubmittime}">
					<input type="hidden" name="workStatus" value="1100">
					<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
				</form>
				<form id="backForm" action="/defaultroot/workflow/back.controller" method="post">
					<input type="hidden" name="workId" value="<%=workId%>">
					<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
					<input type="hidden" name="worktitle" value="${worktitle}">
					<input type="hidden" name="workcurstep" value="${workcurstep}">
					<input type="hidden" name="worksubmittime" value="${worksubmittime}">
					<input type="hidden" name="workStatus" value="0">
					<input type="hidden" name="tableId" value='<x:out select="$doc//workInfo/worktable_id/text()"/>'>
					<input type="hidden" name="recordId" value='<x:out select="$doc//workInfo/workrecord_id/text()"/>'>
					<input type="hidden" name="stepCount" value='<x:out select="$doc//workInfo/workstepcount/text()"/>'>
					<input type="hidden" name="forkId" value='<x:out select="$doc//workInfo/forkId/text()"/>'>
					<input type="hidden" name="forkStepCount" value='<x:out select="$doc//workInfo/forkStepCount/text()"/>'>
					<input type="hidden" name="isForkTask" value='<x:out select="$doc//workInfo/isForkTask/text()"/>'>
					<input type="hidden" name="curCommField" value='<x:out select="$doc//workInfo/commentField/text()"/>' />
					<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
				</form>
                </c:if>
				<!-- 流程图加载 -->
                <div id="tab12" class="tab">  
                  <p><img id="lct"  width="100%" class="lazy lazy-fadeIn"></p> 
                </div>
                <!-- 流程图记录 -->
                <div id="tab13" class="tab">
                  <div class="form-table-record">
                    <table style="border-collapse:separate;border-spacing: 0 10px;" id="flowRecord">
                      
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </section>
		  <section id="selectContent" style="display:none">
	</section>
          <c:if test="${param.workStatus ne '102'}">
			<c:choose>
				<c:when test="${param.workStatus eq '0'}">
					<footer class="wh-footer wh-footer-forum" id="footerButton">
						<div class="wh-container">
						  <div class="wh-footer-btn row">
							<div class="webapp-footer-linebtn">
							  <div class="fl clearfix">
								<c:choose>
									<c:when test="${hasbackbutton == 'true' }">
										<a href="javascript:subBackForm();" class="panel-return-a">退回</a>
										<a href="javascript:subForm();" class="panel-send-a">发送</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:subForm();" class="panel-send-a">发送</a>
									</c:otherwise>
								</c:choose>
							  </div>
							  	<c:if test="${fn:indexOf(modibutton,'Tran') >0 || fn:indexOf(modibutton,'AddSign') >0 || fn:indexOf(modibutton,'Selfsend') >0}">
									<!--  <a id="fbtn-form-more" data-popover=".popover-links" class="fr fbtn-more link open-popover "><span>更多</span></a>-->
									<a id="fbtn-more" onclick="" data-popover=".popover-links" class="fr fbtn-more"><span>更多</span></a>
								</c:if>
							</div>
						  </div>
						</div>
					</footer>
				</c:when>
				<c:when test="${param.workStatus eq '2'}">
					<footer class="wh-footer wh-footer-forum" id="footerButton">
						<div class="wh-container">
						  <div class="wh-footer-btn row">
							<div class="webapp-footer-linebtn">
							  <div class="fl clearfix">
								<a href="javascript:workfolwSend('${wfworkId}');" class="panel-send-a"> 发送</a>
							  </div>
							</div>
						  </div>
						</div>
					</footer>
				</c:when>
				<c:when test="${param.workStatus eq '101'}">
					<c:if test="${fn:indexOf(workcurstep,'办理完毕') == '-1'}">
						<footer class="wh-footer wh-footer-forum" id="footerButton">
							<div class="wh-container">
							  <div class="wh-footer-btn row">
								<div class="webapp-footer-linebtn">
								  <div class="fl clearfix">
									<c:choose>
										<c:when test="${fn:indexOf(modibutton,'Undo') >0 && fn:indexOf(modibutton,'Wait') >0}">
											<a href="javascript:workfolwUndo('${wfworkId}');" class="panel-press-a close-popover">撤办</a>
											<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-press-a close-popover">催办</a>
										</c:when>
										<c:when test="${fn:indexOf(modibutton,'Undo') >0 && fn:indexOf(modibutton,'Wait') <=0}">
											<a href="javascript:workfolwUndo('${wfworkId}');" class="panel-press-a close-popover">撤办</a>
										</c:when>
										<c:when test="${fn:indexOf(modibutton,'Undo') <=0 && fn:indexOf(modibutton,'Wait') >0}">
											<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-press-a close-popover">催办</a>
										</c:when>
									</c:choose>
								  </div>
								</div>
							  </div>
							</div>
						</footer>
					</c:if>
				</c:when>
				<c:when test="${param.workStatus eq '1100'}">
					<c:if test="${fn:indexOf(modibutton,'Wait') >0}">
						<footer class="wh-footer wh-footer-forum" id="footerButton">
							<div class="wh-container">
							  <div class="wh-footer-btn row">
								<div class="webapp-footer-linebtn">
								  <div class="fl clearfix">
									<a href="javascript:document.getElementById('sendFormAgain').submit();" class="panel-press-a close-popover">催办</a>
								  </div>
								</div>
							  </div>
							</div>
						</footer>
					</c:if>
				</c:when>
			</c:choose>
		  </c:if>
        </div>
      </div>
    </div>
  </div>
  <c:if test="${param.workStatus ne '102'}">
	<c:choose>
		<c:when test="${param.workStatus eq '0'}">
			<%--<div class="fbtn-more-nav popover popover-links" id="fbtn-more-con">
				<div class="fbtn-more-nav-inner" id="fbtn-more-list">--%>
			<div class="new-popover" id="">
				<div class="new-pop" id="">
					<c:if test="${fn:indexOf(modibutton,'Tran') >0}">
						<a href="javascript:$('#tranInfoForm').submit();" class="panel-turn-a close-popover">转办</a>
					</c:if>
					<c:if test="${fn:indexOf(modibutton,'AddSign') >0}">
						<a href="javascript:$('#addSignForm').submit();" class="panel-add-a close-popover">加签</a>
					</c:if>
					<c:if test="${fn:indexOf(modibutton,'Selfsend') >0}">
						<a href="javascript:$('#selfsendForm').submit();" class="panel-read-a close-popover">阅件</a>
					</c:if>
				</div>
				<div class="new-sanjiao"></div>
			</div>
			<div class="gray-back"></div>
		</c:when>
		<c:when test="${param.workStatus eq '2'}">
		</c:when>
		<c:when test="${param.workStatus eq '101'}">
			<c:if test="${fn:indexOf(workcurstep,'办理完毕') == '-1'}">
				<div class="fbtn-more-nav popover popover-links" id="fbtn-more-con">
					<div class="fbtn-more-nav-inner" id="fbtn-more-list">
						
					</div>
				</div>
			</c:if>
		</c:when>
		<c:when test="${param.workStatus eq '1100'}">
		
		</c:when>
	</c:choose>
  </c:if>
  <!----------阅件开始---------->
<form id="selfsendForm" class="dialog" action="/defaultroot/dealfile/selfSend.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
	<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
</form>
<!----------阅件结束---------->
<!----------转办开始---------->
<form id="tranInfoForm" class="dialog" action="/defaultroot/dealfile/tranInfo.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="trantype" value="${trantype}">
	<input type="hidden" name="workStatus" value="0">
	<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
</form>
<!----------转办结束---------->
<!----------加签开始---------->
<form id="addSignForm" class="dialog" action="/defaultroot/dealfile/addSign.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
	<input type="hidden" name="fromFlag" value="<%=fromFlag%>">
</form>
<!----------加签结束---------->

<script type="text/javascript" src="<%=rootPath%>/clientview/custmenu/js/custmenu.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/js/subClick.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/template115/js/alert/zepto.alert.js"></script>

<script type="text/javascript" src="<%=rootPath%>/clientview/template/js/template.min.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/js/common.js"></script>
<script type="text/javascript" src="<%=rootPath%>/clientview/js/ajaxfileupload.js"></script>

  <script type="text/javascript">
  	//Export DOM7 to local variable to make it easy accessable
	 var myApp = new Framework7({
	       fastClicks: false,
	 });
	 var $$ = Dom7;
	 //右下角菜单弹框
	  $$('#fbtn-more').click(function () {
	    // body...
		//alert(1);
	    $$('.new-popover').css("display","block");
	    $$('.gray-back').css("display","block");
	  })
	  $$('.gray-back').click(function () {
	    // body...
	    $$('.new-popover').css("display","none");
	    $$('.gray-back').css("display","none");
	  })

  //解决input输入框的问题
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
 	
 	  function judgeAppCanDo(){
    	var modibutton = '${modibutton}';
		if(modibutton==null||modibutton==undefined){
			
		}else{
			var tipValue = "";
			if(modibutton.indexOf('cmdSendclose')>-1){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“分发”，请于PC端处理！";
			}
			if(modibutton.indexOf('cmdSavefile')>-1){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“生成正式文件”，请于PC端处理！";
			}
			if(modibutton.indexOf('cmdCode')>-1){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“编号”，请于PC端处理！";
			}
			if(modibutton.indexOf('cmdToreceive')>-1){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“转收文”，请于PC端处理！";
			}
			if(modibutton.indexOf('cmdGUIDANG')>-1){
			  //   myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
			   tipValue += "该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！";
			}
		//	if(modibutton.indexOf('cmdAutoGUIDANG')){
			   //  myApp.alert("该办理环节含有不支持移动端处理的功能“归档”，请于PC端处理！");
		//	   tipValue += "该办理环节含有不支持移动端处理的功能“自动归档”，请于PC端处理！";
		//	}
			return tipValue;
		}
    }

 	 $(document).ready(function(){
    	 var dealTipsContent = $("#dealTipsContent").html();
         if(dealTipsContent != ''&&dealTipsContent!=null&&dealTipsContent!=undefined){ 
        	 myApp.alert(dealTipsContent);
         }
		 var ezflow_activityTip = '${ezflow_activityTip}';
		 var ezflow_activityTipCotent = '${ezflow_activityTipCotent}';
		 var ezflow_activityTipTitle = '${ezflow_activityTipTitle}';
		 if(ezflow_activityTip=='1' && ezflow_activityTip=='1'){
			 myApp.alert(ezflow_activityTipTitle+" "+ezflow_activityTipCotent);
		 }
	  });
 	
  	var dialog = null;
    var flag = 1;//防止重复提交
    var backFlag = 1;//防止退回重复提交
    var workfolwSendFlag = 1;
    function subForm(){

		confirmForm();
    	var tipValue = judgeAppCanDo(); 
    	if(tipValue!=""){
			myApp.alert(tipValue);
			return;
		}
    	var commentmustnonull = "${commentmustnonull_isTrue}";
    	if(commentmustnonull == 'true'){
	       	if($('comment_input'!= null)&&$('#comment_input').length>0){
	            var comment = $('#comment_input').val();
	            if(comment == ''||comment==null||comment==undefined){ 
	            	myApp.alert('批示意见不能为空！')
	            	return;
	            }else if(comment.length>1000){
	            	myApp.alert('批示意见最大长度为1000个字！')
	            	return;
		         }
	        }
        }
    	if(flag == 0){
    		return;
    	}
    	flag = 0;
    	$('#sendForm').submit();
    }      
    function subBackForm(){
    	if(backFlag == 0){
    		return;
    	}
    	backFlag = 0;
    	$('#backForm').submit();
    }      
    function pageLoading(){
        dialog = $.dialog({
            content:"页面加载中...",
            title: 'load'
        });
    }
    var flowgraphurl = '${flowgraphurl}';
    $(function(){
		//设置单选、下拉框等初始化时的内容
    	setDefaultSpanHtml();
		if(flowgraphurl!='' && flowgraphurl!=undefined){
 			//loadFlowImg(flowgraphurl);
 		}else{
 			$("#12tab").hide();
 			$(".clearfix>a").css("width","50%");
 			$(".clearfix>a").addClass("tab-link-rw");
 			$("#tab12").hide();
 	 	}
    });

    var getFlowImgflag = '0';
	function workFlowGraph(){
		if(flowgraphurl!='' && flowgraphurl!=undefined  && getFlowImgflag =='0'){
			loadFlowImg(flowgraphurl);
		}
	}
	
	//加载图片
	function loadFlowImg(flowgraphurl){
		myApp.showPreloader(' ');
		$.ajax({
			 type: 'post',
			 url: "<%=rootPath%>/download/downloadImg.controller",
			 dataType:'text',
			 data : {"fileName": flowgraphurl,"name": flowgraphurl,"path":"workflow_acc"},
			 success: function(data){
				$('#lct').attr("src", "<%=rootPath%>"+data);
				getFlowImgflag = '1';
				myApp.hidePreloader();
			 },error: function(xhr, type){
				 alert('数据查询异常！');
			 }
		
		});
	}
    
	function workfolwSend(workId){
		if(workfolwSendFlag == 0){
    		return;
    	}
		workfolwSendFlag = 0;
		//发送流程
		$.ajax({
			url : '/defaultroot/workflow/readover.controller',
			type : 'post',
			data : $('#sendForm').serialize(),
			success : function(data){
				if(data){
					var jsonData = eval('('+data+')');
					console.info(jsonData.result);
					if(jsonData.result = 'success'){
						alert('发送成功！');
						window.location = '/defaultroot/dealfile/list.controller?workStatus=0';
					}
				}else{
					alert('发送失败！');
				}
			},
			error : function(){
				alert('发送异常！');
			}
		});
	}
	
	var workfolwUndoFlag =1;
	function workfolwUndo(workId){
		if(workfolwUndoFlag == 0){
    		return;
    	}
		myApp.confirm('是否撤回该流程到您的待办文件中重新办理？', function () {
			workfolwUndoFlag=0;
			var url ='/defaultroot/workflow/workfolwUndo.controller?workId='+workId;
			var openUrl ='/defaultroot/dealfile/list.controller?workStatus=101';
			myApp.showPreloader('正在撤办...');
			$.ajax({
				type:'POST',
				url: url,
				async: true,
				dataType: 'text',
				success: function(data){
					var json = eval("("+data+")");
					myApp.hidePreloader();
					if(json!=null){
						if(json.result == 'success'){
							myApp.alert("撤办成功！");
							window.history.go(-1);
						}else{
							myApp.alert("撤办失败！");
							workfolwUndoFlag = '0';
						}
					}
				},
				error: function(){
					myApp.alert("异常！");
					workfolwUndoFlag = '0';
				}
			});
	    },function () {
	    	workfolwUndoFlag = '1';
	     });		
	}
	
	//选择常用语
    function selectComment(obj){
    	var $selectObj = $(obj);
    	var selectVal = $selectObj.val();
    	if(selectVal == '0'){
        	selectVal = '';
        }
    	var $textarea = $selectObj.parent().siblings();
    	//setSpanHtml(obj,selectVal);
    	$textarea.val($textarea.val() + selectVal);
    	obj.options[0].selected = "selected";
		//--new--
		var newp = $(obj).parent();
		var newo = $(obj).clone();
		$(obj).remove();
		newp.append(newo);
    }
	
	var getlogFlag = 0;
	function openWorkFlowGetLog() {
		if(getlogFlag == 0){
			loadFlowRecord();
		}
	}
	
	//加载流程记录页面数据
	function loadFlowRecord(){	
		myApp.showPreloader(' ');
		var workId= '${workId}';
		var url ='/defaultroot/doc/getFlowRecord.controller?workId='+workId;
		$.ajax({
			type:'POST',
			url: url,
			async: true,
			dataType: 'text',
			success: function(data){
				var jsonData = eval("("+data+")");
				var html ='<tr>'+
							'<td>'+
							  '<div class="step-username">'+
								'<p>发起人</p>'+
								'<em>发送时间</em>'+
							  '</div>'+
							'</td>'+
							'<td>'+
							  '<div class="step-name">'+
								'<em class="skyblue">环节名称</em>'+
							  '</div>'+
							'</td>'+
							'<td>'+
							  '<div class="step-recive">'+
								'<p>接收人</p>'+
							  '</div>'+
							'</td>'+
						'</tr>';
				if(jsonData.data0.length>0){
					for(var i = 0; i < jsonData.data0.length; i++){
						html += '<tr>'+
									'<td>'+
									  '<div class="step-username">'+
										'<p>'+jsonData.data0[i].logUserName+'</p>'+
										'<em>'+jsonData.data0[i].logTime.substring(2)+'</em>'+
									  '</div>'+
									'</td>'+
									'<td>'+
									  '<div class="step-name">'+
										'<em class="skyblue">'+jsonData.data0[i].logAction+'</em>'+
									  '</div>'+
									'</td>'+
									'<td>'+
									  '<div class="step-recive">'+
										'<p>'+jsonData.data0[i].logReceive+'</p>'+
									  '</div>'+
									'</td>'+
								'</tr>';
					}
					$$('#flowRecord').html(html);
				}
				getlogFlag = 1;
                myApp.hidePreloader();	
			},
			error: function(){
				alert("异常！");
			}
		});  
	}

	$(function(){
		setTimeout(loadImg(),'500');
	});

	//加载手写签名自动追加
	function loadImg(){
		$("input[name='imgNames']").each(
			function (){
				var filename = $(this).val();
				var filenamenew = 'rev'+filename+'.gif';
				if(filename != 'null'){
					$.ajax({
						type : 'post',
						url : '<%=rootPath%>/download/downloadImg.controller',
						dataType : 'text',
                        async: false,
						data : {"fileName":filenamenew,"name":filenamenew,"path":"workflow_acc","realtime":"1"},
						success : function(data){
							$('#'+filename).attr("src","<%=rootPath%>"+data);
						},
						error : function (xhr,type){
							alert('数据查询异常！');
						}
					});
				}
			}
		);
	}
	//设置span中的值
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	}

	//设置页面初始时的选项内容显示
    function setDefaultSpanHtml(){
    	var selectText = '';
    	var $currSelect;
    	$('select').each(function(){
    		$currSelect = $(this);
    		selectText = $currSelect.find("option:selected").text();
    		$currSelect.parent().find('div>span').html(selectText);
    	});
    }
    
    //日期空间初始化参数
    var opt = {
		'date': {
			preset: 'date', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            showNow: false,
            endYear:2099
		},
		'datetime': {
	  	 	preset: 'datetime', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            timeFormat: 'HH:ii',
            timeWheels:'HHii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            hourText:'时',
            minuteText:'分',
            showNow: false,
            endYear:2099
		},
		'time': {
	  	 	preset: 'time', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            timeFormat: 'HH:ii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            hourText:'时',
            minuteText:'分',
            amText:'上午',
            pmText:'下午',
            showNow: false,
            endYear:2099
		}
	}
    
    //选择日期时间
    function selectDateTime(){
    	var dateType = '';
    	var firstParam;
    	$('input').each(function(){
    		dateType = $(this).data('datetype');
    		if(dateType){
				$(this).mobiscroll(opt[dateType]);
    		}
    	});
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
			if($('#mainContent').is(':hidden')){
			}else{
				$("#mainContent").css("display","none");
				$("#footerButton").css("display","none");
			}
			$("#selectContent").css("display","block");
		}else if(flag == 1){
			$("#selectContent").css("display","none");
				$("#mainContent").css("display","block");
				$("#footerButton").css("display","block");
			$("#selectContent").empty();
		}else if(flag==2){//显示子表 
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
		}else if(flag==3){
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
		}
	}

	//图片数标记
    var index = 0;
   
    //添加图片
    function addImg(name){
	   $(".edit-upload-in").before(       
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

	//添加图片(自定义)
    function addImgCust(name){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="_custfile_'+name+'"/>'+
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
		var loadingDialog = openTipsDialog('正在上传...');
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=customform', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#img_name_"+(index-1)).val(msg.data+"|"+fileShowName);
				$("#"+imgliId).show();
				loadingDialog.close();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				myApp.alert("文件上传失败！");
			}
		});
	}
    
    function selectCallBack(obj1,obj2){
    	if(obj1.val() && obj2.val()){
			obj2.val(obj1.val() + ";" + obj2.val());
    	}else{
    		obj2.val('');
    	}
	}
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
  </script>
</body>
