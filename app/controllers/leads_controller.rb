class LeadsController < ApplicationController

	def index

		@query = Query.find(params[:query_id])
		@leads = @query.leads
		
	end

	def show

		@lead = Lead.find(params[:id])
		
	end
end