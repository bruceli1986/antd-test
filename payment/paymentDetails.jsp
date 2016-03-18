<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<!DOCTYPE html>
<html>
	<head>
		<title><spring:message code="payment_l_paymentDetails"/></title>
		<style>
		#reportCodeModal td:hover{
			cursor: pointer;
		}
		</style>
	</head>
	<body>
		<div class="payment-path">
			<ol class="breadcrumb">
			  <li class="active"><spring:message code="payment_l_paymentDetails"/></li>
			</ol>
		</div> 

		<div class="row">
			<div class="col-md-12" role="main"> 
				<%@include file="fragment/readonlyForm.jsp"%>
				<br>

				<c:if test="${isComplete}">
					<div class="row">
						<div class="col-md-3 col-md-offset-3">
							<button type="button" class="btn btn-default payment-button" data-flowdiagram="#diagramPic" data-url="<c:url value="/payment2/showFlowDiagram?businessId=${businessId}"/>" data-toggle="modal" data-target="#myModal"><spring:message code="payment_l_viewFlowDiagram"/></button>
						</div>
						<div class="col-md-3">
							<button type="button" class="btn btn-default payment-button" href="/qdp/page/payment/paymentReportForm.jsp" data-businesskey="${businessId}"  data-processinstanceid="${processInstanceId}" data-toggle="modal" data-target="#reportCodeModal"><spring:message code="payment_l_printPayment"/></button>
						</div>
					</div>
				</c:if>
				<c:if test="${isComplete eq false}">
					<div class="col-md-4 col-md-offset-4">
						<button type="button" class="btn btn-default payment-button" data-flowdiagram="#diagramPic" data-url="<c:url value="/payment2/showFlowDiagram?businessId=${businessId}"/>" data-toggle="modal" data-target="#myModal"><spring:message code="payment_l_viewFlowDiagram"/></button>
					</div>
				</c:if>
			</div>
		</div>

		<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog  modal-lg" >
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel"><spring:message code="payment_l_flowDiagram"/></h4>
		      </div>
		      <div class="modal-body">
		       	<img id="diagramPic" class="img-responsive">
		      </div>
		    </div>
		  </div>
		</div>

		<c:if test="${isComplete}">
			<div class="modal fade" id="reportCodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content"></div>
			  </div>
			</div>
			<div class="payment-mask hide"></div>
		</c:if>
		
		<script type="text/javascript" src="<c:url value="/lib/jquery/jquery.media.js"/>"></script>
<!-- 		<script type="text/javascript" src="<c:url value="/lib/jquery-zoom/jquery.zoom.min.js"/>"></script> -->
		<script type="text/javascript" src="<c:url value="/payment2/scripts/htmlUtil.js"/>"></script>
		<script type="text/javascript">
			$(function(){	
				var isComplete = ${isComplete};

				if(isComplete){
					$('#reportCodeModal').on('shown.bs.modal', function (e){
						$("#reportCodeModal input[name=businesskey]").val($(e.relatedTarget).data('businesskey'));
						$('#reportCodeModal input[name=processInstanceId]').val($(e.relatedTarget).data('processinstanceid'));

						$("#reportCodeModal input[name=businesskey]").change();
					});
				}
			});
		</script>
	</body>
</html>