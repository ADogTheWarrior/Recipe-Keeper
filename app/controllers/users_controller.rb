class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    if logged_in?
      erb :"/users/index.html"
    else
      redirect "/users/new"
    end
  end

  # GET: /users/new
  get "/users/new" do
    if logged_in?
      redirect "/recipes"
    else
      erb :"/users/new.html"
    end
  end

  # POST: /users
  post "/users" do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save
        session[:user_id] = user.id
        redirect "/recipes"
      else
        redirect "/users/new"
      end
    else
      redirect "/users/new"
    end
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
