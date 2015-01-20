class QueriesController < ApplicationController

	def index

		@queries = Query.all
		
	end

	def new

		@query = Query.new
		
	end

	def create

		@query = Query.new(query_params)
		if @query.save
			redirect_to root_path, notice: "Query created!"
		else
			render :new
		end
		
	end

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

	private

	def query_params

		params.require(:query).permit(:query_id, :name, :locality, :skill, :archived)
		
	end

end