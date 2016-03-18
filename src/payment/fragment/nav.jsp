  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<header id="header" class="headroom navbar-fixed-top" data-headroom>
  <nav class="navbar navbar-default payment-outer-nav" > 
    <div class="container">
      <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#paymentNav">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <span class="navbar-brand ctg-logo"></span>
          <div class="payment-outer-nav-title visible-xs-block">
              <span class="page-title"><spring:message code="${systemConfigs.currentPage.title}"/></span>
          </div>
      </div>

      <div class="collapse navbar-collapse" id="paymentNav">
        <c:forEach var="program" items="${systemConfigs.programs}" varStatus="status">
              <ul class="nav navbar-nav ">
                  <c:if test="${empty program.parent}">
                    <c:if test="${program.droppable == false}">
                        <c:if test="${program eq systemConfigs.currentProgram || program.id eq systemConfigs.currentProgram.parent}">
                          <li role="presentation" class="active"><a href="<c:url value="${program.url}"/>"><spring:message code="${program.title}"/></a></li>
                        </c:if>
                        <c:if test="${program ne systemConfigs.currentProgram && program.id ne systemConfigs.currentProgram.parent}">
                          <li role="presentation" ><a href="<c:url value="${program.url}"/>"><spring:message code="${program.title}"/></a></li>
                        </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${program.droppable eq true}">
                        <c:if test="${program eq systemConfigs.currentProgram || program.id eq systemConfigs.currentProgram.parent}">
                         <li class="dropdown active">
                        </c:if>
                        <c:if test="${program ne systemConfigs.currentProgram && program.id ne systemConfigs.currentProgram.parent}">
                          <li class="dropdown">
                        </c:if>
                        <a id="dLabel${status.count}" class="dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <spring:message code="${program.title}"/>
                          <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="dLabel${status.count}" style="width:100%;">
                            <c:forEach var="page" items="${program.pages}">
                              <c:if test="${page eq systemConfigs.currentPage && !page.hide}">
                                <li role="presentation" class="active"><a href="#"><spring:message code="${page.title}"/></a></li>
                              </c:if>
                              <c:if test="${page ne systemConfigs.currentPage && !page.hide}">
                                <li role="presentation"><a href="<c:url value="${page.url}"/>"><spring:message code="${page.title}"/></a></li>
                              </c:if>
                            </c:forEach>
                        </ul>
                      </li> 
                  </c:if>
              </ul>
          </c:forEach>
          <p class="navbar-text navbar-right">
              <a href="javascript:closeWindows();" class="glyphicon glyphicon-off"></a>
          </p>
          <p class="navbar-text navbar-right">
              <label class="payment-navbar-welcome"><spring:message code="payment_l_welcomeInfo"/></label><a href="#" class="navbar-link">${loginUser.userName}</a>
          </p>
          <p class="navbar-text navbar-right payment-language">
              <a class="active" data-lang="zh">中文</a>&nbsp;<a class="active" data-lang="en">English</a>
          </p>
      </div>
          
    </div>
 </nav>
</header> 

<div class="payment-header">
  <div class="container">
    <div class="row">
        <div class="col-md-12">
          <c:if test="${!empty systemConfigs.currentProgram.parent}">
            <div class="h2"><spring:message code="${systemConfigs.currentProgram.title}"/></div>
          </c:if>
          <c:if test="${empty systemConfigs.currentProgram.parent}">
            <div class="h2"><spring:message code="${systemConfigs.currentPage.title}"/></div>
          </c:if>
        </div>
    </div>
  </div>
</div>