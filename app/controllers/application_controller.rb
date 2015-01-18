class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :load_schema, :authenticate_user!

  private

  def load_schema

  	Apartment::Tenant.switch('public')
  	return unless request.subdomain.present?

  	account = Account.where(subdomain: request.subdomain).first

  	if account
		Apartment::Tenant.switch(account.subdomain)
	else
		redirect_to root_url(subdomain: false)
	end
  	
  end

  def after_sign_out_path_for(resource_or_scope)
  	
  	new_user_session_path
  	
  end

end
