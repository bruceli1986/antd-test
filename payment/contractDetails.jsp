<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<title><spring:message code="payment_l_contractDetails"/></title>
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-sweetalert-master/lib/sweet-alert.css"/>">
		<style type="text/css" media="screen">
			.shortcut-label{
				padding-left:15px;
				padding-top: 5px;
				float: left;
			}
			.shortcut-nav{
				border: 1px solid #428bca;
    			margin-left: 0px;
    			padding: 5px;
			}
			@media screen and (max-width: 767px){
				#ctrPaidHistory{
					width:65%;
					margin-left:35%;
				}

				#ctrPaidHistory>table th:first-child, #ctrPaidHistory>table td:first-child{
			       width:35%;
			       overflow: auto;
			       left:5px;
			    }
			}
		</style>
	</head>
	<body>
		<div class="btn-toolbar shortcut-nav" role="toolbar" aria-label="">
	    	<span class="shortcut-label"><spring:message code="payment_l_relatedAction"/>:</span>
			<div class="btn-group" role="group" aria-label="...">
			  	<a class="btn btn-default btn-sm" href="<c:url value="/payment2/applyGuarantee?poNo=${purchaseOrder.poNo}&id=${system.id}&code=${system.code}"/>"><spring:message code="payment_l_zbjApply"/></a>
				<a id="applyPaymentBtn" class="btn btn-default btn-sm" href="<c:url value="/payment2/applyPayment?poNo=${purchaseOrder.poNo}&id=${system.id}&code=${system.code}"/>"><spring:message code="payment_l_paymentApply"/></a>
			</div>
		</div>	
		<div class="row">
			<div class="col-md-12" role="main">
				<h3 class="page-header" id="cp-basic">1.<spring:message code="payment_l_contractBasics"/></h3>
				<p>
				<form action="" class="form-horizontal">
					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_project"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${purchaseOrder.project}</p>
						</div>
						<label class="control-label col-md-2"><spring:message code="payment_l_projectDescription"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${purchaseOrder.projectDesc}</p>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_contractNo"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${purchaseOrder.poNo}</p>
						</div>
						<label class="control-label col-md-2"><spring:message code="payment_l_poName"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${purchaseOrder.description}</p>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_ctrDepartmentNo"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${empty purchaseOrder.department?'-':purchaseOrder.department}</p>
						</div>
						<label class="control-label col-md-2"><spring:message code="payment_l_ctrDepartmentDesc"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${empty purchaseOrder.departmentDesc?'-':purchaseOrder.departmentDesc}</p>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-md-2"><spring:message code="payment_l_vendorNo"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${empty purchaseOrder.company?'-':purchaseOrder.company}</p>
						</div>
						<label class="control-label col-md-2"><spring:message code="payment_l_vendorDesc"/></label>
						<div class="col-md-4">
							<p class="form-control-static">${empty purchaseOrder.comDesc?'-':purchaseOrder.comDesc}</p>
						</div>
					</div>				
				</form>
			</div>
			<div class="col-md-12">
				<h3 class="page-header" id="cp-detail">2.<spring:message code="payment_l_contractDetails"/></h3>
				<p>
					<div class="table-responsive-fixedcol table-responsive"> 
