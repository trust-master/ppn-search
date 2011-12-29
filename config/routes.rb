ServiceProviderPortal::Application.routes.draw do

  resources :discounts do
    member do
      post 'destroy_image'
      get 'show_image'
    end
  end


  resources :companies do
    collection do
      get :search
      post 'search_json'
    end

    resources :associations
    resources :certifications
    resources :affiliations
    resources :service_area_coverages
    resources :service_areas
    resources :company_subcategories
    resources :company_categories
  end

  resources :users do
    collection do
      get 'login'
      post 'login'
      get 'logout'
      get 'validate_email_is_unique'
    end
  end

  resources :sessions #, only: [:new, :create, :delete]

  match '/login' => 'sessions#new', as: 'login'
  match '/logout' => 'sessions#delete', as: 'logout'

  root :to => "companies#index"
end
#== Route Map
# Generated on 29 Dec 2011 06:06
#
#                show_image_discount GET    /discounts/:id/show_image(.:format)                              {:action=>"show_image", :controller=>"discounts"}
#                          discounts GET    /discounts(.:format)                                             {:action=>"index", :controller=>"discounts"}
#                                    POST   /discounts(.:format)                                             {:action=>"create", :controller=>"discounts"}
#                       new_discount GET    /discounts/new(.:format)                                         {:action=>"new", :controller=>"discounts"}
#                      edit_discount GET    /discounts/:id/edit(.:format)                                    {:action=>"edit", :controller=>"discounts"}
#                           discount GET    /discounts/:id(.:format)                                         {:action=>"show", :controller=>"discounts"}
#                                    PUT    /discounts/:id(.:format)                                         {:action=>"update", :controller=>"discounts"}
#                                    DELETE /discounts/:id(.:format)                                         {:action=>"destroy", :controller=>"discounts"}
#                   search_companies GET    /companies/search(.:format)                                      {:action=>"search", :controller=>"companies"}
#              search_json_companies POST   /companies/search_json(.:format)                                 {:action=>"search_json", :controller=>"companies"}
#               company_associations GET    /companies/:company_id/associations(.:format)                    {:action=>"index", :controller=>"associations"}
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
#         company_company_categories GET    /companies/:company_id/company_categories(.:format)              {:action=>"index", :controller=>"company_categories"}
#                                    POST   /companies/:company_id/company_categories(.:format)              {:action=>"create", :controller=>"company_categories"}
#       new_company_company_category GET    /companies/:company_id/company_categories/new(.:format)          {:action=>"new", :controller=>"company_categories"}
#      edit_company_company_category GET    /companies/:company_id/company_categories/:id/edit(.:format)     {:action=>"edit", :controller=>"company_categories"}
#           company_company_category GET    /companies/:company_id/company_categories/:id(.:format)          {:action=>"show", :controller=>"company_categories"}
#                                    PUT    /companies/:company_id/company_categories/:id(.:format)          {:action=>"update", :controller=>"company_categories"}
#                                    DELETE /companies/:company_id/company_categories/:id(.:format)          {:action=>"destroy", :controller=>"company_categories"}
#                          companies GET    /companies(.:format)                                             {:action=>"index", :controller=>"companies"}
#                                    POST   /companies(.:format)                                             {:action=>"create", :controller=>"companies"}
#                        new_company GET    /companies/new(.:format)                                         {:action=>"new", :controller=>"companies"}
#                       edit_company GET    /companies/:id/edit(.:format)                                    {:action=>"edit", :controller=>"companies"}
#                            company GET    /companies/:id(.:format)                                         {:action=>"show", :controller=>"companies"}
#                                    PUT    /companies/:id(.:format)                                         {:action=>"update", :controller=>"companies"}
#                                    DELETE /companies/:id(.:format)                                         {:action=>"destroy", :controller=>"companies"}
#                        login_users GET    /users/login(.:format)                                           {:action=>"login", :controller=>"users"}
#                                    POST   /users/login(.:format)                                           {:action=>"login", :controller=>"users"}
#                       logout_users GET    /users/logout(.:format)                                          {:action=>"logout", :controller=>"users"}
#     validate_email_is_unique_users GET    /users/validate_email_is_unique(.:format)                        {:action=>"validate_email_is_unique", :controller=>"users"}
#                              users GET    /users(.:format)                                                 {:action=>"index", :controller=>"users"}
#                                    POST   /users(.:format)                                                 {:action=>"create", :controller=>"users"}
#                           new_user GET    /users/new(.:format)                                             {:action=>"new", :controller=>"users"}
#                          edit_user GET    /users/:id/edit(.:format)                                        {:action=>"edit", :controller=>"users"}
#                               user GET    /users/:id(.:format)                                             {:action=>"show", :controller=>"users"}
#                                    PUT    /users/:id(.:format)                                             {:action=>"update", :controller=>"users"}
#                                    DELETE /users/:id(.:format)                                             {:action=>"destroy", :controller=>"users"}
#                           sessions GET    /sessions(.:format)                                              {:action=>"index", :controller=>"sessions"}
#                                    POST   /sessions(.:format)                                              {:action=>"create", :controller=>"sessions"}
#                        new_session GET    /sessions/new(.:format)                                          {:action=>"new", :controller=>"sessions"}
#                       edit_session GET    /sessions/:id/edit(.:format)                                     {:action=>"edit", :controller=>"sessions"}
#                            session GET    /sessions/:id(.:format)                                          {:action=>"show", :controller=>"sessions"}
#                                    PUT    /sessions/:id(.:format)                                          {:action=>"update", :controller=>"sessions"}
#                                    DELETE /sessions/:id(.:format)                                          {:action=>"destroy", :controller=>"sessions"}
#                              login        /login(.:format)                                                 {:controller=>"sessions", :action=>"new"}
#                             logout        /logout(.:format)                                                {:controller=>"sessions", :action=>"delete"}
#                               root        /                                                                {:controller=>"companies", :action=>"index"}
