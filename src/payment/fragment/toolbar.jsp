<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="./permission.jsp" %> 
<div class="payment-toolbar">
	<div class="payment-toolbar-space" style="height: 25%;"></div>
	<ul class="payment-toolbar-list">
		<li class="payment-toolbar-item-split"></li>
		<%	
			if(qdpDescision.hasAccessPermission("/payment2/todoTaskManage", session)){
		%>
		<li class="payment-toolbar-item">
			<div class="payment-toolbar-item-icon"><a href="<c:url value="/payment2/todoTaskManage"/>" class="glyphicon glyphicon-tasks"></a><div id="todoTaskCountNum" class="payment-toolbar-badge" style="display:none;"></div></div>
			<div class="payment-toolbar-item-tip"><span><spring:message code="payment_l_myTodo"/></span><div class="payment-toolbar-item-arrow">◆</div></div> 
		</li>
		<% } %>
		<li class="payment-toolbar-item-split"></li>
		<% 
			if(qdpDescision.hasAccessPermission("/payment2/viewContract", session)){
		%>
		<li class="payment-toolbar-item">
			<div class="payment-toolbar-item-icon"><a href="<c:url value="/payment2/viewContract"/>" class="glyphicon glyphicon-search"></a></div>
			<div class="payment-toolbar-item-tip"><span><spring:message code="payment_l_viewContract"/></span><div class="payment-toolbar-item-arrow">◆</div></div>
		</li>
		<% } %>
<!-- 	<li class="payment-toolbar-item">
			<div class="payment-toolbar-item-icon"><a href="<c:url value="/payment2/paymentList"/>" class="glyphicon glyphicon-search"></a></div>
			<div class="payment-toolbar-item-tip"><span><spring:message code="payment_l_myPayment"/></span><div class="payment-toolbar-item-arrow">◆</div></div>
		</li> -->
	</ul>
</div> 


