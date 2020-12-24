Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'g/:token', to: 'api/v1/shortened_urls#go'

  namespace :api do
    namespace :v1 do
      resources :shortened_urls, only: [:create, :show], param: :token
    end
  end
end
