ServiceProviderPortal::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :companies do

    resources :associations
    resources :certifications
    resources :affiliations
    resources :service_areas
    resources :categories
    resources :discounts
  end
  namespace :admin do
    resources :users
  end

  resource :user, path: 'profile', only: [:show, :edit, :update]
  resources :password_resets, only: [:new, :create, :show, :update],
    constraints: { id: /[a-zA-Z0-9\-_]{12}/ }

  resource :session, only: [:new, :create, :destroy]

  scope controller: :sessions do
    get :login, action: :new, as: :login
    get :logout, action: :destroy, as: :logout
  end

  root :to => 'companies#index'
end
#== Route Map
# Generated on 06 Mar 2012 08:21
#
#      edit_company_identity GET    /companies/:company_id/identity/edit(.:format)           companies#edit
#           company_identity GET    /companies/:company_id/identity(.:format)                companies#show
#        new_company_service GET    /companies/:company_id/service/new(.:format)             companies#new
#       edit_company_service GET    /companies/:company_id/service/edit(.:format)            companies#edit
#            company_service GET    /companies/:company_id/service(.:format)                 companies#show
#    new_company_credentials GET    /companies/:company_id/credentials/new(.:format)         companies#new
#   edit_company_credentials GET    /companies/:company_id/credentials/edit(.:format)        companies#edit
#        company_credentials GET    /companies/:company_id/credentials(.:format)             companies#show
#       company_associations GET    /companies/:company_id/associations(.:format)            associations#index
#                            POST   /companies/:company_id/associations(.:format)            associations#create
#    new_company_association GET    /companies/:company_id/associations/new(.:format)        associations#new
#   edit_company_association GET    /companies/:company_id/associations/:id/edit(.:format)   associations#edit
#        company_association GET    /companies/:company_id/associations/:id(.:format)        associations#show
#                            PUT    /companies/:company_id/associations/:id(.:format)        associations#update
#                            DELETE /companies/:company_id/associations/:id(.:format)        associations#destroy
#     company_certifications GET    /companies/:company_id/certifications(.:format)          certifications#index
#                            POST   /companies/:company_id/certifications(.:format)          certifications#create
#  new_company_certification GET    /companies/:company_id/certifications/new(.:format)      certifications#new
# edit_company_certification GET    /companies/:company_id/certifications/:id/edit(.:format) certifications#edit
#      company_certification GET    /companies/:company_id/certifications/:id(.:format)      certifications#show
#                            PUT    /companies/:company_id/certifications/:id(.:format)      certifications#update
#                            DELETE /companies/:company_id/certifications/:id(.:format)      certifications#destroy
#       company_affiliations GET    /companies/:company_id/affiliations(.:format)            affiliations#index
#                            POST   /companies/:company_id/affiliations(.:format)            affiliations#create
#    new_company_affiliation GET    /companies/:company_id/affiliations/new(.:format)        affiliations#new
#   edit_company_affiliation GET    /companies/:company_id/affiliations/:id/edit(.:format)   affiliations#edit
#        company_affiliation GET    /companies/:company_id/affiliations/:id(.:format)        affiliations#show
#                            PUT    /companies/:company_id/affiliations/:id(.:format)        affiliations#update
#                            DELETE /companies/:company_id/affiliations/:id(.:format)        affiliations#destroy
#      company_service_areas GET    /companies/:company_id/service_areas(.:format)           service_areas#index
#                            POST   /companies/:company_id/service_areas(.:format)           service_areas#create
#   new_company_service_area GET    /companies/:company_id/service_areas/new(.:format)       service_areas#new
#  edit_company_service_area GET    /companies/:company_id/service_areas/:id/edit(.:format)  service_areas#edit
#       company_service_area GET    /companies/:company_id/service_areas/:id(.:format)       service_areas#show
#                            PUT    /companies/:company_id/service_areas/:id(.:format)       service_areas#update
#                            DELETE /companies/:company_id/service_areas/:id(.:format)       service_areas#destroy
#         company_categories GET    /companies/:company_id/categories(.:format)              categories#index
#                            POST   /companies/:company_id/categories(.:format)              categories#create
#       new_company_category GET    /companies/:company_id/categories/new(.:format)          categories#new
#      edit_company_category GET    /companies/:company_id/categories/:id/edit(.:format)     categories#edit
#           company_category GET    /companies/:company_id/categories/:id(.:format)          categories#show
#                            PUT    /companies/:company_id/categories/:id(.:format)          categories#update
#                            DELETE /companies/:company_id/categories/:id(.:format)          categories#destroy
#          company_discounts GET    /companies/:company_id/discounts(.:format)               discounts#index
#                            POST   /companies/:company_id/discounts(.:format)               discounts#create
#       new_company_discount GET    /companies/:company_id/discounts/new(.:format)           discounts#new
#      edit_company_discount GET    /companies/:company_id/discounts/:id/edit(.:format)      discounts#edit
#           company_discount GET    /companies/:company_id/discounts/:id(.:format)           discounts#show
#                            PUT    /companies/:company_id/discounts/:id(.:format)           discounts#update
#                            DELETE /companies/:company_id/discounts/:id(.:format)           discounts#destroy
#                  companies GET    /companies(.:format)                                     companies#index
#                            POST   /companies(.:format)                                     companies#create
#                new_company GET    /companies/new(.:format)                                 companies#new
#               edit_company GET    /companies/:id/edit(.:format)                            companies#edit
#                    company GET    /companies/:id(.:format)                                 companies#show
#                            PUT    /companies/:id(.:format)                                 companies#update
#                            DELETE /companies/:id(.:format)                                 companies#destroy
#                admin_users GET    /admin/users(.:format)                                   admin/users#index
#                            POST   /admin/users(.:format)                                   admin/users#create
#             new_admin_user GET    /admin/users/new(.:format)                               admin/users#new
#            edit_admin_user GET    /admin/users/:id/edit(.:format)                          admin/users#edit
#                 admin_user GET    /admin/users/:id(.:format)                               admin/users#show
#                            PUT    /admin/users/:id(.:format)                               admin/users#update
#                            DELETE /admin/users/:id(.:format)                               admin/users#destroy
#                  edit_user GET    /profile/edit(.:format)                                  users#edit
#                       user GET    /profile(.:format)                                       users#show
#                            PUT    /profile(.:format)                                       users#update
#            password_resets POST   /password_resets(.:format)                               password_resets#create {:id=>/[a-zA-Z0-9\-_]{12}/}
#         new_password_reset GET    /password_resets/new(.:format)                           password_resets#new {:id=>/[a-zA-Z0-9\-_]{12}/}
#             password_reset GET    /password_resets/:id(.:format)                           password_resets#show {:id=>/[a-zA-Z0-9\-_]{12}/}
#                            PUT    /password_resets/:id(.:format)                           password_resets#update {:id=>/[a-zA-Z0-9\-_]{12}/}
#                    session POST   /session(.:format)                                       sessions#create
#                new_session GET    /session/new(.:format)                                   sessions#new
#                            DELETE /session(.:format)                                       sessions#destroy
#                      login GET    /login(.:format)                                         sessions#new
#                     logout GET    /logout(.:format)                                        sessions#destroy
#                       root        /                                                        companies#index
