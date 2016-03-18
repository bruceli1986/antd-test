function generatePcListForm(data, colspan){
	data.forEach(function(x, i, a){
		var  template = '<tr class="form-tr"><td class="form-td" colspan="'+colspan+'">'+
			'<div class="col-md-11 col-sm-12">'+
			'<% if(unitOfMeasure == "LOT"){%>'+
				'<div class="form-group col-md-6 col-sm-12">'+
					'<label class="control-label">'+$.i18n.prop('payment_l_paidQty')+'</label>'+
					'<span class="form-control-static">1</span>'+	
				'</div>'+
				'<div class="form-group col-md-6 col-sm-12">'+
					'<label class="control-label">'+$.i18n.prop('payment_l_paidAmount')+'</label>'+
					'<input data-max="<%= incurredPrice - incurredFcostsTotal %>" name="pcList['+i+'].incurredFcosts" class="form-control incurredFcosts" type="text" <%if(incurredFcosts){%>value="<%= incurredFcosts %>"<%}%>>'+
				'</div>'+
			'<% } else if( unitOfMeasure != "LOT") {%>'+
				'<div class="form-group col-lg-6 col-md-6 col-sm-12">'+
					'<label class="control-label">'+$.i18n.prop('payment_l_paidQty')+'</label>'+
					'<input data-max="<%= ptdCommitmentQty-incurredQtyTotal %>" data-ptdcommitmentfrate="<%= ptdCommitmentFrate %>" name="pcList['+i+'].incurredQty" class="form-control incurredQty" type="text" <%if(incurredQty){%>value="<%= incurredQty %>"<%}%>>'+	
				'</div>'+
				'<div class="form-group col-md-6 col-sm-12">'+
					'<label class="control-label">'+$.i18n.prop('payment_l_paidAmount')+'</label>'+
					'<span class="pcList-cost form-control-static"></span>'+
				'</div>'+
			'<% } %>'+
			'</div>'+
			'<div class="col-md-1 col-sm-12">'+
				'<a class="glyphicon glyphicon-edit remark-show-button <%if(remark){%>hide<%}%>" data-toggle="collapse" href="#remarkCollapse'+i+'" aria-expanded="false" aria-controls="collapseExample">'+$.i18n.prop('payment_l_remark')+'</a>'+
				'<input type="hidden" name="pcList['+i+'].poItem" value="<%= poItem %>">'+
			'</div>'+
			'<div class="<%if(!remark){%> collapse <%}%> form-group col-md-12 col-sm-12" id="remarkCollapse'+i+'">'+
				'<div class="row remark-container">'+
					'<div class="col-lg-10"><input class="form-control incurredRemark valid" type="text" <%if(remark){%> value="<%= remark %>" <%}%> name="pcList['+i+'].remark" aria-invalid="false"></div>'+
					'<div class="col-lg-2"><p class="form-control-static">'+$.i18n.prop('payment_m_error11')+'</p></div>'+
				'</div>'+
			'</div>'+
		'</td></tr>';
		if(!x.incurredFcosts){
			x.incurredFcosts = null;
		}
		if(!x.incurredQty){
			x.incurredQty = null;
		}
		if(!x.remark){
			x.remark = null;
		}
		var html = ejs.render(template, x);
		$("tr[data-index]:eq("+i+")").after(html);
	});
}

function generateUnit(value, row, index) {
	return row.unitOfMeasure+'/'+row.unitDescription;
}

function formatMoney(value) {
	return numeral(value).format('000,000.00');
}

function formatQty(value, row, index) {
	if(row.unitOfMeasure == 'LOT'){
		return value;
	}else{
		return numeral(value).format('000,000.00000');
	}
}

	