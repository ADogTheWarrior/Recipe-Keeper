class SessionController < ApplicationController
  get '/login' do
    if logged_in?
      redirect "/users/" + current_user.id.to_s
    else
      erb :login
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/" + user.id.to_s
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      erb :welcome
    else
      redirect "/"
    end
  end
end
