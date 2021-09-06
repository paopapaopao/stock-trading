let transactionShare = document.getElementById('transaction_share');
let price = document.getElementById('price');
let transactionValue = document.getElementById('transaction_value');

transactionShare.addEventListener('keyup', function() {
  transactionValue.value = this.value * price.value;
});
