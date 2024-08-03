require 'eu_central_bank'

bank = EuCentralBank.new

bank.update_rates

Money.default_bank = bank

MoneyRails.configure do |config|
  config.default_currency = :usd
end
