<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title><sitemesh:write property='title'/></title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap/dist/css/bootstrap.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-table/dist/bootstrap-table.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/lib/bootstrap-select/dist/css/bootstrap-select.min.css"/>">
    <sitemesh:write property='head'/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/global.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/payment.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/payment2/styles/toolbar.css"/>">
    <script type="text/javascript" src="<c:url value="/lib/jquery/jquery-1.11.3.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/lib/jquery-i18n-properties/jquery.i18n.properties.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/lib/jquery-validation/dist/jquery.validate.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/lib/bootstrap/dist/js/bootstrap.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/lib/headroom.js/dist/headroom.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/lib/bootstrap-table/dist/bootstrap-table.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/lib/bootstrap-select/dist/js/bootstrap-select.min.js"/>"></script>
    <script>
      //国际化化bootStrapTable
      $.fn.bootstrapTable.locales['<spring:message code="qdp_l_lang"/>'] = {
           formatLoadingMessage: function () {
               return '<spring:message code="payment_m_formatLoading"/>';
           },
           formatRecordsPerPage: function (pageNumber) {
               return '';
           },
           formatShowingRows: function (pageFrom, pageTo, totalRows) {
               return '';
           },
           formatNoMatches: function () {
               return '<spring:message code="payment_m_formatNoMatches"/>';
           },
       };

      $.extend($.fn.bootstrapTable.defaults, $.fn.bootstrapTable.locales['<spring:message code="qdp_l_lang"/>']);

      String.prototype.format= function(){
         var args = arguments;
         return this.replace(/\{(\d+)\}/g,function(s,i){
           return args[i];
         });
      }

      window.onload = function (){
          window.language = '<spring:message code="qdp_l_lang"/>';

          $.i18n.properties({
              name : 'payment', //资源文件名称
              path : '/qdp/i18n/', //资源文件路径
              mode : 'map',//用Map的方式使用资源文件中的值
              language: '<spring:message code="qdp_l_lang"/>', //此处利用该标签指定正确的語言
              cache: true, 
              callback : function() {
                $.validator.addMethod("invoiceNotEmpty", function(value, element) {
                    return $('input[name^="pcList"]:visible:filled').length;
                }, $.i18n.prop('payment_m_error1'));

                $.validator.addMethod("incurredQtyNotZero", function(value, element) {
                  if($(element).val() && numeral().unformat($(element).val()) == 0){
                    return false;
                  }else{
                    return true;
                  }
                }, $.i18n.prop('payment_m_error2'));

                $.validator.addMethod("incurredFcostsIsNumber", $.validator.methods.number, $.i18n.prop('payment_m_error3'));

                $.validator.addClassRules("incurredFcosts", {
                  incurredFcostsIsNumber: true
                });

                $.validator.addMethod("incurredQtyIsNumber", $.validator.methods.number,$.i18n.prop('payment_m_error4'));

                $.validator.addClassRules("incurredQty", {
                  incurredQtyIsNumber: true,
                  incurredQtyNotZero: true
                });

                $.validator.addMethod("incurredRemarkLength", $.validator.methods.maxlength,'');

                $.validator.addClassRules("incurredRemark", {
                  incurredRemarkLength: 100
                });

              }
          });

         $.ajax({
             cache: true,
             type: 'GET',
             url: '<c:url value="/payment2/todoTaskManage/countTask"/>'+'?data='+new Date().getTime(),
             async: true,
             success: function(data) {
                if(data != 0) {
                  $("#todoTaskCountNum").show().html(data);
                }else{
                  $("#todoTaskCountNum").hide();
                }
               }
           });

        //grab an element
        var myElement = document.querySelector("#header");
        // construct an instance of Headroom, passing the element
        var headroom  = new Headroom(myElement);
        // initialise
        headroom.init();

        $('a[data-lang='+window.language+']').removeClass('active');
      }

      $(document).on('mouseover.flow.diagram', '[data-flowdiagram]', function (e) {
        var url = $(this).data('url');
        $($(this).data('flowdiagram')).attr('src', url);
        //   .parent()
        //   .trigger('zoom.destroy')
        //   .zoom({on:'click', callback:function(){
        //     $(this).css('background-color', '#FFF');
        // }});
      });

      function closeWindows() {
        var userAgent = navigator.userAgent;
        if (userAgent.indexOf("Firefox") != -1 || userAgent.indexOf("Chrome") !=-1) {
           window.location.href="about:blank";
        }else{
           window.opener = null;
           window.open("", "_self");
           window.close();
        }
      }

      $(document).on('click','.payment-language>a.active', function(e) {
          $.post('<c:url value="/payment2/changeLanguage"/>',{langType:$(this).data("lang")}, function(data) {
                window.location.reload();
          });
          return false;
      });

    </script>
  </head>
  <body class="Site">
    <%@include file="toolbar.jsp"%>

    <%@include file="nav.jsp"%>

    <div class="payment-main Site-content">
      <div class="container">
        <sitemesh:write property='body'/>
      </div>
    </div>
  
    <%@include file="footer.jsp"%>
  </body>
</html>