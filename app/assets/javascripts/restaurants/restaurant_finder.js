$(document).ready(function(){
  $('#create_restaurant').hide();

  $("#new_restaurant_form").on('click', '.rest_choice', function(){
    $("#restaurant_name").val($(this).data('name'));
    $("#restaurant_latitude").val($(this).data('lat'));
    $("#restaurant_longitude").val($(this).data('long'));
    $("#new_restaurant_form").submit();
  });

  var geocoder;
  var map;
  function findCoords(address, rest_data){
    geocoder = new google.maps.Geocoder();
    geocoder.geocode({'address': address}, function(results, status){
      if (status == google.maps.GeocoderStatus.OK){
        foundlat = results[0].geometry.location.k;
        foundlong = results[0].geometry.location.B;
        $("#new_restaurant_form").
        append(
          "<div class='rest_choice' data-name='"+rest_data['name']+"' data-lat='"+foundlat
          +"' data-long='"+foundlong+"'><span class='rest_name'>"
          +rest_data['name']+"</span>"
          +"<span class='rest_addr'>"+rest_data['location']['display_address'][0]+", "+rest_data['location']['display_address'][2]+"</span></div>"           
        )
      }
    });
  };

  $('#restaurant_search').on('submit', function(e){
    e.preventDefault();
    $('#restaurant_search').hide();

    $.get( "/yelp_call?name=" 
      + $('#name').val()+"&latitude=" 
      + $('#latitude').val()+"&longitude=" 
      + $('#longitude').val(), 
      function( response ) {
        $('#name').val('');
        $("#new_restaurant_form").show()
        for(var i =0;i<response.length;i++){
          if(response[i]['location']['coordinate'] != undefined){
              $("#new_restaurant_form").
              append(
                "<div class='rest_choice' data-name='"+response[i]['name']+"' data-lat='"+response[i]['location']['coordinate']['latitude']
                +"' data-long='"+response[i]['location']['coordinate']['longitude']+"'><span class='rest_name'>"
                +response[i]['name']+"</span>"
                +"<span class='rest_addr'>"+response[i]['location']['display_address'][0]+", "+response[i]['location']['display_address'][2]+"</span></div>")            
          }else if (response[i]['location']['address'] != undefined){
            findCoords(response[i]['location']['display_address'][0]+", "+response[i]['location']['display_address'][2], response[i])
          }
        }
      }
    );
  });
});