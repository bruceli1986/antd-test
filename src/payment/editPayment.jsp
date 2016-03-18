<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<title><spring:message code="payment_l_editPayment"/></title>
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-table/dist/bootstrap-table.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-switch-master/dist/css/bootstrap3/bootstrap-switch.min.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/jquery-file-upload/css/jquery.fileupload.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/jquery-file-upload/css/jquery.fileupload-ui.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-sweetalert-master/lib/sweet-alert.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-datepicker/dist/css/bootstrap-datepicker3.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/select2/dist/css/select2.min.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/opinions.css"/>">
		<style type="text/css" media="screen">
			.hide{
				display: none;
			}
			.form-td{
				text-align:left !important;
				border-top: none !important;
				height: 48px !important;
			}
			#payment-form-searcher{
				margin:0 20px;
				width: 200px;
			}
			#paymentForm .fixed-table-container{
			    max-height: 490px;
			    overflow-y: auto;
			}
		</style>
	</head>
	<body>
		<div class="payment-path">
			<ol class="breadcrumb ">
				<li class="active"><spring:message code="payment_l_editPayment"/></li>
			</ol>
		</div>
		<div class="row">
			<div class="col-md-12" role="main">
				<form id="paymentForm" class="form-horizontal" action="editPayment/resubmit" method="post">
					<input type="hidden" name="businessId" value="${businessId}">
					<input type="hidden" name="taskId" value="${taskId}">
					<input type="hidden" name="fileIds" value="${fileIds}">
					<input type="hidden" value="${processInstanceId}" name="processInstanceId">
					<input type="hidden" name="token" value="${token}">
					<h3 class="page-header" id="cp-basic">1.<spring:message code="payment_l_paymentBasics"/></h3>
					<p class="width-600">
					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_project"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${invoice.project}</p>
						</div>
						<label class="control-label col-md-2"><spring:message code="payment_l_projectDescription"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${invoice.projectDesc}</p>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_poNo"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${invoice.poNo}</p>
							<input type="hidden" name="poNo" value="${invoice.poNo}">
						</div>
						<label class="control-label col-md-2"><spring:message code="payment_l_poName"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${invoice.poDesc}</p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_vendorNo"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${invoice.company}</p>
							<input type="hidden" name="company" value="${invoice.company}">
						</div>
						<label class="control-label col-md-2"><spring:message code="payment_l_vendorDesc"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${invoice.companyDesc}</p>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_receiveDate"/></label>
						<div class="col-md-4">
							<input id="datetimepicker" class="form-control" >
							<input type="hidden" name="dateRcvd" value='<fmt:formatDate value="${invoice.dateRcvd}" type="date"/>'>
						</div>
						<label class="control-label col-md-2"><spring:message code="payment_l_invoiceNo"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${invoice.invoiceNo}</p>
							<input class="form-control" type="hidden" name="invoiceNo" value="${invoice.invoiceNo}">
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_apRef"/></label>
						<div class="col-md-4">
							<textarea class="form-control" rows="2" name="apRef">${invoice.apRef}</textarea>
						</div>
					</div>

					<h3 class="page-header" id="cp-detail">2.<spring:message code="payment_l_paymentDetails"/></h3>
					<p>
						<div id="paymentTableToolbar">
							<input id="payment-form-searcher" class="form-control" placeholder="<spring:message code='payment_l_BOQ'/>/<spring:message code='payment_l_paymentDescription'/>"/>
							<input id="payment-form-type" type="checkbox" checked/>
						</div>
						<table id="paymentListTable" data-form="false" data-toggle="table" data-url="<c:url value="/payment2/editPayment/queryPcList?systemCode=${system.code}&poNo=${invoice.poNo}&invoiceNo=${invoice.invoiceNo}&company=${invoice.company}"/>" data-classes="table table-hover table-no-bordered"  data-toolbar="#paymentTableToolbar">
							<thead>
								<tr>
									<th data-field="poItem"><spring:message code="payment_l_BOQ"/></th>
									<th data-field="description"><spring:message code="payment_l_paymentDescription"/></th>
									<th data-formatter="generateUnit"><spring:message code="payment_l_unitNoDesc"/></th>
									<th data-field="currency"><spring:message code="payment_l_currency"/></th>
									<th data-field="ptdCommitmentQty" data-align="right"><spring:message code="payment_l_contractQty"/></th>
									<th data-field="ptdCommitmentFrate" data-formatter="formatMoney" data-align="right"><spring:message code="payment_l_contractFrate"/></th>
									<th data-field="incurredPrice" data-formatter="formatMoney" data-align="right"><spring:message code="payment_l_contractIncurredPrice"/></th>
									<th data-field="incurredQtyTotal" data-align="right"><spring:message code="payment_l_incurredQty"/></th>
									<th data-field="incurredFcostsTotal" data-formatter="formatMoney"  data-align="right"><spring:message code="payment_l_incurredCost"/></th>
								</tr>
							</thead>
						</table>
						<div class="payment-table-footer">
							<div class="row">
								<div class="col-md-3">
									<label><spring:message code="payment_l_paymentCost"/></label><span class="invoice-costs"></span>
								</div>
								<div class="col-md-3">
									<label><spring:message code="payment_l_contactTotal"/></label><span><fmt:formatNumber value="${poCost.poCosts}" type="number" minFractionDigits="2"></fmt:formatNumber></span>
								</div>
								<div class="col-md-3">
									<label><spring:message code="payment_l_contactIncurredTotal"/></label><span><fmt:formatNumber value="${poCost.incurredFcosts}" type="number" minFractionDigits="2"></fmt:formatNumber></span>	
								</div>
								<div class="col-md-3">
									<label><spring:message code="payment_l_contactIncurredPrecent"/></label><span><fmt:formatNumber value="${poCost.sumPoCostsPercent}" type="percent" minFractionDigits="2"></fmt:formatNumber></span>
								</div>
							</div>
						</div>
					<h3 class="page-header" id="cp-upload">3.<spring:message code="payment_l_uploadAttachments"/></h3>
					<p>
						<div id="progress">
						    <div class="bar" style="width: 0%;"></div>
						</div>
						<span class="btn btn-default fileinput-button">
							<i class="glyphicon glyphicon-plus"></i>
							<span><spring:message code="payment_l_chooseUploadFile"/></span>
							<input id="fileupload" type="file" name="files" multiple >	
						</span> 			
	<!-- 						<span class="text-info">(文件大小在5MB以内)</span> -->
						<div class="table-responsive">
							<table id="uploaded-files" class="table uploaded-files" data-key="[]" <c:if test="${associateFileList == null || fn:length(associateFileList) == 0}">style="display:none;"</c:if>>
						        <tr>
						            <th style="min-width:10em;width:40%"><spring:message code="payment_l_fileName"/></th>
									<th style="width:10%;"><spring:message code="payment_l_fileSize"/></th>
									<th style="width:10%;"><spring:message code="payment_l_uploadPerson"/></th>
									<th style="width:20%;"><spring:message code="payment_l_uploadDate"/></th>
									<th style="width:20%;"><spring:message code="payment_l_action"/></th>
						        </tr>
						        <c:forEach var="associateFile" items="${associateFileList}" varStatus="status">
								<tr>
									<td><a style="white-space:normal;" class="preview-href" data-toggle="modal" data-target="#previewModal" data-path="${associateFile.remarkText}">${associateFile.fileShowName}</a></td>
									<td>${associateFile.fileShowSize}</td>
									<td>${associateFile.commonName}</td>
									<td><fmt:formatDate value="${associateFile.uploadDate}" type="date"></fmt:formatDate></td>
									<td><a class="download-href" href="javascript:document.forms.download_${status.index}.submit();"><spring:message code="payment_l_download"/></a><a class="delete-href" data-filepath="${associateFile.remarkText}" data-filekey="${associateFile.fileKey}" data-seq="${associateFile.seqNo}" data-progcode="${associateFile.fileProgCode}" data-url="<c:url value="/payment2/file/delete?businessId=${businessId}"/>"><spring:message code="payment_l_delete"/></a></td> 
								</c:forEach>
						    </table> 
						</div>
					<h3 class="page-header">4.<spring:message code="payment_l_flowHistory"/></h3>
					<p>
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
					<p>
					<br>
					<div class="panel panel-default">
						<div class="panel-body">
							<jsp:include page="fragment/handleTask.jsp" flush="true">
								<jsp:param name="process" value="edit"/> 
								<jsp:param name="formId" value="paymentForm"/> 
								<jsp:param name="outGoing" value="false"/> 
								<jsp:param name="participantUsers" value="true"/> 
							</jsp:include>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="payment-mask hide"></div>

		<div id="associateFile" class="hide">
			<c:forEach var="associateFile" items="${associateFileList}" varStatus="status">
				<form class="download-href" name="download_${status.index}" method="POST" action="<c:url value="/payment2/file/download"/>">
					<input type=hidden name="fileShowName" value="${associateFile.fileShowName}">
					<input type=hidden name="url" value="${associateFile.remarkText}">
				</form>
			</c:forEach>
		</div>

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

		<script type="text/javascript" src="<c:url value="/lib/jquery/jquery.media.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/ejs/ejs.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/bootstrap-switch-master/dist/js/bootstrap-switch.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/handlebars/handlebars.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/typeahead.js/dist/typeahead.jquery.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/typeahead.js/dist/bloodhound.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/bootstrap-sweetalert-master/lib/sweet-alert.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/moment/moment.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/numeraljs/numeral.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/select2/dist/js/select2.full.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/jquery-file-upload/js/vendor/jquery.ui.widget.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/jquery-file-upload/js/jquery.iframe-transport.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/jquery-file-upload/js/jquery.fileupload.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/jquery-file-upload/js/jquery.fileupload-process.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/jquery-file-upload/js/jquery.fileupload-validate.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/bootstrap-datepicker/dist/locales/bootstrap-datepicker.zh-CN.min.js"/>"></script>
