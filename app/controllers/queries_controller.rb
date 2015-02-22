class QueriesController < ApplicationController

	def index

		@queries = Query.not_archived
		
	end

	def new

		@query = Query.new
		
	end

	def create

		subdomain = request.subdomain
		account_id = account(subdomain)
		Apartment::Tenant.switch(subdomain)

		params[:query].merge!(account_id: account_id)

		@query = Query.new(query_params)
		if @query.save
			redirect_to root_path, notice: "Query created!"
		else
			render :new
		end
		
	end

=begin
	def edit

		@query = Query.find(params[:id])
		
	end

	def update

		@query = Query.find(params[:id])

		if @query.update(query_params)
			redirect_to root_path, notice: "Query updated!"
		else
			render :edit
		end
		
	end
=end

	private

	def account(subdomain)

		Apartment::Tenant.switch('public')
		Account.where(:subdomain => subdomain).limit(1).pluck(:id)[0]
		
	end

	def query_params

		params.require(:query).permit(:query_id, :name, :locality, :skill, :archived, :account_id)
		
	end

end