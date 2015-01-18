class AccountsController < ApplicationController
	skip_before_filter :authenticate_user!, only: [:new, :create]

	def new

		@account = Account.new  
		@account.build_owner

	end

	def create

		@account = Account.new(account_params)
		if @account.valid?
			@account.save
		 	redirect_to root_url, notice: 'Signed up successfully'
		else
			render action: 'new'
		end

	end

	private

	def account_params

		params.require(:account).permit(:subdomain, owner_attributes: [:name, :email, :password, :password_confirmation])
	
	end
end