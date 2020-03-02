$(function() {
  if ($("#token_submit") != null) {
    Payjp.setPublicKey("pk_test_af1eb980f3f0ac3fe3baddd7");
    $("#token_submit").on("click", function(e) {
      e.preventDefault();
      let item_id = $('#item_id').val();
      let card = {
        number: $("#card_number").val(),
        cvc: $("#cvc").val(),
        exp_month: $("#exp_month").val(),
        exp_year: $("#exp_year").val()
      };
      Payjp.createToken(card, function(status, response) {
        if (status === 200) {
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name");
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          );
          document.inputForm.submit();
        } else {
          alert("カード情報が正しくありません。");
        }
      })
    })
  }
  false
});