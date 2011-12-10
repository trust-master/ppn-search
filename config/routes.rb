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
            get 'search'
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
