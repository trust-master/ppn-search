ServiceProviderPortal::Application.routes.draw do

  ActiveAdmin.routes(self)

  resources :companies do
    resources :alerts
    resources :discounts
    resources :users
  end

  resource  :user, path: 'profile', only: [:show, :edit, :update]
  resources :password_resets,       only: [:new, :create, :show, :update],
    constraints: { id: /[a-zA-Z0-9\-_]{12}/ }

  resource :session, only: [:new, :create, :destroy]

  scope controller: :sessions do
    get :login,  action: :new,     as: :login
    get :logout, action: :destroy, as: :logout
  end

  root :to => 'companies#index'
end
#== Route Map
# Generated on 16 Mar 2012 23:16
#
#        company_alerts GET    /companies/:company_id/alerts(.:format)             alerts#index
#                       POST   /companies/:company_id/alerts(.:format)             alerts#create
#     new_company_alert GET    /companies/:company_id/alerts/new(.:format)         alerts#new
#    edit_company_alert GET    /companies/:company_id/alerts/:id/edit(.:format)    alerts#edit
#         company_alert GET    /companies/:company_id/alerts/:id(.:format)         alerts#show
#                       PUT    /companies/:company_id/alerts/:id(.:format)         alerts#update
#                       DELETE /companies/:company_id/alerts/:id(.:format)         alerts#destroy
#     company_discounts GET    /companies/:company_id/discounts(.:format)          discounts#index
#                       POST   /companies/:company_id/discounts(.:format)          discounts#create
#  new_company_discount GET    /companies/:company_id/discounts/new(.:format)      discounts#new
# edit_company_discount GET    /companies/:company_id/discounts/:id/edit(.:format) discounts#edit
#      company_discount GET    /companies/:company_id/discounts/:id(.:format)      discounts#show
#                       PUT    /companies/:company_id/discounts/:id(.:format)      discounts#update
#                       DELETE /companies/:company_id/discounts/:id(.:format)      discounts#destroy
#         company_users GET    /companies/:company_id/users(.:format)              users#index
#                       POST   /companies/:company_id/users(.:format)              users#create
#      new_company_user GET    /companies/:company_id/users/new(.:format)          users#new
#     edit_company_user GET    /companies/:company_id/users/:id/edit(.:format)     users#edit
#          company_user GET    /companies/:company_id/users/:id(.:format)          users#show
#                       PUT    /companies/:company_id/users/:id(.:format)          users#update
#                       DELETE /companies/:company_id/users/:id(.:format)          users#destroy
#             companies GET    /companies(.:format)                                companies#index
#                       POST   /companies(.:format)                                companies#create
#           new_company GET    /companies/new(.:format)                            companies#new
#          edit_company GET    /companies/:id/edit(.:format)                       companies#edit
#               company GET    /companies/:id(.:format)                            companies#show
#                       PUT    /companies/:id(.:format)                            companies#update
#                       DELETE /companies/:id(.:format)                            companies#destroy
#             edit_user GET    /profile/edit(.:format)                             users#edit
#                  user GET    /profile(.:format)                                  users#show
#                       PUT    /profile(.:format)                                  users#update
#       password_resets POST   /password_resets(.:format)                          password_resets#create {:id=>/[a-zA-Z0-9\-_]{12}/}
#    new_password_reset GET    /password_resets/new(.:format)                      password_resets#new {:id=>/[a-zA-Z0-9\-_]{12}/}
#        password_reset GET    /password_resets/:id(.:format)                      password_resets#show {:id=>/[a-zA-Z0-9\-_]{12}/}
#                       PUT    /password_resets/:id(.:format)                      password_resets#update {:id=>/[a-zA-Z0-9\-_]{12}/}
#               session POST   /session(.:format)                                  sessions#create
#           new_session GET    /session/new(.:format)                              sessions#new
#                       DELETE /session(.:format)                                  sessions#destroy
#                 login GET    /login(.:format)                                    sessions#new
#                logout GET    /logout(.:format)                                   sessions#destroy
#                  root        /                                                   companies#index
# 
# Routes for RailsAdmin::Engine:
#     dashboard GET         /                                      rails_admin/main#dashboard
#         index GET|POST    /:model_name(.:format)                 rails_admin/main#index
#           new GET|POST    /:model_name/new(.:format)             rails_admin/main#new
#        export GET|POST    /:model_name/export(.:format)          rails_admin/main#export
#   bulk_delete POST|DELETE /:model_name/bulk_delete(.:format)     rails_admin/main#bulk_delete
# history_index GET         /:model_name/history(.:format)         rails_admin/main#history_index
#   bulk_action POST        /:model_name/bulk_action(.:format)     rails_admin/main#bulk_action
#          show GET         /:model_name/:id(.:format)             rails_admin/main#show
#          edit GET|PUT     /:model_name/:id/edit(.:format)        rails_admin/main#edit
#        delete GET|DELETE  /:model_name/:id/delete(.:format)      rails_admin/main#delete
#  history_show GET         /:model_name/:id/history(.:format)     rails_admin/main#history_show
#   show_in_app GET         /:model_name/:id/show_in_app(.:format) rails_admin/main#show_in_app
