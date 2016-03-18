//定义流程的意见控件
//依赖于jquery， typeahead
(function($) {
	function init($input, options){

		//设置默认的意见
		 function engineWithDefaults(q, sync,  async) {
		    if (q === '') {
		    	//加载默认的意见
		  		if(options.process) {
		  			engine.add($.opinions.defaultOpinions[options.process]);
		  		    sync($.opinions.defaultOpinions[options.process]);
		  		}
		    }else {
		        engine.search(q, sync);
		    } 
		  }

  		localStorage.clear();
  		if(options.lang){
  			$.extend($.opinions.defaultOpinions, $.opinions.locales[options.lang]);
  		}
  		$.data($input[0], 'opinions', {options: options}); 

  		var engine = new Bloodhound({
	      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
	      queryTokenizer: Bloodhound.tokenizers.whitespace,
	      prefetch: '/qdp/payment2/flowOpinion/query?'+new Date().getTime(),
	      identify: function(obj) { 
	      		return obj.title; 
	      }
	    });

  		$input.typeahead({
	      minLength: 0,
	      hint:false,
	      highlight: true
	    },{
	      name: 'opinions',
	      source: engineWithDefaults,
	      display: 'title',
	       templates: {
	     	  suggestion:Handlebars.compile('<div><span class="opinion-content" {{#if id}}data-id="{{id}}" style="width:90%"{{/if}}>{{title}}</span>{{#compare type 1}}<span class="opinion-btn opinion-delete glyphicon glyphicon-minus"></span>{{/compare}}</div>')
	       }
	     });

  	}

	//注册一个比较大小的Helper,判断v1是否大于v2
    Handlebars.registerHelper("compare",function(v1,v2,options){
        if(v1>v2){
         //满足添加继续执行
         return options.fn(this);
       }else{
          //不满足条件执行{{else}}部分
          return options.inverse(this);
        }
     });

	$.opinions = {
		defaultOpinions:{},
		locales:{}
	}

	$.fn.opinions = function(options, param) {

		if (typeof options === 'string') {
			return $.fn.opinions.methods[options](this, param);
		}

		options = options || {};


		var $opinionInput = this;
	    $opinionInput.addClass('opinion-input');
	    $opinionInput.after('<span class="opinion-btn opinion-save glyphicon glyphicon-floppy-disk" type="button"></span>');

	    init($opinionInput, options);

	    $("body").on("mousedown", ".opinion-save", function(event){
	    	$.ajax({
				url: '/qdp/payment2/flowOpinion/add?'+new Date().getTime(),
				type: 'POST',
				dataType: 'json',
				data: {comment: $opinionInput.typeahead('val')},
			})
			.done(function() {
				var options = $opinionInput.opinions('options');
				$opinionInput.typeahead('close');
				$opinionInput.typeahead('destroy');
				init($opinionInput, options);
				$opinionInput.trigger('keyup');
			})		
		});


		$("body").on("mousedown", ".opinion-delete", function(event){
			event.stopPropagation();
			$.ajax({
				url: '/qdp/payment2/flowOpinion/delete?'+new Date().getTime(),
				type: 'POST',
				dataType: 'json',
				data: {opinionId: $(this).prev(".opinion-content").data("id")},
			})
			.done(function() {
				var options = $opinionInput.opinions('options');
				$opinionInput.typeahead('close');
				$opinionInput.typeahead('destroy');
				init($opinionInput, options);
				$opinionInput.trigger('keyup');
			})
		});
	};

	$.fn.opinions.methods ={
		options: function(jq){
			return $.data(jq[0], 'opinions').options;
		}
	}

	jQuery.fn.extend({
	  autoHeight: function () {
	    function autoHeight_(element) {
	      return jQuery(element)
	        .css({ 'height': 'auto', 'overflow-y': 'hidden' })
	        .height(element.scrollHeight-10);
	    }
	    return this.each(function() {
	      autoHeight_(this).on('input', function() {
	        autoHeight_(this);
	      });
	    });
	  }
	});

	$(function(){
		$('[data-toggle=opinions]').each(function(i){

			$(this).keyup(function () {
			     //init(this);
			     $(this).autoHeight();

			});
			
			$(this).opinions({
				process:$(this).data('process')?$(this).data('process'):null,
				lang:$(this).data('lang')?$(this).data('lang'):null
			});

			$(this).bind('typeahead:select', function(ev, suggestion) {
			  	$(this).trigger('keyup');
			});
		});
	});

})(jQuery);