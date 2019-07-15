$(document).ready(function(){
    $('#sale_client_id').on('blur', function() {
    	data = $('#sale_client_id').val();
        	url = '/clients_get_client';
        	$.ajax({
        		url: url,
        		data: { client_id: data },
        		success: function(res){
        			document.getElementById("discount_client_sales").innerHTML = res["0"].discount+'%';
        			document.getElementById("limit_credit_client").innerHTML = '$'+ res["0"].limit_credit;
        		    document.getElementById("address_client_sale").innerHTML =  res["0"].address;
        		    document.getElementById("phones_clients_sales").innerHTML =  res["0"].telf;
                    document.getElementById("line_credit_client_available").innerHTML =  res["0"].line_credit_available;
                    $('#price_list_id_').val(res["0"].price_list_id);
                    // document.getElementById("price_list_id_").innerHTML =  res["0"].telf;

                    price_list_id_
        		}
        	});
    	 });
});

  $(document).ready(function() {
    //When checkboxes/radios checked/unchecked, toggle background color
    $('.form-group').on('click','input[type=radio]',function() {
        $(this).closest('.form-group').find('.radio-inline, .radio').removeClass('checked');
        $(this).closest('.radio-inline, .radio').addClass('checked');
    });
    $('.form-group').on('click','input[type=checkbox]',function() {
        $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
    });

    //Show additional info text box when relevant checkbox checked
    $('.additional-info-wrap input[type=checkbox]').click(function() {
        
        if($(this).is(':checked')) {
            $(this).closest('.additional-info-wrap').find('.additional-info').removeClass('hide').find('input,select').removeAttr('disabled');
              $('#id_credit').text('A Credito');
              current_fecha();
             
        }
        else {
            $(this).closest('.additional-info-wrap').find('.additional-info').addClass('hide').find('input,select').val('').attr('disabled','disabled');
             $('#id_credit').text('A Contado');
             current_fecha();             
        }
    });

    //Show additional info text box when relevant radio checked
    $('input[type=radio]').click(function() {
        $(this).closest('.form-group').find('.additional-info-wrap .additional-info').addClass('hide').find('input,select').val('').attr('disabled','disabled');
        if($(this).closest('.additional-info-wrap').length > 0) {
            $(this).closest('.additional-info-wrap').find('.additional-info').removeClass('hide').find('input,select').removeAttr('disabled');
        }
    });
});

function listo(id_sale) {
   alert(id_sale);
}
function current_fecha(){
      var fecha = new Date(); //Fecha actual
      var mes = fecha.getMonth()+1; //obteniendo mes
      var dia = fecha.getDate(); //obteniendo dia
      var ano = fecha.getFullYear(); //obteniendo año
  if(dia<10)
    dia='0'+dia; //agrega cero si el menor de 10
  if(mes<10)
    mes='0'+mes //agrega cero si el menor de 10
    document.getElementById('sale_credit_expiration').value=ano+"-"+mes+"-"+dia;
}



