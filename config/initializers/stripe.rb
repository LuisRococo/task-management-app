# frozen_string_literal: true

require 'stripe'
Stripe.api_key = Rails.application.credentials[:stripe_private_key]
