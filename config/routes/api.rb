scope default: {format: :json} do
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create, :destroy]
      get :test, to: "test#index"
    end
  end
end