<!-- 						<table id="contractTable" data-toggle="table" data-classes="table table-striped table-no-bordered table-hover" <c:if test="${projectCost != null && fn:length(projectCost) >= 10}">data-height="500"</c:if>>  -->
					<table class="table table-striped table-no-bordered table-hover" style="max-height:500px;">
					    <thead>
							<tr>
								<th><spring:message code="payment_l_BOQ"/></th>
								<th><spring:message code="payment_l_paymentDescription"/></th>
								<th><spring:message code="payment_l_unitNoDesc"/></th>
								<th style="text-align:right;"><spring:message code="payment_l_contractQty"/></th>
								<th style="text-align:right;"><spring:message code="payment_l_contractFrate"/></th>
								<th style="text-align:right;"><spring:message code="payment_l_contractIncurredPrice"/></th>
								<th style="text-align:right;"><spring:message code="payment_l_incurredQty"/></th>
								<th style="text-align:right;"><spring:message code="payment_l_incurredCost"/></th>
							</tr>
						</thead>
						<tbody>
							<c:set value="0" var="totalCost"/>
							<c:set value="0" var="totalPaid"/>
							<c:forEach var="cost" items="${projectCost}">
								<tr>
								<td>${cost.poItem}</td>
								<td>${cost.description}</td>
								<td>${cost.unitOfMeasure}/${cost.unitDescription}</td>
								<td style="text-align:right;">${cost.ptdCommitmentQty}</td>
								<td style="text-align:right;"><fmt:formatNumber type="number" value="${cost.ptdCommitmentFrate}" minFractionDigits="2"></fmt:formatNumber></td>
								<td style="text-align:right;"><fmt:formatNumber type="number" value="${cost.ptdCommitmentFrate*cost.ptdCommitmentQty}" minFractionDigits="2"></fmt:formatNumber></td>
								<td style="text-align:right;">${cost.incurredQtyTotal}</td>
								<td style="text-align:right;"><fmt:formatNumber type="number" value="${cost.incurredFcostsTotal}" minFractionDigits="2"></fmt:formatNumber></td>
								</tr>
								<c:set value="${totalCost+cost.ptdCommitmentFrate*cost.ptdCommitmentQty}" var="totalCost"/>
								<c:set value="${totalPaid+cost.incurredFcostsTotal}" var="totalPaid"/>
							</c:forEach>
						</tbody>
					</table>
					</div>
					
					<div class="payment-table-footer">
						<div class="row">
							<div class="col-md-6">
								<label><spring:message code="payment_l_contactTotal"/></label><span><fmt:formatNumber type="number" value="${totalCost}" minFractionDigits="2"></fmt:formatNumber></span>
							</div>
							<div class="col-md-6">
								<label><spring:message code="payment_l_contactIncurredTotal"/></label><span><fmt:formatNumber type="number" value="${totalPaid}" minFractionDigits="2"></fmt:formatNumber></span>
							</div>
						</div>
					</div>
			</div>
			<c:if test="${fn:length(selectPaidHistory) ne 0}">
				<div class="col-md-12">
					<h3 class="page-header">3.<spring:message code="payment_l_ctrPaidHistory"/></h3>
					<p>
					<div id="ctrPaidHistory" class="table-responsive table-responsive-fixedcol">
						<table class="table table-striped table-hover">
							<tr>
								<th><spring:message code="payment_l_paymentNo"/></th>
								<th><spring:message code="payment_l_paidTime"/></th>
								<th><spring:message code="payment_l_applicant"/></th>
								<th style="text-align:right;"><spring:message code="payment_l_paidAmount"/></th>
								<th style="text-align:right;"><spring:message code="payment_l_contactIncurredTotal"/></th>
								<th style="text-align:right;"><spring:message code="payment_l_contactIncurredPrecent"/></th>
							</tr>
							<fmt:setLocale value="zh_cn"/>   
							<c:forEach var="invoice" items="${selectPaidHistory}">
								<tr>
									<td><a target="_blank" href="<c:url value="/payment2/paymentDetails?businessId=${invoice.businessId}"/>">${invoice.invoiceNo}</a></td>
									<td><fmt:formatDate value="${invoice.ownerApprovalDate}"></fmt:formatDate></td>
									<td>${invoice.owner}</td>
									<td style="text-align:right;"><fmt:formatNumber type="number" value="${invoice.sumIncurredCosts}" minFractionDigits="2" maxFractionDigits="2"></fmt:formatNumber></td>
									<td style="text-align:right;"><fmt:formatNumber type="number" value="${invoice.sumPoCosts}" minFractionDigits="2" maxFractionDigits="2"></fmt:formatNumber></td>
									<td style="text-align:right;"><spring:eval expression="invoice.sumPoCostsPercent"></spring:eval></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>	
			</c:if>
		</div>
		<script type="text/javascript" src="<c:url value="/lib/bootstrap-sweetalert-master/lib/sweet-alert.js"/>"></script>
		<script>
			$(function(){
				$(document).on('click', "#applyPaymentBtn", function(event){
					event.preventDefault();
					var forwardHref = event.target.href;
					$.ajax({
		                cache: true,
		                type: 'get',
		                url: '<c:url value="/payment/po/isBudgetYear?systemCode=${system.code}&poNo=${purchaseOrder.poNo}"/>',
		                async: true,
		                datatType:"json",
		                success: function(data) {
		                   if(data == false){
	                    		swal({   
	                    			title: '<spring:message code="payment_l_alert"/>',   
	                    			text: '当前合同预算代码不正确，请联系合同管理员',   
	                    			type: 'warning',   
	                    			showCancelButton: true,      
		                   			confirmButtonColor: '#428bca',   
		                   			confirmButtonText: '<spring:message code="payment_l_continue"/>',
		                   			cancelButtonText: '<spring:message code="payment_l_cancel"/>',
		                   			closeOnConfirm: true},
		                   			function(isConfirm){   
		                   				if (isConfirm) {     
											window.location.href = forwardHref;
		                   				}
		                   			});
		                   }else{
		                   		window.location.href = forwardHref;
		                   }
		                }
		            });
				});
			});
		</script>
	</body>
</html>