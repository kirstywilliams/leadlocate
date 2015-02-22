require 'sidekiq/web'

class SubdomainPresent
	def self.matches?(request)

		request.subdomain.present?

	end
end

class SubdomainBlank
	def self.matches?(request)

		request.subdomain.blank?

	end
end

Rails.application.routes.draw do
	mount Sidekiq::Web, at: '/sidekiq', as: 'sidekiq' if Rails.env.development?
	
	constraints(SubdomainPresent) do

		root 'queries#index', as: :subdomain_root
		devise_for :users
		resources :users, only: :index
		resources :queries, except: [:show, :destroy] do
			resources :leads, only: [:index, :show]
		end

	end

	constraints(SubdomainBlank) do

		root 'home#index'
		resources :accounts, only: [:new, :create]

	end

end
