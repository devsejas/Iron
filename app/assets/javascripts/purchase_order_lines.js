$(document).ready(function(){

    $(document).on("shown.bs.modal", "#new-purchaseorderlines-modal", function() {

    	var items_suggested = new Bloodhound({
    	  datumTokenizer: Bloodhound.tokenizers.obj.whitespace("description"),
    	  queryTokenizer: Bloodhound.tokenizers.whitespace,
          prefetch: window.location.origin + '/items_suggestion',
    	  remote: {
            url: window.location.origin + '/items_suggestion?query=%QUERY',
        	wildcard: '%QUERY'
    	  }
    	});
    	$('#purchase_order_lines_item').typeahead({
    		  hint: true,
    		  highlight: true,
    		  minLength: 1
    	},
    	{
    	  displayKey: 'description',
    	  source: items_suggested,
          templates: {
            suggestion: function (item) {
                return '<p>' + item.description + '</p>';
            }
          }
    	});
    	  $('#purchase_order_lines_item').focus();
    	  $('#purchase_order_lines_item').typeahead('val', $('#item_description').val() );


    	$('#purchase_order_lines_item').on('typeahead:select', function(object, datum){
            $('#purchase_order_lines_item_id').val(datum.id);
                       
        });
            $('#purchase_order_lines_item').on('typeahead:change', function(event, data){
            $('#purchase_order_lines_item').val(data);
       			 });

             $('#purchase_order_lines_item').on('blur', function() {
        	data = $('#purchase_order_lines_item').val();
        	url = '/validate_suggested_item_purchase';
        	$.ajax({
        		url: url,
        		data: { item_description: data },
        		success: function(res){
        			if (res["0"].valid == false){
        				// Item no válido
        				$('#purchase_order_lines_item').css('border-color', 'red');
        			    $('#purchase_order_lines_item_id').val('');
                        $('#purchase_order_lines_item_qty').val('0');
                        $('#purchase_order_lines_item_qty').prop('disabled', true); 
                        $('#purchase_order_lines_price_unit').val('0');
                        $('#purchase_order_lines_price_unit').prop('disabled', true); 
        			}else{
        				// Item correcto
                         $('#purchase_order_lines_item_id').val(res["0"].id.toString());
                         // $('#sale_details_price').val(res["0"].price.toString());
                         // $('#sale_details_discount').val(res["0"].discount.toString());
        				 $('#purchase_order_lines_item').css('border-color', '#ccc');  
                         $('#purchase_order_lines_item_qty').prop('disabled', false);                    
        			}
        		}
        	});
        });


     $('#purchase_order_lines_item_qty').blur(function(){
            subtotal();
            $('#purchase_order_lines_price_unit').prop('disabled', false); 
        });   

     $('#purchase_order_lines_price_unit').blur(function(){
              subtotal();

        });  

        function subtotal() {

            $('#purchase_order_lines_subtotal').val(get_subtotal());
        };   
        function get_subtotal(){
            return ($('#purchase_order_lines_item_qty').val() * $('#purchase_order_lines_price_unit').val());
        }   
    });
});


