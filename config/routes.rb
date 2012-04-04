ServiceProviderPortal::Application.routes.draw do

  ActiveAdmin.routes(self) unless defined?(::Rake)

  resources :companies do
    resources :alerts
    resources :discounts

    resources :users
    resources :company_admins, path: 'users', controller: :users
    resources :administrators, path: 'users', controller: :users
  end
  resource  :company, path: 'profile', only: [:show, :edit, :update]
  resource  :user,    path: 'account', only: [:show, :edit, :update]

  resources :password_resets, only: [:new, :create, :show, :update],
    constraints: { id: /[a-zA-Z0-9\-_]{12}/ }

  resource :session, only: [:create]

  scope controller: :sessions do
    get :login,  action: :new,     as: :login
    get :logout, action: :destroy, as: :logout
  end

  match '/debug/:action', controller: :debug

  scope '/follow_us_on', as: :follow_us_on do
    get 'twitter',  to: redirect('http://twitter.com/#!/TrustMaster1')
    get 'facebook', to: redirect('http://www.facebook.com/pages/Trust-Master/324176494311640')
  end
  root :to => 'companies#index'
end
#== Route Map
# Generated on 02 Apr 2012 17:07
#
#      batch_action_admin_companies POST   /admin/companies/batch_action(.:format)             admin/companies#batch_action
#                   admin_companies GET    /admin/companies(.:format)                          admin/companies#index
#                                   POST   /admin/companies(.:format)                          admin/companies#create
#                 new_admin_company GET    /admin/companies/new(.:format)                      admin/companies#new
#                edit_admin_company GET    /admin/companies/:id/edit(.:format)                 admin/companies#edit
#                     admin_company GET    /admin/companies/:id(.:format)                      admin/companies#show
#                                   PUT    /admin/companies/:id(.:format)                      admin/companies#update
#                                   DELETE /admin/companies/:id(.:format)                      admin/companies#destroy
#     batch_action_admin_categories POST   /admin/categories/batch_action(.:format)            admin/categories#batch_action
#                  admin_categories GET    /admin/categories(.:format)                         admin/categories#index
#                                   POST   /admin/categories(.:format)                         admin/categories#create
#                new_admin_category GET    /admin/categories/new(.:format)                     admin/categories#new
#               edit_admin_category GET    /admin/categories/:id/edit(.:format)                admin/categories#edit
#                    admin_category GET    /admin/categories/:id(.:format)                     admin/categories#show
#                                   PUT    /admin/categories/:id(.:format)                     admin/categories#update
#                                   DELETE /admin/categories/:id(.:format)                     admin/categories#destroy
#         reset_password_admin_user GET    /admin/users/:id/reset_password(.:format)           admin/users#reset_password
#          batch_action_admin_users POST   /admin/users/batch_action(.:format)                 admin/users#batch_action
#                       admin_users GET    /admin/users(.:format)                              admin/users#index
#                                   POST   /admin/users(.:format)                              admin/users#create
#                    new_admin_user GET    /admin/users/new(.:format)                          admin/users#new
#                   edit_admin_user GET    /admin/users/:id/edit(.:format)                     admin/users#edit
#                        admin_user GET    /admin/users/:id(.:format)                          admin/users#show
#                                   PUT    /admin/users/:id(.:format)                          admin/users#update
#                                   DELETE /admin/users/:id(.:format)                          admin/users#destroy
# batch_action_admin_discount_types POST   /admin/discount_types/batch_action(.:format)        admin/discount_types#batch_action
#              admin_discount_types GET    /admin/discount_types(.:format)                     admin/discount_types#index
#                                   POST   /admin/discount_types(.:format)                     admin/discount_types#create
#           new_admin_discount_type GET    /admin/discount_types/new(.:format)                 admin/discount_types#new
#          edit_admin_discount_type GET    /admin/discount_types/:id/edit(.:format)            admin/discount_types#edit
#               admin_discount_type GET    /admin/discount_types/:id(.:format)                 admin/discount_types#show
#                                   PUT    /admin/discount_types/:id(.:format)                 admin/discount_types#update
#                                   DELETE /admin/discount_types/:id(.:format)                 admin/discount_types#destroy
#        batch_action_admin_markets POST   /admin/markets/batch_action(.:format)               admin/markets#batch_action
#                     admin_markets GET    /admin/markets(.:format)                            admin/markets#index
#                                   POST   /admin/markets(.:format)                            admin/markets#create
#                  new_admin_market GET    /admin/markets/new(.:format)                        admin/markets#new
#                 edit_admin_market GET    /admin/markets/:id/edit(.:format)                   admin/markets#edit
#                      admin_market GET    /admin/markets/:id(.:format)                        admin/markets#show
#                                   PUT    /admin/markets/:id(.:format)                        admin/markets#update
#                                   DELETE /admin/markets/:id(.:format)                        admin/markets#destroy
#       batch_action_admin_comments POST   /admin/comments/batch_action(.:format)              admin/comments#batch_action
#                    admin_comments GET    /admin/comments(.:format)                           admin/comments#index
#                                   POST   /admin/comments(.:format)                           admin/comments#create
#                 new_admin_comment GET    /admin/comments/new(.:format)                       admin/comments#new
#                edit_admin_comment GET    /admin/comments/:id/edit(.:format)                  admin/comments#edit
#                     admin_comment GET    /admin/comments/:id(.:format)                       admin/comments#show
#                                   PUT    /admin/comments/:id(.:format)                       admin/comments#update
#                                   DELETE /admin/comments/:id(.:format)                       admin/comments#destroy
#                    company_alerts GET    /companies/:company_id/alerts(.:format)             alerts#index
#                                   POST   /companies/:company_id/alerts(.:format)             alerts#create
#                 new_company_alert GET    /companies/:company_id/alerts/new(.:format)         alerts#new
#                edit_company_alert GET    /companies/:company_id/alerts/:id/edit(.:format)    alerts#edit
#                     company_alert GET    /companies/:company_id/alerts/:id(.:format)         alerts#show
#                                   PUT    /companies/:company_id/alerts/:id(.:format)         alerts#update
#                                   DELETE /companies/:company_id/alerts/:id(.:format)         alerts#destroy
#                 company_discounts GET    /companies/:company_id/discounts(.:format)          discounts#index
#                                   POST   /companies/:company_id/discounts(.:format)          discounts#create
#              new_company_discount GET    /companies/:company_id/discounts/new(.:format)      discounts#new
#             edit_company_discount GET    /companies/:company_id/discounts/:id/edit(.:format) discounts#edit
#                  company_discount GET    /companies/:company_id/discounts/:id(.:format)      discounts#show
#                                   PUT    /companies/:company_id/discounts/:id(.:format)      discounts#update
#                                   DELETE /companies/:company_id/discounts/:id(.:format)      discounts#destroy
#                     company_users GET    /companies/:company_id/users(.:format)              users#index
#                                   POST   /companies/:company_id/users(.:format)              users#create
#                  new_company_user GET    /companies/:company_id/users/new(.:format)          users#new
#                 edit_company_user GET    /companies/:company_id/users/:id/edit(.:format)     users#edit
#                      company_user GET    /companies/:company_id/users/:id(.:format)          users#show
#                                   PUT    /companies/:company_id/users/:id(.:format)          users#update
#                                   DELETE /companies/:company_id/users/:id(.:format)          users#destroy
#                         companies GET    /companies(.:format)                                companies#index
#                                   POST   /companies(.:format)                                companies#create
#                       new_company GET    /companies/new(.:format)                            companies#new
#                      edit_company GET    /companies/:id/edit(.:format)                       companies#edit
#                           company GET    /companies/:id(.:format)                            companies#show
#                                   PUT    /companies/:id(.:format)                            companies#update
#                                   DELETE /companies/:id(.:format)                            companies#destroy
#                                   GET    /profile/edit(.:format)                             companies#edit
#                                   GET    /profile(.:format)                                  companies#show
#                                   PUT    /profile(.:format)                                  companies#update
#                         edit_user GET    /account/edit(.:format)                             users#edit
#                              user GET    /account(.:format)                                  users#show
#                                   PUT    /account(.:format)                                  users#update
#                   password_resets POST   /password_resets(.:format)                          password_resets#create {:id=>/[a-zA-Z0-9\-_]{12}/}
#                new_password_reset GET    /password_resets/new(.:format)                      password_resets#new {:id=>/[a-zA-Z0-9\-_]{12}/}
#                    password_reset GET    /password_resets/:id(.:format)                      password_resets#show {:id=>/[a-zA-Z0-9\-_]{12}/}
#                                   PUT    /password_resets/:id(.:format)                      password_resets#update {:id=>/[a-zA-Z0-9\-_]{12}/}
#                           session POST   /session(.:format)                                  sessions#create
#                             login GET    /login(.:format)                                    sessions#new
#                            logout GET    /logout(.:format)                                   sessions#destroy
#                              root        /                                                   companies#index
