Rails.application.routes.draw do
  resources :user_sessions
  resources :users do
    get :user_details
  end
  resources :events do
    get :signup
    get :leave
    get :remove_attendee
    post :repeat_once
    post :repeat_weekly
    collection do
      get :search_title
      get :search_event
      post :search_event
      post :review
    end
  end

  root "main#introduction"

  match 'calendar' => 'main#calendar', via: %i{get}
  match 'introduction' => 'main#introduction', via: %i{get}
  match 'events_and_activities' => 'main#events_and_activities', via: %i{get}
  match 'membership' => 'main#membership', via: %i{get}
  match 'contacts' => 'main#contacts', via: %i{get}
  match 'bedford' => 'main#bedford', via: %i{get}
  match 'south_bedfordshire' => 'main#south_bedfordshire', via: %i{get}
  match 'st_albans' => 'main#st_albans', via: %i{get}
  match 'contacts' => 'main#contacts', via: %i{get}
  match 'mid_hertfordshire' => 'main#mid_hertfordshire', via: %i{get}
  match 'west_hertfordshire' => 'main#west_hertfordshire', via: %i{get}
  match 'north_hertfordshire' => 'main#north_hertfordshire', via: %i{get}
  match 'other_areas' => 'main#other_areas', via: %i{get}

  match 'evening_events' => 'main#evening_events', via: %i{get}
  match 'days_out' => 'main#days_out', via: %i{get}
  match 'walks' => 'main#walks', via: %i{get}
  match 'city_breaks' => 'main#city_breaks', via: %i{get}
  match 'activity_weekends' => 'main#activity_weekends', via: %i{get}
  match 'trips_abroad' => 'main#trips_abroad', via: %i{get}
  match 'weekends_away' => 'main#weekends_away', via: %i{get}
  match 'activities' => 'main#activities', via: %i{get}
  match 'areas_covered' => 'main#areas_covered', via: %i{get}
  match 'houses_gardens' => 'main#houses_gardens', via: %i{get}
  match 'seaside_breaks' => 'main#seaside_breaks', via: %i{get}
  
  match 'signin' => "user_sessions#new", as: :signin, via: %i{get put post patch delete}
  match 'signout' => "user_sessions#destroy", as: :signout, via: %i{get put post patch delete}

  get 'password_reset' => 'password_reset#new'
  post 'password_reset' => 'password_reset#create'
  get 'password_reset/:id/' => 'password_reset#edit', as: :password_reset_edit
  post 'password_reset/:id/' => 'password_reset#update', as: :password_reset_update
  get ':token/acknowledge' => 'events#acknowledge_user', as: :acknowledge_user

  namespace :admin do
    resources :users
    resources :events do
      get :leave
    end
    root controller: :users, action: :index, as: :root
  end

  namespace :my_account do
    match '/' => 'dashboard#index', as: 'dashboard', via: %i{get put post patch delete}
    resources :users
    resources :events do
      get :leave
    end
    root "dashboard#index"
  end
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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
