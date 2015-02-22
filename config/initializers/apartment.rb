#
# Apartment Configuration
#
Apartment.configure do |config|

  config.excluded_models = %w{Account TempLead}
  config.tenant_names = -> { Account.pluck(:subdomain) }

end