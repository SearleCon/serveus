Serveus::Application.routes.draw do


  match '/tags', to: 'tags#index', via: :post

  resources :incidents, except: [:edit, :new, :update], shallow: true do
    resources :interactions, only: [:create, :new, :edit, :destroy]
  end

  resources :attachments, only: :none do
    get :download, on: :member
  end

  # Devise routes
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }


  authenticated :user do
    root to: 'incidents#index', as: :authenticated_root
  end

  root to: 'high_voltage/pages#show', id: 'home'

  # Contact Us
  resources :contact_forms, controller: :contact_form, only: [:new, :create]

  # Mail Preview
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  # Handle errors
  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/}, via: :all


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
#== Route Map
# Generated on 26 Jun 2013 17:12
#
#                     tags POST     /tags(.:format)                                    tags#index
#    incident_interactions POST     /incidents/:incident_id/interactions(.:format)     interactions#create
# new_incident_interaction GET      /incidents/:incident_id/interactions/new(.:format) interactions#new
#         edit_interaction GET      /interactions/:id/edit(.:format)                   interactions#edit
#              interaction DELETE   /interactions/:id(.:format)                        interactions#destroy
#                incidents GET      /incidents(.:format)                               incidents#index
#                          POST     /incidents(.:format)                               incidents#create
#                 incident GET      /incidents/:id(.:format)                           incidents#show
#                          DELETE   /incidents/:id(.:format)                           incidents#destroy
#      download_attachment GET      /attachments/:id/download(.:format)                attachments#download
#         new_user_session GET      /users/sign_in(.:format)                           devise/sessions#new
#             user_session POST     /users/sign_in(.:format)                           devise/sessions#create
#     destroy_user_session DELETE   /users/sign_out(.:format)                          devise/sessions#destroy
#  user_omniauth_authorize GET|POST /users/auth/:provider(.:format)                    users/omniauth_callbacks#passthru {:provider=>/google_oauth2|facebook/}
#   user_omniauth_callback GET|POST /users/auth/:action/callback(.:format)             users/omniauth_callbacks#(?-mix:google_oauth2|facebook)
#            user_password POST     /users/password(.:format)                          devise/passwords#create
#        new_user_password GET      /users/password/new(.:format)                      devise/passwords#new
#       edit_user_password GET      /users/password/edit(.:format)                     devise/passwords#edit
#                          PATCH    /users/password(.:format)                          devise/passwords#update
#                          PUT      /users/password(.:format)                          devise/passwords#update
# cancel_user_registration GET      /users/cancel(.:format)                            devise/registrations#cancel
#        user_registration POST     /users(.:format)                                   devise/registrations#create
#    new_user_registration GET      /users/sign_up(.:format)                           devise/registrations#new
#   edit_user_registration GET      /users/edit(.:format)                              devise/registrations#edit
#                          PATCH    /users(.:format)                                   devise/registrations#update
#                          PUT      /users(.:format)                                   devise/registrations#update
#                          DELETE   /users(.:format)                                   devise/registrations#destroy
#       authenticated_root GET      /                                                  incidents#index
#                     root GET      /                                                  high_voltage/pages#show {:id=>"home"}
#            contact_forms POST     /contact_forms(.:format)                           contact_form#create
#         new_contact_form GET      /contact_forms/new(.:format)                       contact_form#new
#                                   /mail_view                                         MailPreview
#                                   (/errors)/:status(.:format)                        errors#show {:status=>/\d{3}/}
#                     page GET      /pages/*id                                         high_voltage/pages#show
