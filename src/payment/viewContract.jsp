<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<title><spring:message code="payment_l_viewContract"/></title>
		<link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/icon.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/m_nav.css"/>">
		<style type="text/css" media="screen">	
		/*申请支付按钮的样式*/
		.payment-pay-bt{
			color:#F40;
		}
		.payment-pay-bt:hover{
			color:#F40;
			text-decoration: none;
		}
		.search input.form-control{
			width:250px;
		}
		</style>
	</head>
	<body>
		<div id="paymentList" class="active">	
			<form class="payment-pay-form"></form>	
				
			<div id="table-nav"></div>

			<table id="contractListTable"
				data-toggle="table" 
				data-classes="table table-striped table-hover table-no-bordered"
				data-query-params="generateQueryParams"
				data-pagination="true"
   				data-side-pagination="server"
   				data-search="true">
					<thead>
						<tr>
							<th data-formatter="generateViewContractUrl" data-width="15%"><spring:message code="payment_l_contractNo"/></th>
							<th data-field="description" data-width="50%"><spring:message code="payment_l_poName"/></th>
							<th data-field="departmentDesc" data-width="15%"><spring:message code="payment_l_ctrDepartment"/></th>
							<th data-field="totalAmount"
								data-formatter="formatMoney"
								data-halign="right"
								data-align="right"
								data-width="10%"><spring:message code="payment_l_contractTotalAmount"/></th>
							<th data-field="completionRatio"
								data-formatter="convertNumToPercent"
								data-halign="right"
								data-align="right"
								data-width="10%"><spring:message code="payment_l_completionRatio"/></th>
						</tr>  
					</thead>			
				</table>
		</div>

		<script type="text/javascript" src="<c:url value="/lib/ejs/ejs.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/moment/moment.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/numeraljs/numeral.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/m-nav.js"/>"></script>
		<script type="text/javascript">
	      	$.extend($.fn.bootstrapTable.defaults, {
	          	formatSearch: function () {
	                return '<spring:message code="payment_l_contractNo"/>/<spring:message code="payment_l_poName"/>';
	          	},
	      	});
	      	
			function generateViewContractUrl(value, row, index){
				return '<a target="_blank" href="<c:url value="/payment2/contractDetails?poNo='+row.poNo+'&id='+row.systemId+'&code='+row.systemCode+'"/>">'+row.poNo+'</a>';
			}

			function generateQueryParams(params){
				params = $.extend(params, $('#table-nav').mnav('getQueryParams'),{data: new Date().getTime()});	
				return params;
			}

			function formatMoney(value) {
				return numeral(value).format('000,000.00')
			}

			function convertNumToPercent(value) {
				value *= 100;
			  	value = value.toFixed(2);
			 	return value+"%";
			}

			function convertToDate(value) {
				if(value){
					return  moment(value).format('YYYY-MM-DD');
				}else{
					return '—'
				}			
			}

			$(function(){	 
				if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){
				    $('#contractListTable').bootstrapTable('refreshOptions',{
				   		cardView:true
				    });

				   	$('#contractListTable').on('page-change.bs.table',function(e){
						window.scrollTo(0,0);
					});
				}

				//提交支付单
				$('#contractListTable').on('click', '.btn', function(e){
					var url =  encodeURI($(this).data('url'));
					var $form = $('.payment-pay-form');
	        		$form[0].action = url;
	        		$form[0].method = "POST";
	        		$form.submit();
				});

				$('#contractListTable').on('load-success.bs.table',function(e, data){
					$('#table-nav').mnav('setSpuTotalHit', data.total);
				});

				$('#table-nav').mnav({
		          url:"<c:url value="/payment2/commonQuery/purchaseOrder"/>",
		          status:'expand',
		          onPropChange:function(){
		          	$("#contractListTable").bootstrapTable('refresh', {url:"<c:url value="/payment2/viewContract/query"/>"});
		          }
		        });
			});
		</script>
	</body>
</html>