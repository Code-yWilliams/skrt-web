Rails.application.routes.draw do
  def draw(routes_name)
    path_parts = %w[config routes] + routes_name.to_s.split(File::Separator)
    file_name = "#{path_parts.pop}.rb"
    instance_eval(File.read(Rails.root.join(*path_parts, file_name)))
  end
  
  # User login, logout, and forgot password routes
  devise_for :users, path: "", path_names: {
    sign_up: "signup",
    sign_in: "login",
    sign_out: "logout",
    password: "forgot-password"
  }, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
    unlocks: "users/unlocks"
  }
  
  unauthenticated :user do
    get "/" => redirect("/login")
  end

  draw :api

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
