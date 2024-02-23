Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root "lists#index"
  resources :lists, only: [:index, :show, :new, :create] do
    resources :bookmarks, only: [:new, :create]
  end

  resources :bookmarks, only: [:destroy] # we don't want nesting bc a bookmark list_id

end


#             Prefix Verb URI Pattern                                      Controller#Action
#  rails_health_check GET  /up(.:format)                                   rails/health#show
#      list_bookmarks POST /lists/:list_id/bookmarks(.:format)             bookmarks#create
#   new_list_bookmark GET  /lists/:list_id/bookmarks/new(.:format)         bookmarks#new
#               lists GET  /lists(.:format)                                lists#index
#                     POST /lists(.:format)                                lists#create
#            new_list GET  /lists/new(.:format)                            lists#new
#                list GET  /lists/:id(.:format)                            lists#show
#          bookmark DELETE /bookmark/:id(.:format)                         bookmark#destroy
