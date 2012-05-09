$ ->
  $("#credit-card input, #credit-card select").attr "disabled", false
  $("form:has(#credit-card)").submit ->
    form = this
    $("#account_submit").attr "disabled", true
    $("#credit-card input, #credit-card select").attr "name", ""
    $("#credit-card-errors").hide()
    unless $("#credit-card").is(":visible")
      $("#credit-card input, #credit-card select").attr "disabled", true
      return true
    card =
      number: $("#account_credit_card_number").val()
      expMonth: $("#account_expiry_date_month").val()
      expYear: $("#account_expiry_date_year").val()
      cvc: $("#account_cvc").val()

    Stripe.createToken card, (status, response) ->
      if status is 200
        $("#account_last_4_digits").val response.card.last4
        $("#account_stripe_token").val response.id
        form.submit()
      else
        $("#stripe-error-message").text response.error.message
        $("#credit-card-errors").show()
        $("#user_submit").attr "disabled", false

    false

  $("#change-card a").click ->
    $("#change-card").hide()
    $("#credit-card").show()
    $("#credit_card_number").focus()
    false