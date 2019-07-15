 $(document).ready(function(){ 
 	 $(document).on("shown.bs.modal", "#new-price-modal", function() { 
 	 		 $('#price_price_list_id').on('blur', function() {
			 	data = $('#price_price_list_id').val();
        		url = '/prices_get_price_list';
		        	$.ajax({
		        		url: url,
		        		data: { price_list_id: data },
		        		success: function(res){
		        			  $("#price_utility").val(res["0"].utility);
		        			  $("#price_price_sale").val(get_prise_sale);
		        		}
		        	});       
			    
 				});
 	 		 $('#price_utility').on('blur', function() {
			 	$("#price_price_sale").val(get_prise_sale());
			    
 				});
 	 		 $('#price_price_purchase').on('blur', function() {
			 	$("#price_price_sale").val(get_prise_sale());
			    
 				});
 	 	function get_prise_sale() {
 	 		ppp =  parseFloat($('#price_price_purchase').val());
 	 		mu = parseFloat((($('#price_price_purchase').val()*$('#price_utility').val())/100));
 	 		return mu+ppp;
 	 		}
 	 	}); 	 
 	});
