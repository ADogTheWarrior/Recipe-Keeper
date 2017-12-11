class SessionController < ApplicationController
  get '/login' do
    if logged_in?
      redirect "/recipes"
    else
      erb :login
    end
  end

  post "/login" do
  end

  get "/logout" do
  end
end
