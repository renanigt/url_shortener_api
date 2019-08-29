Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :url_shorteners, only: [:create, :show], param: :token
end
