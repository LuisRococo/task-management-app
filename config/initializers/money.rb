# frozen_string_literal: true

MoneyRails.configure do |config|
  config.default_currency = :usd
end

Money.locale_backend = nil
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
