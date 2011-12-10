ServiceProviderPortal::Application.routes.draw do
  resources :discounts do
    member do
      post 'destroy_image'
      get 'show_image'
    end
  end

  resources :associations

  resources :certifications

  resources :affiliations

  resources :service_area_coverages

  resources :service_areas

  resources :company_subcategories

  resources :company_categories

  resources :companies do
    collection do
      get :search
      post 'search_json'
    end
  end

  resources :users do
    collection do
      get 'login'
      post 'login'
      get 'logout'
      get 'validate_email_is_unique'
    end
  end


  root :to => "users#login"
end
#== Route Map
# Generated on 10 Dec 2011 05:33
#
#            show_image_discount GET    /discounts/:id/show_image(.:format)        {:action=>"show_image", :controller=>"discounts"}
#                      discounts GET    /discounts(.:format)                       {:action=>"index", :controller=>"discounts"}
#                                POST   /discounts(.:format)                       {:action=>"create", :controller=>"discounts"}
#                   new_discount GET    /discounts/new(.:format)                   {:action=>"new", :controller=>"discounts"}
#                  edit_discount GET    /discounts/:id/edit(.:format)              {:action=>"edit", :controller=>"discounts"}
#                       discount GET    /discounts/:id(.:format)                   {:action=>"show", :controller=>"discounts"}
#                                PUT    /discounts/:id(.:format)                   {:action=>"update", :controller=>"discounts"}
#                                DELETE /discounts/:id(.:format)                   {:action=>"destroy", :controller=>"discounts"}
#                   associations GET    /associations(.:format)                    {:action=>"index", :controller=>"associations"}
#                                POST   /associations(.:format)                    {:action=>"create", :controller=>"associations"}
#                new_association GET    /associations/new(.:format)                {:action=>"new", :controller=>"associations"}
#               edit_association GET    /associations/:id/edit(.:format)           {:action=>"edit", :controller=>"associations"}
#                    association GET    /associations/:id(.:format)                {:action=>"show", :controller=>"associations"}
#                                PUT    /associations/:id(.:format)                {:action=>"update", :controller=>"associations"}
#                                DELETE /associations/:id(.:format)                {:action=>"destroy", :controller=>"associations"}
#                 certifications GET    /certifications(.:format)                  {:action=>"index", :controller=>"certifications"}
#                                POST   /certifications(.:format)                  {:action=>"create", :controller=>"certifications"}
#              new_certification GET    /certifications/new(.:format)              {:action=>"new", :controller=>"certifications"}
#             edit_certification GET    /certifications/:id/edit(.:format)         {:action=>"edit", :controller=>"certifications"}
#                  certification GET    /certifications/:id(.:format)              {:action=>"show", :controller=>"certifications"}
#                                PUT    /certifications/:id(.:format)              {:action=>"update", :controller=>"certifications"}
#                                DELETE /certifications/:id(.:format)              {:action=>"destroy", :controller=>"certifications"}
#                   affiliations GET    /affiliations(.:format)                    {:action=>"index", :controller=>"affiliations"}
#                                POST   /affiliations(.:format)                    {:action=>"create", :controller=>"affiliations"}
#                new_affiliation GET    /affiliations/new(.:format)                {:action=>"new", :controller=>"affiliations"}
#               edit_affiliation GET    /affiliations/:id/edit(.:format)           {:action=>"edit", :controller=>"affiliations"}
#                    affiliation GET    /affiliations/:id(.:format)                {:action=>"show", :controller=>"affiliations"}
#                                PUT    /affiliations/:id(.:format)                {:action=>"update", :controller=>"affiliations"}
#                                DELETE /affiliations/:id(.:format)                {:action=>"destroy", :controller=>"affiliations"}
#         service_area_coverages GET    /service_area_coverages(.:format)          {:action=>"index", :controller=>"service_area_coverages"}
#                                POST   /service_area_coverages(.:format)          {:action=>"create", :controller=>"service_area_coverages"}
#      new_service_area_coverage GET    /service_area_coverages/new(.:format)      {:action=>"new", :controller=>"service_area_coverages"}
#     edit_service_area_coverage GET    /service_area_coverages/:id/edit(.:format) {:action=>"edit", :controller=>"service_area_coverages"}
#          service_area_coverage GET    /service_area_coverages/:id(.:format)      {:action=>"show", :controller=>"service_area_coverages"}
#                                PUT    /service_area_coverages/:id(.:format)      {:action=>"update", :controller=>"service_area_coverages"}
#                                DELETE /service_area_coverages/:id(.:format)      {:action=>"destroy", :controller=>"service_area_coverages"}
#                  service_areas GET    /service_areas(.:format)                   {:action=>"index", :controller=>"service_areas"}
#                                POST   /service_areas(.:format)                   {:action=>"create", :controller=>"service_areas"}
#               new_service_area GET    /service_areas/new(.:format)               {:action=>"new", :controller=>"service_areas"}
#              edit_service_area GET    /service_areas/:id/edit(.:format)          {:action=>"edit", :controller=>"service_areas"}
#                   service_area GET    /service_areas/:id(.:format)               {:action=>"show", :controller=>"service_areas"}
#                                PUT    /service_areas/:id(.:format)               {:action=>"update", :controller=>"service_areas"}
#                                DELETE /service_areas/:id(.:format)               {:action=>"destroy", :controller=>"service_areas"}
#          company_subcategories GET    /company_subcategories(.:format)           {:action=>"index", :controller=>"company_subcategories"}
#                                POST   /company_subcategories(.:format)           {:action=>"create", :controller=>"company_subcategories"}
#        new_company_subcategory GET    /company_subcategories/new(.:format)       {:action=>"new", :controller=>"company_subcategories"}
#       edit_company_subcategory GET    /company_subcategories/:id/edit(.:format)  {:action=>"edit", :controller=>"company_subcategories"}
#            company_subcategory GET    /company_subcategories/:id(.:format)       {:action=>"show", :controller=>"company_subcategories"}
#                                PUT    /company_subcategories/:id(.:format)       {:action=>"update", :controller=>"company_subcategories"}
#                                DELETE /company_subcategories/:id(.:format)       {:action=>"destroy", :controller=>"company_subcategories"}
#             company_categories GET    /company_categories(.:format)              {:action=>"index", :controller=>"company_categories"}
#                                POST   /company_categories(.:format)              {:action=>"create", :controller=>"company_categories"}
#           new_company_category GET    /company_categories/new(.:format)          {:action=>"new", :controller=>"company_categories"}
#          edit_company_category GET    /company_categories/:id/edit(.:format)     {:action=>"edit", :controller=>"company_categories"}
#               company_category GET    /company_categories/:id(.:format)          {:action=>"show", :controller=>"company_categories"}
#                                PUT    /company_categories/:id(.:format)          {:action=>"update", :controller=>"company_categories"}
#                                DELETE /company_categories/:id(.:format)          {:action=>"destroy", :controller=>"company_categories"}
#               search_companies GET    /companies/search(.:format)                {:action=>"search", :controller=>"companies"}
#          search_json_companies POST   /companies/search_json(.:format)           {:action=>"search_json", :controller=>"companies"}
#                      companies GET    /companies(.:format)                       {:action=>"index", :controller=>"companies"}
#                                POST   /companies(.:format)                       {:action=>"create", :controller=>"companies"}
#                    new_company GET    /companies/new(.:format)                   {:action=>"new", :controller=>"companies"}
#                   edit_company GET    /companies/:id/edit(.:format)              {:action=>"edit", :controller=>"companies"}
#                        company GET    /companies/:id(.:format)                   {:action=>"show", :controller=>"companies"}
#                                PUT    /companies/:id(.:format)                   {:action=>"update", :controller=>"companies"}
#                                DELETE /companies/:id(.:format)                   {:action=>"destroy", :controller=>"companies"}
#                    login_users GET    /users/login(.:format)                     {:action=>"login", :controller=>"users"}
#                                POST   /users/login(.:format)                     {:action=>"login", :controller=>"users"}
#                   logout_users GET    /users/logout(.:format)                    {:action=>"logout", :controller=>"users"}
# validate_email_is_unique_users GET    /users/validate_email_is_unique(.:format)  {:action=>"validate_email_is_unique", :controller=>"users"}
#                          users GET    /users(.:format)                           {:action=>"index", :controller=>"users"}
#                                POST   /users(.:format)                           {:action=>"create", :controller=>"users"}
#                       new_user GET    /users/new(.:format)                       {:action=>"new", :controller=>"users"}
#                      edit_user GET    /users/:id/edit(.:format)                  {:action=>"edit", :controller=>"users"}
#                           user GET    /users/:id(.:format)                       {:action=>"show", :controller=>"users"}
#                                PUT    /users/:id(.:format)                       {:action=>"update", :controller=>"users"}
#                                DELETE /users/:id(.:format)                       {:action=>"destroy", :controller=>"users"}
#                           root        /                                          {:controller=>"users", :action=>"login"}
