$(document.getElementById('stock_symbol')).change(function() {
  $.ajax({
    url: 'http://localhost:3000/get_data/' + this.value,
    beforeSend: function(xhr) {
      xhr.overrideMimeType('text/plain; charset=x-user-defined');
    }
  }).done(function(data) {
    data = JSON.parse(data);
    document.getElementById('stock_company_name').value = data[0];
    document.getElementById('stock_price').value = data[1];
    document.getElementById('stock_market_cap').value = data[2];
  });
});