<!-- 		<script type="text/javascript" src="<c:url value="/lib/jquery-zoom/jquery.zoom.min.js"/>"></script> -->
		<script type="text/javascript" src="<c:url value="/payment2/scripts/htmlUtil.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/opinions.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/locale/opinions-lang.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/payment-form.js"/>"></script>
		<script>
		 $(function(){
		 	init();

		 	//格式化上传功能
		 	uploadFile();

		 	function init(){
		 		$(window).on('resize', function (){
		 			$('#paymentListTable').bootstrapTable('resetWidth');
		 		});
		 		
		 		$('#paymentListTable').on('post-header.bs.table', function(){
		 			var data = $('#paymentListTable').bootstrapTable('getData');
		 			if($(this).data('form') == false && data.length){
			 			generatePcListForm(data, 9);			 			
		 				//第一次点击，填入默认数字
				 		$('input[name*=incurredQty]:blank').one('click',  function(){
							this.value = $(this).data('max');
							$(this).trigger('change');
						});

						$('input[name*=incurredFcosts]:blank').one('click',  function(){
							this.value = $(this).data('max');
							$(this).trigger('change');
						});

						$(this).data('form', true);

						//格式化输入表单元素
		 				formatInput();

		 				$('#payment-form-type').bootstrapSwitch('toggleState');
		 				$('input[name*=incurredFcosts]').trigger('keyup');
		 				$('input[name*=incurredFcosts]').trigger('change');
		 				$('input[name*=incurredQty]').trigger('keyup');
		 				$('input[name*=incurredQty]').trigger('change'); 
		 			}	
		 		});

		 		$('#paymentListTable').on('post-header.bs.table', function(){
		 			$('.fixed-table-header th').each(function(index){
		 				$('#paymentListTable th:eq('+index+')').width($(this).width());
		 			});
		 		});

		 		$('#payment-form-type').bootstrapSwitch({
			 		size:'mini',
			 		onText:'<spring:message code="payment_l_all"/>',
			 		offText:'<spring:message code="payment_l_filled"/>',
			 		offColor:'primary'
			 	}).on('switchChange.bootstrapSwitch', function(event, state) {
				  if(state == false){
				  	$('#payment-form-searcher').attr('disabled', true);
				  	filterFormTr();
				  }else{
				  	$('#payment-form-searcher').removeAttr('disabled');
				  	$('#payment-form-searcher').trigger('keyup');
				  }
				  $('#paymentListTable').bootstrapTable('resetWidth');
				});

				$('#payment-form-searcher').on('keyup', function(event){
					event.preventDefault();	
					var targetValue = $.trim(this.value);
					var data = $('#paymentListTable').bootstrapTable('getData');
					$('.form-tr').each(function(index){
						var $tr = $(this).closest('tr');
						var poItem = data[index].poItem;
						var description = data[index].description;
						var re =new RegExp(targetValue,'i');
						if(re.test(poItem) || re.test(description) || targetValue == '') {
							$tr.prev().andSelf().removeClass('hide');
						}else{
							$tr.prev().andSelf().addClass('hide');
						}
					});
				});

				$('#datetimepicker').datepicker({
					language:'<spring:message code="qdp_l_lang"/>',
					todayHighlight:true,
					autoclose:true,
					endDate:'0d'
				}).on('changeDate', function(e) {
			        $('[name=dateRcvd]').val($('#datetimepicker').datepicker('getUTCDate'));
			    });

		 		$('#datetimepicker').datepicker('setDate', '<fmt:formatDate value="${invoice.dateRcvd}" type="date"/>');

				//计算总花费
		 		sumTotalCosts();
		 	}

			function filterFormTr(){
				$('.form-tr').each(function(){
					var $tr = $(this).closest('tr');
					if($tr.find('.form-td:has(input[name*=incurredQty]:not(:blank), input[name*=incurredFcosts]:not(:blank))').length){
						$tr.prev().andSelf().removeClass('hide');
					}else{
						$tr.prev().andSelf().addClass('hide');
					}
			  	});
			}

			function formatInput(){
				$('#paymentForm').validate({
					rules:{
						monthRcvd:{
							required: true 
						},
						apRef:{
							required: true
						}
					},
					messages:{
						apRef:{
							required:'<spring:message code="payment_m_error7"/>'
						}
					},
					showErrors: function(errorMap, errorList) {
						this.defaultShowErrors();
						errorList.forEach(function (x, i, a){
							if(x.method == 'incurredRemarkLength'){
								$(x.element).next('label').remove();
								$(x.element).next('span').addClass('error');
							}
						});
					},
					unhighlight: function(element, errorClass, validClass) {
					    $(element).removeClass(errorClass).addClass(validClass);
					    $(element).next('span').removeClass(errorClass);
					},
					invalidHandler:function(event, validator) {
						validator.focusInvalid();
						//解决IE错误提示不在中间的bug
						if($(validator.lastActive).offset().top-$(document).scrollTop() < 70) {
							$(document).scrollTop($(validator.lastActive).offset().top-70);
						}
					},
					submitHandler: function (form){
						$.ajax({
			                cache: true,
		           			type: form.method,
			                url: form.action,
			                data: $(form).serialize(),
			                async: true,
			                error: function(request) {
			                    alert('Connection error');
			                },
			                success: function(data) {
			                	$('.payment-mask').addClass('hide');
			                   if(data.success == true){
		                    		swal({   
		                    			title: '<spring:message code="payment_m_info8"/>',   
		                    			text: '<spring:message code="payment_m_info9"/>',   
		                    			type: 'success',   
		                    			showCancelButton: false,      
			                   			confirmButtonColor: '#428bca',   
			                   			confirmButtonText: '<spring:message code="payment_l_confirm"/>',
			                   			closeOnConfirm: true}, 
			                   			function(isConfirm){   
			                   				if (isConfirm) {     
												location.href = '<c:url value="/payment2/todoTaskManage"/>';
			                   				}
			                   			});
			                   }else{
			                   		swal({   
			                			title: '<spring:message code="payment_m_info3"/>',   
			                			text: '<spring:message code="payment_m_info9"/>',   
			                			type: 'error',   
			                			showCancelButton: false,      
			                   			confirmButtonColor: '#428bca',   
			                   			confirmButtonText: '<spring:message code="payment_l_confirm"/>',
			                   			closeOnConfirm: true}, 
			                   			function(isConfirm){   
			                   				if (isConfirm) {     
												location.href = '<c:url value="/payment2/viewContract"/>';
			                   				}
			                   			});
			                   }
			                }	
			            });
 						$('.payment-mask').removeClass('hide');
			         }
				});

			 	//隐藏备注按钮，防止用户出错
				$(document).on('keyup', 'input[name*=remark]', function(){
					if($.trim(this.value)){
						$(this).closest('.form-td').find('.remark-show-button').addClass('hide');;
					}else{
						$(this).closest('.form-td').find('.remark-show-button').removeClass('hide');;
					}
				});
							
				//警告的实现
				$(document).on('keyup', 'input[name*=incurredFcosts]', function(){
					$(this).nextAll('.warning').remove();
					if($(this).valid()){
						var max = numeral().unformat($(this).data("max"));
						var val = parseFloat($(this).val());

						if(val > max){
							$(this).after('<label class="warning"><spring:message code="payment_m_waring1"/></label>');
						}else if(val < 0){
							$(this).after('<label class="warning"><spring:message code="payment_m_waring2"/></label>');
						}

						$('input[name^="pcList"]:visible:eq(0)').valid();
					}						
				});

				$(document).on('keyup', 'input[name*=incurredQty]', function(){
					$(this).nextAll('.warning').remove();
					if($(this).valid()){
						var max = numeral().unformat($(this).data("max"));
						var val = parseFloat($(this).val());

						if(val > max){
							$(this).after('<label class="warning"><spring:message code="payment_m_waring3"/></label>');
						}else if(val < 0){
							$(this).after('<label class="warning"><spring:message code="payment_m_waring4"/></label>');
						}
						//重新验证第一个可见输入框
						$('input[name^="pcList"]:visible:eq(0)').valid();
					}
				});

				$(document).on('change', 'input[name*=incurredFcosts]', function(){
					if($(this).valid() && this.value){
						$(this).val(numeral($(this).val()).format('0.00'));
					}
					//计算支付单总金额	
					sumTotalCosts();				
				});

				$(document).on('change', 'input[name*=incurredQty]', function(){
					if($(this).valid() && this.value){
						$(this).val(numeral($(this).val()).format('0.00000'));
						var costs = parseFloat($(this).val())*$(this).data("ptdcommitmentfrate");
						$(this).closest('td').find(".pcList-cost").html(numeral(costs).format('000,000.00'));
					}else{
						$(this).closest('td').find(".pcList-cost").empty();
					}	
					sumTotalCosts();						
				});


				$('input[name^="pcList"]:visible:eq(0)').rules( 'add', {
					invoiceNotEmpty: true
				});
			 }

		 	function uploadFile(){
		 		var browser=navigator.appName 
				var b_version=navigator.appVersion 
				var version=b_version.split(';'); 
				var trim_Version=$.trim(version[1]);
				var iframe = false; 
				if(browser=='Microsoft Internet Explorer' && trim_Version=='MSIE 9.0') 
				{ 
					iframe = true;
				} 

				$('#fileupload').fileupload({
					url:'<c:url value="/payment2/file/upload"/>',
			        dataType: 'json',
			        iframe:iframe,
			        formData: {
			        	filePath:'${filePath}',
			        	fileKey:'${uploadFileKey}',
			        	fileProgCode:'${fileProgCode}',
			        	businessId:'${businessId}'
			        },
			 
			        done: function (e, data) {
			        	loadUploadFileTable(data.result);
			        },
			 
			        progressall: function (e, data) {
			            var progress = parseInt(data.loaded / data.total * 100, 10);
			            $('#progress .bar').css(
			                'width',
			                progress + '%'
			            );
			        },

			        minFileSize:1,

			        singleFileUploads:false,

			        acceptFileTypes:/(\.|\/)(gif|jp(e)?g|png|doc(x)?|xls(x)?|ppt(x)?|pdf|txt)$/i
			        
			    });


				$('#fileupload').bind('fileuploadprocessfail', function(e, data) {
					alert('<spring:message code="payment_m_error5"/>');
				});

	        	$(document).on('click', '.delete-href', function (){
	        		var url = $(this).data('url');
	        		var filePath = $(this).data('filepath');
	        		var fileKey = $(this).data('filekey');
	        		var seqNo = $(this).data('seq');
	        		var fileProgCode = $(this).data('progcode');
	        		swal({   
	        			title: '<spring:message code="payment_m_conform1"/>',   
	        			text: '<spring:message code="payment_m_error6"/>',   
	        			type: 'warning',   
	        			showCancelButton: true, 
	        			cancelButtonText: '<spring:message code="payment_l_cancel"/>',     
	           			confirmButtonColor: '#428bca',   
	           			confirmButtonText: '<spring:message code="payment_l_confirm"/>',
	           			closeOnConfirm: true}, 
	           			function(){
							$.post(url, {
								filePath: filePath,
								fileKey: fileKey,
								seqNo: seqNo,
								fileProgCode: fileProgCode,
							}, function(data){
								loadUploadFileTable(data);
							});
	           			}
	           		);
				});

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
		 	}

		 	function loadUploadFileTable(data){
				if(data && data.length > 0){
					$('#uploaded-files').show();
		           	$('#uploaded-files tr:has(td)').remove();
		           	$('#associateFile').empty();

		            $.each(data, function (index, file) {
		            	var uploadDate = moment(file.uploadDate).format('YYYY-MM-DD');

		                $('#uploaded-files').append(
	                    $('<tr/>')
	                    .append($('<td style="white-space:normal;" class="filekey" data-key="'+file.fileProgCode+'||'+file.fileKey+'||'+file.seqNo+'"/>').html('<a class="preview-href" data-toggle="modal" data-target="#previewModal" data-path="'+file.remarkText+'">'+file.fileShowName+'</a>'))
	                    .append($('<td/>').text(file.fileShowSize))
	                    .append($('<td/>').text(file.commonName))
	                    .append($('<td/>').text(uploadDate))
	                    .append($('<td/>').html('<a class="download-href" href="javascript:document.forms.download_'+index+'.submit();"><spring:message code="payment_l_download"/></a><a class="delete-href" data-filepath="'+file.remarkText+'"  data-filekey="'+file.fileKey+'" data-seq="'+file.seqNo+'" data-progcode="'+file.fileProgCode+'" data-url="<c:url value="/payment2/file/delete"/>"><spring:message code="payment_l_delete"/></a>'))
	                    );

	                    $('#associateFile').append($('<form name="download_'+index+'" method="POST" action="<c:url value="/payment2/file/download"/>"><input type=hidden name="fileShowName" value="'+file.fileShowName+'"><input type=hidden name="url" value="'+file.remarkText+'"></form>'));
		            }); 
				}else{
					$('#uploaded-files').hide();
				}
				
	            var fileIds = [];

	            $('#uploaded-files .filekey').each(function (x){
	            	fileIds.push($(this).data('key'));
	            });

	            $('#paymentForm')[0].fileIds.value = fileIds.toString();
	            $('#progress .bar').css('width','0%');
        	}

			//计算所填写的支付单总金额
			function sumTotalCosts(){
				var result = 0;
				$('.pcList-cost:not(empty)').each(function (){
					result += numeral().unformat($(this).html())
				});

				$('input[name$="incurredFcosts"]:visible:filled').each(function (){
					result += numeral().unformat($(this).val());
				});

				$('.invoice-costs').html(numeral(result).format('000,000.00'));
			}

		 });
		</script>
	</body>
</html>