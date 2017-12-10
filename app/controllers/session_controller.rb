class SessionController < ApplicationController
  get "/login" do
    erb :login
  end

  post "/login" do
  end

  get "/logout" do
  end
end
