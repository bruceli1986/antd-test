<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<h3 class="page-header">1.<spring:message code="payment_l_guaranteeBasics"/></h3>
	<p>
	<div class="form-horizontal">
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="payment_l_project"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${guaranteeDeposit.project}</p>
			</div>
			<label class="control-label col-md-2"><spring:message code="payment_l_projectDescription"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${guaranteeDeposit.projectDesc}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="payment_l_poNo"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${guaranteeDeposit.poNo}</p>
			</div>
			<label class="control-label col-md-2"><spring:message code="payment_l_poName"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${guaranteeDeposit.poDesc}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="payment_l_contractOriginalNo"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${empty guaranteeDeposit.originalCode?'-':guaranteeDeposit.originalCode}</p>
			</div>
			<label class="control-label col-md-2"><spring:message code="payment_l_contractCost"/></label>
			<div class="col-md-4">
				<p class="form-control-static"><fmt:formatNumber value="${guaranteeDeposit.poAmount}" type="number" minFractionDigits="2"></fmt:formatNumber></p>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="payment_l_finalincurredCost"/></label>
			<div class="col-md-4">
				<p class="form-control-static"><fmt:formatNumber value="${guaranteeDeposit.paidAmount}" type="number" minFractionDigits="2"></fmt:formatNumber></p>
			</div>
			<label class="control-label col-md-2"><spring:message code="payment_l_finalPaymentPaid"/></label>
			<div class="col-md-4">
				<c:if test="${guaranteeDeposit.hasFinalPaid eq 'false'}">
					<p class="form-control-static"><spring:message code="payment_l_no"/></p>
				</c:if>
				<c:if test="${guaranteeDeposit.hasFinalPaid eq 'true'}">
					<p class="form-control-static"><spring:message code="payment_l_yes"/></p>
				</c:if>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="payment_l_responsibleUnitNo"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${empty guaranteeDeposit.division?'-':guaranteeDeposit.division}</p>
			</div>
			<label class="control-label col-md-2"><spring:message code="payment_l_responsibleUnitDesc"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${empty guaranteeDeposit.divisionDesc?'-':guaranteeDeposit.divisionDesc}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="payment_l_supervisingUnitNo"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${empty guaranteeDeposit.supervision?'-':guaranteeDeposit.supervision}</p>
			</div>
			<label class="control-label col-md-2"><spring:message code="payment_l_supervisingUnitDesc"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${empty guaranteeDeposit.supervisionDesc?'-':guaranteeDeposit.supervisionDesc}</p>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-md-2"><spring:message code="payment_l_vendorNo"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${empty guaranteeDeposit.company?'-':guaranteeDeposit.company}</p>
			</div>
			<label class="control-label col-md-2"><spring:message code="payment_l_vendorDesc"/></label>
			<div class="col-md-4">
				<p class="form-control-static">${empty guaranteeDeposit.comDesc?'-':guaranteeDeposit.comDesc}</p>
			</div>
		</div>
	</div>

