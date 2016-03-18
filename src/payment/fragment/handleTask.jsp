<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="./permission.jsp" %> 
<div class="form-group <c:if test="${param.outGoing == false}">hide</c:if>" >
	<label for="next" class="col-md-2 control-label"><spring:message code="payment_l_nextLink"/></label>
	<div class="col-md-6">
		<c:forEach var="outGoing" items="${outGoingList}" varStatus="status">
			<label class="radio-inline">
				<input type="radio" name="outGoingId" value="${outGoing.id}" <c:if test="${status.count==1}">checked</c:if>>${outGoing.name}
			</label>
		</c:forEach>	
	</div>
</div>
<div class="form-group">
	<label class="col-md-2 control-label"><spring:message code="payment_l_nextAssignee"/></label>
	<div class="col-md-6" id="nextStepUserContainer" >
		<select id="nextStepUser" name="userId"  data-width="150px" data-none-selected-text="无" class="form-control selectpicker"<c:if test="${userList == null || fn:length(userList) == 0}">disabled="disabled"</c:if> >
			<c:forEach var="user" items="${userList}" >	
				<option value="${user.userId}">${user.userName}</option>
			</c:forEach>
		</select>
	</div>
</div>
<div class="form-group">
	<label for="opinion" class="col-md-2 control-label"><spring:message code="payment_l_comment"/></label>
	<div class="col-md-6">
		<textarea style="width:100%;"  rows=1 name="comment" class="form-control" data-toggle="opinions" data-process="${param.process}" data-lang="<spring:message code='qdp_l_lang'/>"></textarea> 
	</div>
</div>
<c:if test="${param.participantUsers}">
	<div class="form-group">
		<label class="col-md-2 control-label"><spring:message code="payment_l_peopleConcerned"/></label>
		<div class="col-md-6">
			<select id="participantUsers" name="participantUsers" class="form-control" multiple="multiple" style="width: 100%">
				<c:forEach var="user" items="${participantUserList}" >	
					<option value="${user.userId}" selected="selected">${user.userName}</option>
				</c:forEach>
			</select>
		</div>
	</div>
</c:if>
<br>
<div class="row">
	<div class="col-md-3 col-md-offset-3">
		<c:if test="${param.process eq('apply')}">
			<button id="paymentAddBt" type="button" class="btn btn-default payment-button" <c:if test='${fn:indexOf(disabledElements, "paymentAddBt") >= 0}'> disabled="disabled"</c:if> ><spring:message code="payment_l_submitApply"/></button>
		</c:if>
		<c:if test="${param.process ne('apply')}">
			<button id="paymentAddBt" type="button" class="btn btn-default payment-button"><spring:message code="payment_l_handleApply"/></button>
		</c:if>
	</div>
	<div class="col-md-3">
		<button type="button" class="btn btn-default payment-button" data-flowdiagram="#diagramPic" data-url="<c:url value="/payment2/showFlowDiagram?appName=${appName}&processInstanceId=${processInstanceId}&businessId=${businessId}"/>" data-toggle="modal" data-target="#myModal"><spring:message code="payment_l_viewFlowDiagram"/></button>
	</div>
</div>
<div class="modal fade flow-modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
<script>
	$(function(){
		$("#paymentAddBt").on("click", function(event){
			event.preventDefault();	
			if($('#${param.formId}').valid()){
				var comment = $('[name=comment]').val()?$('[name=comment]').val():'<spring:message code="payment_l_empty"/>';
				var title = $('#nextStepUser option:selected').html()?'<spring:message code="payment_m_info6"/>'.format($('#nextStepUser option:selected').html()):'<spring:message code="payment_m_info5"/>';

				swal({
			      title: title, 
			      text: '<spring:message code="payment_m_info7"/>'.format(comment),
			      type: 'warning',
			      showCancelButton: true,
			      confirmButtonText: '<spring:message code="payment_l_confirm"/>',
			      cancelButtonText: '<spring:message code="payment_l_cancel"/>',
			    }, function() {
			      $('#${param.formId}').submit();
			    });
			}
		});

		$('input[name="outGoingId"]').on('click', function (event){
			var result = $('#nextStepUserContainer').data(this.value);
			$('#nextStepUser').selectpicker('destroy');
			$('#nextStepUserContainer').append('<select id="nextStepUser" name="userId"></select>')
			if(result.users.length != 0){
				$('#nextStepUser').removeAttr('disabled');
				result.users.forEach(function (x, i, a){
					$('#nextStepUser').append('<option value='+x.userId+'>'+x.userName+'</option>');
				});
				if(result.defaultUser != null && result.defaultUser.length != 0){
					result.defaultUser.forEach(function(x, i, a){
						$('#nextStepUser').val(x.userId);
					});
				}	
			}else{
				$('#nextStepUser').attr('disabled', true);
			}	
			$('#nextStepUser').selectpicker({
				noneSelectedText:'无'
			});	
		});

		$('input[name="outGoingId"]').each(function (index){
			var value = this.value;
			$.ajax({ 
				url: '<c:url value="/payment2/handleTask/queryOutUsers?taskId=${taskId}&processDefinitionId=${processDefinitionId}&processInstanceId=${processInstanceId}&activityId=${activityId}&businessId=${businessId}"/>', 
				dataType:'json',
				data:{outGoingId: value},
				success: function(result) { 
					$('#nextStepUserContainer').data(value, result);
					if(index == 0 ){
						$('input[name="outGoingId"]:eq(0)').trigger('click');
					}
				}
			});
		});

		<c:if test="${param.participantUsers}">
			$("#participantUsers").select2({
			  ajax: {
			    url: "/qdp/qdp/userGroup/query.do",
			    dataType: 'json',
			    contentType: 'application/x-www-form-urlencoded',
			    delay: 250,
			    type:'POST',
			    data: function (params) {
                     return $.param({ q: params.term});
                },
			    processResults: function (data, page) {
			      var result = []; 
			      data.forEach(function(x, i, a){
			      	var user = {};
			      	user.text = x.USER_NAME;
			      	user.id = x.USER_ID;
			      	result.push(user);
			      });
			      return {results:result};
			    },
			    cache: true,
			  },
			  escapeMarkup: function (markup) { return markup; },
			  minimumInputLength: 2,
			  placeholder: '<spring:message code="payment_l_pleaseEnterName"/>',
			  language: {
				  inputTooShort: function (e) {
				    return '<spring:message code="payment_m_info13"/>';
				  },
				  noResults:function(){
				  	return '<spring:message code="payment_m_info14"/>';
				  }
				}
			});

		</c:if>
	});
</script>