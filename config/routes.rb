ServiceProviderPortal::Application.routes.draw do

  resources :companies do
    resources :associations
    resources :certifications
    resources :affiliations
    resources :service_area_coverages
    resources :service_areas
    resources :company_subcategories
    resources :categories
    resources :discounts
  end

  resources :users

  resource :profile
  resource :session, only: [:new, :create, :destroy]
  resources :password_resets

  scope controller: :sessions do
    get :login, action: :new, as: :login
    get :logout, action: :destroy, as: :logout
  end

  root :to => 'sessions#new'
end
#== Route Map
# Generated on 08 Jan 2012 04:59
#
#                                    POST   /companies/:company_id/associations(.:format)                    {:action=>"create", :controller=>"associations"}
#            new_company_association GET    /companies/:company_id/associations/new(.:format)                {:action=>"new", :controller=>"associations"}
#           edit_company_association GET    /companies/:company_id/associations/:id/edit(.:format)           {:action=>"edit", :controller=>"associations"}
#                company_association GET    /companies/:company_id/associations/:id(.:format)                {:action=>"show", :controller=>"associations"}
#                                    PUT    /companies/:company_id/associations/:id(.:format)                {:action=>"update", :controller=>"associations"}
#                                    DELETE /companies/:company_id/associations/:id(.:format)                {:action=>"destroy", :controller=>"associations"}
#             company_certifications GET    /companies/:company_id/certifications(.:format)                  {:action=>"index", :controller=>"certifications"}
#                                    POST   /companies/:company_id/certifications(.:format)                  {:action=>"create", :controller=>"certifications"}
#          new_company_certification GET    /companies/:company_id/certifications/new(.:format)              {:action=>"new", :controller=>"certifications"}
#         edit_company_certification GET    /companies/:company_id/certifications/:id/edit(.:format)         {:action=>"edit", :controller=>"certifications"}
#              company_certification GET    /companies/:company_id/certifications/:id(.:format)              {:action=>"show", :controller=>"certifications"}
#                                    PUT    /companies/:company_id/certifications/:id(.:format)              {:action=>"update", :controller=>"certifications"}
#                                    DELETE /companies/:company_id/certifications/:id(.:format)              {:action=>"destroy", :controller=>"certifications"}
#               company_affiliations GET    /companies/:company_id/affiliations(.:format)                    {:action=>"index", :controller=>"affiliations"}
#                                    POST   /companies/:company_id/affiliations(.:format)                    {:action=>"create", :controller=>"affiliations"}
#            new_company_affiliation GET    /companies/:company_id/affiliations/new(.:format)                {:action=>"new", :controller=>"affiliations"}
#           edit_company_affiliation GET    /companies/:company_id/affiliations/:id/edit(.:format)           {:action=>"edit", :controller=>"affiliations"}
#                company_affiliation GET    /companies/:company_id/affiliations/:id(.:format)                {:action=>"show", :controller=>"affiliations"}
#                                    PUT    /companies/:company_id/affiliations/:id(.:format)                {:action=>"update", :controller=>"affiliations"}
#                                    DELETE /companies/:company_id/affiliations/:id(.:format)                {:action=>"destroy", :controller=>"affiliations"}
#     company_service_area_coverages GET    /companies/:company_id/service_area_coverages(.:format)          {:action=>"index", :controller=>"service_area_coverages"}
#                                    POST   /companies/:company_id/service_area_coverages(.:format)          {:action=>"create", :controller=>"service_area_coverages"}
#  new_company_service_area_coverage GET    /companies/:company_id/service_area_coverages/new(.:format)      {:action=>"new", :controller=>"service_area_coverages"}
# edit_company_service_area_coverage GET    /companies/:company_id/service_area_coverages/:id/edit(.:format) {:action=>"edit", :controller=>"service_area_coverages"}
#      company_service_area_coverage GET    /companies/:company_id/service_area_coverages/:id(.:format)      {:action=>"show", :controller=>"service_area_coverages"}
#                                    PUT    /companies/:company_id/service_area_coverages/:id(.:format)      {:action=>"update", :controller=>"service_area_coverages"}
#                                    DELETE /companies/:company_id/service_area_coverages/:id(.:format)      {:action=>"destroy", :controller=>"service_area_coverages"}
#              company_service_areas GET    /companies/:company_id/service_areas(.:format)                   {:action=>"index", :controller=>"service_areas"}
#                                    POST   /companies/:company_id/service_areas(.:format)                   {:action=>"create", :controller=>"service_areas"}
#           new_company_service_area GET    /companies/:company_id/service_areas/new(.:format)               {:action=>"new", :controller=>"service_areas"}
#          edit_company_service_area GET    /companies/:company_id/service_areas/:id/edit(.:format)          {:action=>"edit", :controller=>"service_areas"}
#               company_service_area GET    /companies/:company_id/service_areas/:id(.:format)               {:action=>"show", :controller=>"service_areas"}
#                                    PUT    /companies/:company_id/service_areas/:id(.:format)               {:action=>"update", :controller=>"service_areas"}
#                                    DELETE /companies/:company_id/service_areas/:id(.:format)               {:action=>"destroy", :controller=>"service_areas"}
#      company_company_subcategories GET    /companies/:company_id/company_subcategories(.:format)           {:action=>"index", :controller=>"company_subcategories"}
#                                    POST   /companies/:company_id/company_subcategories(.:format)           {:action=>"create", :controller=>"company_subcategories"}
#    new_company_company_subcategory GET    /companies/:company_id/company_subcategories/new(.:format)       {:action=>"new", :controller=>"company_subcategories"}
#   edit_company_company_subcategory GET    /companies/:company_id/company_subcategories/:id/edit(.:format)  {:action=>"edit", :controller=>"company_subcategories"}
#        company_company_subcategory GET    /companies/:company_id/company_subcategories/:id(.:format)       {:action=>"show", :controller=>"company_subcategories"}
#                                    PUT    /companies/:company_id/company_subcategories/:id(.:format)       {:action=>"update", :controller=>"company_subcategories"}
#                                    DELETE /companies/:company_id/company_subcategories/:id(.:format)       {:action=>"destroy", :controller=>"company_subcategories"}
#                 company_categories GET    /companies/:company_id/categories(.:format)                      {:action=>"index", :controller=>"categories"}
#                                    POST   /companies/:company_id/categories(.:format)                      {:action=>"create", :controller=>"categories"}
#               new_company_category GET    /companies/:company_id/categories/new(.:format)                  {:action=>"new", :controller=>"categories"}
#              edit_company_category GET    /companies/:company_id/categories/:id/edit(.:format)             {:action=>"edit", :controller=>"categories"}
#                   company_category GET    /companies/:company_id/categories/:id(.:format)                  {:action=>"show", :controller=>"categories"}
#                                    PUT    /companies/:company_id/categories/:id(.:format)                  {:action=>"update", :controller=>"categories"}
#                                    DELETE /companies/:company_id/categories/:id(.:format)                  {:action=>"destroy", :controller=>"categories"}
#                  company_discounts GET    /companies/:company_id/discounts(.:format)                       {:action=>"index", :controller=>"discounts"}
#                                    POST   /companies/:company_id/discounts(.:format)                       {:action=>"create", :controller=>"discounts"}
#               new_company_discount GET    /companies/:company_id/discounts/new(.:format)                   {:action=>"new", :controller=>"discounts"}
#              edit_company_discount GET    /companies/:company_id/discounts/:id/edit(.:format)              {:action=>"edit", :controller=>"discounts"}
#                   company_discount GET    /companies/:company_id/discounts/:id(.:format)                   {:action=>"show", :controller=>"discounts"}
#                                    PUT    /companies/:company_id/discounts/:id(.:format)                   {:action=>"update", :controller=>"discounts"}
#                                    DELETE /companies/:company_id/discounts/:id(.:format)                   {:action=>"destroy", :controller=>"discounts"}
#                          companies GET    /companies(.:format)                                             {:action=>"index", :controller=>"companies"}
#                                    POST   /companies(.:format)                                             {:action=>"create", :controller=>"companies"}
#                        new_company GET    /companies/new(.:format)                                         {:action=>"new", :controller=>"companies"}
#                       edit_company GET    /companies/:id/edit(.:format)                                    {:action=>"edit", :controller=>"companies"}
#                            company GET    /companies/:id(.:format)                                         {:action=>"show", :controller=>"companies"}
#                                    PUT    /companies/:id(.:format)                                         {:action=>"update", :controller=>"companies"}
#                                    DELETE /companies/:id(.:format)                                         {:action=>"destroy", :controller=>"companies"}
#                              users GET    /users(.:format)                                                 {:action=>"index", :controller=>"users"}
#                                    POST   /users(.:format)                                                 {:action=>"create", :controller=>"users"}
#                           new_user GET    /users/new(.:format)                                             {:action=>"new", :controller=>"users"}
#                          edit_user GET    /users/:id/edit(.:format)                                        {:action=>"edit", :controller=>"users"}
#                               user GET    /users/:id(.:format)                                             {:action=>"show", :controller=>"users"}
#                                    PUT    /users/:id(.:format)                                             {:action=>"update", :controller=>"users"}
#                                    DELETE /users/:id(.:format)                                             {:action=>"destroy", :controller=>"users"}
#                            profile POST   /profile(.:format)                                               {:action=>"create", :controller=>"profiles"}
#                        new_profile GET    /profile/new(.:format)                                           {:action=>"new", :controller=>"profiles"}
#                       edit_profile GET    /profile/edit(.:format)                                          {:action=>"edit", :controller=>"profiles"}
#                                    GET    /profile(.:format)                                               {:action=>"show", :controller=>"profiles"}
#                                    PUT    /profile(.:format)                                               {:action=>"update", :controller=>"profiles"}
#                                    DELETE /profile(.:format)                                               {:action=>"destroy", :controller=>"profiles"}
#                            session POST   /session(.:format)                                               {:action=>"create", :controller=>"sessions"}
#                        new_session GET    /session/new(.:format)                                           {:action=>"new", :controller=>"sessions"}
#                                    DELETE /session(.:format)                                               {:action=>"destroy", :controller=>"sessions"}
#                    password_resets GET    /password_resets(.:format)                                       {:action=>"index", :controller=>"password_resets"}
#                                    POST   /password_resets(.:format)                                       {:action=>"create", :controller=>"password_resets"}
#                 new_password_reset GET    /password_resets/new(.:format)                                   {:action=>"new", :controller=>"password_resets"}
#                edit_password_reset GET    /password_resets/:id/edit(.:format)                              {:action=>"edit", :controller=>"password_resets"}
#                     password_reset GET    /password_resets/:id(.:format)                                   {:action=>"show", :controller=>"password_resets"}
#                                    PUT    /password_resets/:id(.:format)                                   {:action=>"update", :controller=>"password_resets"}
#                                    DELETE /password_resets/:id(.:format)                                   {:action=>"destroy", :controller=>"password_resets"}
#                              login GET    /login(.:format)                                                 {:action=>"new", :controller=>"sessions"}
#                             logout GET    /logout(.:format)                                                {:action=>"destroy", :controller=>"sessions"}
#                               root        /                                                                {:controller=>"sessions", :action=>"new"}
