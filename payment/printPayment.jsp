<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<!DOCTYPE html>
<html>
	<head>
		<title><spring:message code="payment_l_printPayment"/></title>
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-sweetalert-master/lib/sweet-alert.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/opinions.css"/>">
	</head>
	<body>
		<div class="payment-path">
			<ol class="breadcrumb ">
				<li class="active"><spring:message code="payment_l_printPayment"/></li>
			</ol>
		</div>
		<div class="row">
			<div class="col-md-12" role="main">
				<%@include file="fragment/readonlyForm.jsp"%>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-md-4">
				<button id="paymentAddBt" type="button" class="btn btn-default payment-button"><spring:message code="payment_l_submitPayment"/></button>
			</div>
			<div class="col-md-4">
	 			<button type="button" class="btn btn-default payment-button" data-flowdiagram="#diagramPic" data-url="<c:url value="/payment2/showFlowDiagram?appName=${appName}&processInstanceId=${processInstanceId}&businessId=${businessId}"/>" data-toggle="modal" data-target="#myModal"><spring:message code="payment_l_viewFlowDiagram"/></button>
			</div>
			<div class="col-md-4">
				<button  type="button" class="btn btn-default payment-button" href="/qdp/page/payment/paymentReportForm.jsp" data-businesskey="${businessId}" data-processinstanceid="${processInstanceId}" data-toggle="modal" data-target="#reportCodeModal" ><spring:message code="payment_l_printPayment"/></button>
			</div>
		</div>

		<div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg">
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

		<div class="modal fade" id="reportCodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">  
		    <div class="modal-content"></div>
		  </div>
		</div>

		<div class="payment-mask hide"></div>
		
		<script type="text/javascript" src="<c:url value="/lib/jquery/jquery.media.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/handlebars/handlebars.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/typeahead.js/dist/typeahead.jquery.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/typeahead.js/dist/bloodhound.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/bootstrap-sweetalert-master/lib/sweet-alert.js"/>"></script>
<!-- 		<script type="text/javascript" src="<c:url value="/lib/jquery-zoom/jquery.zoom.min.js"/>"></script> -->
		<script type="text/javascript" src="<c:url value="/payment2/scripts/htmlUtil.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/opinions.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/locale/opinions-lang.js"/>"></script>
		<script>
			$(function(){
				$('#paymentAddBt').on('click', function(event){
					event.preventDefault();	
					swal({
				      title: '<spring:message code="payment_m_conform2"/>', 
				      type: 'warning',
				      showCancelButton: true,
				      confirmButtonText: '<spring:message code="payment_l_confirm"/>',
				      cancelButtonText: '<spring:message code="payment_l_cancel"/>',
				    }, function() {
					      $.ajax({
			                cache: true,
			                type: 'POST',
			                url: '<c:url value="/payment2/handleTask/complete"/>',
			                data: {taskId: '${taskId}', outGoingId: '${outGoingList[0].id}',processInstanceId:'${processInstanceId}'},
			                async: true,
			                success: function(data) {
			                	if(data.success == true){
		                    		swal({   
		                    			title: '<spring:message code="payment_m_info12"/>',   
		                    			text: '<spring:message code="payment_m_info4"/>',   
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
			                   		alert('failed!');
			                   }
			                }
				        });
				    });
					
				});

				$('#reportCodeModal').on('shown.bs.modal', function (e){
					$("#reportCodeModal input[name=businesskey]").val($(e.relatedTarget).data('businesskey'));

					$('#reportCodeModal input[name=processInstanceId]').val($(e.relatedTarget).data('processinstanceid'));

					$("#reportCodeModal input[name=businesskey]").change();
				});
			});
		</script>
	</body>
</html>