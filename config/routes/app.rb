  scope "/app" do
    unauthenticated :user do
      get "/", to: redirect("/login")
      get "/*path", to: redirect("/login")
    end

    get "/", to: "app#index"
    get "/*path", to: "app#index"
  end
