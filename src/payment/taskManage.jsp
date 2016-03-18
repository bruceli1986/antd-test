<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<title>${currentPage.title}</title>
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-table/dist/bootstrap-table.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/lib/select2/dist/css/select2.min.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/icon.css"/>">
		<link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/m_nav.css"/>">
		<style>
		#reportCodeModal td:hover{
			cursor: pointer;
		}

		</style>
	</head>
	<body>
	    <div class="payment-nav">
	    	<div class="container">
	    		<ul class="nav nav-tabs nav-justified">
		            <c:forEach var="program" items="${systemConfigs.programs}">
		                <c:if test="${program eq systemConfigs.currentProgram}">
		                		<c:forEach var="page" items="${program.pages}">
		                  			<c:if test="${page eq systemConfigs.currentPage}">
			                          <li role="presentation" class="active"><a href="#"><spring:message code="${page.title}"/><!-- &nbsp;<span class="glyphicon glyphicon-refresh"></span> --></a></li>
			                        </c:if>
			                        <c:if test="${page ne systemConfigs.currentPage}">
			                          <li role="presentation"><a href="<c:url value="${page.url}"/>"><spring:message code="${page.title}"/></a></li>
			                        </c:if>
		                		</c:forEach>
		                </c:if>
		            </c:forEach>
		      	</ul>
	    	</div>
	    </div>
		
		<div id="table-nav" <c:if test="${configs.tableNav == false}">class="hide"</c:if>></div>

		<table id="taskTable" data-toggle="table" 
				data-classes="table table-striped table-hover table-no-bordered"
				data-query-params="generateQueryParams"
				data-pagination="true"
   				data-side-pagination="server"
   				data-smart-display="true"
   				<c:if test="${configs.tableNav != false}">
   					data-search="${configs.tableConfig.search}"
   				</c:if>
   				data-sort-name="${configs.tableConfig.sortName}"
   				data-sort-order="${configs.tableConfig.sortOrder}">
				<thead>
				<tr>
					<c:forEach var="field" items="${configs.tableConfig.fields.field}" varStatus="status">
						<th <c:if test="${field.formatter != null}" >data-formatter="${field.formatter}"</c:if> <c:if test="${field.value != null}">data-field="${field.value}"</c:if> <c:if test="${field.sortable != null}">data-sortable="${field.sortable}"</c:if>><spring:message code="${field.name}"/></th>
					</c:forEach>												
				</tr>
			</thead>
		</table>

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
		<div class="payment-mask hide"></div>
		
		<script type="text/javascript" src="<c:url value="/lib/ejs/ejs.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/lib/moment/moment.js"/>"></script>
<!-- 		<script type="text/javascript" src="<c:url value="/lib/jquery-zoom/jquery.zoom.min.js"/>"></script> -->
		<script type="text/javascript" src="<c:url value="/lib/select2/dist/js/select2.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/payment2/scripts/m-nav.js"/>"></script>
		<script type="text/javascript">
			$.extend($.fn.bootstrapTable.defaults, {
				formatSearch:function () {
               		return '<spring:message code="payment_l_subject"/>';
            	}
        	});

 			function generateQueryParams(params){
				params = $.extend(params, $('#table-nav').mnav('getQueryParams'), {data: new Date().getTime()});	
				return params;
			}

			function generateSubjectUrl(value, row, index) {
			   return '<a href="/qdp'+row.url+'">'+row.subject+'</a>';
			}

			function generateActions(value, row, index) {
				var actions = '';
				if(value){
					value.forEach(function (x, i, a){
						if(i > 0 ){
							actions += '&nbsp;'
						}
						if(x.title == 'flowDiagram'){
							actions += '<a data-flowdiagram="#diagramPic" data-url="/qdp/payment2/showFlowDiagram?processInstanceId='+row.processInstanceId+'" data-toggle="modal" data-target="#myModal"><spring:message code="payment_l_flowDiagram"/></a>';
						}else if(x.title == 'printPdf') {
							var index = generateReportModal(x.url);
							actions += '<a href="'+x.url+'" data-businesskey="'+row.businessKey+'"  data-processinstanceid="'+row.processInstanceId+'" data-toggle="modal" data-target="#reportCodeModal'+index+'"><spring:message code="payment_l_print"/></a>';
						}
					});
				}
				return actions;
			}

			function generateReportModal(url){
				if(!window.reportUrls){
					window.reportUrls = [];
				}
				var index = window.reportUrls.indexOf(url);
				if(index == -1){
					window.reportUrls.push(url);
					index = window.reportUrls.indexOf(url);
					$('body').append('<div class="modal fade" id="reportCodeModal'+index+'" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"></div></div></div>');

					$('#reportCodeModal'+index).on('shown.bs.modal', function (e){
						$('#reportCodeModal'+index+' input[name=businesskey]').val($(e.relatedTarget).data('businesskey'));
						
						$('#reportCodeModal'+index+' input[name=processInstanceId]').val($(e.relatedTarget).data('processinstanceid'));

						$('#reportCodeModal'+index+' input[name=businesskey]').change();
					});
				}
				return index;
			}

			function formatTime(value) {
				value = moment(value);
				return 	value.format('YYYY-MM-DD HH:mm:ss');
			}
					
			$(function(){	
				if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){
				    $('#taskTable').bootstrapTable('refreshOptions',{
				   		cardView:true
				    });

				    $('#taskTable').on('page-change.bs.table',function(e){
						window.scrollTo(0,0);
					});
				}

			 	$('#table-nav').mnav({
			 		<c:if test="${systemConfigs.currentPage.id eq('historyTask')}">
		          		url:"<c:url value="/payment2/commonQuery/bpmHis"/>",
		          	</c:if>
		          	<c:if test="${systemConfigs.currentPage.id ne('historyTask')}">
		          		url:"<c:url value="/payment2/commonQuery/bpm"/>",
		          	</c:if>
		          	status:'expand',
		          	onPropChange:function(){
		          		$("#taskTable").bootstrapTable('refresh', {url:"<c:url value="${configs.tableConfig.url}"/>"});
		          	}
		        });

		        $('#taskTable').on('load-success.bs.table',function(e, data){
					$('#table-nav').mnav('setSpuTotalHit', data.total);

				});

				$('.glyphicon-refresh').on('click', function(){
					$("#taskTable").bootstrapTable('refresh');
				});
			});
		</script>
	</body>
</html>