Serveus::Application.routes.draw do


  # Emails
  resources :incidents, only: [:none] do
   resources :emails, only: [:new, :create]
  end

  #Basket
  controller :basket do
    get '/basket/show', as: :basket
    patch '/basket/update', as: :update_basket
  end



  # Trash
  get "trash/index", as: :trashcan
  patch "trash/restore", as: :restore_items
  patch "trash/restore_all", as: :restore_all
  delete "trash/destroy", as: :destroy_items
  delete "trash/empty", as: :empty_trash


  # Feedback
  resource :feedback, controller: :feedback, only: [:new, :create]

  # Tags
  match '/tags', to: 'tags#index', via: :post

  # Incidents and Interactions
  resources :incidents, except: [:new] do
    patch :reopen, on: :member
    patch :close, on: :member
    patch :reopen_all, on: :collection
    patch :close_all, on: :collection
    get :print, on: :member
    get :print_all, on: :collection
    resources :interactions
  end

  # Attachments
  resources :attachments, only: :none do
    get :download, on: :member
  end

  # Devise routes
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations', invitations: 'users/invitations' }

  # Root paths
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
# Generated on 29 Jul 2013 08:14
#
#                    emails POST     /emails(.:format)                                       emails#create
#                 new_email GET      /emails/new(.:format)                                   emails#new
#                    basket GET      /basket/show(.:format)                                  basket#show
#             update_basket PATCH    /basket/update(.:format)                                basket#update
#                  trashcan GET      /trash/index(.:format)                                  trash#index
#             restore_items PATCH    /trash/restore(.:format)                                trash#restore
#               restore_all PATCH    /trash/restore_all(.:format)                            trash#restore_all
#             destroy_items DELETE   /trash/destroy(.:format)                                trash#destroy
#               empty_trash DELETE   /trash/empty(.:format)                                  trash#empty
#                  feedback POST     /feedback(.:format)                                     feedback#create
#              new_feedback GET      /feedback/new(.:format)                                 feedback#new
#                      tags POST     /tags(.:format)                                         tags#index
#           reopen_incident PATCH    /incidents/:id/reopen(.:format)                         incidents#reopen
#            close_incident PATCH    /incidents/:id/close(.:format)                          incidents#close
#      reopen_all_incidents PATCH    /incidents/reopen_all(.:format)                         incidents#reopen_all
#       close_all_incidents PATCH    /incidents/close_all(.:format)                          incidents#close_all
#            print_incident GET      /incidents/:id/print(.:format)                          incidents#print
#       print_all_incidents GET      /incidents/print_all(.:format)                          incidents#print_all
#     incident_interactions GET      /incidents/:incident_id/interactions(.:format)          interactions#index
#                           POST     /incidents/:incident_id/interactions(.:format)          interactions#create
#  new_incident_interaction GET      /incidents/:incident_id/interactions/new(.:format)      interactions#new
# edit_incident_interaction GET      /incidents/:incident_id/interactions/:id/edit(.:format) interactions#edit
#      incident_interaction PATCH    /incidents/:incident_id/interactions/:id(.:format)      interactions#update
#                           PUT      /incidents/:incident_id/interactions/:id(.:format)      interactions#update
#                           DELETE   /incidents/:incident_id/interactions/:id(.:format)      interactions#destroy
#                 incidents GET      /incidents(.:format)                                    incidents#index
#                           POST     /incidents(.:format)                                    incidents#create
#             edit_incident GET      /incidents/:id/edit(.:format)                           incidents#edit
#                  incident GET      /incidents/:id(.:format)                                incidents#show
#                           PATCH    /incidents/:id(.:format)                                incidents#update
#                           PUT      /incidents/:id(.:format)                                incidents#update
#                           DELETE   /incidents/:id(.:format)                                incidents#destroy
#       download_attachment GET      /attachments/:id/download(.:format)                     attachments#download
#          new_user_session GET      /users/sign_in(.:format)                                devise/sessions#new
#              user_session POST     /users/sign_in(.:format)                                devise/sessions#create
#      destroy_user_session DELETE   /users/sign_out(.:format)                               devise/sessions#destroy
#   user_omniauth_authorize GET|POST /users/auth/:provider(.:format)                         users/omniauth_callbacks#passthru {:provider=>/google_oauth2/}
#    user_omniauth_callback GET|POST /users/auth/:action/callback(.:format)                  users/omniauth_callbacks#(?-mix:google_oauth2)
#             user_password POST     /users/password(.:format)                               devise/passwords#create
#         new_user_password GET      /users/password/new(.:format)                           devise/passwords#new
#        edit_user_password GET      /users/password/edit(.:format)                          devise/passwords#edit
#                           PATCH    /users/password(.:format)                               devise/passwords#update
#                           PUT      /users/password(.:format)                               devise/passwords#update
#  cancel_user_registration GET      /users/cancel(.:format)                                 devise_invitable/registrations#cancel
#         user_registration POST     /users(.:format)                                        devise_invitable/registrations#create
#     new_user_registration GET      /users/sign_up(.:format)                                devise_invitable/registrations#new
#    edit_user_registration GET      /users/edit(.:format)                                   devise_invitable/registrations#edit
#                           PATCH    /users(.:format)                                        devise_invitable/registrations#update
#                           PUT      /users(.:format)                                        devise_invitable/registrations#update
#                           DELETE   /users(.:format)                                        devise_invitable/registrations#destroy
#    accept_user_invitation GET      /users/invitation/accept(.:format)                      devise/invitations#edit
#    remove_user_invitation GET      /users/invitation/remove(.:format)                      devise/invitations#destroy
#           user_invitation POST     /users/invitation(.:format)                             devise/invitations#create
#       new_user_invitation GET      /users/invitation/new(.:format)                         devise/invitations#new
#                           PATCH    /users/invitation(.:format)                             devise/invitations#update
#                           PUT      /users/invitation(.:format)                             devise/invitations#update
#        authenticated_root GET      /                                                       incidents#index
#                      root GET      /                                                       high_voltage/pages#show {:id=>"home"}
#             contact_forms POST     /contact_forms(.:format)                                contact_form#create
#          new_contact_form GET      /contact_forms/new(.:format)                            contact_form#new
#                                    /mail_view                                              MailPreview
#                                    (/errors)/:status(.:format)                             errors#show {:status=>/\d{3}/}
#           email_processor POST     /email_processor(.:format)                              griddler/emails#create
#                      page GET      /pages/*id                                              high_voltage/pages#show
