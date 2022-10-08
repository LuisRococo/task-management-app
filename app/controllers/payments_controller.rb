class PaymentsController < ApplicationController
  authorize_persona class_name: "User"
  before_action :validate_is_manager
  before_action :validate_should_user_pay
  grant(
    manager: :all
  )

  def new
  end

  def create
    customer_id = current_user.get_or_create_stripe_customer_id
    card_token = tokenizate_card

    Stripe::Charge.create({
      amount: current_user.plan.price_cents,
      currency: current_user.plan.price_currency,
      source: card_token,
      description: "Charge for usign #{current_user.plan.title}",
    })

    flash[:notice] = 'The payment was successfull'
    redirect_to root_path
  rescue StandardError => e
    flash[:alert] = 'There was an error, try again'
    redirect_back(fallback_location: root_path)
  end

  private

  def tokenizate_card
    token = Stripe::Token.create({
      card: {
        number: params[:card_number],
        exp_month: params['expiration_date(2i)'],
        exp_year: params['expiration_date(1i)'],
        cvc: params[:cvc]
      },
    })
  end

  def validate_is_manager
    unless current_user.authorization_tier == 'manager'
      flash[:alert] = 'You can not access this section'
      redirect_back(fallback_location: root_path)
    end
  end

  def validate_should_user_pay
    unless current_user.user_has_plan? && !current_user.trial_block
      flash[:alert] = 'You do not have a plan to pay or you already payed'
      redirect_back(fallback_location: root_path)
    end
  end
end
