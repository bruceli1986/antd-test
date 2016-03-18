<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<!DOCTYPE html>
<html>
	<head>
		<title><spring:message code="payment_l_examineGuarantee"/></title>
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-sweetalert-master/lib/sweet-alert.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/select2/dist/css/select2.min.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/opinions.css"/>">
	</head>
	<body>
		<div class="payment-path">
			<ol class="breadcrumb ">
				<li class="active"><spring:message code="${processName}"/></li>
			</ol>
		</div>

		<div class="row">
			<div class="col-md-12" role="main">
				<%@include file="fragment/guaranteeReadonlyForm.jsp"%>
				<br>
				<div class="panel panel-default">
					<div class="panel-body">
						<form id="examineForm" class="form-horizontal" action="<c:url value="/payment2/handleTask/complete"/>" method="post">
							<input type="hidden" name="token" value="${token}">
							<input type="hidden" value="${taskId}" name="taskId">
							<input type="hidden" value="${processDefinitionId}" name="processDefinitionId">
							<input type="hidden" value="${processInstanceId}" name="processInstanceId">
							<jsp:include page="fragment/handleTask.jsp" flush="true">
								<jsp:param name="process" value="examine"/> 
								<jsp:param name="formId" value="examineForm"/> 
								<jsp:param name="outGoing" value="true"/> 
								<jsp:param name="participantUsers" value="true"/> 
							</jsp:include>
						</form>	
					</div>
				</div>
			</div>
		</div>

		<div class="payment-mask hide"></div>
		
		<script type="text/javascript" src="<c:url value="/lib/jquery/jquery.media.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/handlebars/handlebars.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/typeahead.js/dist/typeahead.jquery.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/typeahead.js/dist/bloodhound.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/bootstrap-sweetalert-master/lib/sweet-alert.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/select2/dist/js/select2.full.min.js"/>"></script>
<!-- 		<script type="text/javascript" src="<c:url value="/lib/jquery-zoom/jquery.zoom.min.js"/>"></script> -->
		<script type="text/javascript" src="<c:url value="/payment2/scripts/htmlUtil.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/opinions.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/locale/opinions-lang.js"/>"></script>
		<script>
			$('#examineForm').validate({
				submitHandler: function (form){
					$.ajax({
		                cache: true,
		                type: form.method,
		                url: form.action,
		                data: $(form).serialize(),
		                async: true,
		                success: function(data) {
		                	$('.payment-mask').addClass('hide');
		                   if(data.success == true){
	                    		swal({   
	                    			title: '<spring:message code="payment_m_info10"/>',   
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
						$('.payment-mask').removeClass('hide');
				}
			});

		</script>
	</body>
</html>