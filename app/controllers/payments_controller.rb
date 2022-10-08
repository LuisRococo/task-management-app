class PaymentsController < ApplicationController
  def create
    customer_id = current_user.get_or_create_stripe_customer_id
    card_token = tokenizate_card

    Stripe::Charge.create({
      amount: current_user.plan.price_cents,
      currency: current_user.price_currency,
      source: card_token,
      description: "Charge for usign #{current_user.plan.title}",
    })
  end

  private

  def tokenizate_card
    token = Stripe::Token.create({
      card: {
        number: params[:card_number],
        exp_month: params[:exp_month],
        exp_year: params[:exp_year],
        cvc: params[:cvc]
      },
    })
  end
end
