<%@ page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.ctg.qdp.security.springsecurity.QdpAccessDecisionManagerImpl"%>
<%@ page import="com.ctg.qdp.security.service.RoleResourceServiceI"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ctg.payment2.model.SystemConfigs"%>
<%
	WebApplicationContext web =(WebApplicationContext)request.getSession().getServletContext().getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
	RoleResourceServiceI roleResourceService=(RoleResourceServiceI)web.getBean("roleResourceService");
	QdpAccessDecisionManagerImpl qdpDescision = new QdpAccessDecisionManagerImpl(); 
	SystemConfigs configs = (SystemConfigs) session.getAttribute("systemConfigs");
	List<String> disabledElements = roleResourceService.queryDisablePageElements(configs.getCurrentPage().getId(), session);
	session.setAttribute("disabledElements" , disabledElements);
	session.setAttribute("qdpDescision" , qdpDescision);
%>