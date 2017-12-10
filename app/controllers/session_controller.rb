class SessionController < ApplicationController
  get "/login" do
    erb :login
  end
end