<h3 class="page-header">2.<spring:message code="payment_l_attachments"/></h3>
<p>
	<c:if test="${associateFileList != null && fn:length(associateFileList) != 0}">
	<div class="table-responsive">
		<table class="table table-striped table-hover">
			<tr>
				<th style="min-width:10em;width:50%;"><spring:message code="payment_l_fileName"/></th>
				<th style="width:10%;"><spring:message code="payment_l_fileSize"/></th>
				<th style="width:10%;"><spring:message code="payment_l_uploadPerson"/></th>
				<th style="width:20%;"><spring:message code="payment_l_uploadDate"/></th>
				<th style="width:20%;"><spring:message code="payment_l_action"/></th>
			</tr>
			<c:forEach var="associateFile" items="${associateFileList}" varStatus="status">
			<tr>
				<td style="white-space:normal;" class="filekey" data-key="${associateFile.fileProgCode}||${associateFile.fileKey}||${associateFile.seqNo}"><a class="preview-href" data-toggle="modal" data-target="#previewModal" data-path="${associateFile.remarkText}">${associateFile.fileShowName}</a></td>
				<td>${associateFile.fileShowSize}</td>
				<td>${associateFile.commonName}</td>
				<td><fmt:formatDate value="${associateFile.uploadDate}" type="date"></fmt:formatDate></td>
				<td><form name="download_${status.index}" method="POST" action="<c:url value="/payment2/file/download?fileShowName=${associateFile.fileShowName}&url=${associateFile.remarkText}"/>"><a href="javascript:document.forms.download_${status.index}.submit();"><spring:message code="payment_l_download"/></a></form></td>
			</tr>
			</c:forEach>
		</table>
	</div>
	</c:if>
	<c:if test="${associateFileList == null || fn:length(associateFileList) == 0}">
		<p class="lead" style="font-size:14px; margin-left: 2em;"><spring:message code="payment_l_empty"/></p>
	</c:if>

	<h3 class="page-header">3.<spring:message code="payment_l_flowHistory"/></h3>
	<p>
	<c:if test="${historyList != null && fn:length(historyList) != 0}">
		<div class="table-responsive">
			<table class="table table-striped table-hover">
				<tr>
					<th style="width:10%;"><spring:message code="payment_l_assignee"/></th>
					<th style="min-width:15em;width:30%;"><spring:message code="payment_l_comment"/></th>
					<th style="min-width:10em;width:20%;"><spring:message code="payment_l_taskName"/></th>
					<th style="width:15%;"><spring:message code="payment_l_startTime"/></th>
					<th style="width:15%;"><spring:message code="payment_l_endTime"/></th>
				</tr>
				<c:forEach var="history" items="${historyList}">
					<tr>
						<td>${history.assignee}</td>
						<td style="white-space:normal;text-align:left;">${empty history.comment?'-':history.comment}</td>
						<td style="white-space:normal;">${history.taskName}</td>
						<td><fmt:formatDate value="${history.startTime}" type="both"></fmt:formatDate></td>
						<td><fmt:formatDate value="${history.endTime}" type="both"></fmt:formatDate></td>
					</tr>
				</c:forEach>	
			</table>
		</div>
	</c:if>

	<c:if test="${historyList == null || fn:length(historyList) == 0}">
		<p class="lead" style="font-size:14px; margin-left: 2em;"><spring:message code="payment_l_empty"/></p>
	</c:if>

	<div class="modal fade" id="previewModal" tabindex="-1" role="dialog" aria-labelledby="previewModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">			  
		    <div class="modal-content">
		    	<div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="previewModalLabel"><spring:message code="payment_l_filePreview"/></h4>
			    </div>
			    
		    	<div id="convertContent" class="modal-body">
		    		<div id="officeDiv" class="preview-modal">
						<object id="TANGER_OCX" name="TANGER_OCX" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" codebase="<c:url value='/lib/ntkoOffice/OfficeControl.cab#version=5,0,1,6'/>" width="100%" height="100%">
							<param name='MakerCaption' value='中电科长江数据股份有限公司'/>
							<param name='MakerKey' value='E862EEFF6D976F41A81D67BEF5BD3450217FCEA1'/>
							<param name='ProductCaption' value='中国长江三峡集团公司'/>
							<param name='ProductKey' value='0149138A064B57EEC1B42144148FF7D18E1497B3'/>
							<param name='IsUseControlAgent' value='true'/>
							<param name='IsUseUTF8URL' value='true'/>
							<param name='IsUseUTF8Data' value='true'/>
							<param name='IsShowNetErrorMsg' value='false'/>
							<param name='DefaultOpenDocType' value='0'/>
							<param name='IsShowFileErrorMsg' value='false'/>
							<param name='TitleBar' value='true'/>
							<param name='MenuBar' value='true'/>
							<param name='ToolBars' value='true'/>
							<param name='Statusbar' value='true'/>
							<param name='IsResetToolbarsOnOpen' value='false'/>
							<param name='IsShowHelpMenu' value='true'/>
							<param name='IsShowInsertMenu' value='true'/>
							<param name='IsShowEditMenu' value='true'/>
							<param name='FileNew' value='false'/>
							<param name='FileOpen' value='true'/>
							<param name='FileClose' value='false'/>
							<param name='IsShowFullScreenButton' value='true'/>
							<param name='IsNoCopy' value='false'/>
							<param name='IsStrictNoCopy' value='false'/>
							<param name='IsOpenURLReadOnly' value='false'/>
							
							<param name='Caption' value='预览'/>
							
							<param name='BorderStyle' value='0'/>
							<param name='BorderColor' value='14402205'/>
							<param name='TitlebarColor' value='14402205'/>
							<param name='TitlebarTextColor' value='0'/>
							<param name='IsShowToolMenu' value='-1'/>
							<param name='MaxUploadSize' value='10000000'/>
							
							<span style='color:red'>装载文档插件失败！请检查如下两项：
							</br>1、请使用IE9+浏览器，并检查浏览器选项中的安全设置；
							</br>2、检查文档插件是否正确安装。</span>
						</object>
					</div>
					<div id="pdfDiv" class="preview-modal"></div>
		    		<pre class="preview-modal" style="word-wrap:break-word;white-space:pre-wrap;"></pre>
		    		<img class="img-responsive"/>
		    	</div>
			</div>
		  </div>
	</div>
	<script>
		$(document).on('click', '.preview-href', function (){
			preview($(this).data('path'));
		});

		function preview (filePath) {
			var param = {
				remarkText:filePath
			};

			$('#officeDiv').hide();
			$('#pdfDiv').hide();
			$('#convertContent pre').hide();
			$('#convertContent img').hide();		

			if(/(doc(x)?|xls(x)?|ppt(x)?)$/i.test(filePath)){
				//获取文档对象
				$('#officeDiv').show();
				filePath = encodeURI(filePath);
				var officeObj = document.getElementById("TANGER_OCX");
				try {
					setTimeout(function (){
						officeObj.OpenFromURL('<c:url value="/payment2/file/previewOffice?remarkText="/>'+filePath);
					}, 1000);
				}catch (e){
					console.log('error');
				}
			}else if(/(pdf|gif|jp(e)?g|png|txt)$/i.test(filePath)){
				$.post('<c:url value="/payment2/file/preview"/>',param,function(result){
					if(result){
					 	var url = encodeURI('<c:url value="/"/>'+result);
					 	if(/(gif|jp(e)?g|png)$/i.test(url)){
					 		$('#convertContent img').attr('src', url);
					 		$('#convertContent img').show();
					 	}else if(/txt$/i.test(url)){
							$.get(url ,null, function(response,status,xhr){
								$('#convertContent pre').empty().append(HtmlUtil.htmlEncode(response));
								$('#convertContent pre').show();
							});
					 	}else if(/pdf$/i.test(url)){
					 		$('#pdfDiv').media({
					    		src:'<c:url value="/"/>'+result,
					    		width:'100%',
					    	}).show();
					 	}
					}
				});
			}
		}

		// function preview (filePath) {
		// 	var param = {
		// 		remarkText:filePath
		// 	};
		// 	$('#convertContent').empty();
		// 	$('#previewMask').show();

		// 	$.post('<c:url value="/payment2/file/preview"/>',param,function(result){
		// 		$('#previewMask').hide();
		// 		if(result && result.length != 0){
		// 			 for(var i = 0; i < result.length; i++){
		// 			 	var url = '<c:url value="/"/>'+result[i];
		// 			 	if(/(gif|jp(e)?g|png)$/i.test(url)){
		// 			 		$('#convertContent').append('<img class="img-responsive" src="'+url+'"></br>');
		// 			 	}else if(/txt$/i.test(url)){
		// 					$('#convertContent').load(url);
		// 			 	}
		// 			}
		// 		}
		// 	});
		// };
</script>
