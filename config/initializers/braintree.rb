Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = ENV['MERCHANT_KEY']
Braintree::Configuration.public_key = ENV['PUBLIC_KEY']
Braintree::Configuration.private_key = ENV['PRIVATE_KEY']