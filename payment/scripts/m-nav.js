//定义流程的意见控件
//依赖于jquery， typeahead
(function($) {

	function  load($mNav , data){
		var  template = '<div class="crumb g-clearfix">'+
			'<% if(common.length != 0){%>'+
				'<a class="J_ToggleNav icon-tag toggle-btn" href="#">'+
					'<span class="expand">'+
						'<span>'+$.i18n.prop('payment_l_showConditions')+'</span><span class="glyphicon glyphicon-menu-down"></span>'+
					'</span>'+
					'<span class="collapse">'+
						'<span>'+$.i18n.prop('payment_l_hideConditions')+'</span><span class="glyphicon glyphicon-menu-up"></span>'+
					'</span>'+
				'</a>'+
			'<% } %>'+	
			'<span class="cat-text"><%= catpath.text %></span>'+
			'<span class="glyphicon glyphicon-menu-right"></span>'+
			'<% for(var i=0; i<propSelected.length; i++) {%>'+
			   	'<% if(propSelected[i].required) {%>'+
				    '<a class="pro icon-tag J_Ajax pro-required" title="<%= propSelected[i].text %>：<%= propSelected[i].sub.map(function(x){return x.text}).join(",") %>" data-query="<%= propSelected[i].field%>:<%= propSelected[i].sub.map(function(x){return x.value}).join(",") %>">'+
				    	'<%= propSelected[i].text %>：<span><%= propSelected[i].sub.map(function(x){return x.text}).join(",") %></span>'+
				   		'<span class="glyphicon glyphicon-menu-down"></span>'+
				   	'</a>'+
				   	'<div class="pro-required-submenu">'+
				   		'<% for(var j=0; j<common.length; j++) {%>'+
					 		'<% if(common[j].field == propSelected[i].field) {%>'+
					 			'<% for(var k=0; k<common[j].sub.length; k++) {%>'+
			   						'<a class="item icon-tag J_Ajax J_baikeiTrigger" href="#" data-query="<%=common[j].field %>:<%= common[j].sub[k].value %>">'+
										'<span class="text"><%= common[j].sub[k].text %></span>'+
									'</a>'+
			   					'<% }%>'+
			   				'<% }%>'+
			   			'<% }%>'+
			   		'</div>'+
			   	'<% }else {%>'+
				    '<a class="pro icon-tag J_Ajax" title="<%= propSelected[i].text %>：<%= propSelected[i].sub.map(function(x){return x.text}).join(",") %>" data-query="<%= propSelected[i].field%>:<%= propSelected[i].sub.map(function(x){return x.value}).join(",") %>">'+
				    	'<%= propSelected[i].text %>：<span><%= propSelected[i].sub.map(function(x){return x.text}).join(",") %></span>'+
				   		'<span class="glyphicon glyphicon-remove"></span>'+
				   	'</a>'+
				'<% }%>'+
			'<% } %>'+
		'</div>'+
		 '<div class="groups J_NavGroup" style="display:none;">'+
				'<% for(var i=0; i<common.length; i++) {%>'+
					 '<% if(common[i].required != true) {%>'+
						'<div class="group">'+
						'<div class="row J_Row  hide-toggle <% if(i==0){%>row-first<%}%>" >'+
							'<div class="head">'+
								'<h4>'+
								'<span class="title"><%= common[i].text %></span>：'+
								'</h4>'+
							'</div>'+
							'<div class="body">'+
								'<div class="items J_Items">'+
									'<div class="items-inner g-clearfix" ">'+
									'<% for(var j=0; j<common[i].sub.length; j++) {%>'+
										'<a class="item icon-tag J_Ajax J_baikeiTrigger" href="#" data-query="<%=common[i].field %>:<%= common[i].sub[j].value %>">'+
											'<span class="icon-btn-check-small"></span>'+
											'<span class="text"><%= common[i].sub[j].text %></span>'+
										'</a>'+
									'<% } %>'+	
									'</div>'+
								'</div>'+
								'<div class="btns">'+
									'<span class="submit J_SubmitMulti">'+$.i18n.prop('payment_l_submit')+'</span>'+
									'<span class="cancel J_CloseMulti">'+$.i18n.prop('payment_l_cancel')+'</span>'+
								'</div>'+							
							'</div>'+
							'<div class="foot">'+
								'<% if(common[i].multiple == true) {%>'+
								'<span class="switch-multi J_OpenMulti">'+$.i18n.prop('payment_l_multiSelect')+'</span>'+
								'<span class="show-more J_ToggleItems">'+$.i18n.prop('payment_l_more')+'<span class="icon-btn-arrow-down-2"></span></span>'+
								'<span class="show-less J_ToggleItems">'+$.i18n.prop('payment_l_packUp')+'<span class="icon-btn-arrow-up-2"></span></span>'+
								'<% }%>'+
							'</div>'+
						'</div>'+
						'</div>'+
					'<% } %>'+
				'<% } %>'+
		'</div>';

		 var html = ejs.render(template, data);
		 $mNav.empty().append(html);
		 var options = $mNav.mnav('options');

		 if(options.data && genPropSelected(options.data.propSelected) == genPropSelected(data.propSelected)) {
		 	if(options.data.spuTotalHit != null){
		 		data.spuTotalHit = options.data.spuTotalHit;
		 		options.data = data;
		 		setSpuTotalHit($mNav, options.data.spuTotalHit)
		 	}

		 }else{
		 	options.data = data;	
		 	options.onPropChange.call($mNav);
		 }

		if(options.status == "expand"){
			$(".J_ToggleNav").trigger('click');
		}

		options.onLoadSuccess.call($mNav, data);

	}

		function init($mNav) {
			$mNav.addClass('m-nav');

			var options = $mNav.mnav('options');

			if(options.url){
				$.ajax({
			 		url: options.url,
			 		type: 'GET'
			 	}).done(function(data) {
			 		load($mNav , data);
			 		options.onInit.call($mNav);
			 	})

			}else if(options.data){
				load($mNav , $mNav.mnav('options').data);
				options.onInit.call($mNav);
			}			

			 $mNav.on('click', '.switch-multi.J_OpenMulti', function(){
			 	$(this).closest('.J_Row').addClass('expand-mode multi-mode');
			 });

			 $mNav.on('click', '.J_ToggleNav', function(){
			 	$(this).toggleClass('show-collapse');
			 	if($(this).hasClass('show-collapse')){
			 		$(this).parent().next('.J_NavGroup').show();
			 		$mNav.mnav('options').status = 'expand'
			 	}else{
			 		$(this).parent().next('.J_NavGroup').hide();
			 		$mNav.mnav('options').status = 'collapse'
			 	}
			 });

			 $mNav.on('click', '.multi-mode .item', function(){
			 	$(this).toggleClass('icon-hover');
			 });

			 $mNav.on('click', '.btns .submit', function(){
			 	/* Act on the event */
			 	var options  = $mNav.mnav('options');
			 	$.ajax({
			 		url: options.url,
			 		type: 'GET',
			 		data: {propSelected: genPropSelected(options.data.propSelected), query: genQueryMulti($(this)),  method: 'add'},
			 	}).done(function(data) {
			 		$mNav.mnav('load', data);
			 	})	
			 });

			 $mNav.on('click', '.btns .cancel', function (){
			 	/* Act on the event */
			 	$(this).closest('.J_Row').removeClass('multi-mode');
			 	$(this).closest('.J_Row').find('.item').removeClass('icon-hover');
			 });

			 $mNav.on('click', '.J_Row:not(.multi-mode) .item, .pro-required-submenu .item', function(){
			 	/* Act on the event */
			 	var options  = $mNav.mnav('options');

			 	$.ajax({
			 		url: options.url,
			 		type: 'GET',
			 		data: {propSelected: genPropSelected(options.data.propSelected), query: $(this).data('query'), method:'add'}
			 	}).done(function(data) {
			 		$mNav.mnav('load', data);
			 	})	
			 });

			 $mNav.on('click', '.pro:not(.pro-required)', function(event) {
			 	/* Act on the event */
			 	var options  = $mNav.mnav('options');

			 	$.ajax({
			 		url: options.url,
			 		type: 'GET',
			 		data: {propSelected: genPropSelected(options.data.propSelected), query: $(this).data('query'), method:'remove'}
			 	}).done(function(data) {
			 		$mNav.mnav('load', data);
			 	})
			 });

			 $mNav.on('mouseover', '.pro.pro-required', function (event){
			 	$(this).next('.pro-required-submenu').css('left', $(this).position().left);
			 	$(this).next('.pro-required-submenu').css("width",$(this).css("width"));
			 	$(this).next('.pro-required-submenu').show();
			 });

			 $mNav.on('mouseout', '.pro.pro-required', function (event){
			 	$(this).next('.pro-required-submenu').hide();
			 });

			 $mNav.on('mouseenter', '.pro-required-submenu', function (event){
			 	$(this).show();
			 });

			 $mNav.on('mouseleave', '.pro-required-submenu', function (event){
			 	$(this).hide();
			 });
		}

		function genQueryMulti($submit){
			//所有选中的条件
			var $select = $submit.closest('.body').find('a.icon-hover');
			var query = ""; 

		 	$select.each(function (){
		 		if(query == ""){
		 			query = $(this).data('query');	
		 		}else{
		 			param =  $(this).data('query').match(/(.+?)\:(.+)/);
		 			query += '&'+ param[2];
		 		}
		 	});

		 	return query;
		}

		function genPropSelected(propSelected){
			var result = [];
			propSelected.forEach(function (x, i, a){
				var str = x.field+':';
				x.sub.forEach(function (y, j, b){
					if(j){
				 		str += '&';
				 	}
					str += y.value;
				});
				result.push(str);
			});
			return result.toString();
		}

		function getQueryParams($mNav){
			var param = {};
			var propSelected = $mNav.mnav('options').data.propSelected;

			propSelected.forEach(function (x, i, a){
				var value = '';
				var key = x.field;
				x.sub.forEach(function (y, j, b) {
					if(j){
				 		value += ',';
				 	}
				 	value += y.value;
				});
				param[key] = value;
			});

			return param;
		}

		function setSpuTotalHit($mNav, num){
			var  $spuTotalHit;
			if(num == 0 || num == 1){
				$spuTotalHit = $('<span class="total">'+$.i18n.prop('payment_l_total')+'<span class="h">'+num+'</span>'+$.i18n.prop('payment_l_perRecord')+'</span>');
			}else{
				$spuTotalHit = $('<span class="total">'+$.i18n.prop('payment_l_total')+'<span class="h">'+num+'</span>'+$.i18n.prop('payment_l_perRecords')+'</span>');
			}			
			$mNav.find('.crumb .total').remove();
			$mNav.find('.crumb').append($spuTotalHit);
			$mNav.mnav('options').data.spuTotalHit = num;
		}


	$.fn.mnav = function(options, param) {
		if (typeof options === 'string') {
			return $.fn.mnav.methods[options](this, param);
		}

		options = options || {};

		return this.each(function (){

			var state = $.data(this, 'mnav');
			if(state) {
				$.extend(state.options , options)
			}else {
				state = $.data(this, 'mnav', {
					options: $.extend({}, $.fn.mnav.defaults, options)
				});
				init($(this));
			}
		});
	};

	$.fn.mnav.methods = {
		load: function (jq, data){
			return load(jq , data);
		},
		options: function (jq){
			return $.data(jq[0], 'mnav').options;
		},
		getQueryParams: function (jq){
			return getQueryParams(jq);
		},
		setSpuTotalHit: function (jq, num){
			return setSpuTotalHit(jq, num);
		}
	};

	$.fn.mnav.defaults = {
		onLoadSuccess: function(data){

		},
		onInit: function (){

		},
		onPropChange: function (){

		},
		status:'collapse'
	};

})(jQuery);